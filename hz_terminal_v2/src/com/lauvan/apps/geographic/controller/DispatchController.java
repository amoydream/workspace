package com.lauvan.apps.geographic.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.event.model.T_Bus_EventProcess;
import com.lauvan.apps.event.model.T_Bus_Event_PreschAction;
import com.lauvan.apps.event.model.T_Bus_Event_PreschActionDept;
import com.lauvan.apps.event.model.T_Bus_Event_Preschphase;
import com.lauvan.apps.event.model.T_Bus_Presch_Instance;
import com.lauvan.apps.event.model.T_Bus_SmsSendRD;
import com.lauvan.apps.geographic.model.T_Bus_EventCmdpos;
import com.lauvan.apps.geographic.model.T_Bus_Graphic;
import com.lauvan.apps.geographic.model.T_Bus_MapConfig;
import com.lauvan.apps.geographic.util.WeatherUtil;
import com.lauvan.apps.massms.service.MasSms;
import com.lauvan.apps.plan.model.T_Bus_PlanItem;
import com.lauvan.apps.plan.model.T_Bus_PreschTrainEvent;
import com.lauvan.apps.plan.model.T_Bus_Preschinfo;
import com.lauvan.apps.workcontact.model.T_Bus_ContactBook;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

/**
 * 指挥调度控制类
 * @author chen  2016/06/08
 *
 */

@RouteBind(path="Main/geographic/dispatch",viewPath="/geographic/dispatch")
public class DispatchController extends BaseController {

	public void index(){
		String eventid = getPara("eventid");
		String flag = getPara("flag");
		setAttr("eventid",eventid);
		setAttr("flag",flag);
		render("index.jsp");
//		main();
	}
	
