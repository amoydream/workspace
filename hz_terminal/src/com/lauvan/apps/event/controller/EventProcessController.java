package com.lauvan.apps.event.controller;

/**
 * 过程信息控制类
 * @author 黄丽凯
 * */
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.jfinal.aop.Clear;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import com.lauvan.apps.communication.ccms.util.ConvertPrintUtil;
import com.lauvan.apps.communication.linkman.model.T_Bus_Linkman;
import com.lauvan.apps.communication.linkman.model.T_Bus_Linkman_Qun;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.event.model.T_Bus_EventProcess;
import com.lauvan.apps.event.model.T_Bus_Fax_Task;
import com.lauvan.apps.event.model.T_Bus_SmsSendRD;
import com.lauvan.apps.massms.service.MasSms;
import com.lauvan.apps.workcontact.model.T_Bus_ContactBook;
import com.lauvan.apps.workcontact.model.T_Bus_EmergencyContact;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.FileUtils;
import com.lauvan.util.JsonUtil;


@RouteBind(path = "Main/eventProcess", viewPath = "/event/process")
public class EventProcessController extends BaseController {
	private int			maxPostSize		= JFWebConfig.maxPostSize;
	protected String	tifConvertUrl	= JFWebConfig.attrMap.get("tifConvertUrl");

	public void index() {
		setAttr("eventid", getPara("eventid"));
		setAttr("estatus", getPara("estatus"));
		render("main.jsp");
	}

