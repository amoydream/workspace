package com.lauvan.apps.resource.assets.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.assets.model.T_Bus_Expertgroup;
import com.lauvan.apps.resource.assets.model.T_Bus_Expertgroup_Per;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path="Main/expertgroup",viewPath="/resource/assets/expertgroup")
public class ExpertGroupController extends BaseController{
	public void index(){
		render("main.jsp");
	}
	
	public void getData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String egName = getPara("egName");
		StringBuffer str = new StringBuffer();
		if(egName!=null && !"".equals(egName)){
			str.append("eg_name like '%").append(egName).append("%'");
		}
		Page<Record> page=Paginate.dao.getPage("T_BUS_EXPERTGROUP", pageSize, pageNumber, str.toString(), "eg_id", null);
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
		T_Bus_Expertgroup model=T_Bus_Expertgroup.dao.getById(id);
		setAttr("model", model);
		render("edit.jsp");
	}
	
	public void save(){
		T_Bus_Expertgroup exgroup=getModel(T_Bus_Expertgroup.class);
		boolean success=false;
		try {
			exgroup.set("fjid", getPara("fjid"));
			if(exgroup.get("eg_id") == null){
				success = T_Bus_Expertgroup.dao.insert(exgroup);
			}else{
				success = T_Bus_Expertgroup.dao.upd(exgroup);
			}
		} catch (Exception e) {
			e.printStackTrace();
			}
		if(success){
			toDwzText(success, "保存成功！","", "exgroupDialog", "exgroupGrid", "closeCurrent");
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
			T_Bus_Expertgroup_Per.dao.deleteByExgroupIds(idStr); //删除专家组下的成员配置信息
			String fjids = T_Bus_Expertgroup.dao.getfjidsByIds(idStr);
			if(fjids != null && !"".equals(fjids)){
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_Expertgroup.dao.deleteByIds(idStr);
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
		T_Bus_Expertgroup exgroup = T_Bus_Expertgroup.dao.getById(id);
		setAttr("exgroup", exgroup);
		//组建单位
		String dept = exgroup.get("buildorgan")==null?null:exgroup.get("buildorgan").toString();
		if(dept!=null){
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			setAttr("buildorganname",d.getStr("or_name"));
		}
		renderJsp("view.jsp");
	}
	
	
}