	public void main(){
		T_Bus_MapConfig config=T_Bus_MapConfig.dao.getData();
		if(config==null){
			renderText("未配置地图基本信息！");
			return;
		}
		
		boolean isOnline=!config.getStr("onlinemap").equals("0");
		
		//判断是否进入事件指挥调度
		String eventid = getPara("eventid");
		if(StringUtils.isNotBlank(eventid)){
			if("train".equals(getPara("flag"))){ //判断是否为演练事件
				T_Bus_PreschTrainEvent event = T_Bus_PreschTrainEvent.dao.findById(eventid);
				//instList =  T_Bus_Presch_Instance.dao.getListByEventId(eventid, "train"); //获取演练事件启动预案列表
				setAttr("event", event);
				setAttr("trainflag", "train"); // 标记事件为演练事件
			}else{
				T_Bus_EventInfo event = T_Bus_EventInfo.dao.findById(eventid);
				//instList =  T_Bus_Presch_Instance.dao.getListByEventId(eventid, null); //获取事件启动预案列表
				setAttr("event", event);
			}
			String instid = getPara("instid");
			String planid = getPara("planid");
			if(null == instid || "".equals(instid)
					|| null == planid || "".equals(planid)){
				List<T_Bus_Presch_Instance> instList = T_Bus_Presch_Instance.dao.getListByEventId(eventid, getPara("flag"));
				if(instList.size()>0){
					T_Bus_Presch_Instance inst = instList.get(0); //默认获取最新启动的预案
					planid = inst.get("plan_id").toString(); //预案id
					instid = inst.get("id").toString(); //事件预案启动实例
				}
			}
			setAttr("planid", planid); //预案id
			setAttr("instid", instid); //事件预案启动实例
			setAttr("flag", true); //显示具体事件
		}
		setAttr("lng", config.get("lng"));
		setAttr("lat", config.get("lat"));
		setAttr("zoom",config.get("zoom"));
		setAttr("date", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		
		if(!isOnline){
			String apiUrl=config.getStr("apiurl"),gisUrl=config.getStr("gisurl");
			if(apiUrl.isEmpty()){
				renderText("未配置离线地图api地址");
				return;
			}
			if(gisUrl.isEmpty()){
				renderText("未配置离线地图地址");
				return;
			}
			setAttr("gisUrl", gisUrl);
			setAttr("apiUrl", apiUrl);
			render("offline_main.jsp");
		}else{
			render("online_main.jsp");
		}
	}
	
	//保存地图标识
	public void graphicSignSave(){
		
		Map<String, Object> map=new HashMap<String, Object>();
		boolean success=false;
		String msg="";
		try{
			Integer eventId=getParaToInt("eventid");
			String flag=getPara("flag");
			String data=getPara("data");
			String attrName="";
			if(flag.equals("1")){
				attrName="effect";
			}else if(flag.equals("2")){
				attrName="path";
			}else if(flag.equals("3")){
				attrName="situation";
			}else{
				msg="传入的参数不正确";
			}
			T_Bus_Graphic record=T_Bus_Graphic.dao.getByEventId(eventId);
			if(record==null){
				record=new T_Bus_Graphic();
				record.set("eventid", eventId);
				record.set("g_id", AutoId.nextval(record));
				record.set(attrName, data);
				success=record.save();
			}else{
				record.set(attrName, data);
				success=record.update();
			}
		}catch (Exception e) {
			// TODO: handle exception
			msg=e.getMessage();
			e.printStackTrace();
		}
		finally{
			map.put("success", success);
			map.put("msg", msg);
			renderJson(map);
		}
	}
	
	
	public void graphicSignDel(){
		Map<String, Object> map=new HashMap<String, Object>();
		boolean success=false;
		String msg="";
		String data="";
		try{
			Integer eventId=getParaToInt("eventid");
			String flag=getPara("flag");
			String attrName="";
			if(flag.equals("1")){
				attrName="effect";
			}else if(flag.equals("2")){
				attrName="path";
			}else if(flag.equals("3")){
				attrName="situation";
			}else{
				msg="传入的参数不正确";
			}
			T_Bus_Graphic record=T_Bus_Graphic.dao.getByEventId(eventId);
			if(record!=null){
				if(record.get(attrName)!=null){
					record.set(attrName, "");
					success=record.update();
				}
				else{
					msg="该事件无地图标识";
				}
			}else{
				msg="无该事件地图标识";
			}
		}catch (Exception e) {
			// TODO: handle exception
			msg=e.getMessage();
			e.printStackTrace();
		}
		finally{
			map.put("success", success);
			map.put("msg", msg);
			renderJson(map);
		}
	}
	
	//获取地图标识
	public void getGrahpicSign(){
		Map<String, Object> map=new HashMap<String, Object>();
		boolean success=false;
		String msg="";
		String data="";
		try{
			Integer eventId=getParaToInt("eventid");
			String flag=getPara("flag");
			String attrName="";
			if(flag.equals("1")){
				attrName="effect";
			}else if(flag.equals("2")){
				attrName="path";
			}else if(flag.equals("3")){
				attrName="situation";
			}else{
				msg="传入的参数不正确";
			}
			T_Bus_Graphic record=T_Bus_Graphic.dao.getByEventId(eventId);
			success=true;
			if(record!=null){
				data=record.getStr(attrName);
			}else{
				
			}
			map.put("data", data);
		}catch (Exception e) {
			// TODO: handle exception
			msg=e.getMessage();
			e.printStackTrace();
		}
		finally{
			map.put("success", success);
			map.put("msg", msg);
			renderJson(map);
		}
	}
	
	//事件处置步骤
	public void handleProc(){
		String instid = getPara(3);
		List<T_Bus_Event_Preschphase> pList = 
			T_Bus_Event_Preschphase.dao.getByFatherId(instid, "0"); //获取预案的阶段列表
		setAttr("pList", pList);
		setAttr("instid", instid);
		setAttr("trainflag", getPara(1));
		setAttr("planid", getPara(2));
		setAttr("eventid", getPara(0));
		renderJsp("handleProc.jsp");
	}
	
	//查看事件详情
	public void eventInfo(){
		String id = getPara(0);
		String organid = null;
		if("train".equals(getPara(1))){
			T_Bus_PreschTrainEvent event = T_Bus_PreschTrainEvent.dao.findById(id);
			organid = event.get("organid") ==null?"":event.get("organid").toString();
			setAttr("info", event);
		}else{
			T_Bus_EventInfo info = T_Bus_EventInfo.dao.findById(id);
			organid = info.get("organid") ==null?"":info.get("organid").toString();
			setAttr("info", info);
		}
		
		if(organid!=null && !"".equals(organid)){
			T_Sys_Department d = T_Sys_Department.dao.findById(organid);
			setAttr("organ", d.getStr("d_name"));
		}
		renderJsp("event/eventinfo.jsp");
		
	}
	
	//查看事件对于物资配置
	public void resource(){
		String preschid = getPara(0);
		setAttr("preschid", preschid);
		renderJsp("event/resource.jsp");
	}
	
	//辅助决策
	public void asstDecs(){
		String eventid = getPara(0);
		String preschid = getPara(1);
		if("train".equals(getPara(2))){
			T_Bus_PreschTrainEvent event = T_Bus_PreschTrainEvent.dao.findById(eventid);
			setAttr("t", event);
		}else{
			T_Bus_EventInfo info = T_Bus_EventInfo.dao.findById(eventid);
			setAttr("t", info);
		}
		
		setAttr("eventid", eventid);
		setAttr("preschid", preschid);
		setAttr("instid", getPara(3));
		renderJsp("event/asstdesc.jsp");
	}
	
	//相关事件案例
	public void eventList(){
		renderJsp("event/eventlist.jsp");
	}
	
	//重点保护对象列表
	public void protectObj(){
		renderJsp("event/protect_obj.jsp");
	}
	//周边居民列表
	public void residentsList(){
		renderJsp("event/residents.jsp");
	}
	//危险源列表
	public void dangerList(){
		renderJsp("event/danger.jsp");
	}
	
	public void monit(){
		setAttr("flag", getPara(0));
		renderJsp("monit.jsp");
	}
	 
	
	//获取处置行动
	public void getProcess(){
		String instid = getPara("instid"); //事件预案实例
		String phaseid = getPara("phaseid"); // 处置阶段id
		List<T_Bus_Event_Preschphase> plist = 
			T_Bus_Event_Preschphase.dao.getByPhaseId(instid, phaseid); 
		List<Map<String, Object>> treeList = new ArrayList<Map<String, Object>>();
		Map<String, Object> node = null;
		if(plist.size()>0){
			for(T_Bus_Event_Preschphase p : plist){ //阶段
				node = new HashMap<String, Object>();
				node.put("id", p.get("phaseid"));
				node.put("pid", p.get("fatherid"));
				node.put("name", p.getStr("phasename"));
				node.put("flag", p.getStr("flag"));
				treeList.add(node);
			}
		}
		renderJson(treeList);
	}
	
	//获取为处置完成的突发事件列表
	public void getEventList(){
		//查询为处置完成的突发事件
		List<T_Bus_EventInfo> eventList = 
			T_Bus_EventInfo.dao.getListByStateStatus("00X","'00C'");
		renderJson(eventList);
	}
	
	//获取事件对应预案资源配置
	public void getResourceList(){
		String planid = getPara("planid");
		List<Record> resList = new ArrayList<Record>();
		//应急队伍
		List<Record> res = T_Bus_PlanItem.dao.getListByIdCode2(planid, "3010");
		resList.addAll(res);
		//应急专家
		res = T_Bus_PlanItem.dao.getListByIdCode2(planid, "2080");
		resList.addAll(res);
		
		//应急物资
		res = T_Bus_PlanItem.dao.getListByIdCode2(planid, "3020");
		resList.addAll(res);
		
		//应急装备
		res = T_Bus_PlanItem.dao.getListByIdCode2(planid, "3030");
		resList.addAll(res);
		renderJson(resList);
		
	}
	
	//获取行动负责部门
	public void getActionDept(){
		String instid = getPara("instid");
		String phaseid = getPara("phaseid");
		String eventid = getPara("eventid");
		String trainflag = getPara("trainflag");
		if("train".equals(trainflag)){
			T_Bus_PreschTrainEvent event = T_Bus_PreschTrainEvent.dao.findById(eventid);
			setAttr("t", event);
		}else{
			T_Bus_EventInfo info = T_Bus_EventInfo.dao.findById(eventid);
			setAttr("t", info);
		}
		String evactid = getPara("evactid");
		if(evactid ==null || "".equals(evactid)){
			List<T_Bus_Event_PreschAction>  actList  = 
				T_Bus_Event_PreschAction.dao.getListByInstidPhaseid(instid, phaseid);
			if(actList.size()>0){
				T_Bus_Event_PreschAction act = actList.get(0);
				setAttr("evactid", act.get("evactid")==null?"":act.get("evactid"));
			}
		}else{
			setAttr("evactid", evactid);
		}
		setAttr("instid", instid);
		setAttr("phaseid", phaseid);
		setAttr("eventid", eventid);
		renderJsp("act_notice.jsp");
	}
	
	//行动通知人员列表
	public void getActionDeptDataGrid(){
		String evactid = getPara("evactid");
		if(evactid != null && !"".equals(evactid)){
			List<T_Bus_Event_PreschActionDept> deptlist = 
				T_Bus_Event_PreschActionDept.dao.getListByEVactid(evactid);
			renderJson(deptlist);
		}else{
			renderJson("[]");
		}
		
	}
	
	//通知行动负责人
	public void sendActMsg(){
		String telVal = getPara("telVal");
		String sendMsg = getPara("sendMsg");
		String[] telArr = telVal.split(",");
		Map<String, Object> tips = new HashMap<String, Object>();
		String msg = "";
		boolean success = true;
		LoginModel login  = getSessionAttr("loginModel");
		if(telArr.length>1000){
			msg = "发送短信号码不能超过1000个， 请检查！";
			success = false;
			return;
		}else{
			long smsid = MasSms.send(login.getUserId().toString(), telArr, sendMsg, "00A");
			if(smsid!=0){
				String state = "V";
				msg = "发送成功！";
				if(smsid<0){
					state = "F";
					msg = "发送失败，请检查！";
					success = false;
				}
				String eventid = getPara("eventid");
				String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
				String sworknum = "";
				T_Bus_ContactBook b = T_Bus_ContactBook.dao.getBookByDepartId(BigDecimal.valueOf(login.getOrgId().longValue()));
				if(b != null){
					sworknum = b.getStr("bo_worknumber");
				}
				for(String tel : telArr){
					if(tel != null && !"".equals(tel)){
						String callname = T_Bus_SmsSendRD.dao.getCallName(tel);
						T_Bus_SmsSendRD sms = new T_Bus_SmsSendRD();
							sms.set("smsid", smsid);
							sms.set("callno", tel);
							sms.set("smsdata", sendMsg);
							sms.set("eventid", eventid);
							sms.set("senduser", login.getUserName());
							sms.set("smsnum", sworknum);
							sms.set("sendtime", now);
							sms.set("sendstate", state);
							sms.set("callname", callname);
							T_Bus_SmsSendRD.dao.insert(sms);
					}
				}
			}else{
				msg = "连接短信接口失败，请检查！";
			}
			
		}
		tips.put("success", success);
		tips.put("msg", msg);
		renderJson(tips);
		
	}
	
	
	public void handleAct(){
		String instid = getPara("instid");
		String phaseid = getPara("phaseid");
		String eventid = getPara("eventid");
		String trainflag= getPara("trainflag");
		String dateStr = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("dateStr", dateStr);
		setAttr("instid", instid);
		setAttr("phaseid", phaseid);
		setAttr("eventid", eventid);
		setAttr("trainflag", trainflag);
		setAttr("planid", getPara("planid"));
		renderJsp("act_mgt.jsp");
	}
	
	//获取行动列表
	public void getActDataGrid(){
		String instid = getPara(0);
		String phaseid = getPara(1);
		List<T_Bus_Event_PreschAction>  actList  = 
			T_Bus_Event_PreschAction.dao.getListByInstidPhaseid(instid, phaseid);
		renderJson(actList);
		
	}
	
	//事件升级页面
	public void getEventUpd(){
		String eventid = getPara("eventid");
		String instid = getPara("instid");
		String flag = getPara("flag");
		T_Bus_Presch_Instance pinfo = T_Bus_Presch_Instance.dao.findById(instid);
		String planid = pinfo.get("plan_id").toString();
		String elevel = "";
		if("train".equals(flag)){
			T_Bus_PreschTrainEvent info = T_Bus_PreschTrainEvent.dao.findById(eventid);
			setAttr("info",info);
			elevel = info.getStr("ev_level");
		}else{
			T_Bus_EventInfo info = T_Bus_EventInfo.dao.findById(eventid);
			setAttr("info",info);
			elevel = info.getStr("ev_level");
		}
		List<Record> ellist = T_Bus_PlanItem.dao.getEPlevel(planid, elevel);
		setAttr("ellist",ellist);
		//setAttr("elevel",elevel);
		setAttr("instid",instid);
		setAttr("flag",flag);
		setAttr("planid",planid);
		render("eventUpd.jsp");
	}
	
	public void eventUpdSave(){
		String eventid = getPara("eventid");
		String flag = getPara("flag");
		String ev_deathToll = getPara("ev_deathToll");
		String ev_level = getPara("ev_level");
		String ev_affectedarea = getPara("ev_affectedarea");
		String ev_injuredPeople = getPara("ev_injuredPeople");
		String ev_economicLoss = getPara("ev_economicLoss");
		
		try {
			if("train".equals(flag)){
				//演练事件
				T_Bus_PreschTrainEvent info = T_Bus_PreschTrainEvent.dao.findById(eventid);
				info.set("ev_level", ev_level);
				info.update();
			}else{
				//基础事件，更新数据
				T_Bus_EventInfo info = T_Bus_EventInfo.dao.findById(eventid);
				info.set("ev_level", ev_level);
				info.set("ev_deathToll", ev_deathToll);
				info.set("ev_injuredPeople", ev_injuredPeople);
				info.set("ev_affectedarea", ev_affectedarea);
				info.set("ev_economicLoss", ev_economicLoss);
				info.update();
			}
			//添加处置过程信息
			LoginModel login = getSessionAttr("loginModel");
			T_Bus_EventProcess pro = new T_Bus_EventProcess();
			pro.set("ep_date", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
			String content = "【事件升级】 ";
			if(ev_deathToll!=null && !"".equals(ev_deathToll)){
				content = content + "死亡（失踪）人数："+ev_deathToll;
			}
			if(ev_affectedarea!=null && !"".equals(ev_affectedarea)){
				content = content + "受灾面积（m²）："+ev_affectedarea;
			}
			if(ev_injuredPeople!=null && !"".equals(ev_injuredPeople)){
				content = content + "中毒（重伤）人数："+ev_injuredPeople;
			}
			if(ev_economicLoss!=null && !"".equals(ev_economicLoss)){
				content = content + "经济损失（万元）："+ev_economicLoss;
			}
			pro.set("ep_content", content);
			pro.set("ep_user", login.getUserName());
			pro.set("ep_type", "zh01");//事件升级
			pro.set("user_id", login.getUserId());
			pro.set("eventid", eventid);
			pro.set("ep_reporter", login.getUserName());
			pro.set("ep_organ", login.getOrgName());
			pro.set("ep_instflag", flag);
			pro.set("ep_deathToll", ev_deathToll);
			pro.set("ep_affectedarea", ev_affectedarea);
			pro.set("ep_injuredPeople", ev_injuredPeople);
			pro.set("ep_economicLoss", ev_economicLoss);
			T_Bus_EventProcess.dao.insert(pro);
			toDwzText(true, "保存成功！", "", "actEventUpdDialog", "", "closeCurrent");
		} catch (Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}
	}
	
	//修改事件状态-结束
	public void endEvent(){
		String eventid = getPara("eventid");
		Map<String, Object> tips = new HashMap<String, Object>();
		String msg = "";
		boolean success = false;
		
		T_Bus_EventInfo info = T_Bus_EventInfo.dao.findById(eventid);
		try {
			if(info == null){
				msg = "事件信息异常，请检查！";
			}else{
				success = info.set("ev_status", "00D").update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			tips.put("success", success);
			tips.put("msg", msg);
			renderJson(tips);
		}
	}
	
	//成立现场指挥
	public void addCmdPos(){
		String planid = getPara(0);
		String eventid = getPara(1);
		//查询预案拥有的应急机构
		List<Record> list = T_Bus_PlanItem.dao.getListByIdCode(planid, "2000");
		//查询现场指挥中心
		T_Bus_EventCmdpos ec = T_Bus_EventCmdpos.dao.getByEventid(eventid);
		setAttr("ec", ec);
		setAttr("orglist", list);
		setAttr("apid", list.size()>0?list.get(0).get("id"):null);
		setAttr("planid", planid);
		setAttr("eventid", eventid);
		renderJsp("cmdpos.jsp");
	}
	
	//保存现场指挥经纬度
	public void saveCmdPos(){
		T_Bus_EventCmdpos cmdpos = getModel(T_Bus_EventCmdpos.class);
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		try {
			if(cmdpos.get("id") == null){
				success = cmdpos.set("id", AutoId.nextval(cmdpos)).save();
			}else{
				success = cmdpos.update();
			}
			tips.put("lat", cmdpos.get("lat"));
			tips.put("lng", cmdpos.get("lng"));
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}finally{
			tips.put("success", success);
			tips.put("msg", msg);
			renderJson(tips);
		}
		
	}
	
	//添加处置任务
	public void addEventAct(){
		setAttr("instid", getPara("instid"));
		setAttr("phaseid",  getPara("phaseid"));
		setAttr("eventid",  getPara("eventid"));
		setAttr("planid", getPara("planid"));
		setAttr("trainflag",  getPara("trainflag"));
		renderJsp("eventact/act_add.jsp");
	}
	
	public void saveEventAct(){
		T_Bus_Event_PreschAction p = getModel(T_Bus_Event_PreschAction.class);
		try {
			p.set("evactid", AutoId.nextval(p))
					.set("actstatus", "U").save();
			toDwzText(true, "保存成功！", "", "actDialog", "actGrid2", "closeCurrent");
		} catch (Exception e) {
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}
	
	//删除事件行动任务
	@Before(Tx.class)
	public void delEventAct(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Bus_Event_PreschActionDept.dao.delByEvactid(idStr);
			success = T_Bus_Event_PreschAction.dao.deleteById(idStr);
			errorCode = "info";
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally{
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			renderJson(tips);
		}
	}
	
	//获取现场指挥经纬度
	public void getCmdPos(){
		String eventid = getPara("eventid");
		if(eventid == null && !"".equals(eventid)){
			renderJson("[]");
		}else{
			T_Bus_EventCmdpos e = 
				T_Bus_EventCmdpos.dao.getByEventid(eventid);
			if(e == null){
				renderJson("[]");
			}else{
				renderJson(e);
			}
		}
	}
	
	//获取行动详情
	public void getActContent(){
		String evactid = getPara("evactid");
		T_Bus_Event_PreschAction act = T_Bus_Event_PreschAction.dao.findById(evactid);
		if(act ==null){
			renderJson("[]");
		}else{
			renderJson(act);
		}
	}
	
	//保存执行部门信息
	public void saveActDept(){
		T_Bus_Event_PreschActionDept dept = getModel(T_Bus_Event_PreschActionDept.class);
		Map<String, Object> tips = new HashMap<String, Object>();
		String msg = "";
		boolean success = false;
		try {
			String actdeptid = dept.get("actdeptid").toString();
			String actdeptname = T_Bus_Preschinfo.dao.getOrganName(actdeptid);
			success = dept.set("id", AutoId.nextval(dept))
					.set("actdeptname", actdeptname).save();
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally{
			tips.put("success", success);
			tips.put("msg", msg);
			renderJson(tips);
		}
	}
	
	//查看事件方案
	public void viewEventDoc(){
		Integer eventid = getParaToInt(0);
		String url = PathKit.getWebRootPath();
	/*	if(eventid == 41){
			url += "/upload/事件.docx";
		}else{
			url += "/upload/事件2.docx";
		}*/
		LoginModel login = getSessionAttr("loginModel");
		//setAttr("newPath", url);
		setAttr("username", login.getUserName());
		setAttr("eventid", eventid);
		setAttr("url", url);
		render("docView.jsp");
	}
	
	public void pageSave(){
		renderNull();
	}
	
	
	public void getEventProcess(){
		String instid = getPara(0);
		List<Record> plist = 
			T_Bus_Event_Preschphase.dao.getListByInstid(instid);
		List<Record> alist = 
			T_Bus_Event_PreschAction.dao.getListByInstid(instid);
		setAttr("instid", instid);
		setAttr("plist", plist);
		setAttr("alist", alist);
		renderJsp("event/process.jsp");
		
	}
	//事件相关预案处置流程
	public void getEventProcessData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String instid = getPara(0);
		String pid = getPara(1);
		String flag = getPara(2);
		Page<Record> page = 
			T_Bus_Event_Preschphase.dao.getPageByPresch(pageSize, pageNumber, instid, pid, flag);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	//启动预案的事件列表
	public void getListForEventInst(){
		renderJsp("eventinst.jsp");
	}
	
	public void getActStatus(){
		String status = getPara("status");
		String evactid =  getPara("evactid");
		setAttr("status", status);
		setAttr("evactid", evactid);
		renderJsp("actstatus.jsp");
	}
	
	public void setActStatus(){
		String status = getPara("status");
		String evactid = getPara("evactid");
		T_Bus_Event_PreschAction act = 
			T_Bus_Event_PreschAction.dao.findById(evactid);
		boolean flag = false;
		try {
			if(act != null){
				flag = act.set("actstatus", status).update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(flag){
				toDwzText(flag, "操作成功","", "actStatusDialog", "actGrid2",  "closeCurrent");
			}else{
				toDwzText(flag, "保存异常！", "", "", "", "");
			}
		}
		
	}
	
	//查询行动对应执行部门
	public void getActDept(){
		String evactid = getPara("evactid"); //事件行动id
		List<T_Bus_Event_PreschActionDept> actdeptList = 
			T_Bus_Event_PreschActionDept.dao.getListByEVactid(evactid);
		renderJson(actdeptList);
	}
	
	//获取天气预报信息
	public void getWeather(){
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode3("ADDR_WF");
		if(p!=null){
			List<String> weatherList = WeatherUtil.getWeather(p.getStr("p_name"));
			renderJson(weatherList);
		}else{
			renderJson("[]");
		}
	}
	//获取事件关联预案列表
	public void getEventPlan(){
		String eventid = getPara("eventid");
		setAttr("eventid", eventid);
		renderJsp("eventPlan.jsp");
	}
	//获取事件关联预案列表
	public void getEventPlanList(){
		String eventid = getPara("eventid");
		List<T_Bus_Presch_Instance> instList = 
			T_Bus_Presch_Instance.dao.getListByEventId(eventid, null); //获取演练事件启动预案列表
		renderJson(instList);
	}
	
	public void saveActOrder(){
		Map<String, String[]> result = getParaMap();
		Set<String> keys = result.keySet();
		Map<String, Object> tips = new HashMap<String, Object>();
		String[] arr = null;
		for(String str : keys){
			arr = result.get(str);
		}
		int len = arr.length;
		Object[][] objArr = new Object[len][2];
		for(int i=0; i<len; i++){
			String[] data = arr[i].split("-");
			objArr[i][0] = data[1];
			objArr[i][1] = data[0];
		}
		try {
			T_Bus_Event_PreschAction.dao.saveActOrder(objArr);
		} catch (Exception e) {
			e.printStackTrace();
			tips.put("msg", "保存异常，请检查重试！");
		}
		tips.put("msg", "保存成功！");
		renderJson(tips);
	}
}
