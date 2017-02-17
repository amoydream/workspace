package com.lauvan.apps.plan.controller;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.event.model.T_Bus_Event_PreschAction;
import com.lauvan.apps.event.model.T_Bus_Event_Preschphase;
import com.lauvan.apps.event.model.T_Bus_Presch_Instance;
import com.lauvan.apps.plan.model.T_Bus_PreschTrainEvent;
import com.lauvan.apps.plan.model.T_Bus_Preschinfo;
/**
 * 预案演练与培训
 * */
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/planyl",viewPath="/plan/train")
public class PlanTrainController extends BaseController {
	public void index(){
		List<Record> plist = T_Sys_Parameter.dao.getParamByCode("YAFL",false);
		setAttr("plist",plist);
		List<Record> tlist = T_Bus_Preschinfo.dao.getTreeList("0");
		setAttr("tlist",tlist);
		render("main.jsp");
	}
	
	public void getGridData(){
		String treeid = getPara("treeid");
		String planid = getPara("planid");
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String jsonStr="[]";
		StringBuffer str = new StringBuffer();
		if(treeid!=null && treeid.startsWith("p_")){
			str.append(" and p.preschid=").append(planid);
			Page<Record> page = T_Bus_PreschTrainEvent.dao.getPageList(pageSize, pageNumber, str.toString());
			List<Record> list=page.getList();
			int totalCount=page.getTotalRow();
			//调用JsonUtil函数返回datagrid表格json数据
			jsonStr=JsonUtil.getGridData(list, totalCount);
		}
		renderText(jsonStr);
	}
	
	public void add(){
		String id = getPara(0);
		T_Bus_Preschinfo pinfo = T_Bus_Preschinfo.dao.findById(id);
		setAttr("pinfo",pinfo);
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate",nowdate);
		render("add.jsp");
	}
	
	public void save(){
		T_Bus_PreschTrainEvent einfo = getModel(T_Bus_PreschTrainEvent.class);
		String eid = T_Bus_PreschTrainEvent.dao.insert(einfo);
		String planid =  einfo.get("preschid").toString();
		//生成演练事件预案实例
		LoginModel login = getSessionAttr("loginModel");
		String now =  DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		T_Bus_Presch_Instance inst = new T_Bus_Presch_Instance();
		inst.set("plan_id", planid);
		inst.set("event_id", eid);
		inst.set("start_time",now);
		inst.set("start_man", login.getUserAccount());
		inst.set("start_memo", "预案演练");
		inst.set("user_id", login.getUserId());
		inst.set("marktime", now);
		inst.set("instflag", "train");
		String instid = T_Bus_Presch_Instance.dao.insert(inst);
		//根据预案流程，插入实例流程
		boolean flag = T_Bus_Event_Preschphase.dao.insert(eid, planid, instid);
		if(flag){
			T_Bus_Event_PreschAction.dao.insert(planid, eid, instid);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", true);
		map.put("msg", "演练开始！");
		map.put("dialogid", "planTrainDialog");
		map.put("gridid", "planylGrid");
		map.put("eventid", eid);
		map.put("planid", planid);
		renderText(JsonKit.toJson(map));
		//toDwzText(true, "演练开始！", "","planTrainDialog", "planylGrid", "closeCurrent", eid);
	}
}
