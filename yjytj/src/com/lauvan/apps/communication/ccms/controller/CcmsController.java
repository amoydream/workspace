package com.lauvan.apps.communication.ccms.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.kit.JsonKit;
import com.lauvan.apps.communication.ccms.model.T_Ccms_Setting;
import com.lauvan.apps.communication.ccms.util.CcmsUtil;
import com.lauvan.apps.workcontact.model.V_Contact;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;

@RouteBind(path = "Main/communication/ccms", viewPath = "/communication/ccms")
public class CcmsController extends BaseController {
	public void console() {
		render("console.jsp");
	}

	public void setting() {
		T_Ccms_Setting setting = T_Ccms_Setting.dao.findFirst("SELECT * FROM T_CCMS_SETTING");
		if(setting == null) {
			setting = new T_Ccms_Setting();
			setting.save();
		}

		setAttr("setting", setting);
		render("setting.jsp");
	}

	public void save_setting() {
		T_Ccms_Setting setting = T_Ccms_Setting.dao.findFirst("SELECT * FROM T_CCMS_SETTING");

		boolean success = false;
		setting.set("WS_LOCATION", getPara("WS_LOCATION"));
		setting.set("TEL_NUMBER", getPara("TEL_NUMBER"));
		setting.set("FAX_NUMBER", getPara("FAX_NUMBER"));
		setting.set("MFAX_SHPATH", getPara("MFAX_SHPATH"));
		setting.set("MFAX_PATH", getPara("MFAX_PATH"));
		setting.set("MSEQ_PATH", getPara("MSEQ_PATH"));
		setting.set("MSEQ_SHPATH", getPara("MSEQ_SHPATH"));
		setting.set("VOCR_PATH", getPara("VOCR_PATH"));
		setting.set("VOCR_SHPATH", getPara("VOCR_SHPATH"));
		setting.set("VOCR_URL", getPara("VOCR_URL"));
		setting.set("FAXR_PATH", getPara("FAXR_PATH"));
		setting.set("FAXR_SHPATH", getPara("FAXR_SHPATH"));
		setting.set("FAXR_URL", getPara("FAXR_URL"));
		setting.set("FAXS_PATH", getPara("FAXS_PATH"));
		setting.set("FAXS_SHPATH", getPara("FAXS_SHPATH"));
		setting.set("FAXS_URL", getPara("FAXS_URL"));
		setting.set("PRINT_LOCATION", getPara("PRINT_LOCATION"));
		setting.set("CONV_LOCATION", getPara("CONV_LOCATION"));
		setting.set("AUTO_PRINT", getPara("AUTO_PRINT"));
		success = setting.update();

		if(success) {
			setContextAttr("CCMSET", setting);
			CcmsUtil.init(setting);
		}

		renderJson("{\"success\":" + success + "}");
	}

	public void contacts() {
		List<Map<String, Object>> contacts = getContactTree();
		renderJson(JsonKit.toJson(contacts));
	}

	public void contact() {
		String tel_number = getPara("tel_number");
		V_Contact contact = getContact(tel_number);
		String OR_NAME = contact.get("OR_NAME");
		if(OR_NAME == null) {
			contact.set("OR_NAME", "未知");
		}

		contact.set("TEL_NUMBER", tel_number);
		renderJson(JsonKit.toJson(contact));
	}

	public List<Map<String, Object>> getContactTree() {
		String idKey = StringUtils.isBlank(getPara("idKey")) ? "ID" : getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "PID" : getPara("pidKey");

		List<V_Contact> contacts = getContactCache();

		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();

		Map<String, Object> root = new HashMap<String, Object>();
		root.put(idKey, "0");
		root.put("name", "组织机构");
		root.put(pidKey, "0");
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
			Map<String, Object> node = new HashMap<String, Object>();
			String CONTACT_TYPE = c.get("CONTACT_TYPE");
			node.put("CONTACT_TYPE", CONTACT_TYPE);
			node.put("OR_NAME", c.get("OR_NAME"));
			node.put("CONTACT_NAME", c.get("CONTACT_NAME"));
			node.put("POSITION_NAME", c.get("POSITION_NAME"));
			node.put("TEL_NUMBER", c.get("TEL_NUMBER"));
			node.put("TEL_OFFICE", c.get("TEL_OFFICE"));
			node.put("TEL_HOME", c.get("TEL_HOME"));
			node.put("TEL_MOBILE", c.get("TEL_MOBILE"));
			node.put("FAX_NUMBER", c.get("FAX_NUMBER"));
			node.put("EMAIL", c.get("EMAIL"));
			node.put("name", c.get("CONTACT_NAME"));

			Object or_pid = c.get("OR_PID");
			if("O".equals(CONTACT_TYPE)) {
				node.put(idKey, "organ_" + c.get("CONTACT_ID"));
				String pid = or_pid.equals("0") ? "organ_0" : "organ_" + or_pid.toString();
				node.put(pidKey, pid);
			} else if("D".equals(CONTACT_TYPE)) {
				node.put(idKey, "dept_" + c.get("CONTACT_ID"));
				String pid = or_pid.equals("0") ? "dept_0" : "dept_" + or_pid.toString();
				node.put(pidKey, pid);
			} else {
				node.put(idKey, CONTACT_TYPE + "_" + c.get("CONTACT_ID"));
				if("P".equals(CONTACT_TYPE)) {
					node.put(pidKey, "organ_" + c.get("OR_ID"));
				} else if("U".equals(CONTACT_TYPE) || "S".equals(CONTACT_TYPE)) {
					node.put(pidKey, "dept_" + c.get("OR_ID"));
				}
			}

			dataList.add(node);
		}

