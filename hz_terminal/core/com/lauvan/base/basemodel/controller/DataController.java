package com.lauvan.base.basemodel.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_DataRelation;
import com.lauvan.base.basemodel.model.T_Sys_DataService;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;

/**
 * 数据权限控制类
 * */
@RouteBind(path="Main/dataService",viewPath="/base/basemodel/data")
public class DataController extends BaseController {
	public void index(){
		//获取系统上所有部门信息
		LoginModel login = getSessionAttr("loginModel");
		List<Record> deptTree = new ArrayList<Record>();
		if(login.getIsSuper()){
			deptTree = T_Sys_Department.dao.getAllDepartments();
		}else{
			String deptId = login.getRootOrgId().toString();
			deptTree = T_Sys_Department.dao.getDepartmentList(deptId);
		}
		String deptid = getPara(0);
		if(deptid==null|| "".equals(deptid)){
			deptid = "0";
		}
		setAttr("deptTree",deptTree);
		setAttr("apId",deptid);
		render("main.jsp");
	}
	public void getDataGrid(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String sername = getPara("sername");
		String deptid = getPara(0);
		StringBuffer str = new StringBuffer();
		if(sername!=null && !"".equals(sername)){
			str.append(" and s.serviceName like '%").append(sername).append("%' ");
		}
		Page<Record> page=T_Sys_DataService.dao.getPage( pageSize, pageNumber,deptid ,str.toString());
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	//配置数据权限
	public void dataRole(){
		String deptid = getPara("deptid");
		String serviceid = getPara(0);
		if(deptid==null || "".equals(deptid) || "0".equals(deptid)){
			toDwzText(false, "请选择部门！", "", "dataserviceDialog", "", "closeCurrent");
			return;
		}
		if(serviceid==null || "".equals(serviceid) ){
			toDwzText(false, "请选择业务模块！", "", "dataserviceDialog", "", "closeCurrent");
			return;
		}
		T_Sys_Department dept = T_Sys_Department.dao.findById(deptid);
		T_Sys_DataService service = T_Sys_DataService.dao.findById(serviceid);
		setAttr("d",dept);
		setAttr("s",service);
		//查询非本部门及本部门以下的所有部门
		List<Record> dlist = T_Sys_Department.dao.getDepartmentExtList("0", deptid);
		//已经存在的部门
		StringBuffer selids = new StringBuffer();
		dlist = T_Sys_DataRelation.dao.getListByIDs(serviceid, deptid, dlist,selids);
		setAttr("selids",selids.length()==0?"":selids.toString());
		setAttr("dlist",dlist);
		render("data.jsp");
	}
	//数据权限保存
	public void dataRoleSave(){
		try {
			String selid = getPara("selid");//勾选的部门id
			String deptid = getPara("deptid");
			String serviceid = getPara("serviceid");
			//删除多余的部门id
			T_Sys_DataRelation.dao.deleteByIds(deptid, serviceid, selid);
			//如有新的记录，新增
			String nids = T_Sys_DataRelation.dao.getNewDept(deptid, serviceid, selid);
			if(nids!=null && !"".equals(nids)){
				String[] nid = nids.split(",");
				for(String n : nid){
					if(n!=null && !"".equals(n)){
						T_Sys_DataRelation data = new T_Sys_DataRelation();
						data.set("dept_id", deptid);
						data.set("service_id", serviceid);
						data.set("other_dept", n);
						T_Sys_DataRelation.dao.insert(data);
					}
				}
			}
			toDwzText(true, "保存成功！", "", "dataserviceDialog", "list_data", "closeCurrent");
		} catch (Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}
	}
	
	//清除权限内容
	public void delete(){
		String ids = getPara("ids");
		String dept = getPara("dept");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="清除成功！";
		String errorCode="info";
		try {
			success = T_Sys_DataRelation.dao.deleteBySerDept(ids, dept);
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
}
