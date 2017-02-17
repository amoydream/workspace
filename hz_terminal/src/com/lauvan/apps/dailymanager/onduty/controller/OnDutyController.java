package com.lauvan.apps.dailymanager.onduty.controller;

import java.io.OutputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.jfinal.aop.Clear;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.dailymanager.onduty.model.T_LeaderDuty;
import com.lauvan.apps.dailymanager.onduty.model.Vw_Leaderduty;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;

@RouteBind(path = "Main/onduty", viewPath = "/dailymanager/onduty")
public class OnDutyController extends BaseController {
	private static final Logger log = Logger.getLogger(OnDutyController.class);

	public void index() {
		String startDate = "";
		String type = "";
		startDate = getPara("startDate");
		type = getPara("type");
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Vw_Leaderduty t_calendar = new Vw_Leaderduty();
		try {
			if(StringUtils.isNotEmpty(startDate)) {
				calendar.setTime(format.parse(startDate));

			}
		} catch(Exception e) {
			renderJson("{\"statusCode\":\"300\", " + "\"message\":\"您提交的数据有误，请检查后重新提交！\"}");
			return;
		}
		setAttr("startDate", calendar.getTime());
		System.out.println("startDate:" + startDate);
		Calendar firtCalendar = (Calendar)calendar.clone();
		Calendar lastCalendar = (Calendar)calendar.clone();
		if(type != null && "agendaWeek".equals(type)) {
			//周格式
			lastCalendar.add(Calendar.DAY_OF_WEEK, 7);
		} else if(type != null && "agendaDay".equals(type)) {
			//日格式
			lastCalendar.add(Calendar.HOUR, 24);
		} else {
			//月格式
			firtCalendar.set(Calendar.DATE, 1);
			lastCalendar.set(Calendar.DATE, 0);
			lastCalendar.add(Calendar.MONTH, 1);
		}
		String start = format.format(firtCalendar.getTime());
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		String end = format.format(lastCalendar.getTime());
		List<Record> calendars = t_calendar.getCalendarDayAll(start, end);
		;
		if(null != calendars && 0 < calendars.size()) {
			setAttr("calendars", calendars);
		}
		setAttr("type", type);
		render("main.jsp");
	}

