package com.lauvan.base.main.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.geographic.model.T_Bus_MapConfig;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Module;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;
import com.lauvan.util.PermitHandler;
import com.lauvan.util.Pwd;


@RouteBind(path = "/Main", viewPath = "/base")
public class MainController extends Controller {

	public void index(){
		//LoginModel loginModel=getSessionAttr("loginModel");
		
		//Integer rootMenuId=8;
		LoginModel loginModel=getSessionAttr("loginModel");
		//获取系统导航条参数
		String rootCode = loginModel.getRootOrgCode();
		List<T_Sys_Parameter> plist = T_Sys_Parameter.dao.getByStartCode(rootCode, "SYSSET");
		if(plist!=null && plist.size()>0){
			for(T_Sys_Parameter p : plist){
				String pname = p.getStr("p_name");
				String pacode = p.getStr("p_acode");
				if((rootCode+"_name").equals(pname)){
					setAttr("sysname",pacode);
				}
				if((rootCode+"_color").equals(pname)){
					setAttr("syscolor",pacode);
				}
				if((rootCode+"_syscebian").equals(pname)){
					setAttr("cebian",pacode);
				}
				if((rootCode+"_mlayout").equals(pname)){
					List<Record> fmenuList = T_Sys_Module.dao.getFirstMenu();
					setAttr("fmenuList",fmenuList);
					if("1".equals(pacode)){
						//一级菜单
						setAttr("sysmlayout",pacode);
					}
				}
				if((rootCode+"_syswin").equals(pname)){
					if("1".equals(pacode)){
						setAttr("tabflag","only");//单窗口模式
					}
				}
				if((rootCode+"_sysmodel").equals(pname)){
					Record model = T_Sys_Module.dao.getByID(pacode);
					//T_Sys_Module model = T_Sys_Module.dao.findById(pacode);
					if(model!=null && PermitHandler.haspermit(model.getNumber("id").intValue(), loginModel.getLimit())){
						//默认主页有权限
						setAttr("clickflag","defopen");
						Record node = new Record();
						node.set("text", model.getStr("name"));
						node.set("url", model.getStr("address"));
						node.set("iconCls", model.getStr("iconclass"));
						node.set("onlytext", model.getStr("onlytext"));
						node.set("id", model.get("id"));

						//setAttr("tabNode",node);
						String jsonNode = JsonKit.toJson(node);
						jsonNode = jsonNode.replace("ONLYTEXT", "onlytext");
						jsonNode = jsonNode.replace("TEXT", "text");
						jsonNode = jsonNode.replace("URL", "url");
						jsonNode = jsonNode.replace("ICONCLS", "iconCls");
						setAttr("jsonNode",jsonNode);
						
						T_Sys_Module rootMenu=T_Sys_Module.dao.getRootModule(model.getBigDecimal("id").intValue());
						setAttr("rootMenu",rootMenu);
					}
				}
			}
		}
		/*T_Sys_Parameter t = T_Sys_Parameter.dao.getByCode(rootCode+"_name","SYSSET");
		if(t!=null){
			setAttr("sysname",t.getStr("p_acode"));
		}
		T_Sys_Parameter t2 = T_Sys_Parameter.dao.getByCode(rootCode+"_color","SYSSET");
		if(t2!=null){
			setAttr("syscolor",t2.getStr("p_acode"));
		}*/
		//获取当前时间
		Calendar c1 = Calendar.getInstance();
		Date now = new Date();
	    c1.setTime(now);
	    String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
	    int w = c1.get(Calendar.DAY_OF_WEEK) - 1;
	    if(w<0){
	    	w=0;
	    }
	    setAttr("_zynowdate",DateTimeUtil.formatDate(now, DateTimeUtil.ZHCN_Y_M_D_FORMAT)+" "+ weekDays[w]);
	    
	    
	    //添加离线地图script连接地址
	    
	    T_Bus_MapConfig mapConfig=T_Bus_MapConfig.dao.getData();
	    if(mapConfig!=null){
	    	setAttr("map",mapConfig);
	    }
	    
		render("main.jsp");
	}
	
