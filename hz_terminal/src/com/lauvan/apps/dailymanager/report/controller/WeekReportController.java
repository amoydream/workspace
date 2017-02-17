package com.lauvan.apps.dailymanager.report.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.dailymanager.report.model.T_Bus_Report;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

/**
 * 每周要情快报控制器
 * @author Bob
 */
@RouteBind(path = "Main/weekreport", viewPath = "/dailymanager/report/week")
public class WeekReportController extends BaseController {

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String rname = getPara("rname");
		String username = getPara("username");
		StringBuffer sqlWhere = new StringBuffer();
		sqlWhere.append(" r_type='1'");
		if(rname != null && !"".equals(rname)) {
			sqlWhere.append(" and r_title like '%").append(rname).append("%'");
		}
		if(username != null && !"".equals(username)) {
			sqlWhere.append(" and r_username like '%").append(username).append("%'");
		}
		Page<Record> page = Paginate.dao.getPage("t_bus_report", pageSize, pageNumber, sqlWhere.toString(), "r_id", "desc");
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		LoginModel login = getSessionAttr("loginModel");
		String username = login.getUserName();
		setAttr("username", username);
		render("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_Report weekreport = T_Bus_Report.dao.findById(id);
		setAttr("weekreport", weekreport);
		render("edit.jsp");
	}

	public void save() {

		String act = getPara("act");
		String msg = "保存成功！";
		boolean success = true;
		T_Bus_Report model = getModel(T_Bus_Report.class);
		try {
			if("add".equals(act)) {
				String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
				model.set("r_createtime", now);
				model.set("r_type", "1");
				model.set("r_id", AutoId.nextval(model));
				success = model.save();
			} else if("fax".equals(act)) {

			} else {
				success = model.update();
			}
			if(success) {
				toDwzText(true, msg, "", "weekReportDialog", "weekreportGrid", "closeCurrent");
			} else {
				toDwzText(false, msg, "", "", "", "");
			}
		} catch(Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}

	}

	public void delete() {
		Integer[] ids = getParaValuesToInt("ids");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			success = T_Bus_Report.dao.delete(ids);
		} catch(Exception e) {
			e.printStackTrace();
			errorCode = "error";
			msg = e.getMessage();
		} finally {
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}

	}

	public void view() {
		String id = getPara(0);
		T_Bus_Report report = T_Bus_Report.dao.findById(id);
		setAttr("report", report);
		render("view.jsp");
	}

}
