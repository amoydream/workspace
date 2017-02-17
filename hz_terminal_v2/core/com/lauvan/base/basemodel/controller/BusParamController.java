package com.lauvan.base.basemodel.controller;
/**
 * 业务字典控制类
 * @author 黄丽凯
 * */
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Module;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/busParam",viewPath="/base/basemodel/busParam")
public class BusParamController extends BaseController {
	public void main(){
		String pcode = getPara(0);
		setAttr("pcode",pcode);
		String flag = getPara(1);
		setAttr("ztreename",pcode);
		//根据pcode获取对应的树节点
		T_Sys_Parameter root = T_Sys_Parameter.dao.getByCode3(pcode);
		setAttr("root",root);
		if(root!=null){
			setAttr("apId",root.get("id").toString());
		}else{
			setAttr("apId",0);
		}
		if("1".equals(flag)){
			//树页面
			List<Record> rlist = T_Sys_Parameter.dao.getParamByCode(pcode, false);
			setAttr("rlist",rlist);
			render("main_tree.jsp");
		}else{
			//列表页面
			render("main.jsp");
		}
	}
	
	public void getTreeData(){
		String pid = getPara("id");
		T_Sys_Parameter root = null ;
		if(pid==null || "".equals(pid)){
			pid = getPara("rootid");
			root = T_Sys_Parameter.dao.findById(pid);
		}
		List<Record> list = T_Sys_Parameter.dao.getChildTree(pid);
		if(root!=null){
			Record r = new Record();
			r.set("ID", root.get("id"));
			r.set("P_NAME", root.getStr("p_name"));
			r.set("SUP_ID", root.get("sup_id"));
			r.set("ISLEAF", 1);
			list.add(r);
		}
		renderJson(list);
	}
	
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String id = getPara("pid");
		String searchid = getPara("searchid");
		String pname = getPara("pname");
		String flag = getPara("flag");
		String jsonStr = "[]";
		String swhere = "";
		if(pname!=null && !"".equals(pname)){
			swhere = swhere +" and p.p_name like '%"+pname+"%' ";
		}
		Page<Record> page = T_Sys_Parameter.dao.getChildPage(pageSize, pageNumber,id, null,swhere,searchid,flag);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void add(){
		String pid = getPara(0);
		setAttr("grid",getPara(1));
		setAttr("treeid",getPara(2));
		setAttr("pid",pid);
		T_Sys_Parameter sup = T_Sys_Parameter.dao.findById(pid);
		if(sup!=null){
			setAttr("fpname",sup.getStr("p_name"));
		}else{
			setAttr("fpname","参数管理");
		}
		render("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		setAttr("grid",getPara(1));
		T_Sys_Parameter t = T_Sys_Parameter.dao.findById(id);
		setAttr("t",t);
		T_Sys_Parameter sup = T_Sys_Parameter.dao.findById(t.get("sup_id"));
		if(sup!=null){
			setAttr("fpname",sup.getStr("p_name"));
		}else{
			setAttr("fpname","参数管理");
		}
		render("edit.jsp");
	}
	
	public void delete(){
		String[] ids=getParaValues("ids");
		//String grid = getPara(0)+"_grid";
		String treeid = getPara(0);
		ids = ArrayUtils.removeDuplicate(ids);
		String id = ArrayUtils.ArrayToString(ids);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="删除异常，请检查！";
		String errorCode="info";
		try {
			//获取刷新的父级节点
			String supid = T_Sys_Parameter.dao.getSupids(id);
			//删除节点下的所有子节点
			T_Sys_Parameter.dao.deleteAllChildren(id);
			success = T_Sys_Parameter.dao.deleteByIds(id);
			if(success){
				msg = "删除成功！";
				map.put("treeObj", treeid);
				if(supid!=null && !"".equals(supid) && supid.indexOf(",")<0){
					map.put("idkey", "id");
					map.put("reloadid", supid);
				}
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
		String act = getPara("act");
		String grid = getPara("grid");
		String treeid = getPara("treeid");
		T_Sys_Parameter t = getModel(T_Sys_Parameter.class);
		String sup_id = t.get("sup_id").toString();
		boolean success = false;
		if("add".equals(act)){
			success = T_Sys_Parameter.dao.insert(t);
		}else{
			success = t.update();
		}
		if(success){
			if(treeid!=null && !"".equals(treeid)){
				renderText("{\"success\":"+success+",\"dialogid\":\"busParamDialog\",\"gridid\":\""
						+grid+"\",\"treeObj\":\""+treeid+"\",\"reloadid\":"+sup_id+",\"idkey\":\"id\"}");
			}else{
				toDwzText(success, "保存成功！", "", "busParamDialog", grid, "closeCurrent");
			}
		}else{
			toDwzText(success, "保存异常！", "", "", "", "");
		}
	}
	
	//获取业务字典菜单目录
	public void getBusModelTree(){
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Module.dao.getChildMenu("busParam");
			Map<String,String> outputKey = new HashMap<String,String>();
			outputKey.put("id", "id");
			outputKey.put("text", "name");
			jsonStr=JsonUtil.getTreeData(list.get(0), false, list, "id", "p_id", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}
	
	//获取类型树
	public void getTypeTree(){
		String jsonStr = "[]";
		String acode = getPara(0);
		String flag = getPara(1);
		String flag2 = getPara(2);
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode(acode,"1".equals(flag)?true:false);
			Map<String,String> outputKey = new HashMap<String,String>();
			outputKey.put("id", "p_acode");
			outputKey.put("text", "p_name");
			jsonStr=JsonUtil.getTreeData(list.get(0), "1".equals(flag2)?true:false, list, "id", "sup_id", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}
}
