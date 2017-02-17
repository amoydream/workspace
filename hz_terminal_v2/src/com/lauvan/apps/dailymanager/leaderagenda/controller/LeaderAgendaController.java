package com.lauvan.apps.dailymanager.leaderagenda.controller;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.dailymanager.leaderagenda.model.T_WeekPlan;
import com.lauvan.apps.dailymanager.leaderagenda.model.T_WeekPlan_Content;
import com.lauvan.apps.dailymanager.workhandover.model.T_Work_Handover;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/leaderagenda",viewPath="/dailymanager/leaderagenda")
public class LeaderAgendaController extends BaseController {
private static final Logger log = Logger.getLogger(LeaderAgendaController.class);
	public void index(){
		Calendar cal=Calendar.getInstance();
		int year=cal.get(Calendar.YEAR);
		int week=cal.get(Calendar.WEEK_OF_YEAR);
		Date d=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		int day=cal.get(Calendar.DAY_OF_WEEK);
		cal.add(Calendar.DATE,-day+1);
		String sjd=sdf.format(cal.getTime());
		cal.add(Calendar.DATE,6);
		sjd+="至"+sdf.format(cal.getTime());
		setAttr("sjd",sjd);
		setAttr("year",year);
		setAttr("week",week);
		setAttr("now",sdf.format(d));
		render("main.jsp");
	}
	public void getchangetime(){
		String time=getPara("time");
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = Calendar.getInstance();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			Date date=sdf.parse(time);
			calendar.setTime(date);
			int week=calendar.get(Calendar.WEEK_OF_YEAR);
			int day=calendar.get(Calendar.DAY_OF_WEEK);
			calendar.add(Calendar.DATE,-day+1);
			int year=calendar.get(Calendar.YEAR);
			String sjd=sdf.format(calendar.getTime());
			calendar.add(Calendar.DATE,6);
			sjd+="至"+sdf.format(calendar.getTime());
			map.put("year", year);
			map.put("week", week);
			map.put("sjd", sjd);
			renderJson(map);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String name=getPara("sname");
		String syear=getPara("syear");
		String sweek=getPara("sweek");
		if(syear==null){
			Calendar cal=Calendar.getInstance();
			syear=String.valueOf(cal.get(Calendar.YEAR));
			sweek=String.valueOf(cal.get(Calendar.WEEK_OF_YEAR));	
		}
		Page<Record> page=T_WeekPlan.dao.getGridPage(pageNumber,pageSize,name,syear,sweek);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void getGridDataview(){
		String id=getPara("id");
		String json="";
		List<Record> list=T_WeekPlan_Content.dao.getlist(id);
		json=JsonKit.toJson(list);
		renderText(json);
	}
	public void agendaadd() throws UnsupportedEncodingException{
		String nowtime=getPara("nowtime");
		String time=getPara("time");
		String date[]=time.split("年");
		setAttr("year",date[0]);
		setAttr("week",date[1].substring(0, date[1].indexOf("周")));
		setAttr("now",nowtime);
		setAttr("time",time);
		render("add.jsp");	
	}
	 //获取一年中第几周的开始时间
	public String getStartDayOfWeekNo(Object year,Object weekNo){
        Calendar cal =Calendar.getInstance();
        cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);      
        cal.set(Calendar.YEAR, Integer.valueOf(year.toString()));
        cal.set(Calendar.WEEK_OF_YEAR, Integer.valueOf(weekNo.toString()));
        return cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH) + 1) + "-" +
               cal.get(Calendar.DAY_OF_MONTH);    
        
    }
	public void agendaupd(){
		String 	id=getPara(0);
		T_WeekPlan wp=T_WeekPlan.dao.findById(id);
		String starttime=getStartDayOfWeekNo(wp.get("year"),wp.get("weeknum"));
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Date date;
		try {
			date = sdf.parse(starttime);
			calendar.setTime(date);
			int day=calendar.get(Calendar.DAY_OF_WEEK);
			calendar.add(Calendar.DATE,-day+1);			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		int week=calendar.get(Calendar.WEEK_OF_YEAR);
		int year=calendar.get(Calendar.YEAR);
		String sjd=year+"年"+week+"周（日程时间段："+sdf.format(calendar.getTime());
		calendar.add(Calendar.DATE,6);
		sjd+="至"+sdf.format(calendar.getTime())+"）";
		setAttr("sjd",sjd);
		setAttr("wp",wp);
		setAttr("starttime",starttime);
		render("update.jsp");	
	}
	public void updagenda(){
	String 	id=getPara(0);	
	T_WeekPlan_Content wc=T_WeekPlan_Content.dao.findById(id);
	setAttr("wc",wc);
	render("updcontent.jsp");
	}
	public void addagenda(){
	String 	id=getPara(0);
	String wcs=","+T_WeekPlan_Content.dao.getampm(id)+",";
	ArrayList<String> timelist=new ArrayList<String>();
	if(wcs.equals(",001,002,")){
	toDwzText(false, "已存在上下午信息，请检查！", "", "leaderagendaDialog", "leaderagendaGrid", "closeCurrent");	
	return;
	}else{
		if(wcs.indexOf(",001,")==-1){
			timelist.add("001");	
		}
        if(wcs.indexOf(",002,")==-1){
			timelist.add("002");
		}
		setAttr("id",id);
		setAttr("timelist",timelist);
		render("addcontent.jsp");
	}
	}
	//修改详细日程
	public void contentSave(){
	boolean success=false;
	LoginModel loginModel=getSessionAttr("loginModel");
	Number userid=loginModel.getUserId();
	String methodname="add";
	String act=getPara("act");
	boolean flag=false;
	String alt="";
	Date d=new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	try{
	T_WeekPlan_Content wc = getModel(T_WeekPlan_Content.class);
	if(wc.getStr("contents1")==null&&wc.getStr("contents2")==null&&wc.getStr("contents3")==null&&wc.getStr("contents4")==null&&wc.getStr("contents5")==null&&wc.getStr("contents6")==null&&wc.getStr("contents7")==null){
		flag=true;
	}
    if(act.equals("upd")){
    if(flag){
    wc.delete();
    success=true;	
    }else{
    wc.set("marktime", sdf.format(d));
    wc.update();
    success=true;	
    }
    alt="修改成功！";
    methodname="update";
    }else{
    if(flag){
    success=true;
    alt="添加成功！";	
    }else{
    wc.set("id", AutoId.nextval(wc));
    wc.set("marktime", sdf.format(d));
    wc.save();
    success=true;
    alt="添加成功！";
    }
    }
	T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/leaderagenda", methodname,wc,getRequest());
	toDwzText(success, alt, "", "leaderagendaDialog", "leaderagendaGrid", "closeCurrent");
	} catch (Exception e) {
		log.error(e.getMessage());
		e.printStackTrace();
		toDwzText(false, "保存异常！", "", "", "", "");
	}
	}
	public void save(){
		try {
    		boolean success=false;
    		boolean flag1=false;
    		boolean flag2=false;
    		LoginModel loginModel=getSessionAttr("loginModel");
    		Number userid=loginModel.getUserId();
    		String methodname="add";
			String act = getPara("act");
			T_WeekPlan tw = getModel(T_WeekPlan.class);
			tw.set("year", getPara("yy")).set("weeknum", getPara("ww"));
			T_WeekPlan_Content wc1=new T_WeekPlan_Content();
			T_WeekPlan_Content wc2=new T_WeekPlan_Content();
			wc1.set("type", "001");
			wc2.set("type", "002");
			String tempam=null;
			String temppm=null;
			for(int i=1;i<=7;i++){
			tempam=getPara("am"+i);
			temppm=getPara("pm"+i);
			if(tempam!=null&&!"".equals(tempam)){
			wc1.set("contents"+i,tempam);
			flag1=true;
			}
			if(temppm!=null&&!"".equals(temppm)){
				wc2.set("contents"+i,temppm);
				flag2=true;
			}
			}
			String alt="";
					if(act.equals("upd")){
						tw.update();
						success=true;
						methodname="update";
						alt="修改成功！";
					}else{
						Number id=AutoId.nextval(tw);
						tw.set("id",id);
						tw.save();
						Date d=new Date();
						SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						wc1.set("weekplanid", id);
						wc2.set("weekplanid", id);
						wc1.set("marktime", sdf.format(d));
						wc2.set("marktime", sdf.format(d));
						if(flag1||flag2){
						Number cid=AutoId.nextval(wc1);
						if(flag1){
							wc1.set("id", cid);
							wc1.save();
							if(flag2){
							wc2.set("id", AutoId.nextval(wc2));
							wc2.save();
							}
						}else{
							wc2.set("id", cid);
							wc2.save();
						}
						}
						success=true;
						alt="保存成功！";							
					}
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/leaderagenda", methodname,tw,getRequest());
				toDwzText(success, alt, "", "leaderagendaDialog", "leaderagendaGrid", "closeCurrent");
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}
	//删除日程
	public void agendadel(){
		String ids=getPara("ids");
		String[] id=ids.split(",");
		 LoginModel loginModel=getSessionAttr("loginModel");
		 Number userid=loginModel.getUserId();
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		boolean flag=false;
		String msg="";
		String errorCode="info";
		try {
		for(String i:id){
		T_WeekPlan wp=T_WeekPlan.dao.findById(i);
		List<Record> list=T_WeekPlan_Content.dao.getlist(i);
		if(!list.isEmpty()){
		msg+="(名称："+wp.getStr("name")+")，";
		flag=true;
		}else{
		wp.delete();
		T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/leaderagenda", "delete",wp,getRequest());
		}
		}
		if(!flag){
			success=true;
			}
		msg+="日程存在详细日程安排，请先删除详细内容，其余日程删除成功！";
		} catch (Exception e) {
			log.error(e.getMessage());
			errorCode="error";
			msg=e.getMessage();
			e.printStackTrace();
		}finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
	//删除详细日程
	public void delagenda(){
		String id = getPara(0);
		 LoginModel loginModel=getSessionAttr("loginModel");
		 Number userid=loginModel.getUserId();
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		try {
		T_WeekPlan_Content wc=T_WeekPlan_Content.dao.findById(id);
		wc.delete();
		T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/leaderagenda", "delete",wc,getRequest());
		success=true;
		} catch (Exception e) {
			log.error(e.getMessage());
			errorCode="error";
			msg=e.getMessage();
			e.printStackTrace();
		}finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
}