		return dataList;
	}

	public V_Contact getContact(String TEL_NUMBER) {
		List<V_Contact> CONTACT_CACHE = getContactCache();
		V_Contact contact = new V_Contact();
		contact.set("CONTACT_ID", null);
		contact.set("CONTACT_TYPE", "N");
		contact.set("CONTACT_NAME", TEL_NUMBER);
		contact.set("TEL_NUMBER", TEL_NUMBER);
		contact.set("FAX_NUMBER", TEL_NUMBER);
		contact.set("OR_ID", null);
		contact.set("OR_NAME", null);
		if(StringUtils.trimToNull(TEL_NUMBER) != null) {
			TEL_NUMBER = TEL_NUMBER.trim();
			for(V_Contact c : CONTACT_CACHE) {
				String TEL_MOBILE = StringUtils.trimToEmpty(c.getStr("TEL_MOBILE"));
				String TEL_OFFICE = StringUtils.trimToEmpty(c.getStr("TEL_OFFICE"));
				String TEL_HOME = StringUtils.trimToEmpty(c.getStr("TEL_HOME"));
				String FAX_NUMBER = StringUtils.trimToEmpty(c.getStr("FAX_NUMBER"));
				if(TEL_NUMBER.equals(TEL_MOBILE) || TEL_NUMBER.equals(TEL_OFFICE) || TEL_NUMBER.equals(TEL_HOME) || TEL_NUMBER.equals(FAX_NUMBER)) {
					contact = c;
					break;
				} else {
					String TEL_NUMBER_REV = StringUtils.reverse(TEL_NUMBER);
					TEL_OFFICE = StringUtils.reverse(TEL_OFFICE);
					TEL_HOME = StringUtils.reverse(TEL_HOME);
					String TEL_NUMBER_7 = TEL_NUMBER_REV;
					String TEL_NUMBER_8 = TEL_NUMBER_REV;
					String TEL_OFFICE_7 = TEL_OFFICE;
					String TEL_OFFICE_8 = TEL_OFFICE;
					String TEL_HOME_7 = TEL_HOME;
					String TEL_HOME_8 = TEL_HOME;
					String FAX_NUMBER_7 = FAX_NUMBER;
					String FAX_NUMBER_8 = FAX_NUMBER;
					if(TEL_NUMBER.length() > 8 && TEL_NUMBER.startsWith("0")) {
						TEL_NUMBER_7 = TEL_NUMBER_REV.substring(0, 7);
						TEL_NUMBER_8 = TEL_NUMBER_REV.substring(0, 8);
					}
					if(TEL_OFFICE.length() >= 8) {
						TEL_OFFICE_7 = TEL_OFFICE.substring(0, 7);
						TEL_OFFICE_8 = TEL_OFFICE.substring(0, 8);
					}
					if(TEL_HOME.length() >= 8) {
						TEL_HOME_7 = TEL_HOME.substring(0, 7);
						TEL_HOME_8 = TEL_HOME.substring(0, 8);
					}
					if(FAX_NUMBER.length() >= 8) {
						FAX_NUMBER_7 = FAX_NUMBER.substring(0, 7);
						FAX_NUMBER_8 = FAX_NUMBER.substring(0, 8);
					}

					if(TEL_NUMBER_7.equals(TEL_OFFICE_7) || TEL_NUMBER_7.equals(TEL_HOME_7) || TEL_NUMBER_8.equals(TEL_OFFICE_8) || TEL_NUMBER_8.equals(TEL_HOME_8) || TEL_NUMBER_7.equals(FAX_NUMBER_7) || TEL_NUMBER_8.equals(FAX_NUMBER_8)) {
						contact = c;
						break;
					}
				}
			}
		}

		return contact;
	}

	public List<V_Contact> getContactCache() {
		List<V_Contact> CONTACT_CACHE = getContextAttr("CONTACT_CACHE");
		if(CONTACT_CACHE == null) {
			CONTACT_CACHE = setContactCache();
		}

		return CONTACT_CACHE;
	}

	public List<V_Contact> setContactCache() {
		List<V_Contact> CONTACT_CACHE = V_Contact.dao.find("SELECT * FROM V_CONTACT");
		setContextAttr("CONTACT_CACHE", CONTACT_CACHE);

		return CONTACT_CACHE;
	}

	public void refreshContact() {
		setContactCache();
		List<Map<String, Object>> contacts = getContactTree();
		String jsonText = JsonKit.toJson(contacts);
		renderJson(jsonText);
	}
}
