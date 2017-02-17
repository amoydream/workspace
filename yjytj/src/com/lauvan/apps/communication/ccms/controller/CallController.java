package com.lauvan.apps.communication.ccms.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.ccms.model.T_Call_Record;
import com.lauvan.apps.communication.ccms.model.V_Call_Record;
import com.lauvan.apps.communication.ccms.util.CcmsUtil;
import com.lauvan.apps.workcontact.model.V_Contact;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/communication/ccms/call", viewPath = "/communication/ccms/call")
public class CallController extends CcmsController {
	public void callin() {
		setAttr("caller", "N");
		render("callin.jsp");
	}

	public void callout() {
		setAttr("caller", "Y");
		render("callout.jsp");
	}

	public void play() {
		Integer callid = getParaToInt("callid");
		T_Call_Record rec = T_Call_Record.dao.findById(callid);
		String vocRecdUrl = "";
		File file = null;
		if(rec != null) {
			String recdFile = rec.get("RECDFILE");
			if(recdFile != null) {
				vocRecdUrl = CcmsUtil.VOCR_URL + "/" + recdFile.replace("\\", "/");
				file = new File(CcmsUtil.VOCR_SHPATH + "\\" + recdFile);
			}
		}
		boolean recd_exist = rec != null && file != null && file.exists();
		if(!recd_exist) {
			renderJson("{\"not_exist\":" + recd_exist + "}");
		} else {
			renderJson("{\"vocRecdUrl\":\"" + vocRecdUrl + "\"}");
		}
	}

	public void search() {
		Integer maxResults = getParaToInt("rows");
		Integer page = getParaToInt("page");
		StringBuffer sql = new StringBuffer();
		String contact_name = getPara("contact_name");
		String or_name = getPara("or_name");
		String caller = getPara("caller");
		if(!StringUtils.isEmpty(contact_name)) {
			sql.append(" AND TEL_NUMBER IN (SELECT DISTINCT(CONTACT_NUMBER) FROM V_CONTACT_SEARCH WHERE CONTACT_NAME LIKE '%" + contact_name + "%'");
			if(!StringUtils.isEmpty(or_name)) {
				sql.append(" AND OR_NAME LIKE '%" + or_name + "%')");
			} else {
				sql.append(")");
			}
		}

		if(!StringUtils.isEmpty(or_name)) {
			sql.append(" AND TEL_NUMBER IN (SELECT DISTINCT(CONTACT_NUMBER) FROM V_CONTACT_SEARCH WHERE OR_NAME LIKE '%" + or_name + "%')");
		}

		String tel_number = getPara("tel_number");
		if(!StringUtils.isEmpty(tel_number)) {
			sql.append(" AND TEL_NUMBER LIKE '%" + tel_number + "%'");
		}

		String ev_name = getPara("ev_name");
		if(!StringUtils.isEmpty(ev_name)) {
			sql.append(" AND EV_NAME LIKE '%" + ev_name + "%'");
		}

		String dateTime = getPara("dateTime");
		if(!StringUtils.isEmpty(dateTime)) {
			sql.append(" AND DATETIME LIKE '" + dateTime + "%'");
		}

		sql.append(" AND CALLER='" + caller + "'");

		Page<Record> recordPage = V_Call_Record.dao.getPageList(maxResults, page, sql.toString());
		List<Record> list = recordPage.getList();
		for(Record rec : list) {
			Map<String, Object> columns = rec.getColumns();
			String TEL_NUMBER = (String)columns.get("TEL_NUMBER");
			V_Contact contact = getContact(TEL_NUMBER);
			columns.put("CONTACT_ID", contact.get("CONTACT_ID"));
			columns.put("CONTACT_TYPE", contact.get("CONTACT_TYPE"));
			columns.put("OR_ID", contact.get("OR_ID"));
			columns.put("OR_NAME", contact.get("OR_NAME"));
			if("Y".equals(columns.get("CALLER"))) {
				columns.put("CONTACT_NAME", contact.get("CONTACT_NAME"));
			} else {
				columns.put("CONTACT_NAME", contact.get("CONTACT_NAME"));
			}

			if("Y".equals(columns.get("ANSWERED"))) {
				String RECDFILE = (String)columns.get("RECDFILE");
				if(RECDFILE != null) {
					RECDFILE = CcmsUtil.VOCR_URL + "/" + RECDFILE.replace("\\", "/");
					columns.put("RECDFILE", RECDFILE);
				}
			} else {
				columns.put("RECDFILE", "");
			}
		}

		String data = JsonUtil.getGridData(list, recordPage.getTotalRow());
		renderText(data);
	}

	public void event() {
		String action = getPara("action");
		if("relate".equals(action)) {
			String callids = getPara("callids");
			String eventId = getPara("eventId");
			List<T_Call_Record> recList = T_Call_Record.dao.find("SELECT * FROM T_CALL_RECORD WHERE CALLID IN (" + callids + ")");
			boolean success = false;
			if(recList != null && recList.size() > 0) {
				for(int i = 0; i < recList.size(); i++) {
					T_Call_Record rec = recList.get(i);
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
		List<T_Call_Record> recList = T_Call_Record.dao.find("SELECT * FROM T_CALL_RECORD WHERE CALLID IN (" + callids + ")");
		boolean success = false;
		if(recList != null && recList.size() > 0) {
			for(int i = 0; i < recList.size(); i++) {
				T_Call_Record rec = recList.get(i);
				rec.set("EVENTID", null);
				rec.update();
			}
		}
		success = true;
		renderJson("{\"success\":" + success + "}");
	}

	public void delete() {
		String[] ids = getParaValues("ids");
		LoginModel user = getSessionAttr("loginModel");
		boolean isAdmin = user.getIsAdmin() || user.getIsSuper() || user.isLeader();
		renderJson(T_Call_Record.dao.delete(ids, isAdmin ? null : user.getUserId().toString()));
	}
}