	public void menu() throws Exception{
		Integer menuId=getParaToInt(0);
		LoginModel loginModel=getSessionAttr("loginModel");
		String[] temp=loginModel.getLimit().split(",");
		Integer[] menuIds=ArrayUtils.ArrayToInteger(temp);

		List<Record> list =  T_Sys_Module.dao.findByListId(menuIds, null);
		T_Sys_Module parentMo=T_Sys_Module.dao.findById(menuId);
		Map<String, String> map=new HashMap<String, String>();
		map.put("id", "id");
		map.put("text", "name");
		map.put("url", "address");
		map.put("iconCls", "iconclass");
		map.put("opentype", "opentype");
		map.put("onlytext", "onlytext");
		
		String json=JsonUtil.getTreeData(parentMo.toRecord(),true, list, "id", "p_id", map);
		System.out.println(json);
		setAttr("treeData", json);
		setAttr("menuTreeID", menuId);
		render("basemodel/main/menu.jsp");
	}
	
	public void getMenu(){
		Integer rootId=getParaToInt(0);
		LoginModel loginModel=getSessionAttr("loginModel");
		String[] temp=loginModel.getLimit().split(",");
		Integer[] menuIds=ArrayUtils.ArrayToInteger(temp);
		Integer[] parentIds={rootId};
		
		List<Record> list =  T_Sys_Module.dao.findByListId(menuIds, parentIds);
		renderText(JsonKit.toJson(list));
	}
	
	public void pwordset(){
		LoginModel login = getSessionAttr("loginModel");
		String userAccount = login.getUserAccount();
		setAttr("useraccount",userAccount);
		setAttr("userid",login.getUserId());
		render("password.jsp");
	}
	
	public void pwordSave(){
		String uid = getPara("userid");
		String pwd =getPara("pwd");
		boolean success=false;
		T_Sys_User user = T_Sys_User.dao.findById(uid);
		user.set("password", Pwd.encrypt(pwd));
		success = user.update();
		renderText("{\"success\":"+success+",\"msg\":\"修改成功！\",\"dialogid\":\"pwdDialog\",\"callbackType\":\"closeCurrent\"}");
	}
	
