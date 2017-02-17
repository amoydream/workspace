package com.lauvan.apps.analysis.eventstats.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
/**
 * 事件统计分析
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/eventStats", viewPath="analysis/eventstats")
public class EventStatsController extends BaseController{
	
	public void index(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String edate = sdf.format(c.getTime());
		c.add(Calendar.MONTH, -3);
		String sdate = sdf.format(c.getTime());
		setAttr("sdate", sdate);
		setAttr("edate", edate);
		renderJsp("main.jsp");
	}
	
	public void statsResult(){
		String sdate = getPara("sdate");
		String edate = getPara("edate");
		String xval = getPara("xval");
		String yval = getPara("yval");
		String dlval = getPara("dlval");
		List<Record> list = 
			T_Bus_EventInfo.dao.statsEvent(sdate, edate, xval, yval, dlval);
		List<Record> xlist = 
			T_Bus_EventInfo.dao.groupBy(sdate, edate, xval);
		List<Record> ylist = 
			T_Bus_EventInfo.dao.groupBy(sdate, edate, yval);
		setAttr("list", list);
		setAttr("xlist", xlist);
		setAttr("ylist", ylist);
		setAttr("xtext", getPara("xtext"));
		setAttr("ytext", getPara("ytext"));
		setAttr("dltext", getPara("dltext"));
		setAttr("yval", yval);
		renderJsp("statsResult.jsp");
	}

}
