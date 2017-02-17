package com.lauvan.apps.log.controller;

import java.util.List;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_LoginLog;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/logmg", viewPath = "/logmg")
public class LogMgController extends BaseController {
	public void loginlog() {
		render("loginmain.jsp");
	}

	public void opelog() {
		render("opemain.jsp");
	}

	public void getloginGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("name");
		String type = getPara("type");
		Page<Record> page = T_Sys_LoginLog.dao.getGridPage(pageNumber, pageSize, name, type);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void getopeGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("name");
		String type = getPara("type");
		String status = getPara("status");
		Page<Record> page = T_Sys_Operation_Log.dao.getGridPage(pageNumber, pageSize, name, type, status);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
}
