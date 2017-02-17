package com.lauvan.apps.event.controller;

/**
 * 事件综合查询控制类
 * @author 黄丽凯
 * */
import java.util.List;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.event.model.T_Bus_EventProcess;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/eventSearch", viewPath = "/event/search")
public class EventController extends BaseController {
	public void index() {
		render("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String ename = getPara("ename");
		String etype = getPara("etype");
		String estatus = getPara("estatus");
		String elevel = getPara("elevel");
		String stime=getPara("stime");
		String etime=getPara("etime");
		String estate=getPara("estate");//事件性质
		String noevtype = getPara("noevtype");//不包含类型
		//LoginModel login = getSessionAttr("loginModel");
		//String dept = login.getOrgId().toString();
		StringBuffer sqlWhere = new StringBuffer();
		sqlWhere.append(" 1=1 ");
		/*if(ename!=null && !"".equals(ename)){
			sqlWhere.append(" and s.ev_name like '%").append(ename).append("%'");
		}
		if(estatus!=null && !"".equals(estatus)){
			sqlWhere.append(" and s.ev_status = '").append(estatus).append("'");
		}
		if(etype!=null && !"".equals(etype)){
			sqlWhere.append(" and s.ev_type = '").append(etype).append("'");
		}
		if(elevel!=null && !"".equals(elevel)){
			sqlWhere.append(" and s.ev_level = '").append(elevel).append("'");
		}*/
		if(ename != null && !"".equals(ename)) {
			sqlWhere.append(" and e.ev_name like '%").append(ename).append("%'");
		}
		if(estatus != null && !"".equals(estatus)) {
			sqlWhere.append(" and e.ev_status = '").append(estatus).append("'");
		}
		if(etype != null && !"".equals(etype)) {
			sqlWhere.append(" and e.ev_type = '").append(etype).append("'");
		}
		if(elevel != null && !"".equals(elevel)) {
			sqlWhere.append(" and e.ev_level = '").append(elevel).append("'");
		}
		if(stime != null && !"".equals(stime)) {
			sqlWhere.append(" and e.marktime >= '").append(stime).append(" 00:00:00'");
		}
		if(etime != null && !"".equals(etime)) {
			sqlWhere.append(" and e.marktime <= '").append(etime).append(" 23:59:59'");
		}
		if(estate != null && !"".equals(estate)) {
			sqlWhere.append(" and e.ev_state = '").append(estate).append("'");
		}
		if(noevtype != null && !"".equals(noevtype)) {
			sqlWhere.append(" and e.ev_type not in ('").append(noevtype).append("')");
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

	//处置回放
	public void processView() {
		String id = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(id);
		String ev_date = t.getStr("ev_date");
		String lastoperatetime = t.getStr("lastoperatetime");
		setAttr("evdate", ev_date.substring(0, 4));
		setAttr("evday", ev_date.substring(0, 10));
		setAttr("evtime", ev_date.substring(11));
		if(lastoperatetime != null && !"".equals(lastoperatetime)) {
			setAttr("evday_fin", lastoperatetime.substring(0, 10));
			setAttr("evtime_fin", lastoperatetime.substring(11));
		}
		setAttr("e", t);
		//接报方式
		T_Sys_Parameter rp = T_Sys_Parameter.dao.getByCode2(t.getStr("ev_reportmode"), "EVRP");
		setAttr("reporttype", rp.getStr("p_name"));
		String content = t.getStr("ev_basicsituation");
		if(content != null && !"".equals(content)) {
			content = content.replaceAll("/r/n", "</br>");
		}
		String content_fin = t.getStr("finishnotes");
		if(content_fin != null && !"".equals(content_fin)) {
			content_fin = content_fin.replaceAll("/r/n", "</br>");
			setAttr("content_fin", content_fin);
		}
		setAttr("content", content);

		//过程信息
		List<Record> eplist = T_Bus_EventProcess.dao.getListByEid_HG(id);
		setAttr("eventProcessList", eplist);
		render("playback.jsp");
	}

	/**
	 * 根据名称返回事件详细信息
	 * */
	public void getContent() {
		String name = getPara("ename");
		String flag = getPara("flag");
		List<Record> list = T_Bus_EventInfo.dao.getListByName(name, flag);
		String jsonlist = JsonKit.toJson(list);
		renderJson(jsonlist);
	}
}
