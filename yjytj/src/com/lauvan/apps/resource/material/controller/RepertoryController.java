package com.lauvan.apps.resource.material.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.material.model.T_Bus_Repertory;
import com.lauvan.apps.resource.material.model.T_Bus_Store;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path="Main/repertory",viewPath="/resource/material/repertory")
public class RepertoryController extends BaseController{
	public void index(){
		render("main.jsp");
	}
	
	public void getData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String reName = getPara("reName");
		StringBuffer str = new StringBuffer();
		if(reName!=null && !"".equals(reName)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append("  name like '%").append(reName).append("%'");
		}
		Page<Record> page=Paginate.dao.getPage("T_BUS_REPERTORY", pageSize, pageNumber, str.toString(), "rep_id", null);
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
		T_Bus_Repertory model=T_Bus_Repertory.dao.getById(id);
		setAttr("model", model);
		render("edit.jsp");
	}
	
	public void save(){
		T_Bus_Repertory repertory=getModel(T_Bus_Repertory.class);
		boolean success=false;
		try {
			repertory.set("fjid", getPara("fjid"));
			if(repertory.get("rep_id") == null){
				success = T_Bus_Repertory.dao.insert(repertory);
			}else{
				success = T_Bus_Repertory.dao.upd(repertory);
			}
		} catch (Exception e) {
			e.printStackTrace();
			}
		if(success){
			toDwzText(success, "保存成功！","", "repertoryDialog", "repertoryGrid", "closeCurrent");
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
			String fjids = T_Bus_Repertory.dao.getfjidsByIds(idStr);
			if(fjids != null && !"".equals(fjids)){
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_Repertory.dao.deleteByIds(idStr);
			T_Bus_Store.dao.beNullByReIds(idStr);
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
	
	
	/**
	 * 获取仓库列表页面供其他模块选择
	 */
	public void getRepertory(){
		renderJsp("select.jsp");
	}
	
	public void getview(){
		Integer id=getParaToInt(0);
		T_Bus_Repertory model=T_Bus_Repertory.dao.getById(id);
		//所属单位
				String dept = model.get("organid")==null?null:model.get("organid").toString();
				if(dept!=null){
					T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
					setAttr("organ",d.getStr("or_name"));
				}
		setAttr("model", model);
		render("view.jsp");
	}
}
