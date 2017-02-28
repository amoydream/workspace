package com.lauvan.apps.communication.ccms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Clear;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import com.lauvan.apps.communication.ccms.model.T_Fax_Record;
import com.lauvan.apps.communication.ccms.model.V_Contact;
import com.lauvan.apps.communication.ccms.model.V_Fax_Record;
import com.lauvan.apps.communication.ccms.util.CcmsUtil;
import com.lauvan.apps.communication.ccms.util.ConvertPrintUtil;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.FileUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/communication/ccms/fax", viewPath = "/communication/ccms/fax")
public class FaxController extends CcmsController {
	public void sent() {
		setAttr("sender", "Y");
		render("sent.jsp");
	}

	public void received() {
		setAttr("sender", "N");
		render("received.jsp");
	}

	public void unreadFax() {
		List<V_Fax_Record> records = V_Fax_Record.dao.find("SELECT * FROM V_FAX_RECORD WHERE SENDER='N' AND READ='N' ORDER BY READ DESC, DATETIME DESC, FAXST DESC");
		if(records != null && records.size() > 0) {
			for(int i = 0; i < records.size(); i++) {
				V_Fax_Record fr = records.get(i);
				String FAX_NUMBER = fr.get("FAX_NUMBER");
				V_Contact contact = getContact(FAX_NUMBER);
				String OR_NAME = contact.get("OR_NAME");
				if(OR_NAME == null) {
					OR_NAME = FAX_NUMBER;
				}
				fr.set("OR_ID", contact.get("OR_ID"));
				fr.set("OR_NAME", OR_NAME);
			}
		}

		renderJson(JsonKit.toJson(records));
	}

	public void faxResult() {
		String CALLID = getPara("CALLID");
		V_Fax_Record fr = V_Fax_Record.dao.findById(CALLID);

		if(fr != null) {
			String FAX_NUMBER = fr.get("FAX_NUMBER");
			V_Contact contact = getContact(FAX_NUMBER);
			String OR_NAME = contact.get("OR_NAME");
			if(OR_NAME == null) {
				OR_NAME = FAX_NUMBER;
			}
			fr.set("OR_ID", contact.get("OR_ID"));
			fr.set("OR_NAME", OR_NAME);
		}

		renderJson(JsonKit.toJson(fr));
	}

	public void send() {
		Integer callid = getParaToInt("callid");
		String fax_number = getPara("fax_number");
		String action = getPara("action");
		V_Fax_Record fax = new V_Fax_Record();
		if(callid != null) {
			fax = V_Fax_Record.dao.findById(callid);
			if(fax == null) {
				setAttr("error", "传真记录不存在");
			} else {
				fax_number = fax.getStr("FAX_NUMBER");
				if("reply".equals(action)) {
					fax.set("CALLID", null);
					fax.set("recdFile", "");
				} else if("resend".equals(action)) {
					String faxFile = CcmsUtil.FAXS_SHPATH + "\\" + fax.getStr("RECDFILE");
					if(new File(faxFile).exists()) {
						String tifFile = CcmsUtil.copyFile(faxFile, CcmsUtil.MFAX_SHPATH);
						setAttr("tifFile", tifFile);
					} else {
						fax.set("RECDFILE", "");
					}
				}
			}
		}

		if(fax_number != null) {
			fax.set("FAX_NUMBER", fax_number);
			V_Contact contact = getContact(fax_number);
			String OR_NAME = contact.getStr("OR_NAME");
			if(OR_NAME == null) {
				OR_NAME = fax_number;
			}
			fax.put("OR_NAME", OR_NAME);
		}

		String eventId = null;
		if("new".equals(action)) {
			eventId = getPara("eventId");
		} else {
			if(fax.get("EVENTID") != null) {
				eventId = fax.get("EVENTID").toString();
			}
		}

		if(eventId != null) {
			T_Bus_EventInfo event = T_Bus_EventInfo.dao.findById(eventId);
			if(event != null) {
				fax.set("EV_NAME", event.get("EV_NAME"));
			} else {
				fax.set("EVENTID", null);
			}
		}

		setAttr("action", action);
		setAttr("fax", fax);
		render("send.jsp");
	}

