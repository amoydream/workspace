package com.lauvan.apps.event.controller;

/**
 * 日常事件管理控制类
 * @author 黄丽凯
 * */
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/eventRoutine", viewPath = "/event/routine")
public class RoutineController extends BaseController {
	public void index() {
		setAttr("ev_reporttel", getPara("ev_reporttel"));
		setAttr("callId", getPara("callId"));
		render("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String ename = getPara("ename");
		String etype = getPara("etype");
		String stime=getPara("stime");
		String etime=getPara("etime");
		//LoginModel login = getSessionAttr("loginModel");
		//String dept = login.getOrgId().toString();
		StringBuffer sqlWhere = new StringBuffer();
		/*sqlWhere.append(" and s.ev_state = '00A'");
		if(ename!=null && !"".equals(ename)){
			sqlWhere.append(" and s.ev_name like '%").append(ename).append("%'");
		}
		if(etype!=null && !"".equals(etype)){
			sqlWhere.append(" and s.ev_type = '").append(etype).append("'");
		}*/
		sqlWhere.append(" e.ev_state = '00A'");
		if(ename != null && !"".equals(ename)) {
			sqlWhere.append(" and e.ev_name like '%").append(ename).append("%'");
		}
		if(etype != null && !"".equals(etype)) {
			sqlWhere.append(" and e.ev_type = '").append(etype).append("'");
		}
		if(stime != null && !"".equals(stime)) {
			sqlWhere.append(" and e.marktime >= '").append(stime).append(" 00:00:00'");
		}
		if(etime != null && !"".equals(etime)) {
			sqlWhere.append(" and e.marktime <= '").append(etime).append(" 23:59:59'");
		}
		//Page<Record> page = Paginate.dao.getServicePage(pageSize, pageNumber, "t_bus_eventinfo", dept, sqlWhere.toString(), "s.Ev_date", "desc");
		//Page<Record> page = Paginate.dao.getPage("t_bus_eventinfo", pageSize, pageNumber, sqlWhere.toString(), "Ev_date", "desc");
		Page<Record> page=T_Bus_EventInfo.dao.getPage(pageSize, pageNumber,sqlWhere);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate", nowdate);
		setAttr("ev_reporttel", getPara("ev_reporttel"));
		setAttr("callid", getPara("callid"));
		render("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(id);
		if(t != null) {
			LoginModel login = getSessionAttr("loginModel");
			Number user = login.getUserId();
			Number creater = t.getNumber("user_id");
			/*if(!login.getIsAdmin() && !creater.toString().equals(user.toString())) {
				toDwzText(false, "只能由事件的登记人修改，请检查！", "", "", "", "closeCurrent");
				return;
			}*/
			setAttr("t", t);
			//获取现场图片
			String img = t.get("ev_img")==null?"":t.get("ev_img").toString();
			if(!"".equals(img)){
				T_Attachment imgfj = T_Attachment.dao.findById(img);
				setAttr("imgfj",imgfj);
			}
			render("edit.jsp");
		} else {
			toDwzText(false, "该事件不存在，请检查！", "", "", "", "closeCurrent");
			return;
		}
	}

	public void save() {
		try {
			String act = getPara("act");
			T_Bus_EventInfo t = getModel(T_Bus_EventInfo.class);
			//现场图形
			String txid = getPara("ectxid");
			if(txid!=null && !"".equals(txid)){
				t.set("ev_img", txid);
			}
			//行政区域
			String occurcity = "";
			String occurarea = t.getStr("occurarea");
			T_Sys_Parameter pcode = T_Sys_Parameter.dao.getPcodeRoot(occurarea, "EVQY");
			if(pcode!=null){
				occurcity = pcode.getStr("p_acode");
				t.set("occurcity", occurcity);
			}
			if("add".equals(act)) {
				LoginModel login = getSessionAttr("loginModel");
				t.set("user_id", login.getUserId());
				t.set("ev_state", "00A");//日常事件
				t.set("ev_status", "00A");
				T_Bus_EventInfo.dao.insert(t);
			} else {
				t.update();
			}
			toDwzText(true, "保存成功！", "", "eventDialog", "routineGrid", "closeCurrent");
		} catch(Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}
	}

	public void delete() {
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "删除成功！";
		String errorCode = "info";
		try {
			/*LoginModel login = getSessionAttr("loginModel");
			String uid = login.getUserId().toString();
			if(login.getIsAdmin() || T_Bus_EventInfo.dao.isStatus(ids, null, uid)) {
				success = T_Bus_EventInfo.dao.deleteByIDs(ids);
			} else {
				errorCode = "error";
				msg = "只能删除自己登记的事件！";
			}*/
			success = T_Bus_EventInfo.dao.deleteByIDs(ids);
		} catch(Exception e) {
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

	public void view() {
		String id = getPara(0);
		String flag = getPara(1);
		setAttr("tflag", flag);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(id);
		setAttr("t", t);
		//事发单位
		String dept = t.get("organid") == null ? null : t.get("organid").toString();
		if(dept != null) {
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			setAttr("organ", d.getStr("or_name"));
		}
		//获取现场图片
		String img = t.get("ev_img")==null?"":t.get("ev_img").toString();
		if(!"".equals(img)){
			T_Attachment imgfj = T_Attachment.dao.findById(img);
			setAttr("imgfj",imgfj);
		}
		String ships = t.getStr("ev_ships");
		if(ships!=null && !"".equals(ships)){
			ships = ships.replace("\r\n", "</br>");
		}
		setAttr("ships",ships);
		render("view.jsp");
	}

	//转突发事件
	public void changeEvent() {
		String id = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(id);
		setAttr("t", t);
		render("changevent.jsp");
	}
}
