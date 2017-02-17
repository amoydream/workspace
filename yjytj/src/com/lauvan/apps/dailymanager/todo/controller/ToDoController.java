package com.lauvan.apps.dailymanager.todo.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.dailymanager.document.model.T_Receive_Doc;
import com.lauvan.apps.dailymanager.todo.model.T_ThingInfo;
import com.lauvan.apps.dailymanager.workhandover.model.T_DutyRecord_Content;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/todo", viewPath = "/dailymanager/todo")
public class ToDoController extends BaseController {
	private static final Logger log = Logger.getLogger(ToDoController.class);
	public void todoall() {
		render("todoallmain.jsp");
	}
	public void needtodo() {
		render("needtodo.jsp");
	}
	public void havetodo() {
		render("havetodo.jsp");
	}
	//获取事宜
	public void getallGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("tname");
		String code = getPara("tcode");
		Page<Record> page;
		LoginModel loginModel = getSessionAttr("loginModel");
		page = T_ThingInfo.dao.getallGridPage(pageNumber, pageSize, code, name,
				loginModel,null);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
		public void getneedGridData() {
			Integer pageSize = getParaToInt("rows");
			Integer pageNumber = getParaToInt("page");
			String name = getPara("ntname");
			String code = getPara("ntcode");
			Page<Record> page;
			LoginModel loginModel = getSessionAttr("loginModel");
			page = T_ThingInfo.dao.getallGridPage(pageNumber, pageSize, code, name,
					loginModel,"0");
			List<Record> list = page.getList();
			int totalCount = page.getTotalRow();
			// 调用JsonUtil函数返回datagrid表格json数据
			String jsonStr = JsonUtil.getGridData(list, totalCount);
			renderText(jsonStr);
		}
		public void gethaveGridData() {
			Integer pageSize = getParaToInt("rows");
			Integer pageNumber = getParaToInt("page");
			String name = getPara("htname");
			String code = getPara("htcode");
			Page<Record> page;
			LoginModel loginModel = getSessionAttr("loginModel");
			page = T_ThingInfo.dao.getallGridPage(pageNumber, pageSize, code, name,
					loginModel,"1");
			List<Record> list = page.getList();
			int totalCount = page.getTotalRow();
			// 调用JsonUtil函数返回datagrid表格json数据
			String jsonStr = JsonUtil.getGridData(list, totalCount);
			renderText(jsonStr);
		}
	public void todoadd() {
		render("add.jsp");
	}

	public void todoupd(){
    String id=getPara(0);
    String type=getPara(1);
    T_ThingInfo it=T_ThingInfo.dao.getinfo(id,type);
    setAttr("it",it);
    render("update.jsp");	
    }

	public void save() {
		try {
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			boolean success = false;
			String methodname = "add";
			String act = getPara("act");
			String alt = "";
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			T_ThingInfo ti = getModel(T_ThingInfo.class);
			ti.set("recordman", userid).set("recordtime", sdf.format(date));
			if (act.equals("upd")) {
				ti.update();
				success = true;
				methodname = "update";
				alt = "修改成功！";
			} else {
				ti.set("id", AutoId.nextval(ti));
				ti.set("thingstatus", 0);
				ti.set("type","001");
				ti.save();
				success = true;
				alt = "保存成功！";
			}
			T_Sys_Operation_Log.dao.insert(success, userid.toString(),
					"Main/todo/todoadd", methodname, ti,getRequest());
			toDwzText(success, alt, "", "todoDialog", "todoallGrid",
					"closeCurrent");
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}
	 public void tododel(){
			String ids=getPara("ids");
			String[] id=ids.split(",");
			LoginModel loginModel=getSessionAttr("loginModel");
			 Number userid=loginModel.getUserId();
			Map<String,Object> map = new HashMap<String,Object>();
			boolean success=false;
			String msg="";
			String errorCode="info";
			try {
			for(String i:id){
			T_ThingInfo ti=T_ThingInfo.dao.findById(i);
			ti.delete();
			T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/todo/tododel", "delete",ti,getRequest());	
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
	 //详情
	 public void todoview(){
		    String id=getPara(0);
		    String type=getPara(1);
		    T_ThingInfo it=T_ThingInfo.dao.getinfo(id,type);
		    T_ThingInfo tempit=T_ThingInfo.dao.findById(id);
		    //值班事宜查看后变为已办
		    if(type.equals("003")){
		    tempit.set("thingstatus", "1").update();
		    }
		    //公文查看后为已读，已读者的事宜为已办结
		    if(type.equals("002")){
		    String readed=tempit.getStr("readed");
		    LoginModel loginModel=getSessionAttr("loginModel");
			 Number userid=loginModel.getUserId();
			 if(readed==null){
			 readed=""+userid;	 
			 }else{
			 readed+=","+userid;
			 }
			 tempit.set("readed", readed).update();
		    }
		    setAttr("it",it);
		    render("view.jsp");	
		    } 
	 //办结
	 public void todomaking(){
			String id = getPara(0);
			LoginModel loginModel=getSessionAttr("loginModel");
			 Number userid=loginModel.getUserId();
			Map<String,Object> map = new HashMap<String,Object>();
			boolean success=false;
			String msg="";
			String errorCode="info";
			try {
			T_ThingInfo ti=T_ThingInfo.dao.findById(id);
			ti.set("thingstatus", "1");
			ti.update();
			T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/todo/todomaking", "todomaking",ti,getRequest());			
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
	// 获取事件
	public void getEvents() {
		render("findData/eventList.jsp");
	}

	public void geteventbyname() {
		String ename = getPara("ename");
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		Page<Record> event = T_Bus_EventInfo.dao.getalleventlist(pageSize,
				pageNumber, ename);
		List<Record> list = event.getList();
		int totalCount = event.getTotalRow();
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
}