	public void getcalendars() {
		String startDate = getPara("startDate");
		String type = getPara("type");
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Vw_Leaderduty t_calendar = new Vw_Leaderduty();
		try {
			calendar.setTime(format.parse(startDate));
		} catch(ParseException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		Calendar firtCalendar = (Calendar)calendar.clone();
		Calendar lastCalendar = (Calendar)calendar.clone();
		if(type != null && "agendaWeek".equals(type)) {
			//周格式
			lastCalendar.add(Calendar.DAY_OF_WEEK, 7);
		} else if(type != null && "agendaDay".equals(type)) {
			//日格式
			lastCalendar.add(Calendar.HOUR, 24);
		} else {
			//月格式
			firtCalendar.set(Calendar.DATE, 1);
			lastCalendar.set(Calendar.DATE, 0);
			lastCalendar.add(Calendar.MONTH, 1);
		}
		String start = format.format(firtCalendar.getTime());
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		String end = format.format(lastCalendar.getTime());
		List<Record> calendars = t_calendar.getCalendarDayAll(start, end);
		;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("calendars", calendars);
		renderJson(map);
	}

	@Clear
	public void ondutyadd() {
		String type = getPara(0);
		String time = getPara(1);
		if(time != null) {
			time = time.replace("t", "-");
		}
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		setAttr("type", type);
		setAttr("dateStr", time);
		setAttr("now", sdf.format(d));
		render("add.jsp");
	}

	@Clear
	public void ondutyupd() {
		String id = getPara(0);
		T_LeaderDuty ld = T_LeaderDuty.dao.findById(id);
		setAttr("ld", ld);
		render("update.jsp");
	}

	public void getUsers() {
		Integer apId = 0;
		if(null != getPara("apId")) {
			try {
				apId = getParaToInt("apId");
			} catch(Exception e) {
				toDwzText(false, "您提交的数据有误，请检查后重新提交！", "", "", "", "");
				return;
			}
		}
		List<T_Sys_Department> baseorgans = T_Sys_Department.dao.find("select * from t_sys_department where d_pid=0");
		List<Record> organs = T_Sys_Department.dao.getOrgans(baseorgans);
		setAttr("organs", organs);
		setAttr("apId", apId);
		render("findData/depts.jsp");
	}

	public void getUserList() {
		String d_pid = getPara(0);
		setAttr("pid", d_pid);
		render("findData/userList.jsp");
	}

	public void getuserbypid() {
		String pid = getPara(0);
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		//Page<Record> user=T_Sys_User.dao.getUserlist(pageSize, pageNumber,pid,userid);
		Page<Record> user = T_Sys_User.dao.getUserlist(pageSize, pageNumber, pid, null);
		List<Record> list = user.getList();
		int totalCount = user.getTotalRow();
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void save() {
		try {
			String moudle = getPara("moudle");
			boolean success = false;
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			String methodname = "add";
			String act = getPara("act");
			String type = getPara("type");
			T_LeaderDuty ldt = getModel(T_LeaderDuty.class);
			String phonelist = "," + T_LeaderDuty.dao.findFirst("select to_char(wmsys.wm_concat(phone)) as phonelist from T_LeaderDuty where dutydate='" + ldt.getStr("dutydate") + "'").getStr("phonelist") + ",";
			if(phonelist.indexOf(ldt.getStr("phone")) != -1 && !moudle.equals("y")) {
				toDwzText(false, "当天已安排值班，不得重复安排！", "", "", "", "");
				return;
			}
			String alt = "";
			if(act.equals("upd")) {
				ldt.update();
				success = true;
				methodname = "update";
				alt = "修改成功！";
				toDwzText(success, alt, "", "ondutyDialog", "ondutyGrid", "closeCurrent");
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/onduty", methodname, ldt, getRequest());
				return;
			} else {
				ldt.set("id", AutoId.nextval(ldt));
				if(moudle.equals("y")) {
					ldt.set("dutydate", null);
				}
				ldt.save();
				success = true;
				alt = "保存成功！";
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/onduty", methodname, ldt, getRequest());
				if(type.equals("g")) {
					toDwzText(success, alt, "", "ondutyDialog", "ondutyGrid", "closeCurrent");
				} else {
					toDwzText(success, alt, "", "ondutyDialog", "", "closeCurrent");
				}
			}
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}

	//当天列表
	@Clear
	public void list() {
		Date date = getParaToDate() == null ? getParaToDate("dateStr") : getParaToDate();
		if(date == null || "".equals(date)) {
			toDwzText(false, "数据异常，请您检查后重新提交！", "", "", "", "");
			return;
		}
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = df.format(date);
		setAttr("dateStr", dateStr);
		render("list.jsp");
	}

	public void getdutyGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		Date date = getParaToDate() == null ? getParaToDate("dateStr") : getParaToDate();
		if(date == null || "".equals(date)) {
			toDwzText(false, "数据异常，请您检查后重新提交！", "", "", "", "");
			return;
		}
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = df.format(date);
		String name = getPara("name");
		Page<Record> page = Vw_Leaderduty.dao.getGridPage(pageNumber, pageSize, dateStr, name);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	@Clear
	public void ondutydel() {
		String ids = getPara("ids");
		String[] id = ids.split(",");
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			for(String i : id) {
				T_LeaderDuty ld = T_LeaderDuty.dao.findById(i);
				ld.delete();
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/onduty", "delete", ld, getRequest());
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

	@Clear
	//导出排班
	public void dutyexp() {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			//设置表格表头样式
			WritableFont font = new WritableFont(WritableFont.createFont("宋体"), 20, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE);
			WritableCellFormat headerFormat = new WritableCellFormat(NumberFormats.TEXT);
			headerFormat.setFont(font);
			headerFormat.setBorder(Border.ALL, BorderLineStyle.MEDIUM, Colour.BLACK);
			headerFormat.setAlignment(Alignment.CENTRE);
			//表格内容样式
			WritableFont font2 = new WritableFont(WritableFont.createFont("宋体"), 10, WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE);
			WritableCellFormat bodyFormat = new WritableCellFormat(font2);
			bodyFormat.setBackground(Colour.WHITE);
			bodyFormat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
			String date = getPara("startDate");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(sdf.parse(date));
			cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			String enddate = sdf.format(cal.getTime());
			cal.set(Calendar.DAY_OF_MONTH, 1);
			String startdate = sdf.format(cal.getTime());
			List<Record> list = T_LeaderDuty.dao.getdutylist(startdate, enddate);
			String namelist = T_LeaderDuty.dao.getnamestr(startdate, enddate);
			HttpServletResponse res = getResponse();
			res.setContentType("application/vnd.ms-excel");
			res.setHeader("Content-disposition", "attachment;filename=onduty.xls");
			OutputStream os = res.getOutputStream();
			jxl.WorkbookSettings settings = new jxl.WorkbookSettings();
			jxl.write.WritableWorkbook wb = jxl.Workbook.createWorkbook(os, settings);
			jxl.write.WritableSheet sheet = wb.createSheet("值班表", 0);
			sheet.addCell(new jxl.write.Label(0, 0, "总值班室轮值表", headerFormat));
			String str = startdate.substring(0, 4) + "年" + startdate.substring(5, 7) + "月" + startdate.substring(8, 10) + "日-" + enddate.substring(5, 7) + "月" + enddate.substring(8, 10) + "日";
			sheet.addCell(new jxl.write.Label(0, 1, str, headerFormat));
			sheet.addCell(new jxl.write.Label(0, 2, "日期\\名称", bodyFormat));
			sheet.setColumnView(0, 12);
			if(list != null && list.size() > 0) {
				Map<String, Integer> nl = new HashMap<String, Integer>();
				String nlist[] = namelist.split(",");
				sheet.mergeCells(0, 0, nlist.length + 1, 0);
				sheet.mergeCells(0, 1, nlist.length + 1, 1);
				for(int j = 0; j < nlist.length; j++) {
					sheet.setColumnView(1+j, 8);
					sheet.addCell(new jxl.write.Label(1 + j, 2, nlist[j], bodyFormat));
					nl.put(nlist[j], j + 1);
				}
				sheet.addCell(new jxl.write.Label(nlist.length + 1, 2, "备注", bodyFormat));
				String datefirst = list.get(0).getStr("dutydate");
				int hang = 3;
				sheet.addCell(new jxl.write.Label(0, hang, datefirst, bodyFormat));
				for(int k = 0; k < nlist.length; k++) {
					sheet.addCell(new jxl.write.Label(k + 1, hang, "\\", bodyFormat));
				}
				sheet.addCell(new jxl.write.Label(nlist.length + 1, 3, "", bodyFormat));
				String nowdate = "";
				String nowname = "";
				for(int i = 0; i < list.size(); i++) {
					nowdate = list.get(i).getStr("dutydate");
					nowname = list.get(i).getStr("leadername");
					if(nowdate.equals(datefirst)) {
						sheet.addCell(new jxl.write.Label(nl.get(nowname), hang, "值班", bodyFormat));
					} else {
						hang = hang + 1;
						sheet.addCell(new jxl.write.Label(0, hang, nowdate, bodyFormat));
						for(int k = 0; k < nlist.length; k++) {
							sheet.addCell(new jxl.write.Label(k + 1, hang, "\\", bodyFormat));
						}
						sheet.addCell(new jxl.write.Label(nlist.length + 1, hang, "", bodyFormat));
						sheet.addCell(new jxl.write.Label(nl.get(nowname), hang, "值班", bodyFormat));
						datefirst = nowdate;
					}
				}
				sheet.addCell(new jxl.write.Label(0, hang + 1, "注释：值班时间为24小时，\\表示休息。", headerFormat));
				sheet.mergeCells(0, hang + 1, nlist.length + 1, hang + 1);
			}
			wb.write();
			wb.close();
			success = true;
		} catch(Exception e) {
			log.error(e.getMessage());
			errorCode = "error";
			msg = e.getMessage();
			e.printStackTrace();
		} finally {
			renderNull();
		}
	}

	//拖拉保存
	@Clear
	public void ondutydrop() {
		String id = getPara("id");
		String time = getPara("time");
		String type = getPara("type");
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		String method = "add";
		try {
			T_LeaderDuty ld = T_LeaderDuty.dao.findById(id);
			String phonelist = "," + T_LeaderDuty.dao.findFirst("select to_char(wmsys.wm_concat(phone)) as phonelist from T_LeaderDuty where dutydate='" + time + "'").getStr("phonelist") + ",";
			if(phonelist.indexOf(ld.getStr("phone")) != -1) {
				msg = "当天已安排值班，不得重复安排！";
			} else {
				if(type.equals("d")) {
					ld.set("dutydate", time);
					ld.update();
					method = "update";
				} else {
					ld.set("id", AutoId.nextval(ld)).set("dutydate", time);
					ld.save();
				}
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/onduty", method, ld, getRequest());
				success = true;
			}
		} catch(Exception e) {
			log.error(e.getMessage());
			errorCode = "error";
			msg = e.getMessage();
			e.printStackTrace();
		} finally {
			map.put("time", time);
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}

	public void getmoudle() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<T_LeaderDuty> dlist = T_LeaderDuty.dao.find("select * from (select * from t_leaderduty where dutydate is null order by leadername asc)");
		map.put("result", dlist);
		renderJson(map);
	}
}
