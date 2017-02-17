package com.lauvan.apps.dailymanager.report.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.dailymanager.report.model.T_Bus_Report;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

/**
 * 每日要情快报控制器
 * @author Bob
 */
@RouteBind(path = "Main/dayreport", viewPath = "/dailymanager/report")
public class DayReportController extends BaseController {

	public void main() {
		render("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String rname = getPara("rname");
		String username = getPara("username");
		StringBuffer sqlWhere = new StringBuffer();
		sqlWhere.append(" r_type='0'");
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
		render("day/add.jsp");
	}

	//跳转到传真
	public void faxSave() {
		String title = getPara("rtitle");
		String content = getPara("rcontent");
		List<Record> olist = T_Sys_Department.dao.getAllDepartments();
		if(olist != null && olist.size() > 0) {
			for(Record organ : olist) {
				String pid = organ.get("d_pid").toString();
				organ.set("pid", "d_" + pid);
				organ.set("upid", "u_" + pid);
			}
		}
		setAttr("orglist", olist);
		// 日常机构人员
		List<Record> deptlist = T_Bus_Organ.dao.getAllOrgans();
		if(deptlist != null && deptlist.size() > 0) {
			for(Record organ2 : deptlist) {
				String pid = organ2.get("or_pid").toString();
				organ2.set("pid", "od_" + pid);
				organ2.set("upid", "ou_" + pid);
			}
		}
		setAttr("orglist2", deptlist);
		setAttr("title", title);
		setAttr("content", content);
		render("fax.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_Report dayreport = T_Bus_Report.dao.findById(id);
		setAttr("dayreport", dayreport);
		render("day/edit.jsp");
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
				model.set("r_type", "0");
				model.set("r_id", AutoId.nextval(model));
				success = model.save();
			} else {
				success = model.update();
			}
			if(success) {
				toDwzText(true, msg, "", "dayReportDialog", "dayreportGrid", "closeCurrent");
			} else {
				toDwzText(false, msg, "", "", "", "");
			}
		} catch(Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}

	}

	public void view() {
		String id = getPara(0);
		T_Bus_Report report = T_Bus_Report.dao.findById(id);
		setAttr("report", report);
		render("day/view.jsp");
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
}
