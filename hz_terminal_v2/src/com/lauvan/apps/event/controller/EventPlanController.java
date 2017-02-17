package com.lauvan.apps.event.controller;
/**
 * 启动预案控制类型
 * @author 黄丽凯
 * **/
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.event.model.T_Bus_EventProcess;
import com.lauvan.apps.event.model.T_Bus_Event_PreschAction;
import com.lauvan.apps.event.model.T_Bus_Event_Preschphase;
import com.lauvan.apps.event.model.T_Bus_Presch_Instance;
import com.lauvan.apps.plan.model.T_Bus_PlanItem;
import com.lauvan.apps.plan.model.T_Bus_Preschinfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/eventPlan",viewPath="/event/plan")
public class EventPlanController extends BaseController {
	public void main(){
		String eventid = getPara("eventid");
		setAttr("eventid",eventid);
		//获取事件基本信息
		T_Bus_EventInfo e = T_Bus_EventInfo.dao.findById(eventid);
		setAttr("einfo",e);
		render("list.jsp");
	}
	//预案查询
	public void getPlanData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String prename = getPara("prename");
		String pretype = getPara("pretype");
		String eptype = getPara("eptype");
		String eplevel = getPara("eplevel");
		StringBuffer str = new StringBuffer();
		//非模板预案
		str.append(" and p.type='0' ");
		if(prename!=null && !"".equals(prename)){
			str.append(" and p.preschname like '%").append(prename).append("%' ");
		}
		if(pretype!=null && !"".equals(pretype)){
			str.append(" and p.preschtype = '").append(pretype).append("' ");
		}
		Page<Record> page = T_Bus_Preschinfo.dao.getPageSearch(pageSize, pageNumber, eptype, eplevel, str.toString());
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	//获取事件已启动的预案关列表
	public void getPlanGZ(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String eventid = getPara("eventid");
		Page<Record> page = T_Bus_Presch_Instance.dao.getPageByEventid(pageSize, pageNumber, eventid);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	//预案跟踪
	public void getPlanView(){
		setAttr("instid",getPara(0));
		render("view.jsp");
	}
	public void getPlanViewData(){
		String instid = getPara("instid");
		//T_Bus_Presch_Instance inst = T_Bus_Presch_Instance.dao.findById(instid);
		/**展示跟踪信息*/
		List<Record> list = T_Bus_Presch_Instance.dao.getACTList(instid);
		int totalCount=list.size();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	//启动预案
	public void startPlan(){
		String planid = getPara("planid");
		String eventid = getPara("eventid");
		T_Bus_Preschinfo p = T_Bus_Preschinfo.dao.findById(planid);
		T_Bus_EventInfo e = T_Bus_EventInfo.dao.findById(eventid);
		setAttr("p",p);
		setAttr("e",e);
		String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate",now);
		render("startPlan.jsp");
	}
	public void startPlanSave(){
		try {
			T_Bus_Presch_Instance inst = getModel(T_Bus_Presch_Instance.class);
			LoginModel login = getSessionAttr("loginModel");
			inst.set("user_id", login.getUserId());
			inst.set("start_man", login.getUserName());
			String instid = T_Bus_Presch_Instance.dao.insert(inst);
			String eventid = inst.get("event_id").toString();
			String planid = inst.get("plan_id").toString();
			//根据预案流程，插入实例流程
			boolean flag = T_Bus_Event_Preschphase.dao.insert(eventid, planid, instid);
			if(flag){
				T_Bus_Event_PreschAction.dao.insert(planid, eventid, instid);
			}
			//修改事件状态
			T_Bus_EventInfo event = T_Bus_EventInfo.dao.findById(eventid);
			event.set("ev_status", "00C");
			event.update();
			//添加启动预案的处置信息
			T_Bus_EventProcess pro = new T_Bus_EventProcess();
			pro.set("ep_date", inst.getStr("start_time"));
			pro.set("ep_content", inst.getStr("start_memo"));
			pro.set("ep_user", login.getUserName());
			pro.set("ep_type", "0005");
			pro.set("user_id", login.getUserId());
			pro.set("eventid", eventid);
			pro.set("ep_reporter", login.getUserName());
			pro.set("ep_organ", login.getOrgName());
			T_Bus_EventProcess.dao.insert(pro);
			toDwzText(true, "启动预案成功！", "", "ePalyBackDialog", "eventPlanGrid", "closeCurrent");
		} catch (Exception e) {
			toDwzText(false, "启动预案异常！", "", "", "", "");
			e.printStackTrace();
		}
	}
	
	//删除已启动的预案
	public void delete(){
		String id = getPara("id");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="删除异常，请检查！";
		String errorCode="info";
		try {
			T_Bus_Presch_Instance t = T_Bus_Presch_Instance.dao.findById(id);
			if(t!=null){
				LoginModel login = getSessionAttr("loginModel");
				String uid = login.getUserId().toString();
				if(!login.getIsAdmin() && !uid.equals(t.get("user_id").toString())){
					errorCode="error";
					msg="只能删除自己启动的预案，请检查！";
				}else{
					T_Bus_Event_PreschAction.dao.deleteByInst(id);
					T_Bus_Event_Preschphase.dao.deleteByInst(id);
					String planid= t.get("plan_id").toString();
					String eventid =  t.get("event_id").toString();
					success = t.delete();
					if(!T_Bus_Presch_Instance.dao.isPlanInst(planid,eventid)){
						T_Bus_EventInfo event = T_Bus_EventInfo.dao.findById(eventid);
						event.set("ev_status", "00B");//处置中
						event.update();
					}
				}
			}else{
				errorCode="error";
				msg="该预案实例不存在，请检查！";
			}
		}catch (Exception e) {
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
	//根据源ID，以及事件级别查询预案的预设信息
	public void getEPlanLevel(){
		String elevel = getPara("elevel");
		String planid = getPara("planid");
		List<Record> ellist = T_Bus_PlanItem.dao.getEPlevel(planid, elevel);
		setAttr("ellist",ellist);
		setAttr("elevel",elevel);
		render("levelSelect.jsp");
	}
}
