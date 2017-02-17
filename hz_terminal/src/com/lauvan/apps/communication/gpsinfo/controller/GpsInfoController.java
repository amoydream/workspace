package com.lauvan.apps.communication.gpsinfo.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.gpsinfo.model.T_UserLocator;
import com.lauvan.apps.communication.mobileuser.model.T_MobileUser;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/gpsinfo", viewPath = "/communication/gpsinfo")
public class GpsInfoController extends BaseController {
	private static final Logger log = Logger.getLogger(GpsInfoController.class);

	public void index() {
		render("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String id = getPara("pid");
		Page<Record> page;
		page = T_UserLocator.dao.getGridPage(pageNumber, pageSize, id);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void getusertree() {
		String idKey = StringUtils.isBlank(getPara("idKey")) ? "id" : getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "pid" : getPara("pidKey");

		List<Record> userList = T_MobileUser.dao.getAllusers();

		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> row = new HashMap<String, Object>();
		Map<String, Object> root = new HashMap<String, Object>();

		root.put(idKey, "0");
		root.put("name", "终端用户");
		root.put(pidKey, "");
		dataList.add(root);

		for(Record de : userList) {
			row = new HashMap<String, Object>();
			row.put(idKey, de.get("id"));
			row.put("name", de.get("realname"));
			row.put(pidKey, "0");
			dataList.add(row);
		}
		renderJson(dataList);
	}

	public void infodel() {
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
				T_UserLocator ul = T_UserLocator.dao.findById(i);
				//删除文件
				T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("MOBILEFILE", "UPDZ");
				String url = p.getStr("p_acode");
				if(url != null && !url.equals("")) {
					if(!url.startsWith("/") && url.indexOf(":") != 1) {
						url = PathKit.getWebRootPath() + (url.endsWith("/") || url.endsWith("\\") ? url : url + "/") + ul.getStr("path");
					} else {
						url = url.endsWith("/") || url.endsWith("\\") ? url : url + "/" + ul.getStr("path");
					}
					File file = new File(url);
					if(file.exists()) {
						file.delete();
					}
				}
				ul.delete();
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/gpsinfo/infodel", "delete", ul, getRequest());
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

	/**
	 * 根据用户id查找最新的信息点详细信息
	 * */
	public void getContent() {
		String uid = getPara("uid");
		List<Record> list = T_UserLocator.dao.getListByUid(uid);
		String jsonlist = JsonKit.toJson(list);
		renderJson(jsonlist);
	}

	public void getSelect() {
		Integer uid = getParaToInt(0);
		String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("uid", uid);
		setAttr("nowdate", now);
		render("select.jsp");
	}
}