	public void read() {
		Integer callid = getParaToInt(0);
		V_Fax_Record fax = V_Fax_Record.dao.findById(callid);
		if(fax != null) {
			String READ = fax.getStr("READ");
			if(!"Y".equals(READ)) {
				T_Fax_Record rec = T_Fax_Record.dao.findById(callid);
				rec.set("READ", "Y");
				rec.update();
			}
		}

		setAttr("fax", fax);
		render("read.jsp");
	}

	public void search() {
		Integer maxResults = getParaToInt("rows");
		Integer currentPage = getParaToInt("page");
		StringBuffer sql = new StringBuffer();

		String sender = getPara("sender");
		if(!StringUtils.isEmpty(sender)) {
			sql.append(" AND SENDER='" + sender + "'");
		}

		String or_name = getPara("or_name");
		if(!StringUtils.isEmpty(or_name)) {
			sql.append(" AND FAX_NUMBER IN (SELECT DISTINCT(CONTACT_NUMBER) FROM V_CONTACT_SEARCH WHERE (CONTACT_TYPE='O' OR CONTACT_TYPE='D') AND OR_NAME LIKE '%" + or_name + "%')");
		}

		String fax_number = getPara("fax_number");
		if(!StringUtils.isEmpty(fax_number)) {
			sql.append(" AND FAX_NUMBER LIKE '%" + fax_number + "%'");
		}

		String ev_name = getPara("ev_name");
		if(!StringUtils.isEmpty(ev_name)) {
			sql.append(" AND EV_NAME LIKE '%" + ev_name + "%'");
		}

		String dateTime = getPara("dateTime");
		if(!StringUtils.isEmpty(dateTime)) {
			sql.append(" AND DATETIME LIKE '" + dateTime + "%'");
		}

		Page<Record> page = V_Fax_Record.dao.getPageList(maxResults, currentPage, sql.toString());
		List<Record> list = page.getList();
		for(Record rec : list) {
			Map<String, Object> columns = rec.getColumns();
			String FAX_NUMBER = (String)columns.get("FAX_NUMBER");
			V_Contact contact = getContact(FAX_NUMBER);
			columns.put("OR_ID", contact.get("OR_ID"));
			columns.put("OR_NAME", contact.get("OR_NAME"));
		}

		String data = JsonUtil.getGridData(list, page.getTotalRow());
		renderText(data);
	}

	public void receiver() {
		render("receiver.jsp");
	}

	public void getOrganTree() {
		String idKey = StringUtils.isBlank(getPara("idKey")) ? "id" : getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "pid" : getPara("pidKey");
		List<V_Contact> contacts = getContactCache();

		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();

		Map<String, Object> root = new HashMap<String, Object>();
		root.put(idKey, "0");
		root.put("name", "组织机构");
		root.put(pidKey, "");
		dataList.add(root);

		Map<String, Object> organRoot = new HashMap<String, Object>();
		organRoot.put(idKey, "organ_0");
		organRoot.put("name", "日常机构");
		organRoot.put(pidKey, "0");
		dataList.add(organRoot);

		Map<String, Object> deptRoot = new HashMap<String, Object>();
		deptRoot.put(idKey, "dept_0");
		deptRoot.put("name", "应急机构");
		deptRoot.put(pidKey, "0");
		dataList.add(deptRoot);

		for(V_Contact c : contacts) {
			String CONTACT_TYPE = c.get("CONTACT_TYPE");
			if("O".equals(CONTACT_TYPE) || "D".equals(CONTACT_TYPE)) {
				Map<String, Object> node = new HashMap<String, Object>();
				node.put("CONTACT_TYPE", CONTACT_TYPE);
				Object or_pid = c.get("OR_PID");
				String pid = null;
				if("O".equals(CONTACT_TYPE)) {
					node.put(idKey, "organ_" + c.get("CONTACT_ID"));
					pid = or_pid.equals("0") ? "organ_0" : "organ_" + or_pid.toString();
				} else if("D".equals(CONTACT_TYPE)) {
					node.put(idKey, "dept_" + c.get("CONTACT_ID"));
					pid = or_pid.equals("0") ? "dept_0" : "dept_" + or_pid.toString();
				}

				node.put(pidKey, pid);
				node.put("name", c.get("OR_NAME"));
				dataList.add(node);
			}
		}

		renderJson(dataList);
	}

