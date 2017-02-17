package com.lauvan.apps.dailymanager.document.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.dailymanager.document.model.T_Receive_Doc;
import com.lauvan.apps.dailymanager.todo.model.T_ThingInfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/document", viewPath = "/dailymanager/document")
public class DocumentController extends BaseController {
	private static final Logger log = Logger.getLogger(DocumentController.class);

	public void docsend() {
		render("smain.jsp");
	}

	public void docreceive() {
		render("rmain.jsp");
	}

	public void getsGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("dname");
		String code = getPara("dcode");
		Page<Record> page;
		LoginModel loginModel = getSessionAttr("loginModel");
		page = T_Receive_Doc.dao.getsGridPage(pageNumber, pageSize, code, name, loginModel);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void getrGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("dname");
		String code = getPara("dcode");
		Page<Record> page;
		LoginModel loginModel = getSessionAttr("loginModel");
		page = T_Receive_Doc.dao.getrGridPage(pageNumber, pageSize, code, name, loginModel);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void docadd() {
		LoginModel login = getSessionAttr("loginModel");
		setAttr("userid", login.getUserId());
		render("add.jsp");
	}

	public void save() {
		try {
			boolean success = false;
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			String methodname = "add";
			String act = getPara("act");
			String receivetype = getPara("receivetype");
			String receiveid = getPara("receiveid");
			T_Receive_Doc rdc = getModel(T_Receive_Doc.class);
			String[] fjids = getParaValues("fjid");
			String fj = "";
			if(fjids != null) {
				for(String temp : fjids) {
					fj = fj + temp.toString() + ",";
				}
				fj = fj.substring(0, fj.length() - 1);
				rdc.set("gwfjid", fj);
			}
			T_ThingInfo ti = new T_ThingInfo();
			if(receivetype.equals("user")) {
				rdc.set("receiver", receiveid);
				ti.set("receiver", receiveid);
			} else {
				rdc.set("receiver_dept", receiveid);
				ti.set("receiver_dept", receiveid);
			}
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			rdc.set("sender", userid).set("sendtime", sdf.format(date));
			String alt = "";
			if(act.equals("upd")) {
				rdc.update();
				success = true;
				methodname = "update";
				alt = "修改成功！";
			} else {
				rdc.set("id", AutoId.nextval(rdc));
				Number thingid = AutoId.nextval(ti);
				ti.set("id", thingid).set("name", rdc.getStr("name")).set("content", rdc.getStr("content")).set("thingstatus", "0").set("recordman", userid);
				ti.set("recordtime", sdf.format(date)).set("note", rdc.getStr("note")).set("receivername", rdc.getStr("receivename")).set("type", "002");
				ti.save();
				rdc.set("thingid", thingid);
				rdc.save();
				success = true;
				alt = "保存成功！";
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/document/docsend", methodname, rdc, getRequest());
			}
			toDwzText(success, alt, "", "docDialog", "documentGrid", "closeCurrent");
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}

	public void getUsers() {
		setAttr("checktype", "user");
		//获取当前市县用户
		LoginModel login = getSessionAttr("loginModel");
		String suporg = login.getRootOrgId().toString();
		List<Record> userlist = new ArrayList<Record>();
		if(login.getIsSuper()) {
			userlist = T_Sys_User.dao.getUsableUser();
		} else {
			userlist = T_Sys_User.dao.getUsableUser(suporg);
		}
		String userJson = JsonKit.toJson(userlist);
		setAttr("userList", userJson);
		render("findData/checkuser.jsp");
	}

	//用户数据
	public void getCheckData() {
		String checktype = getPara("checktype");
		List<Record> list = new ArrayList<Record>();
		int totalCount = 0;
		String pid = "";
		if("user".equals(checktype)) {
			//list = T_Sys_Department.dao.getDepartmentList(suporg);
			List<T_Sys_Department> baseorgans = T_Sys_Department.dao.find("select * from t_sys_department where d_pid=0");
			list = T_Sys_Department.dao.getOrgans(baseorgans);
			pid = "d_pid";
		} else {
			list = Paginate.dao.getList("t_sys_department", " d_name as checkname,d_id as id,d_pid as pid", "1=1 order by d_id desc");
			//list = Paginate.dao.getList("t_sys_role", " role_name as checkname,role_id as id,pid", str);
			pid = "pid";
		}
		totalCount = list.size();
		String jsonStr = JsonUtil.getTreeGridData(list, totalCount, pid);
		renderText(jsonStr);
	}

	//打开文件
	public void getfileview() {
		String id = getPara(0);
		String type = getPara(1);
		LoginModel login = getSessionAttr("loginModel");
		Number uid = login.getUserId();
		T_Sys_User user = T_Sys_User.dao.findById(uid);
		T_Attachment attachment = T_Attachment.dao.findById(id);
		String url = attachment.getStr("URL");
		if(!url.startsWith("/") && url.indexOf(":") != 1) {
			setAttr("newPath", PathKit.getWebRootPath() + "/" + attachment.getStr("URL"));
		} else {
			setAttr("newPath", url);
		}
		setAttr("username", user.get("user_name"));
		setAttr("type", type);
		render("findData/fjview.jsp");
	}

	//打开pdf
	public void getpdfview() {
		String id = getPara("id");
		String title = getPara("title");
		T_Attachment attachment = T_Attachment.dao.findById(id);
		String url = attachment.getStr("URL");
		if(!url.startsWith("/") && url.indexOf(":") != 1) {
			setAttr("newPath", PathKit.getWebRootPath() + "/" + attachment.getStr("URL"));
		} else {
			setAttr("newPath", url);
		}
		setAttr("title", title);
		render("findData/pdfview.jsp");
	}

	//查看详情
	private String saveDirectory = JFWebConfig.saveDirectory;

	public void docview() {
		String savepath = saveDirectory;
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("FJDZ", "UPDZ");
		if(p != null) {
			savepath = p.getStr("p_acode");
		}
		String id = getPara(0);
		T_Receive_Doc rdc = T_Receive_Doc.dao.getinfo(id);
		List<T_Attachment> fjlist = T_Attachment.dao.getListByIds(rdc.getStr("gwfjid"));
		String nurl;
		if(fjlist != null) {
			for(T_Attachment att : fjlist) {
				nurl = att.getStr("url");
				if(nurl.startsWith("/") || nurl.indexOf(":") == 1) {
					nurl = nurl.replace(savepath, "/yj/fjdoc");
					att.set("url", nurl);
				}
			}
		}
		setAttr("rdc", rdc);
		setAttr("fileList", fjlist);
		render("view.jsp");
	}

	public void docdel() {
		String ids = getPara("ids");
		String[] id = ids.split(",");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		try {
			for(String i : id) {
				T_Receive_Doc rdc = T_Receive_Doc.dao.findById(i);
				List<T_Attachment> attlist = T_Attachment.dao.getListByIds(rdc.getStr("gwfjid"));
				if(attlist != null) {
					for(T_Attachment model : attlist) {
						String url = model.getStr("url");
						if(!url.startsWith("/") && url.indexOf(":") != 1) {
							url = PathKit.getWebRootPath() + "/" + model.getStr("url");
						}
						File file = new File(url);
						if(file.exists()) {
							file.delete();
						}
						model.delete();
					}
				}
				T_ThingInfo thing = T_ThingInfo.dao.findById(rdc.get("thingid"));
				if(thing != null) {
					thing.delete();
				}
				rdc.delete();
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/document/docsend", "delete", rdc, getRequest());
			}
			success = true;
		} catch(Exception e) {
			log.error(e.getMessage());
			errorCode = "error";
			msg = e.getMessage();
			e.printStackTrace();
		} finally {
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
}
