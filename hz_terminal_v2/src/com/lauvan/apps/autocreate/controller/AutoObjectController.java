package com.lauvan.apps.autocreate.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.autocreate.model.T_AutoAttr;
import com.lauvan.apps.autocreate.model.T_AutoTable;
import com.lauvan.apps.autocreate.utils.AutoCreate;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/autoObject",viewPath="/autoCreate/object")
public class AutoObjectController extends BaseController {
	public void index(){
		render("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String objName = getPara("objName");
		String objCode = getPara("objCode");
		StringBuffer str = new StringBuffer();
		if(objName!=null && !"".equals(objName)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append("  table_name like '%").append(objName).append("%'");
		}
		if(objCode!=null && !"".equals(objCode)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append(" table_code like '%").append(objCode).append("%'");
		}
		Page<Record> page=Paginate.dao.getPage("t_autotable", pageSize, pageNumber, str.toString(), "id", null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void getGridDataView(){
		String tcode = getPara("tcode");
		List<Record> list = T_AutoAttr.dao.getListByCode(tcode);
		String json=JsonUtil.getGridData(list, list.size());
		renderText(json);
	}
	
	public void add(){
		String dbatype = JFWebConfig.attrMap.get("dbaType");
		String dbaname = JFWebConfig.attrMap.get("dbaName");
		String[] dbalist = dbatype.split(",");
		if(dbaname!=null && !"".equals(dbaname)){
			String[] dbanames = dbaname.split(",");
			setAttr("dbaname",dbanames);
		}
		setAttr("dbalist",dbalist);
		render("add.jsp");
	}
	
	
	public void delete(){
		String id = getPara("tid");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		try {
			T_AutoTable t = T_AutoTable.dao.findById(id);
			if(t!=null){
				String tcode = t.getStr("table_code");
				//删除字段
				T_AutoAttr.dao.deleteByTcode(tcode);
				//删除表以及model类文件
				T_AutoTable.dao.deletTable(tcode, t.getStr("dba_name"),t.getStr("model_path"));
				success = t.delete();
				msg = "删除成功！";
			}else{
				errorCode="error";
				msg = "该对象不存在，请检查！";
			}
		} catch (Exception e) {
			errorCode="error";
			msg=e.getMessage();
			e.printStackTrace();
		}finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
		
	}
	
	public void save(){
		boolean success = false;
		T_AutoTable t = getModel(T_AutoTable.class);
		String modelpath = getPara("modelpath");
		t.set("model_path", modelpath);
		String tcode = t.getStr("table_code");
		T_AutoTable.dao.insert(t);
		//获取表单属性并保存表单属性
		String pkid = "";
		Integer fnum = getParaToInt("fnum");
		if(fnum!=null && fnum>0){
			for(int i=fnum-1;i>=0;i--){
				T_AutoAttr attr = new T_AutoAttr();
				String pk = getPara("_ispkid_"+i);
				attr.set("attrname", getPara("_attrname_"+i));
				attr.set("attrcode", getPara("_attrcode_"+i));
				attr.set("attrtype", getPara("_attrtype_"+i));
				attr.set("acodelen", getPara("_acodelen_"+i));
				attr.set("ispkid", pk);
				if("1".equals(getPara("_ispkid_"+i))){
					pkid = getPara("_attrcode_"+i);
				}
				attr.set("remark", getPara("_remark_"+i));
				attr.set("tcode", tcode);
				T_AutoAttr.dao.insert(attr);
			}
		}
		//建表
		String dba = t.getStr("dba_type");
		String dbaname = t.getStr("dba_name");
		if("sqlserver".equals(dba)){
			success = T_AutoTable.dao.createSQLServerTable(tcode,dbaname);
		}else if("mysql".equals(dba)){
			success = T_AutoTable.dao.createMySqlTable(tcode,dbaname);
		}else{
			success = T_AutoTable.dao.createOracleTable(tcode,dbaname);
		}
		//是否建model类
		String ismodel = getPara("ismodel");
		
		
		if("1".equals(ismodel)){
			T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("model", "AUTO");
			String file = p.getStr("p_acode");
			AutoCreate.createModel(file, tcode.replaceFirst(tcode.substring(0, 1), tcode.substring(0, 1).toUpperCase()), 
					tcode, pkid, modelpath);
		}
		if(success){
			toDwzText(success, "保存成功！", "", "autoObjDialog", "objtable", "closeCurrent");
		}else{
			toDwzText(success, "保存失败！", "", "", "", "");
		}
	}
	//校验对象编码是否唯一
	public void check(){
		String signcode = getPara("signcode");
		String dbaname = getPara("dbaname");
		if(!T_AutoTable.dao.isExit(signcode, dbaname)){
			renderText("true");
		}else{
			renderText("false");
		}
	}
}