	public void getOrgans() {
		Integer maxResults = getParaToInt("rows");
		Integer currentPage = getParaToInt("page");
		String pid = getPara("pid");
		String or_name = getPara("or_name");
		StringBuffer sql = new StringBuffer();
		sql.append("FAX_NUMBER IS NOT NULL");
		if(pid != null && !"".equals(pid)) {
			pid = pid.substring(pid.lastIndexOf("_") + 1);
			sql.append(" AND OR_PID=" + pid);
		}
		if(or_name != null && !"".equals(or_name)) {
			if(pid != null && !"".equals(pid)) {
				sql.append(" AND ");
			}
			sql.append("OR_NAME LIKE '%" + or_name + "%'");
		}
		Page<Record> page = Paginate.dao.getPage("V_CONTACT", maxResults, currentPage, sql.toString(), null, null);
		String json = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(json);
	}

	public void event() {
		String action = getPara("action");
		if("relate".equals(action)) {
			String callids = getPara("callids");
			String eventId = getPara("eventId");
			List<T_Fax_Record> recList = T_Fax_Record.dao.find("SELECT * FROM T_FAX_RECORD WHERE CALLID IN (" + callids + ")");
			boolean success = false;
			if(recList != null && recList.size() > 0) {
				for(int i = 0; i < recList.size(); i++) {
					T_Fax_Record rec = recList.get(i);
					rec.set("EVENTID", eventId);
					rec.update();
				}
			}
			success = true;
			renderJson("{\"success\":" + success + "}");
		} else {
			render("event.jsp");
		}
	}

	public void unrelateEvent() {
		String callids = getPara("callids");
		List<T_Fax_Record> recList = T_Fax_Record.dao.find("SELECT * FROM T_FAX_RECORD WHERE CALLID IN (" + callids + ")");
		boolean success = false;
		if(recList != null && recList.size() > 0) {
			for(int i = 0; i < recList.size(); i++) {
				T_Fax_Record rec = recList.get(i);
				rec.set("EVENTID", null);
				rec.update();
			}
		}
		success = true;

		renderJson("{\"success\":" + success + "}");
	}

	public void update() {
		Integer callid = getParaToInt("CALLID");
		T_Fax_Record rec = T_Fax_Record.dao.findById(callid);
		boolean success = false;
		String msg = "";
		if(rec == null) {
			msg = "传真记录不存在";
		} else {
			rec.set("TITLE", getPara("TITLE"));
			rec.set("REMARK", getPara("REMARK"));
			success = rec.update();
			msg = "保存成功";
		}
		renderJson("{\"success\":" + success + ", \"msg\":\"" + msg + "\"}");
	}

	public void delete() {
		String[] ids = getParaValues("ids");
		LoginModel user = getSessionAttr("loginModel");
		boolean isAdmin = user.getIsAdmin() || user.getIsSuper() || user.isLeader();
		renderJson(T_Fax_Record.dao.delete(ids, isAdmin ? null : user.getUserId().toString()));
	}

