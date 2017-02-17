package com.lauvan.base.basemodel.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Module;
import com.lauvan.base.basemodel.model.T_Sys_Role;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.basemodel.model.T_Sys_UserRoles;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;


@RouteBind(path = "/Main/role", viewPath = "/base/basemodel/role")
public class RoleController extends BaseController {

	public void index(){
		//判断当前用户是否是超级管理员，否则以当前用户所在市县展示角色
		LoginModel login = getSessionAttr("loginModel");
		boolean isSuper = login.getIsSuper();
		if(!isSuper){
			setAttr("suporg", login.getRootOrgId());
		}
		render("main.jsp");
	}
	
	public void add(){
		Integer pid=getParaToInt(0);
		
		setAttr("pid", pid);
		render("add.jsp");
	}
	
	public void edit(){
		Integer id=getParaToInt(0);
		T_Sys_Role user=T_Sys_Role.dao.findById(id);
		
		setAttr("role", user);
		render("edit.jsp");
	}
	
	//权限分配
	public void authAssign(){
		
		Integer roleId=getParaToInt(0);
		T_Sys_Role role=T_Sys_Role.dao.findById(roleId);
		if(role!=null)
			setAttr("role", role);
		render("authAssign.jsp");
	}
	
	//用户分配
	public void userAssign(){
		Integer roleId=getParaToInt(0);
		T_Sys_Role role=T_Sys_Role.dao.findById(roleId);
		/*LoginModel login = getSessionAttr("loginModel");
		String suporg = login.getRootOrgId().toString();
		List<Record> userList=null;
		if(login.getIsSuper()){
			userList=T_Sys_User.dao.getUsableUser();
		}else{
			userList=T_Sys_User.dao.getUsableUser(suporg);
		}*/
		List<Record> userList = T_Sys_User.dao.getUsableUser();
		Integer[] userIdList=T_Sys_UserRoles.dao.getUserId(roleId);
		String userIds=ArrayUtils.ArrayToString(userIdList);
		if(role!=null)
			setAttr("role", role);
		
		String userJson=JsonKit.toJson(userList);
		setAttr("userList", userJson);
		setAttr("userIds", userIds);
		render("userAssign.jsp");
	}
	