	public void getDataGrid() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String eventid = getPara(0);
		Page<Record> page = T_Bus_EventProcess.dao.getPageByEventid(pageSize, pageNumber, eventid);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		String flag = getPara(0);
		String eventid = getPara(1);
		setAttr("eventid", eventid);
		if("fk".equals(flag)) {
			//反馈页面
			//获取组织机构
			List<Record> olist = T_Sys_Department.dao.getAllDepartments();
			if(olist != null && olist.size() > 0) {
				for(Record organ : olist) {
					String pid = organ.get("d_pid").toString();
					organ.set("pid", "d_" + pid);
					organ.set("upid", "u_" + pid);
				}
			}
			setAttr("orglist", olist);
			//日常机构人员
			List<Record> deptlist = T_Bus_Organ.dao.getAllOrgans();
			if(deptlist != null && deptlist.size() > 0) {
				for(Record organ2 : deptlist) {
					String pid = organ2.get("or_pid").toString();
					organ2.set("pid", "od_" + pid);
					organ2.set("upid", "ou_" + pid);
				}
			}
			setAttr("orglist2", deptlist);
			//获取群组
			/*List<Record> clulist = T_Bus_EmergencyContact.dao.getAllEmergencys();
			if(clulist != null && clulist.size() > 0) {
				for(Record clu : clulist) {
					String pid = clu.get("e_pid").toString();
					clu.set("epid", "c_" + pid);
				}
			}
			setAttr("clulist", clulist);*/
			String faxno = JFWebConfig.attrMap.get("ccmsFaxNos");
			setAttr("faxno", "," + faxno + ",");
			//render("add_fk.jsp");
			//获取部门
			/*List<Record> dept = T_Bus_Linkman.dao.getdeptlist();
			setAttr("deptlist",dept);*/
			//获取群组
			List<Record> clulist_lm = T_Bus_Linkman_Qun.dao.getqunlist();
			setAttr("clulist",clulist_lm);
			render("add_fk2.jsp");
		} else {
			String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
			setAttr("nowdate", nowdate);
			render("add.jsp");
		}
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_EventProcess t = T_Bus_EventProcess.dao.findById(id);
		if(t == null) {
			toDwzText(false, "该处置信息不存在，请检查！", "", "", "", "closeCurrent");
			return;
		}
		if("0002".equals(t.getStr("ep_type"))) {
			toDwzText(false, "该信息已反馈，不能修改，请检查！", "", "", "", "closeCurrent");
			return;
		}
		String userid = t.get("user_id").toString();
		LoginModel login = getSessionAttr("loginModel");
		if(!login.getIsAdmin() && !userid.equals(login.getUserId().toString())) {
			toDwzText(false, "只能修改自己记录的处置信息，请检查！", "", "", "", "closeCurrent");
			return;
		}
		setAttr("p", t);
		T_Sys_User user = T_Sys_User.dao.findById(userid);
		setAttr("username", user.getStr("user_name"));
		render("edit.jsp");
	}

	public void delete() {
		String id = getPara("id");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "删除成功！";
		String errorCode = "info";
		try {
			T_Bus_EventProcess t = T_Bus_EventProcess.dao.findById(id);
			if(t != null) {
				if(!"0002".equals(t.getStr("ep_type"))) {
					LoginModel login = getSessionAttr("loginModel");
					String uid = login.getUserId().toString();
					if(!login.getIsAdmin() && !uid.equals(t.get("user_id").toString())) {
						errorCode = "error";
						msg = "只能删除自己提交的过程信息，请检查！";
					} else {
						success = t.delete();
					}
				} else {
					errorCode = "error";
					msg = "该信息已反馈，不能删除，请检查！";
				}
			} else {
				errorCode = "error";
				msg = "该信息不存在，请检查！";
			}
		} catch(Exception e) {
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

	public void save() {
		try {
			T_Bus_EventProcess t = getModel(T_Bus_EventProcess.class);
			String act = getPara("act");
			String msg = "保存成功！";
			String grid = "eventProcessGrid";
			boolean success = true;
			LoginModel login = getSessionAttr("loginModel");
			if("fk".equals(act)) {
				//保存反馈信息
				String date = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
				t.set("ep_user", login.getUserName());
				t.set("ep_date", date);
				t.set("ep_organ", login.getOrgName());
				t.set("ep_type", "0002");//反馈类型
				t.set("ep_reporter", login.getUserName());
				t.set("ep_reportdate", date);
				t.set("user_id", login.getUserId());
				T_Bus_EventProcess.dao.insert(t);
			} else if("sms".equals(act)) {
				//发送短信
				grid = "evSmsGrid";
				String smsnum = getPara("smsnum");
				//smsnum = smsnum.substring(1);
				String content = getPara("smscontent");
				String[] phones = smsnum.split(",");
				if(phones.length > 1000) {
					toDwzText(false, "发送短信号码不能超过1000个，请检查！", "", "", "", "");
					return;
				}
				//调用短信接口
				//int smsid = SmsUtil.sendSMS2(phones, content);
				long smsid = MasSms.send(login.getUserId().toString(), phones, content, "00A");
				if(smsid != 0) {
					String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
					//保存数据
					msg = "提交成功！";
					String eventid = t.get("eventid").toString();
					String sworknum = "";
					T_Bus_ContactBook b = T_Bus_ContactBook.dao.getBookByDepartId(BigDecimal.valueOf(login.getOrgId().longValue()));
					if(b != null) {
						sworknum = b.getStr("bo_worknumber");
					}
					String state = "V";
					if(smsid < 0) {
						state = "F";
						success = false;
						msg = "发送失败，请检查！";
					}
					for(String phone : phones) {
						if(phone != null && !"".equals(phone)) {
							//根据callno，查询名称
							String callname = "";
							T_Bus_Linkman linkman = T_Bus_Linkman.dao.findbytelnum(phone);
							if(linkman!=null){
								callname = linkman.getStr("name");
							}else{
								callname = T_Bus_SmsSendRD.dao.getCallName(phone);
							}
							T_Bus_SmsSendRD sms = new T_Bus_SmsSendRD();
							sms.set("smsid", smsid);
							sms.set("callno", phone);
							sms.set("smsdata", content);
							sms.set("eventid", eventid);
							sms.set("senduser", login.getUserName());
							sms.set("smsnum", sworknum);
							sms.set("sendtime", now);
							sms.set("sendstate", state);
							sms.set("callname", callname);
							T_Bus_SmsSendRD.dao.insert(sms);
						}
					}
				} else {
					msg = "连接短信接口失败，请检查！";
					success = false;
				}
			} else if("add".equals(act)) {
				t.set("user_id", login.getUserId());
				T_Bus_EventProcess.dao.insert(t);
				//将事件状态转为处置中
				String type = t.getStr("ep_type");
				T_Bus_EventInfo e = T_Bus_EventInfo.dao.findById(t.get("eventid"));
				if(e != null) {
					String status = e.getStr("ev_status");
					if("00A".equals(status) && !"0002".equals(type) && !"0005".equals(type)) {
						e.set("ev_status", "00B");
						e.update();
					} else if(!"00C".equals(status) && "0005".equals(type)) {
						e.set("ev_status", "00C");
						e.update();
					}

				}
			} else {
				t.update();
			}
			if(success) {
				toDwzText(true, msg, "", "eventProcessDialog", grid, "closeCurrent");
			} else {
				toDwzText(false, msg, "", "", "", "");
			}
		} catch(Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}
	}

	//获取通讯簿树
	public void getSmsMain() {
		//获取组织机构
		List<Record> olist = T_Sys_Department.dao.getAllDepartments();
		if(olist != null && olist.size() > 0) {
			for(Record organ : olist) {
				String pid = organ.get("d_pid").toString();
				organ.set("pid", "d_" + pid);
				organ.set("upid", "u_" + pid);
			}
		}
		setAttr("orglist", olist);
		//获取群组
		render("add_fk.jsp");
	}

	public void getSmsList() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String id = getPara(0);
		//String bname = getPara("bname");
		String jsonStr = "[]";
		if(!"0".equals(id)&&!"gzllw".equals(id)) {
			Page<Record> page = T_Bus_EventProcess.dao.getPageBySmsid(pageSize, pageNumber, id);
			List<Record> list = page.getList();
			int totalCount = page.getTotalRow();
			//调用JsonUtil函数返回datagrid表格json数据
			jsonStr = JsonUtil.getGridData(list, totalCount);
		}
		renderText(jsonStr);
	}

	//获取过程信息详情页面
	public void getContent() {
		//String eventid = getPara("eventid");
		String id = getPara("id");
		T_Bus_EventProcess ep = T_Bus_EventProcess.dao.findById(id);
		setAttr("ep", ep);
		String userid = ep.get("user_id").toString();
		T_Sys_User user = T_Sys_User.dao.findById(userid);
		setAttr("username", user.getStr("user_name"));
		render("view.jsp");
	}

	//获取短信列表
	public void getSmsGrid() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String eventid = getPara(0);
		Page<Record> page = T_Bus_SmsSendRD.dao.getPageByEventid(pageSize, pageNumber, eventid);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	@Clear
	public void callphone() {
		setAttr("phone", "null".equals(getPara("phone")) ? "" : getPara("phone"));
		setAttr("worknum", "null".equals(getPara("worknum")) ? "" : getPara("worknum"));
		setAttr("eid", getPara("eid"));
		render("callphone.jsp");
	}

	//传真页面
	@Clear
	public void faxOpen() {
		String faxnum = getPara("fax");
		//String rowid = getPara("rowid");
		//String pid = getPara("pid");
		String eid = getPara("eid");
		/*if("yj_organ".equals(pid) || pid.startsWith("od_")){
			rowid = "od_"+rowid;
		}else if("yj_user".equals(pid) || pid.startsWith("ou_")){
			rowid = "ou_"+rowid;
		}else if("hy_organ".equals(pid) || pid.startsWith("d_")){
			rowid = "d_"+rowid;
		}else if("hy_user".equals(pid) || pid.startsWith("u_")){
			rowid = "u_"+rowid;
		}
		//接收对象
		Record receFax = T_Bus_EventProcess.dao.getFaxUserRecord(rowid);*/
		String recename = getPara("recename");
		setAttr("recename", recename);
		if("undefined".equals(faxnum)){
			faxnum = "";
		}
		setAttr("faxnum", faxnum);
		setAttr("eid", eid);
		render("fax.jsp");
	}

	public void faxOpenSave() {
		String taskid = getPara("taskid");
		T_Bus_Fax_Task t = T_Bus_Fax_Task.dao.findById(taskid);
		if(t != null) {
			String title = getPara("_faxtitle");
			//String userfaxnum = getPara("userfaxnum");
			String _callids = getPara("_callids");
			if(_callids != null && !"".equals(_callids)) {
				_callids = _callids.substring(1);
			}
			//String _ceids = getPara("_ceids");
			String eid = getPara("eventid");
			t.set("fax_task_title", title);
			t.set("eventid", eid);
			t.set("file_state", "1");
			t.set("callid", _callids);
			t.update();
			//创建传真发送记录
			toDwzText(true, "发送完成！", "", "efaxDialog", "evfaxGrid", "closeCurrent");
		} else {
			toDwzText(false, "请上传传真文件！", "", "", "", "");
		}
	}

	public void getfaxnum() {
		//获取组织机构
		List<Record> olist = T_Sys_Department.dao.getAllDepartments();
		if(olist != null && olist.size() > 0) {
			for(Record organ : olist) {
				String pid = organ.get("d_pid").toString();
				organ.set("pid", "d_" + pid);
				organ.set("upid", "u_" + pid);
			}
		}
		setAttr("orglist", olist);
		//日常机构人员
		List<Record> deptlist = T_Bus_Organ.dao.getAllOrgans();
		if(deptlist != null && deptlist.size() > 0) {
			for(Record organ2 : deptlist) {
				String pid = organ2.get("or_pid").toString();
				organ2.set("pid", "od_" + pid);
				organ2.set("upid", "ou_" + pid);
			}
		}
		setAttr("orglist2", deptlist);
		//获取群组
		List<Record> clulist = T_Bus_EmergencyContact.dao.getAllEmergencys();
		if(clulist != null && clulist.size() > 0) {
			for(Record clu : clulist) {
				String pid = clu.get("e_pid").toString();
				clu.set("epid", "c_" + pid);
			}
		}
		setAttr("clulist", clulist);
		String faxnos = getPara("faxnos");
		String faxnames = getPara("faxnames");
		setAttr("faxnos", faxnos);
		//已勾选机构/人员
		if(faxnos != null) {
			List<Record> faxsel = new ArrayList<Record>();
			String[] fax = faxnos.split(",");
			String[] faxname = faxnames.split(",");
			for(int i = 0; i < fax.length; i++) {
				Record r = new Record();
				r.set("fax", fax[i]);
				r.set("add_name", faxname[i]);
				faxsel.add(r);
			}
			setAttr("faxsel", faxsel);
		}
		render("faxList.jsp");
	}

	public void getfaxnumData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String id = getPara(0);
		String faxno = JFWebConfig.attrMap.get("ccmsFaxNos");
		faxno = faxno.replaceAll(",", "','");
		String jsonStr = "[]";
		if(!"0".equals(id)) {
			Page<Record> page = T_Bus_EventProcess.dao.getPageByfaxList(pageSize, pageNumber, id, faxno);
			List<Record> list = page.getList();
			int totalCount = page.getTotalRow();
			//调用JsonUtil函数返回datagrid表格json数据
			jsonStr = JsonUtil.getGridData(list, totalCount);
		}
		renderText(jsonStr);
	}

	@Clear
	public void faxUpload() {
		String dlname = getPara(0);
		String uid = getPara(1);
		Date date = new Date();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String datePath = format.format(date);
		String savepath_bd = "upload/eventCZDZ";//默认地址是upload
		String savepath = JFWebConfig.attrMap.get("dutyDocPath");
		String url = JFWebConfig.attrMap.get("dutyDocUrl") + "\\";
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("CZDZ", "UPDZ");
		if(p != null) {
			savepath_bd = p.getStr("p_acode");
		}
		url = url + datePath;
		savepath = savepath + "\\" + datePath;
		savepath_bd = savepath_bd + "\\" + datePath;
		if(dlname != null && !"".equals(dlname)) {
			url = url + "\\" + dlname;
			savepath = savepath + "\\" + dlname;
			savepath_bd = savepath_bd + "\\" + dlname;
		}
		//将相对路径的upload去掉
		/*if(savepath.startsWith("upload/")){
			url = url.substring(7);
		}*/
		UploadFile file = getFile("file", "/" + savepath, maxPostSize);
		String filename = file.getFileName();
		File fileUp = file.getFile();
		String m_size = FileUtils.getFileSize(fileUp.length());
		//同步文件(绝对路径)
		String atpath = savepath_bd;
		if(!savepath_bd.startsWith("/") && savepath_bd.indexOf(":") != 1) {
			if(!savepath_bd.startsWith("upload/")) {
				savepath_bd = "upload/" + savepath_bd;
			}
			atpath = PathKit.getWebRootPath() + "/" + savepath_bd;
		}
		FileUtils.copyFile(fileUp, atpath, filename);
		String faxpath = savepath + "\\" + filename;
		url = url + "\\" + filename;
		savepath_bd = savepath_bd + "\\" + filename;
		//转换传真文件
		String tifFile = "";
		boolean success = true;
		String msg = "上传成功";
		try {
			tifFile = ConvertPrintUtil.convert(faxpath);
			if(tifFile == null) {
				success = false;
				msg = "文件【" + file.getOriginalFileName() + "】转换失败";
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		Map<String, String> json = new HashMap<String, String>();
		json.put("success", new Boolean(success).toString());
		json.put("msg", msg);
		//插入记录表
		if(tifFile != null) {
			T_Bus_Fax_Task task = new T_Bus_Fax_Task();
			task.set("fax_file", tifFile);
			task.set("filename", url);
			task.set("filename_view", filename);
			task.set("file_state", "0");
			task.set("user_info_id", dlname);
			task.set("user_id", uid);
			task.set("filepath", savepath_bd);
			String id = T_Bus_Fax_Task.dao.insert(task);
			json.put("id", id);
		}
		json.put("tifFile", tifFile);
		json.put("name", filename);
		json.put("size", m_size);
		renderJson(json);
	}

	@Clear
	public void downloadFax() {
		String id = getPara(0);
		T_Bus_Fax_Task t = T_Bus_Fax_Task.dao.findById(id);
		if(t != null) {
			try {
				HttpServletResponse res = getResponse();
				res.setContentType("text/html; charset=UTF-8");
				res.setContentType("application/x-msdownload");
				res.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(t.getStr("filename_view"), "UTF-8"));
				OutputStream out = res.getOutputStream();
				String url = t.getStr("filename");
				if(!url.startsWith("/") && url.indexOf(":") != 1) {
					url = PathKit.getWebRootPath() + "/" + url;
				}
				File file = new File(url);
				if(file.exists()) {
					FileInputStream fis = new FileInputStream(file);
					BufferedInputStream buff = new BufferedInputStream(fis);
					byte[] b = new byte[1024];//相当于我们的缓存
					long k = 0;//该值用于计算当前实际下载了多少字节
					while(k < file.length()) {
						int j = buff.read(b, 0, 1024);
						k += j;
						//将b中的数据写到客户端的内存
						out.write(b, 0, j);
					}
				}
				//将写入到客户端的内存的数据,刷新到磁盘
				out.flush();
				out.close();
			} catch(IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				renderNull();
			}
		} else {
			renderText("该文件不存在！id：" + id);
		}
	}

	public void getFaxDataList() {
		String eventid = getPara(0);
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String jsonStr = "[]";
		Page<Record> page = T_Bus_EventProcess.dao.getFaxListByEid(pageSize, pageNumber, eventid);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void getFaxView() {
		String taskid = getPara(0);
		T_Bus_Fax_Task t = T_Bus_Fax_Task.dao.findById(taskid);
		if(t != null) {
			String filepath = t.getStr("filepath");
			if(filepath != null && !"".equals(filepath)) {
				filepath = filepath.replace("\\", "/");
			}
			if(!filepath.startsWith("/") && filepath.indexOf(":") != 1) {
				filepath = PathKit.getWebRootPath() + "/" + filepath;
			}
			String filename = t.getStr("filename_view");
			File file = new File(filepath);
			if(file.exists()) {
				setAttr("newPath", filepath);
				setAttr("ftype", filename.substring(filename.lastIndexOf(".") + 1));
				LoginModel login = getSessionAttr("loginModel");
				setAttr("username", login.getUserName());
				render("faxView.jsp");
			} else {
				renderText("该传真文件不存在，请检查！");
			}
		} else {
			renderText("该传真文件不存在，请检查！");
		}
	}
}