	@Clear
	public void download() {
		String callid = getPara("callid");
		T_Fax_Record fax = T_Fax_Record.dao.findById(callid);
		if(fax != null) {
			String recdFile = fax.getStr("RECDFILE");
			String faxFile = ("Y".equals(fax.get("SENDER")) ? CcmsUtil.FAXS_SHPATH : CcmsUtil.FAXR_SHPATH) + "\\" + recdFile;
			if(!new File(faxFile).exists()) {
				renderHtml("<script>alert(\"传真文件不存在\");</script>");
			} else {
				String filename = getPara("filename");
				if(filename != null && !filename.trim().equals("")) {
					if(filename.toLowerCase().lastIndexOf(".tif") == -1) {
						filename += ".tif";
					}
				} else {
					filename = recdFile.substring(recdFile.lastIndexOf("\\"));
				}
				HttpServletResponse response = getResponse();
				response.setContentType("multipart/form-data");
				response.setHeader("Content-disposition", "attachment;filename=" + filename);
				OutputStream os = null;
				FileInputStream fis = null;
				try {
					os = response.getOutputStream();
					String url = ("Y".equals(fax.get("SENDER")) ? CcmsUtil.FAXS_SHPATH : CcmsUtil.FAXR_SHPATH) + "\\" + recdFile;
					File file = new File(url);
					if(file.exists()) {
						fis = new FileInputStream(file);
						byte[] byteArr = new byte[1024];
						while(fis.read(byteArr) != -1) {
							os.write(byteArr);
						}
						os.flush();
					}
				} catch(IOException e) {
					renderHtml("<script>alert(e.getMessage());</script>");
					e.printStackTrace();
				} finally {
					if(os != null) {
						try {
							os.close();
						} catch(IOException e) {
							e.printStackTrace();
						}
					}
					if(fis != null) {
						try {
							fis.close();
						} catch(IOException e) {
							e.printStackTrace();
						}
					}
					renderNull();
				}
			}
		} else {
			renderHtml("<script>alert(\"传真记录不存在\");</script>");
		}
	}

	@Clear
	public void upload() {
		UploadFile uploadFile = getFile("faxFile", "/" + CcmsUtil.MFAX_SHPATH);
		File faxFile = uploadFile.getFile();
		faxFile = faxFile.getAbsoluteFile();
		String tifFile = "";
		boolean success = true;
		String msg = "上传成功";
		if(faxFile.exists()) {
			if(!faxFile.getAbsolutePath().toLowerCase().endsWith(".tif")) {
				try {
					tifFile = ConvertPrintUtil.convert(faxFile.getAbsolutePath());
					if(tifFile == null) {
						success = false;
						msg = "文件【" + faxFile + "】转换失败";
					}
				} catch(Exception e) {
					success = false;
					msg = "文件【" + faxFile + "】转换失败: " + e.getMessage();
					e.printStackTrace();
				} finally {
					faxFile.delete();
				}
			} else {
				tifFile = faxFile.getAbsolutePath();
			}
		} else {
			success = false;
			msg = "文件【" + faxFile + "】不存在";
		}

		Map<String, String> data = new HashMap<String, String>();
		data.put("success", new Boolean(success).toString());
		data.put("msg", msg);
		data.put("tifFile", tifFile);
		renderJson(data);
	}

	@Clear
	public void uploadNotice() {
		String soundDir = PathKit.getWebRootPath() + "\\sound\\";
		int sizeLimit = JFWebConfig.maxPostSize;
		Integer size = getParaToInt(3);
		if(size != null && !"".equals(size)) {
			sizeLimit = size;
		}
		UploadFile file = getFile("file", soundDir, sizeLimit);
		File newFile = file.getFile();
		String fileName = getPara("fileName");
		if(newFile.exists()) {
			File oldFile = new File(soundDir + "\\" + fileName);
			if(oldFile.exists()) {
				oldFile.delete();
			}
			newFile.renameTo(new File(soundDir + "\\" + fileName));
		}

		String fileSize = FileUtils.getFileSize(file.getFile().length());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", fileName);
		map.put("url", "sound/" + fileName);
		map.put("error", 0);
		map.put("size", fileSize);
		map.put("type", "mp3");
		renderJson(map);
	}
}
