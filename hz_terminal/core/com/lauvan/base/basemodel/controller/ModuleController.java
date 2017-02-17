package com.lauvan.base.basemodel.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;


import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Module;
import com.lauvan.base.main.model.GridData;

import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "/Main/module", viewPath = "/base/basemodel/module")
public class ModuleController extends BaseController {

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
		T_Sys_Module model=T_Sys_Module.dao.findById(id);
		
		setAttr("model", model);
		render("edit.jsp");
	}
	

	public void save(){
		String act=getPara("act");
		boolean success=false;
		T_Sys_Module model=getModel(T_Sys_Module.class);
		String pid = model.get("p_id").toString();
		if(act.equals("add")){
			model.set("id", AutoId.nextval(model));
			success=model.save();
		}else{
			success=model.update();
		}
		if(success){
			toDwzText(success, "保存成功！", "module_data", "modelDialog", "", "closeCurrent",pid);
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
			if(!T_Sys_Module.dao.hasSonModule(ids)){
				if(ids!=null && ids.length>0){
					T_Sys_Module t = T_Sys_Module.dao.findById(ids[0]);
					map.put("treeid", Integer.parseInt(t.get("p_id").toString()));
				}
				success=T_Sys_Module.dao.delete(ids);
			}
			else{
				msg="删除节点存在子模块信息";
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
	
	//判断是否存在模块标识
	public void ifExsitMark(){
		String mark=getPara("mark");
		Integer id=getParaToInt("id");
		boolean flag=T_Sys_Module.dao.ifExsitMark(mark, id);
		
		renderJson("{\"success\":"+flag+"}");
	}
	
	public void getGridData(){
		/*Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");*/
		Integer pid=getParaToInt("pid");
		String str = "p_id=0";
		if(pid!=null){
			str = "p_id="+pid;
		}
		String zd = " ,iconclass as iconCls";
		//获取表格表页数据
		/*Page<Record> page=Paginate.dao.getPage("t_sys_module",zd, pageSize, pageNumber, str, "p_id, orderindex", null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();*/
		//调用JsonUtil函数返回datagrid表格json数据
		//String jsonStr=JsonUtil.getGridData(list, totalCount);
		List<Record> list = GridData.dao.treeList("t_sys_module","p_id", zd, str, "p_id, orderindex", null);
		int totalCount=list!=null?list.size():0;
		String jsonStr=JsonUtil.getTreeGridData(list, totalCount, "p_id");
		renderText(jsonStr);
	}
	
	public void getTreeData(){
		
		String idKey=StringUtils.isBlank(getPara("idKey"))?"id":getPara("idKey");
		String pidKey=StringUtils.isBlank(getPara("pidKey"))?"pid":getPara("pidKey");
		
		List<T_Sys_Module> moduleList=T_Sys_Module.dao.getAllModule();
		
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		Map<String,Object> row = new HashMap<String,Object>();
		Map<String,Object> root = new HashMap<String,Object>();
		
		root.put(idKey, "0");
		root.put("name", "系统功能模块");
		root.put(pidKey, "");
		dataList.add(root);
		
		for(T_Sys_Module de:moduleList){
			row=new HashMap<String,Object>();
			row.put(idKey, de.get("id"));
			row.put("name", de.get("name"));
//			row.put("iconSkin", de.get("iconclass"));
			row.put(pidKey, de.get("p_id"));
			dataList.add(row);
		}
		renderJson(dataList);
	}
}
