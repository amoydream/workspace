package com.lauvan.apps.analysis.eventanls.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;

@RouteBind(path="Main/happenrate",viewPath="/analysis/eventanls/happenrate")
public class HappenRateController extends BaseController{
	
	public void index(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String edate = sdf.format(c.getTime());
		c.add(Calendar.MONTH, -3);
		String sdate = sdf.format(c.getTime());
		setAttr("sdate", sdate);
		setAttr("edate", edate);
		render("main.jsp");
	}
	
	//查看损失图表
		public void getHappenChart(){
			String sdate = getPara("sdate");
			String edate = getPara("edate");
			setAttr("sdate", sdate);
			setAttr("edate", edate);
			renderJsp("happenChart.jsp");
		}
	
		//获取圆饼数据
		public void getPieData(){
			String yearMonth = getPara("haYearMonth");
			Map<String, Object> result = new HashMap<String, Object>();
			List<Record> nowdata = T_Bus_EventInfo.dao.groupByEventArea2(yearMonth);
			yearMonth = (Integer.parseInt(yearMonth.substring(0,4))-1) + yearMonth.substring(4);
			List<Record> lastdata = T_Bus_EventInfo.dao.groupByEventArea2(yearMonth);
			for(int i=0; i< nowdata.size(); i++){
			     Record r = nowdata.get(i);
				 Record r2 = new Record();
				 r2.set("name", r.getStr("ev_type"));
				 r2.set("value", r.get("total")==null?0:r.get("total"));
				 nowdata.remove(i);
				 nowdata.add(i, r2);
			}
			for(int i=0; i< lastdata.size(); i++){
			     Record r = lastdata.get(i);
				 Record r2 = new Record();
				 r2.set("name", r.getStr("ev_type"));
				 r2.set("value",  r.get("total")==null?0:r.get("total"));
				 lastdata.remove(i);
				 lastdata.add(i, r2);
			}
			result.put("nowdata", nowdata.toArray());
			result.put("lastdata", lastdata.toArray());
			renderJson(result);
			
		}
		
		//获取概率数据
		public void getRateData(){
			String sdate = getPara("sdate");
			String edate = getPara("edate");
			List<Record> list = T_Bus_EventInfo.dao.groupByMonth2(sdate, edate);
			Float[] nowdata = new Float[list.size()];
			Float[] lastdata = new Float[list.size()];
			String[] months = new String[list.size()];
			Map<String, Object[]> result = new HashMap<String, Object[]>(); 
			for(int i=0; i<nowdata.length; i++){
				Record r = list.get(i);
				nowdata[i] = r.getBigDecimal("total").floatValue();
				months[i] = r.getStr("month");
			}
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			try {
				Date d = sdf.parse(sdate);
				c.setTime(d);
				c.add(Calendar.YEAR, -1);
				sdate = sdf.format(c.getTime());  //上年同期开始时间
				d = sdf.parse(edate);
				c.setTime(d);
				c.add(Calendar.YEAR, -1);
				edate = sdf.format(c.getTime()); //上年同期结束时间
				list = T_Bus_EventInfo.dao.groupByMonth2(sdate, edate); //查询上年同期
				for(int i=0; i<months.length; i++){
					for(Record r : list){
						String month = r.getStr("month").substring(4); //截取月份
						String year = r.getStr("month").substring(0,4); //截取年份
						month = (Integer.parseInt(year)+1) + month; //年份加1
						if(months[i].equals(month)){ //对比日期是否间隔一年
							lastdata[i] = r.getBigDecimal("total").floatValue();
						}
					}
				}
			} catch (ParseException e) {
				e.printStackTrace();
			} finally{
				result.put("nowdata", nowdata);
				result.put("lastdata", lastdata);
				result.put("months", months);
				renderJson(result);
			}
		}
		
		
		//查看损失列表
		public void getHappenList(){
			String sdate = getPara("sdate");
			String edate = getPara("edate");
			String occurarea = getPara("occurarea");
			String lastsdate = "";
			String lastedate = "";
			SimpleDateFormat sdf = null;
			Calendar c = Calendar.getInstance();
			//计算上年同期时间
			try {
				sdf = new SimpleDateFormat("yyyy-MM-dd");
				c.setTime(sdf.parse(sdate));
				c.add(Calendar.YEAR, -1);
				lastsdate = sdf.format(c.getTime()); //上年同期开始时间
				c.setTime(sdf.parse(edate));
				c.add(Calendar.YEAR, -1);
				lastedate = sdf.format(c.getTime()); //上年同期结束时间
			} catch (ParseException e) {
				e.printStackTrace();
			}
			setAttr("sdate", sdate);
			setAttr("edate", edate);
			setAttr("lastsdate", lastsdate);
			setAttr("lastedate", lastedate);
			setAttr("occurarea", occurarea);
			setAttr("column", "EV_TYPE");
			setAttr("columnname", "事件类型");
			renderJsp("happenList.jsp");
			
		}
		
		public void getGridData(){
			Integer pageSize = getParaToInt("rows");
			Integer pageNumber = getParaToInt("page");
			String sdate = getPara("sdate");
			String edate = getPara("edate");
			String yearMonth = getPara("haYearMonth");
			if(yearMonth != null && !"".equals(yearMonth)){
				try {
					SimpleDateFormat sdf = null;
					Calendar c = Calendar.getInstance();
					sdf = new SimpleDateFormat("yyyy-MM");
					c.setTime(sdf.parse(yearMonth));
					sdf = new SimpleDateFormat("yyyy-MM-dd");
					sdate = sdf.format(c.getTime());
					c.add(Calendar.MONTH, 1);
					c.add(Calendar.DAY_OF_MONTH, -1);
					edate = sdf.format(c.getTime());
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
			String evtype = getPara("evtype");
			Page<Record> page = T_Bus_EventInfo.dao.getPageByDate2(pageSize, pageNumber, sdate, edate, evtype);
			String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
			renderText(jsonStr);
			
		}

}
