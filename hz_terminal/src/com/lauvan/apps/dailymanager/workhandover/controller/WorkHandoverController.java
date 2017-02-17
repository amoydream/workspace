package com.lauvan.apps.dailymanager.workhandover.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import com.lauvan.apps.dailymanager.todo.model.T_ThingInfo;
import com.lauvan.apps.dailymanager.workhandover.model.T_DutyRecord;
import com.lauvan.apps.dailymanager.workhandover.model.T_DutyRecord_Content;
import com.lauvan.apps.dailymanager.workhandover.model.T_Work_Handover;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;
import com.zhuozhengsoft.pageoffice.wordwriter.DataRegion;
import com.zhuozhengsoft.pageoffice.wordwriter.DataRegionInsertType;
import com.zhuozhengsoft.pageoffice.wordwriter.ParagraphFormat;
import com.zhuozhengsoft.pageoffice.wordwriter.WdLineSpacing;
import com.zhuozhengsoft.pageoffice.wordwriter.WdParagraphAlignment;

@RouteBind(path = "Main/workhandover", viewPath = "/dailymanager/workhandover")
public class WorkHandoverController extends BaseController {
	private static final Logger log = Logger.getLogger(WorkHandoverController.class);

	//交班管理
	public void givenworkmg() {
		render("givenworkmgmain.jsp");
	}

	public void getgivenGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String type = getPara(0);
		String givenname = getPara("givenname");
		String receivename = getPara("receivename");
		LoginModel loginModel = getSessionAttr("loginModel");
		String useraccount = null;
		if(!loginModel.getIsAdmin()) {
			useraccount = loginModel.getUserAccount();
		}
		Page<Record> page = T_Work_Handover.dao.getGridPage(pageNumber, pageSize, givenname, receivename, useraccount, type);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void getgivenGridDataview() {
		String id = getPara("id");
		String json = "";
		List<Record> list = T_Work_Handover.dao.getlist(id);
		json = JsonKit.toJson(list);
		renderText(json);
	}
	
	public void getXlsSave(){
			com.zhuozhengsoft.pageoffice.FileSaver fs = new com.zhuozhengsoft.pageoffice.FileSaver(getRequest(),getResponse());
			fs.close();
			renderNull();
	}
	