	public void authoritySave(){
		String menuId=getPara("menuId");
		String excludeFunId=getPara("excludeFunId");
		
		Integer roleId=getParaToInt("roleId");
		T_Sys_Role role=T_Sys_Role.dao.findById(roleId);
		boolean success=false;
		String msg="";
		if(role!=null){
			role.set("OPT_PERMISSIONS", menuId);
			role.set("NO_PERMISSIONS", excludeFunId);
			success=role.update();
		}else{
			msg="您所查找的角色不存在";
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("success", success);
		map.put("msg", msg);
		renderJson(map);
	}
	
	public void userAssignSave(){
		
		Integer[] userIdList=getParaValuesToInt("idList");
		Integer roleId=getParaToInt("roleId");
		
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		try{
			T_Sys_UserRoles.dao.deleteByRoleId(roleId);
			
			success=T_Sys_UserRoles.dao.insert(userIdList, roleId);
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
	
	public void save(){
		String act=getPara("act");
		boolean success=false;
		T_Sys_Role model=getModel(T_Sys_Role.class);
		LoginModel loginModel = getSessionAttr("loginModel");
		Number supOrg = loginModel.getRootOrgId();
		String pid = model.get("pid").toString();
		if(!loginModel.getIsSuper()){
			model.set("suporg", supOrg);
		}
		if(act.equals("add")){
			model.set("role_id", AutoId.nextval(model));
			success=model.save();
		}else{
			success=model.update();
		}
		if(success){
			toDwzText(success, "保存成功！", "rolelist_data", "roleDialog", "", "closeCurrent",pid);
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
			String id = ArrayUtils.ArrayToString(ids);
			boolean flag = T_Sys_UserRoles.dao.isUseRoleId(id);
			if(flag){
				errorCode="error";
				msg="有角色被引用，不能删除，请检查！";
			}else{
				success=T_Sys_UserRoles.dao.deleteByRoleIds(ids);
				if(success)
					success=T_Sys_Role.dao.delete(ids);
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
	
	public void getTreeGridData(){
		try{
			String id="id";
			String name="name";
			Map<Integer, Map<String, String>> funsMap=new HashMap<Integer, Map<String,String>>();
			List<Record> funList=T_Sys_Module.dao.getListByModelType(1);
			
			for(Record funRec:funList){
				Integer key=funRec.getNumber("p_id").intValue();
				Map<String, String> parentFun=funsMap.get(key);
				if(parentFun==null){
					parentFun=new HashMap<String, String>();
					parentFun.put(id, funRec.get("id").toString());
					parentFun.put(name, funRec.getStr("name"));
					funsMap.put(key, parentFun);
				}else{
					String ids=parentFun.get(id)+","+funRec.get("id");
					String names=parentFun.get(name)+","+funRec.getStr("name");
					parentFun.put(id, ids);
					parentFun.put(name, names);
					funsMap.put(key, parentFun);
				}
			}
			
			List<Record> moduleList=T_Sys_Module.dao.getListByModelType(0);
			String json=getTreeGrid(null, moduleList,funsMap);
			System.out.println(json);
			renderText(json);
		}catch (Exception e) {
			e.printStackTrace();
			renderText("[]");
		}
	}
	
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		Integer suporg=getParaToInt("suporg");
		String str = "";
		if(suporg!=null){
			str = "suporg="+suporg;
		}
		//获取表格表页数据
		Page<Record> page=Paginate.dao.getPage("t_sys_role", pageSize, pageNumber, str, "role_id", null);
		
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		//String jsonStr=JsonUtil.getGridData(list, totalCount);
		//调用JsonUtil函数返回treegrid表格json数据
		String jsonStr=JsonUtil.getTreeGridData(list, totalCount, "pid");
		renderText(jsonStr);
	}
	
	

	/**
	 * 获取组织机构树结构json
	 * 
	 * @param   parentRec   欲获取树的根节点对象(null为获取所有节点)
	 * @param   deptList	组织机构所有数据
	 * @param	funsMap		功能点集合
	 * @return				返回树结构json
	 * @throws Exception    异常
	 */
	public String getTreeGrid(Record parentRec,List<Record> deptList,Map<Integer, Map<String, String>> funsMap) throws Exception{
		
		try{
			List<Map<String,Object>> rootList=new ArrayList<Map<String,Object>>();
			if(deptList!=null){
				if(parentRec==null){
					for(Record dept:deptList){
						if(dept.getNumber("p_id").intValue()==0)
							rootList.add(getChildrenNode(dept, deptList,funsMap));
					}
				}else
					rootList.add(getChildrenNode(parentRec, deptList,funsMap));
			}
			return JSONArray.toJSONString(rootList);
		}catch (Exception e) {
			throw e;
		}
	}
	
	/**
	 * 获取树当前节点所有子节点数据，用于递归
	 * 
	 * @param   parentRec   节点对象
	 * @param   deptList	节点所有数据对象
	 * @return				返回树结构json
	 */
	public Map<String,Object> getChildrenNode(Record parentRec,List<Record> deptList,Map<Integer, Map<String, String>> funsMap){
		List<Map<String,Object>> childList=new ArrayList<Map<String,Object>>();
		Map<String,Object> parentMap = new HashMap<String,Object>();
		
		parentMap.put("id", parentRec.get("id"));
		parentMap.put("name", parentRec.get("name"));
		parentMap.put("pid", parentRec.get("p_id"));
		parentMap.put("iconCls", parentRec.get("iconclass"));
		
		Map<String,String> tempMap=funsMap.get(parentRec.getNumber("id").intValue());
		
		if(tempMap!=null){
			String id="id";
			String name="name";
			parentMap.put("funId", tempMap.get(id));
			parentMap.put("funName", tempMap.get(name));
		}
		
		for(Record rec:deptList){
			if(parentRec.get("id").equals(rec.get("p_id"))){
				childList.add(getChildrenNode(rec, deptList,funsMap));
			}
		}
		
		if(childList.size()!=0)
			parentMap.put("children", childList);
		
		return parentMap;
		
	}
}
