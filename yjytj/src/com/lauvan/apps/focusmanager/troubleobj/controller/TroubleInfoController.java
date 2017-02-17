package com.lauvan.apps.focusmanager.troubleobj.controller;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.focusmanager.troubleobj.model.T_Bus_Hidtrub;
import com.lauvan.apps.plan.model.T_Bus_Preschinfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/troubleinfo", viewPath = "/focusmanager/troubleobj")
public class TroubleInfoController extends BaseController {
	private static final Logger log = Logger.getLogger(TroubleInfoController.class);
	public void index() {
		render("maininfo.jsp");
	}
	public void nocheck(){
		render("maincheck.jsp");
	}
	public void getTree(){
		String idKey=StringUtils.isBlank(getPara("idKey"))?"id":getPara("idKey");
		String pidKey=StringUtils.isBlank(getPara("pidKey"))?"pid":getPara("pidKey");
		List<T_Sys_Parameter> typelist=T_Sys_Parameter.dao.getChildByAcode("YHDLB");
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		Map<String,Object> row = new HashMap<String,Object>();
		Map<String,Object> root = new HashMap<String,Object>();
		root.put(idKey, "800");
		root.put("name", "隐患点类型");
		root.put("p_acode",null);
		root.put(pidKey, "");
		dataList.add(root);
		for(T_Sys_Parameter de:typelist){
			row=new HashMap<String,Object>();
			row.put(idKey, de.get("id"));
			row.put("name", de.get("p_name"));
			row.put("p_acode", de.get("p_acode"));
			row.put(pidKey,"800");
			dataList.add(row);
		}
		renderJson(dataList);	
	}
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("troublename");
		String p_acode=getPara("p_acode");
		Integer did = getParaToInt(0); //所属单位id
		Page<Record> page;
		if(did == null || did == 0){
			page = T_Bus_Hidtrub.dao.getGridPage(pageNumber, pageSize,p_acode, name,null);
		}else{
			page = T_Bus_Hidtrub.dao.getGridPage2(pageNumber, pageSize,p_acode, name, "od_"+did);
		}
		
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void getcheckGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("checkname");
		String p_acode=getPara("p_check");
		Page<Record> page;
		page = T_Bus_Hidtrub.dao.getGridPage(pageNumber, pageSize,p_acode, name,"0");
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void add(){
	String pcode=getPara(0);
	if(pcode==null||pcode.equals("")||pcode.equals("null")){
		pcode="0001";
	}
	setAttr("pcode",pcode);
	render("add.jsp");
	}
	public void upd(){
	String id=getPara(0);
	T_Bus_Hidtrub hidtrub=T_Bus_Hidtrub.dao.findById(id);
	setAttr("hidtrub",hidtrub);
	render("update.jsp");
	}
	public void view(){
		String id=getPara(0);
		T_Bus_Hidtrub hidtrub=T_Bus_Hidtrub.dao.findById(id);
		setAttr("hidtrub",hidtrub);
		render("view.jsp");
		}
	public void save(){
		try {
    		boolean success=false;
    		LoginModel loginModel=getSessionAttr("loginModel");
    		Number userid=loginModel.getUserId();
    		String methodname="add";
			String act = getPara("act");
			T_Bus_Hidtrub hidtrub = getModel(T_Bus_Hidtrub.class);
			Date d=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			hidtrub.set("recname", userid.toString()).set("rectime", sdf.format(d));
			String alt="";
			String deptname=T_Bus_Preschinfo.dao.getOrganName(hidtrub.getStr("hidtrubdeptid"));
			hidtrub.set("hidtrubdept", deptname);
					if(act.equals("upd")){
						hidtrub.update();
						success=true;
						methodname="update";
						alt="修改成功！";
					}else{
						
						hidtrub.set("id", AutoId.nextval(hidtrub)).set("isvail", "0");
						hidtrub.save();
						success=true;
						alt="保存成功！";
						T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/troubleinfo", methodname,hidtrub,getRequest());
					}
		toDwzText(success, alt, "", "troubleinfoDialog", "troubleinfoGrid", "closeCurrent");	
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}
	public void del(){
		String ids=getPara("ids");
		String[] id=ids.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		LoginModel loginModel=getSessionAttr("loginModel");
		Number userid=loginModel.getUserId();
		try {
		for(String i:id){
		T_Bus_Hidtrub hidtrub=T_Bus_Hidtrub.dao.findById(i);
		hidtrub.delete();
		T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/troubleinfo/del", "delete",hidtrub,getRequest());
		}
		success=true;								
		} catch (Exception e) {
			log.error(e.getMessage());
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
	public void check(){
		String id = getPara(0);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		LoginModel loginModel=getSessionAttr("loginModel");
		Number userid=loginModel.getUserId();
		try {
		T_Bus_Hidtrub hidtrub=T_Bus_Hidtrub.dao.findById(id);
		Date d=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		hidtrub.set("recname",loginModel.getUserName()).set("rectime", sdf.format(d)).set("isvail", "1").update();
		T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/troubleinfo/check", "delete",hidtrub,getRequest());
		success=true;								
		} catch (Exception e) {
			log.error(e.getMessage());
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
	/**
	 * 根据名称返回重点防护目标详细信息
	 * */
	public void getContent(){
		String name = getPara("tname");
		List<Record> list = T_Bus_Hidtrub.dao.getListByName(name);
		String jsonlist = JsonKit.toJson(list);
		renderJson(jsonlist);
	}
}
