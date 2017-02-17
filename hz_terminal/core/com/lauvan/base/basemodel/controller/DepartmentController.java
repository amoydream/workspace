package com.lauvan.base.basemodel.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "/Main/department", viewPath = "/base/basemodel/department")
public class DepartmentController extends BaseController {

	public void index(){
		render("main.jsp");
	}
	
	public void add(){
		Integer pid=getParaToInt(0);
		setAttr("pid", pid);
		render("add.jsp");
	}
	
	public void edit(){
		Integer id=getParaToInt(0);
		T_Sys_Department model=T_Sys_Department.dao.findById(id);
		
		setAttr("dept", model);
		render("edit.jsp");
	}
	
	public void save(){
		String act=getPara("act");
		boolean success=false;
		T_Sys_Department model=getModel(T_Sys_Department.class);
		String d_pid = model.get("d_pid").toString();
		if(act.equals("add")){
			model.set("d_id", AutoId.nextval(model));
			success=model.save();
		}else{
			success=model.update();
		}
		//renderText("{\"success\":"+success+"}");
		if(success){
			toDwzText(success, "保存成功！", "departTree", "departDialog", "", "closeCurrent",d_pid);
		}else{
			toDwzText(success, "保存异常！", "", "", "", "");
		}
	}
	
	public void delete(){
		Integer[] ids=getParaValuesToInt("ids");
		
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		try{
			if(!T_Sys_Department.dao.hasSonDepartment(ids)){
				success=T_Sys_Department.dao.delete(ids);
			}
			else{
				msg="删除节点存在子部门信息";
				errorCode="info";
			}
		}catch(Exception e){
			e.printStackTrace();
			errorCode="error";
			msg=e.getMessage();
		}
		finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
	
	//判断是否存在重复部门编号
	public void ifExistCode(){
		String code=getPara("code");
		Integer did=getParaToInt("did");
		boolean flag=T_Sys_Department.dao.ifExsitDeptCode(code, did);
		
		renderJson("{\"success\":"+flag+"}");
	}
	
	
	public void getTreeData(){
		
		String idKey=StringUtils.isBlank(getPara("idKey"))?"id":getPara("idKey");
		String pidKey=StringUtils.isBlank(getPara("pidKey"))?"pid":getPara("pidKey");
		
		List<Record> deptList=T_Sys_Department.dao.getAllDepartments();
		
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		Map<String,Object> row = new HashMap<String,Object>();
		Map<String,Object> root = new HashMap<String,Object>();
		
		root.put(idKey, "0");
		root.put("name", "组织机构");
		root.put(pidKey, "");
		dataList.add(root);
		
		for(Record de:deptList){
			row=new HashMap<String,Object>();
			row.put(idKey, de.get("d_id"));
			row.put("name", de.get("d_name"));
			row.put(pidKey, de.get("d_pid"));
			dataList.add(row);
		}
		renderJson(dataList);
	}
	
	public void getGridData(){
		/*Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		//Integer pid=getParaToInt("pid");
		
		//获取表格表页数据
		Page<Record> page=Paginate.dao.getPage("t_sys_department", pageSize, pageNumber, "", "orderid", "asc");
		
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();*/
		List<Record> list = Paginate.dao.getList("t_sys_department", " 1=1 order by orderid asc");
		int totalCount = list.size();
		//调用JsonUtil函数返回datagrid表格json数据
		//String jsonStr=JsonUtil.getGridData(list, totalCount);
		//调用JsonUtil函数返回treegrid表格json数据
		String jsonStr=JsonUtil.getTreeGridData(list, totalCount, "d_pid");
		renderText(jsonStr);
	}
	
	public void getComboTree(){
		try{
			//Integer rootId=47;
			List<Record> deptList=T_Sys_Department.dao.getAllDepartments();
			
			//T_Sys_Department pModel=T_Sys_Department.dao.findById(rootId);
			
			String json=T_Sys_Department.dao.getDeptTreeData(null, deptList);
			System.out.println(json);
			renderText(json);
		}catch (Exception e) {
			e.printStackTrace();
			renderText("[]");
		}
	}
	
//	/**
//	 * 获取树结构json
//	 * 
//	 * @param   parentRec   节点对象
//	 * @param   deptList	节点所有数据对象
//	 * @return				返回树结构json
//	 */
//	private String getDeptTreeData(Record parentRec,List<Record> deptList){
//		
//		List<Map<String,Object>> rootList=new ArrayList<Map<String,Object>>();
//		if(parentRec==null){
//			for(Record dept:deptList){
//				if(dept.getBigDecimal("d_pid").intValue()==0)
//					rootList.add(getChildrenNode(dept, deptList));
//			}
//		}else
//			rootList.add(getChildrenNode(parentRec, deptList));
//
//		return JSONArray.toJSONString(rootList);
//	}
//	
//	/**
//	 * 获取树当前节点所有子节点数据，用于递归
//	 * 
//	 * @param   parentRec   节点对象
//	 * @param   deptList	节点所有数据对象
//	 * @return				返回树结构json
//	 */
//	private Map<String,Object> getChildrenNode(Record parentRec,List<Record> deptList){
//		List<Map<String,Object>> childList=new ArrayList<Map<String,Object>>();
//		Map<String,Object> parentMap = new HashMap<String,Object>();
//		
//		parentMap.put("id", parentRec.get("d_id"));
//		parentMap.put("text", parentRec.get("d_name"));
//		
//		for(Record rec:deptList){
//			if(parentRec.get("d_id").equals(rec.get("d_pid"))){
//				childList.add(getChildrenNode(rec, deptList));
//			}
//		}
//		
//		if(childList.size()!=0)
//			parentMap.put("children", childList);
//		
//		return parentMap;
//		
//	}
}
