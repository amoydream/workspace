package com.lauvan.apps.resource.material.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.material.model.T_Bus_Materialcap;
import com.lauvan.apps.resource.material.model.T_Bus_Materialfirm;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path="Main/materialfirm",viewPath="/resource/material/materialfirm")
public class MaterialFirmController extends BaseController{
	public void index(){
		render("main.jsp");
	}
	
	public void getData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String mfName = getPara("mfName");
		StringBuffer str = new StringBuffer();
		if(mfName!=null && !"".equals(mfName)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append("  mf_name like '%").append(mfName).append("%'");
		}
		Page<Record> page=Paginate.dao.getPage("T_BUS_MATERIALFIRM", pageSize, pageNumber, str.toString(), "mf_id", null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void add(){
		render("add.jsp");
	}
	
	public void edit(){
		Integer id=getParaToInt(0);
		T_Bus_Materialfirm model=T_Bus_Materialfirm.dao.getById(id);
		setAttr("model", model);
		render("edit.jsp");
	}
	
	public void save(){
		T_Bus_Materialfirm mafirm=getModel(T_Bus_Materialfirm.class);
		boolean success=false;
		try {
			mafirm.set("fjid", getPara("fjid"));
			if(mafirm.get("mf_id") == null){
				success = T_Bus_Materialfirm.dao.insert(mafirm);
			}else{
				success = T_Bus_Materialfirm.dao.upd(mafirm);
			}
		} catch (Exception e) {
			e.printStackTrace();
			}
		if(success){
			toDwzText(success, "保存成功！","", "mafirmDialog", "mafirmGrid", "closeCurrent");
		}else{
			toDwzText(success, "保存异常！", "", "", "", "");
		}
	}
	
	public void delete(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Bus_Materialcap.dao.deleteByMafirmIds(idStr); //删除企业下的生产能力
			String fjids = T_Bus_Materialfirm.dao.getfjidsByIds(idStr);
			if(fjids != null && !"".equals(fjids)){
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_Materialfirm.dao.deleteByIds(idStr);
			success = true;
			errorCode = "info";
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally{
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			renderJson(tips);
		}
	}
	
	public void getview(){
		Integer id = getParaToInt(0);
		T_Bus_Materialfirm mafirm = T_Bus_Materialfirm.dao.getById(id);
		setAttr("model", mafirm);
		//所属单位
		String dept = mafirm.get("organid")==null?null:mafirm.get("organid").toString();
		if(dept!=null){
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			setAttr("organname",d.getStr("or_name"));
		}
		renderJsp("view.jsp");
	}
	
	
}