	//主页标题以及图片设置
	public void systemSet(){
		//查询数据字典表，查找系统名称
		LoginModel login = getSessionAttr("loginModel");
		String rootCode = login.getRootOrgCode();
		/*T_Sys_Parameter t = T_Sys_Parameter.dao.getByCode(rootCode+"_name","SYSSET");
		if(t!=null){
			setAttr("sysname",t.getStr("p_acode"));
		}
		//标题底色图片
		T_Sys_Parameter t2 = T_Sys_Parameter.dao.getByCode(rootCode+"_color","SYSSET");
		if(t2!=null){
			setAttr("sysjpg",t2.getStr("p_acode"));
		}*/
		List<T_Sys_Parameter> plist = T_Sys_Parameter.dao.getByStartCode(rootCode, "SYSSET");
		if(plist!=null && plist.size()>0){
			for(T_Sys_Parameter p : plist){
				String pname = p.getStr("p_name");
				String pacode = p.getStr("p_acode");
				if((rootCode+"_name").equals(pname)){
					setAttr("sysname",pacode);
				}
				if((rootCode+"_color").equals(pname)){
					setAttr("sysjpg",pacode);
				}
				if((rootCode+"_mlayout").equals(pname)){
					setAttr("sysMenu",pacode);
				}
				if((rootCode+"_syswin").equals(pname)){
					setAttr("sysWin",pacode);
				}
				if((rootCode+"_sysmodel").equals(pname)){
					setAttr("sysTab",pacode);
				}
				if((rootCode+"_syscebian").equals(pname)){
					setAttr("syscebian",pacode);
				}
			}
		}
		setAttr("dept",rootCode);
		T_Sys_Department d = T_Sys_Department.dao.findById(login.getRootOrgId());
		setAttr("deptname",d.getStr("d_name"));
		render("systemSet.jsp");
	}
	public void systemSetSave(){
		try {
			//查询数据字典表，查找系统名称
			LoginModel login = getSessionAttr("loginModel");
			String rootCode = login.getRootOrgCode();
			T_Sys_Parameter sys = T_Sys_Parameter.dao.getByCode3("SYSSET");
			T_Sys_Parameter nt = T_Sys_Parameter.dao.getByCode(rootCode+"_name","SYSSET");
			if(nt!=null && nt.get("id")!=null && !"".equals(nt.get("id").toString())){
				nt.set("p_acode", getPara("sysname"));
				nt.update();
			}else{
				nt = new T_Sys_Parameter();
				nt.set("p_name", rootCode+"_name");
				nt.set("p_acode", getPara("sysname"));
				nt.set("sup_id", sys.get("id"));
				T_Sys_Parameter.dao.insert(nt);
			}
			//标题底色图片
			T_Sys_Parameter t2 = T_Sys_Parameter.dao.getByCode( rootCode+"_color","SYSSET");
			if(t2!=null){
				t2.set("p_acode",getPara("syscolor"));
				t2.update();
			}else{
				t2 = new T_Sys_Parameter();
				t2.set("p_name", rootCode+"_color");
				t2.set("p_acode", getPara("syscolor"));
				t2.set("sup_id", sys.get("id"));
				T_Sys_Parameter.dao.insert(t2);
			}
			T_Sys_Parameter t3 = T_Sys_Parameter.dao.getByCode( rootCode+"_mlayout","SYSSET");
			if(t3!=null){
				t3.set("p_acode",getPara("sysMenu"));
				t3.update();
			}else{
				t3 = new T_Sys_Parameter();
				t3.set("p_name", rootCode+"_mlayout");
				t3.set("p_acode", getPara("sysMenu"));
				t3.set("sup_id", sys.get("id"));
				T_Sys_Parameter.dao.insert(t3);
			}
			T_Sys_Parameter t4 = T_Sys_Parameter.dao.getByCode( rootCode+"_syswin","SYSSET");
			if(t4!=null){
				t4.set("p_acode",getPara("sysWin"));
				t4.update();
			}else{
				t4 = new T_Sys_Parameter();
				t4.set("p_name", rootCode+"_syswin");
				t4.set("p_acode", getPara("sysWin"));
				t4.set("sup_id", sys.get("id"));
				T_Sys_Parameter.dao.insert(t4);
			}
			T_Sys_Parameter t5 = T_Sys_Parameter.dao.getByCode( rootCode+"_sysmodel","SYSSET");
			if(t5!=null){
				t5.set("p_acode",getPara("sysTab"));
				t5.update();
			}else{
				t5 = new T_Sys_Parameter();
				t5.set("p_name", rootCode+"_sysmodel");
				t5.set("p_acode", getPara("sysTab"));
				t5.set("sup_id", sys.get("id"));
				T_Sys_Parameter.dao.insert(t5);
			}
			T_Sys_Parameter t6 = T_Sys_Parameter.dao.getByCode( rootCode+"_syscebian","SYSSET");
			if(t6!=null){
				t6.set("p_acode",getPara("syscebian"));
				t6.update();
			}else{
				t6 = new T_Sys_Parameter();
				t6.set("p_name", rootCode+"_syscebian");
				t6.set("p_acode", getPara("syscebian"));
				t6.set("sup_id", sys.get("id"));
				T_Sys_Parameter.dao.insert(t6);
			}
			renderText("{\"success\":true,\"msg\":\"设置成功！\",\"dialogid\":\"sysSetDialog\",\"callbackType\":\"closeCurrent\",\"forward\":\"/Main\"}");
		} catch (Exception e) {
			renderText("{\"success\":false,\"msg\":\"设置异常！\"}");
			e.printStackTrace();
		}
	}
}