	//值班清单
	public void getDutyDoc(){
		String id = getPara(0);
		String newPath = PathKit.getWebRootPath() +"/upload/template/dailyduty.doc";
		T_Work_Handover h = T_Work_Handover.dao.findById(id);
		String evtids = h.getStr("EVENT_ID");
		com.zhuozhengsoft.pageoffice.wordwriter.WordDocument doc = new com.zhuozhengsoft.pageoffice.wordwriter.WordDocument();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//日期转换
		String  intervaltime = "";
		String betweentime = "";
		//交班时间为14点后，打印时间是今天12点至明天12点
		try {
			if(StringUtils.isNotBlank(h.getStr("DUTYDATE"))){
				intervaltime = h.getStr("DUTYDATE").substring(0,10);
				intervaltime = intervaltime+" "+"12:00:00";
				Date d = DateTimeUtil.stringToDate(intervaltime, "yyyy-MM-dd HH:mm:ss");
				String t = DateTimeUtil.formatDate(d, "yyyy年MM月dd日 HH时 E");
			if(DateTimeUtil.compareTime(sdf.parse(h.getStr("DUTYDATE")), "14:00:00")){
				Date d1 = DateTimeUtil.getInternalDateByDay(d, 1);	
				String t1 = DateTimeUtil.formatDate(d1, "yyyy年MM月dd日 HH时 E");
				betweentime = t.substring(0, 15)+"-"+t1.substring(5,15)+"("+t.substring(16)+"至"+t1.substring(18)+")"; 
			}else{	
				Date d1 = DateTimeUtil.getInternalDateByDay(d, -1);
				String t1 = DateTimeUtil.formatDate(d1, "yyyy年MM月dd日 HH时 E");
				betweentime = t1.substring(0, 15)+"-"+t.substring(5,15)+"("+t1.substring(16)+"至"+t.substring(18)+")";
			   }
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 获取事件信息
		String flag = "PO_content";
		Map<String,List<Record>> eventmap = T_Bus_EventInfo.dao.getAllDairyEvent(evtids);
		/*List<Record> evtList = T_Bus_EventInfo.dao.getEventList(evtids);*/
		List<Record> reportModel = T_Bus_EventInfo.dao.getAllEventReportModel(evtids);
		StringBuffer content = new StringBuffer();
		// 创建DataRegion对象，PO_content为自动添加的书签名称
		// 设置字体：粗细、是否是斜体、大小、字体名称、字体颜色
		DataRegion body = doc.createDataRegion("PO_newview",
				DataRegionInsertType.After, flag);				
		for(int m=0;m<reportModel.size();m++){
				flag = "PO_newview"+m;
			String modelcode = reportModel.get(m).getStr("model");
			body.getFont().setBold(false);
			body.getFont().setItalic(false);
			body.getFont().setSize(11);
			// 设置中文字体名称
			body.getFont().setName("宋体");
			T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode2(modelcode,"EVRP"); 
			if(p!=null){
			content.append(p.getStr("P_NAME")+"：").append("\n");
			}
			List<Record> evtList = eventmap.get(modelcode);
		if (eventmap.size()>0) {
			// 创建DataRegion对象，PO_content为自动添加的书签名称
			/*DataRegion   body = doc.createDataRegion(flag + 0,
					DataRegionInsertType.After, flag);*/
			// 设置字体：粗细、是否是斜体、大小、字体名称、字体颜色
			for (int i = 0; i < evtList.size(); i++) {
				flag = flag + i;
				/*body.getFont().setBold(false);
				body.getFont().setItalic(false);
				body.getFont().setSize(11);
				// 设置中文字体名称
				body.getFont().setName("宋体");*/
				Record evtinfo = evtList.get(i);
				
				content.append(i + 1 + "、 ")
						.append(evtinfo.getStr("or_name") != null ?evtinfo.getStr("or_name") : "未填事发单位")
						.append("，")
						.append(DateTimeUtil.formatDate(
								DateTimeUtil.stringToDate(evtinfo.getStr("ev_reportdate"),"yyyy-MM-dd HH:mm:ss"),"yyyy年MM月dd日 HH时mm分").substring(5))
						.append("；")		
						.append(evtinfo.getStr("reportmode")!=null?evtinfo.getStr("reportmode")+"上报"+" ":"未填接报方式")
						.append(evtinfo.getStr("ev_reporttel")!=null?evtinfo.getStr("ev_reporttel"):"未填报告电话").append("；")
						.append(evtinfo.getStr("area")!=null?evtinfo.getStr("area")+":":"未填事发地点:")
						.append(evtinfo.getStr("ev_name")!=null?evtinfo.getStr("ev_name"):"未填事件名称").append("，")
				        .append(evtinfo.getStr("evtp")!=null?evtinfo.getStr("evtp"):"未填事件类型").append("。")
				        .append("\n");
			 }
		 }
		}	
		// 给DataRegion对象赋值
		body.setValue(content.toString());
		//创建ParagraphFormat对象
		ParagraphFormat bodyPara = body.getParagraphFormat();
		//设置段落的行间距、对齐方式、首行缩进
		bodyPara.setLineSpacingRule(WdLineSpacing.wdLineSpaceAtLeast);
		bodyPara.setAlignment(WdParagraphAlignment.wdAlignParagraphLeft);
		bodyPara.setFirstLineIndent(21);
		
		//三试三看情况
		StringBuffer conditions = new StringBuffer();
		if(h!=null){
		conditions.append("1、电话（").append(h.getStr("telstatus")!=null?h.getStr("telstatus"):"").append("）\n")
		.append("2、传真（").append(h.getStr("faxstatus")!=null?h.getStr("faxstatus"):"").append("）\n")
		.append("3、短信（").append(h.getStr("smstatus")!=null?h.getStr("smstatus"):"").append("）\n")
        .append("4、邮箱（").append(h.getStr("emailstatus")!=null?h.getStr("emailstatus"):"").append("）\n")
		.append("5、市委OA（").append(h.getStr("swoastatus")!=null?h.getStr("swoastatus"):"").append("）\n")
		.append("6、市府OA（").append(h.getStr("sfoastatus")!=null?h.getStr("sfoastatus"):"").append("）\n");
		}		
		doc.openDataTag("PO_content").setValue("");
		doc.openDataTag("{PO_date}").setValue(betweentime);
		doc.openDataTag("{PO_bak}").setValue(h!=null&&h.getStr("BAK")!=null?h.getStr("BAK"):"");
		doc.openDataTag("{PO_doccontent}").setValue(h!=null&&h.getStr("DOCCONTENT")!=null?h.getStr("DOCCONTENT"):"");
		doc.openDataTag("{PO_conditions}").setValue(conditions.toString());
		doc.openDataTag("{PO_giver}").setValue(h!=null&&h.getStr("GIVERNAME")!=null?h.getStr("GIVERNAME"):"");
		doc.openDataTag("{PO_receiver}").setValue(h!=null&&h.getStr("RECEIVENAME")!=null?h.getStr("RECEIVENAME"):"");
		doc.openDataTag("{PO_manager}").setValue(h!=null&&h.getStr("MANAGER")!=null?h.getStr("MANAGER"):"");
		
		LoginModel login = getSessionAttr("loginModel");
		setAttr("username",login.getUserName());
		setAttr("newPath",newPath);
		setAttr("doc",doc);
		render("dutydoc.jsp");
		
	}

	//新增值班信息
	public void addgivenworkmg() {
		LoginModel loginModel = getSessionAttr("loginModel");
		setAttr("useraccount", loginModel.getUserAccount());
		setAttr("username", loginModel.getUserName());
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//判断当前时间是否大于12点
		String startDate = "";
		String endDate = "";
		//当前时间大于14点的查询当天12点后的记录，当前时间小于14点，查询昨天12点后今天12点之间的记录
		if(DateTimeUtil.compareTime(date, "14:00:00")){
			startDate = DateTimeUtil.formatDate(date, DateTimeUtil.Y_M_D_FORMAT);
			startDate = startDate+" 12:00:00";
			endDate = DateTimeUtil.getInternalDateByLastDay(date, 1);
			endDate = endDate+" 12:00:00";
		}else{
			startDate = DateTimeUtil.getInternalDateByLastDay(date, -1);
			startDate = startDate+" 12:00:00";
			endDate = DateTimeUtil.formatDate(date, DateTimeUtil.Y_M_D_FORMAT);
			endDate = endDate+" 12:00:00";
		}		
		List<T_Bus_EventInfo> blist = T_Bus_EventInfo.dao.getListByTime(startDate, endDate);
		String blistid = "";
		String blistname = "";
		if(!blist.isEmpty()) {
			for(T_Bus_EventInfo b : blist) {
				blistid += b.get("id") + ",";
				blistname += b.get("ev_name") + ",";
			}
			blistid = blistid.substring(0, blistid.length() - 1);
			blistname = blistname.substring(0, blistname.length() - 1);
		}
		setAttr("blistname", blistname);
		setAttr("blistid", blistid);
		setAttr("blist", blist);
		setAttr("now", sdf.format(date));
		render("addgivenworkmg.jsp");
	}

	//新增值班详细纪要
	public void addgivenwork() {
		String id = getPara(0);
		T_Work_Handover wh = T_Work_Handover.dao.findById(id);
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		setAttr("wh", wh);
		setAttr("now", sdf.format(d));
		render("addgivenwork.jsp");
	}

	public void updgivenwork() {
		String id = getPara(0);
		T_DutyRecord_Content dc = T_DutyRecord_Content.dao.findById(id);
		T_Work_Handover wh = T_Work_Handover.dao.findFirst("select * from T_Work_Handover where dutyid=" + dc.get("pid"));
		setAttr("wh", wh);
		setAttr("record", dc);
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		setAttr("now", sdf.format(d));
		render("updgivenwork.jsp");
	}

	public void workview() {
		String id = getPara(0);
		T_DutyRecord_Content dc = T_DutyRecord_Content.dao.findById(id);
		setAttr("record", dc);
		render("workview.jsp");
	}

	public void workmgview() {
		String id = getPara(0);
		T_Work_Handover wh = T_Work_Handover.dao.findById(id);
		setAttr("wh", wh);
		render("workmgview.jsp");
	}

	public void updgivenworkmg() {
		String id = getPara(0);
		T_Work_Handover wh = T_Work_Handover.dao.findById(id);
		setAttr("wh", wh);
		render("updgivenworkmg.jsp");
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

	//获取用户
	public void getUserList() {
		String d_pid = getPara(0);
		setAttr("pid", d_pid);
		render("findData/userList.jsp");
	}

	public void getuserbypid() {
		String pid = getPara(0);
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		Page<Record> user = T_Sys_User.dao.getUserlist(pageSize, pageNumber, pid, null);
		List<Record> list = user.getList();
		int totalCount = user.getTotalRow();
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	//获取事件
	public void getEvents() {
		String eventids = getPara("eventids");
		setAttr("eventids", eventids);
		render("findData/eventList.jsp");
	}

	public void geteventbyname() {
		String ename = getPara("ename");
		String eventids = getPara("eventids");
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		Page<Record> event = T_Bus_EventInfo.dao.geteventlist(pageSize, pageNumber, eventids, ename);
		List<Record> list = event.getList();
		int totalCount = event.getTotalRow();
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void givenworkmgSave() {
		try {
			boolean success = false;
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			String methodname = "add";
			String act = getPara("act");
			T_Work_Handover wh = getModel(T_Work_Handover.class);
			String alt = "";
			if(act.equals("upd")) {
				wh.update();
				success = true;
				methodname = "update";
				alt = "修改成功！";
			} else {
				T_DutyRecord rd = new T_DutyRecord();
				Number dutyrecord_id = AutoId.nextval(rd);
				rd.set("dutyrecord_id", dutyrecord_id);
				Date date = new Date();
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date d = sdf2.parse(wh.getStr("dutydate"));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
				SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd");
				String end = sdf.format(d);
				String tempend = sdf3.format(d) + " 12:00:00";
				end = end.substring(end.indexOf("年"));
				Calendar cal = Calendar.getInstance();
				cal.setTime(d);
				cal.add(Calendar.DATE, -1);
				String start = sdf.format(cal.getTime());
				String tempstart = sdf3.format(cal.getTime()) + " 12:00:00";
				rd.set("dutyrecord_title", wh.getStr("givername") + "-" + start + "12时-" + end + "-值班纪要");
				rd.set("note", "1").set("recorder", wh.getStr("giveuser")).set("recordtime", sdf2.format(date));
				String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
				int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
				if(w < 0) {
					w = 0;
				}
				rd.set("starttime", tempstart).set("endtime", tempend).set("week", weekDays[w] + "至" + weekDays[w + 1 == 7 ? 0 : w + 1]);
				if(StringUtils.isNotBlank(wh.getStr("dutydate"))){
					String datestr = wh.getStr("dutydate");
					String eventids = getEventId(datestr);
					wh.set("event_id", eventids);
				}
				wh.set("id", AutoId.nextval(wh));
				wh.set("dutyid", dutyrecord_id);
				T_ThingInfo ti = getModel(T_ThingInfo.class);
				Number thingid = AutoId.nextval(ti);
				ti.set("id", thingid).set("name", rd.getStr("dutyrecord_title")).set("thingstatus", "0");
				ti.set("recordman", userid).set("recordtime", sdf2.format(date)).set("note", wh.getStr("bak")).set("receivername", wh.getStr("receivename")).set("type", "003");
				ti.save();
				rd.save();
				wh.set("thingid", thingid);
				wh.save();
				success = true;
				alt = "保存成功！";
			}
			T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/workhandover/givenworkmg", methodname, wh, getRequest());
			toDwzText(success, alt, "", "givenworkmgDialog", "givenworkmgGrid", "closeCurrent");
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}
	
	
	
	public String getEventId(String datetimestr){		
		Date date = DateTimeUtil.stringToDate(datetimestr, DateTimeUtil.Y_M_D_HMS_FORMAT);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//判断当前时间是否大于12点
		String startDate = "";
		String endDate = "";
		//当前时间大于14点的查询当天12点后的记录，当前时间小于14点，查询昨天12点后今天12点之间的记录
		if(DateTimeUtil.compareTime(date, "14:00:00")){
			startDate = DateTimeUtil.formatDate(date, DateTimeUtil.Y_M_D_FORMAT);
			startDate = startDate+" 12:00:00";
			endDate = DateTimeUtil.getInternalDateByLastDay(date, 1);
			endDate = endDate+" 12:00:00";
		}else{
			startDate = DateTimeUtil.getInternalDateByLastDay(date, -1);
			startDate = startDate+" 12:00:00";
			endDate = DateTimeUtil.formatDate(date, DateTimeUtil.Y_M_D_FORMAT);
			endDate = endDate+" 12:00:00";
		}		
		List<T_Bus_EventInfo> blist = T_Bus_EventInfo.dao.getListByTime(startDate, endDate);
		String blistid = "";
		if(!blist.isEmpty()) {
			for(T_Bus_EventInfo b : blist) {
				blistid += b.get("id") + ",";
			}
			blistid = blistid.substring(0, blistid.length() - 1);
		}
		return blistid;
	}

	public void givenworkSave() {
		try {
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			boolean success = false;
			String methodname = "add";
			String act = getPara("act");
			String alt = "";
			T_DutyRecord_Content ct = getModel(T_DutyRecord_Content.class);
			;
			if(act.equals("upd")) {
				ct.update();
				success = true;
				methodname = "update";
				alt = "修改成功！";
			} else {
				ct.set("id", AutoId.nextval(ct));
				ct.save();
				success = true;
				alt = "保存成功！";
			}
			T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/workhandover/givenworkmg", methodname, ct, getRequest());
			toDwzText(success, alt, "", "givenworkDialog", "givenworkmgGrid", "closeCurrent");
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}

	public void delgivenworkmg() {
		String ids = getPara("ids");
		String[] id = ids.split(",");
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		boolean flag = false;
		String msg = "";
		String errorCode = "info";
		try {
			for(String i : id) {
				T_Work_Handover wh = T_Work_Handover.dao.findById(i);
				List<Record> list = T_Work_Handover.dao.getlist(i);
				if(!list.isEmpty()) {
					flag = true;
					msg += "(交班人：" + wh.getStr("giveuser") + "接班人：" + wh.getStr("receiveuser") + "交班时间：" + wh.getStr("dutydate") + ")，";
				} else {
					T_DutyRecord dr = T_DutyRecord.dao.findById(wh.get("dutyid"));
					T_ThingInfo thing = T_ThingInfo.dao.findById(wh.get("thingid"));
					if(dr != null) {
						dr.delete();
					}
					if(thing != null) {
						thing.delete();
					}
					wh.delete();
					T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/workhandover/givenworkmg", "delete", wh, getRequest());
				}
			}
			if(!flag) {
				success = true;
			}
			msg += "交班信息存在值班详细纪要，请先删除纪要，其余交班信息删除成功！";
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

	public void delgivenwork() {
		String id = getPara(0);
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			T_DutyRecord_Content ct = T_DutyRecord_Content.dao.findById(id);
			ct.delete();
			T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/workhandover/givenworkmg", "delete", ct, getRequest());
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

	//接班管理
	public void receiveworkmg() {
		render("receiveworkmgmain.jsp");
	}

	//接班
	public void receivework() {
		String id = getPara(0);
		String time = getPara("time");
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			T_Work_Handover wh = T_Work_Handover.dao.findById(id);
			wh.set("getduty", time);
			wh.update();
			T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/workhandover/receiveworkmg", "delete", wh, getRequest());
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
