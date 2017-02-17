package com.lauvan.apps.communication.comdecivemanagement.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.comdecivemanagement.model.T_DeviceInfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/comdevicemanagement", viewPath = "/communication/comdevicemanagement")
public class ComDeciveMgController extends BaseController {
	private static final Logger log = Logger.getLogger(ComDeciveMgController.class);

	public void index() {
		render("main.jsp");
	}

	public void getTree() {
		String idKey = StringUtils.isBlank(getPara("idKey")) ? "id" : getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "pid" : getPara("pidKey");
		List<T_Sys_Parameter> typelist = T_Sys_Parameter.dao.getChildByAcode("TXSBLX");
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> row = new HashMap<String, Object>();
		Map<String, Object> root = new HashMap<String, Object>();
		root.put(idKey, "325");
		root.put("name", "设备类型");
		root.put("p_acode", null);
		root.put(pidKey, "");
		dataList.add(root);
		for(T_Sys_Parameter de : typelist) {
			row = new HashMap<String, Object>();
			row.put(idKey, de.get("id"));
			row.put("name", de.get("p_name"));
			row.put("p_acode", de.get("p_acode"));
			row.put(pidKey, "325");
			dataList.add(row);
		}
		renderJson(dataList);
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String code = getPara("dcode");
		String name = getPara("dname");
		String p_acode = getPara("p_acode");
		Page<Record> page;
		page = T_DeviceInfo.dao.getGridPage(pageNumber, pageSize, p_acode, code, name);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void deviceadd() {
		String pcode = getPara(0);
		if(pcode == null || pcode.equals("") || pcode.equals("null")) {
			pcode = "0001";
		}
		setAttr("pcode", pcode);
		render("add.jsp");
	}

	public void deviceupd() {
		String id = getPara(0);
		T_DeviceInfo dif = T_DeviceInfo.dao.findById(id);
		setAttr("dif", dif);
		render("update.jsp");
	}

	public void deviceview() {
		String id = getPara(0);
		T_DeviceInfo dif = T_DeviceInfo.dao.findById(id);
		setAttr("dif", dif);
		render("view.jsp");
	}

	public void save() {
		try {
			boolean success = false;
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			String methodname = "add";
			String act = getPara("act");
			T_DeviceInfo dif = getModel(T_DeviceInfo.class);
			String alt = "";
			if(act.equals("upd")) {
				dif.update();
				success = true;
				methodname = "update";
				alt = "修改成功！";
			} else {
				dif.set("id", AutoId.nextval(dif));
				dif.save();
				success = true;
				alt = "保存成功！";
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/comdevicemanagement/deviceadd", methodname, dif, getRequest());
			}
			toDwzText(success, alt, "", "deviceDialog", "deviceGrid", "closeCurrent");
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}

	public void devicedel() {
		//String id = getPara(0);
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
				T_DeviceInfo dif = T_DeviceInfo.dao.findById(i);
				dif.delete();
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/comdevicemanagement/devicedel", "delete", dif, getRequest());
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
