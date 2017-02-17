package com.lauvan.apps.event.controller;
/**
 * 突发事件管理控制器
 * @author 黄丽凯
 * */
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.communication.mobileuser.model.S_Bas_SendTask;
import com.lauvan.apps.communication.mobileuser.model.T_MobileUser;
import com.lauvan.apps.event.model.T_Bus_EventAppNews;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.event.model.T_Bus_EventProcess;
import com.lauvan.apps.event.utils.SendTask;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

import net.sf.json.JSONObject;
@RouteBind(path="Main/event",viewPath="/event/emergency")
public class EmergencyController extends BaseController {
	public void index(){
		render("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String ename = getPara("ename");
		String etype = getPara("etype");
		String estatus = getPara("estatus");
		String elevel = getPara("elevel");
		//LoginModel login = getSessionAttr("loginModel");
		//String dept = login.getOrgId().toString();
		StringBuffer sqlWhere = new StringBuffer();
		/*sqlWhere.append(" and s.ev_state = '00X'");
		if(ename!=null && !"".equals(ename)){
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
		sqlWhere.append("  ev_state = '00X'");
		if(ename!=null && !"".equals(ename)){
			sqlWhere.append(" and ev_name like '%").append(ename).append("%'");
		}
		if(estatus!=null && !"".equals(estatus)){
			sqlWhere.append(" and ev_status = '").append(estatus).append("'");
		}
		if(etype!=null && !"".equals(etype)){
			sqlWhere.append(" and ev_type = '").append(etype).append("'");
		}
		if(elevel!=null && !"".equals(elevel)){
			sqlWhere.append(" and ev_level = '").append(elevel).append("'");
		}
		//Page<Record> page = Paginate.dao.getServicePage(pageSize, pageNumber, "t_bus_eventinfo", dept, sqlWhere.toString(), "s.Ev_date", "desc");
		Page<Record> page = Paginate.dao.getPage("t_bus_eventinfo", pageSize, pageNumber, sqlWhere.toString(), "Ev_date", "desc");
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	//获取类型树
	public void getTypeTree(){
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("EVTP",true);
			Map<String,String> outputKey = new HashMap<String,String>();
			outputKey.put("id", "p_acode");
			outputKey.put("text", "p_name");
			jsonStr=JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}
	//获取区域信息树
	public void getoccurAreaTree(){
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("EVQY",false);
			Map<String,String> outputKey = new HashMap<String,String>();
			outputKey.put("id", "p_acode");
			outputKey.put("text", "p_name");
			jsonStr=JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}
	
	public void add(){
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate",nowdate);
		render("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(id);
		if(t!=null){
			String status = t.getStr("ev_status");
			if("00D".equals(status)){
				toDwzText(false, "该事件已经处理完成，不能修改，请检查！", "", "", "", "closeCurrent");
				return;
			}
			LoginModel login = getSessionAttr("loginModel");
			Number user = login.getUserId();
			Number creater = t.getNumber("user_id");
			if(!login.getIsAdmin() && !creater.toString().equals(user.toString())){
				toDwzText(false, "只能由事件的登记人修改，请检查！", "", "", "", "closeCurrent");
				return;
			}
			setAttr("t",t);
			render("edit.jsp");
		}else{
			toDwzText(false, "该事件不存在，请检查！", "", "", "", "closeCurrent");
			return;
		}
	}
	
	public void save(){
		try {
			String act = getPara("act");
			T_Bus_EventInfo t = getModel(T_Bus_EventInfo.class);
			LoginModel login = getSessionAttr("loginModel");
			String grid = "eventGrid";
			if("add".equals(act)){
				t.set("user_id", login.getUserId());
				t.set("ev_state", "00X");//突发事件
				t.set("ev_status", "00A");
				T_Bus_EventInfo.dao.insert(t);
			}else if("upd".equals(act)){
				t.update();
			}else{
				//日常事件转突发事件
				t.set("ev_state", "00X");//突发事件
				t.set("ev_status", "00A");
				t.update();
				//新增一条过程信息记录
				T_Bus_EventProcess p = new T_Bus_EventProcess();
				p.set("eventid", t.get("id"));
				T_Bus_EventProcess.dao.insert(p,"日常事件转突发事件",login.getUserName(),login.getOrgName(),login.getUserId().toString());
				grid = "routineGrid";
			}
			toDwzText(true, "保存成功！", "", "eventDialog", grid, "closeCurrent");
		} catch (Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}
		
	}
	
	public void delete(){
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="删除成功！";
		String errorCode="info";
		try {
			if(T_Bus_EventInfo.dao.isStatus(ids, "'00A'", null)){
				LoginModel login = getSessionAttr("loginModel");
				String uid = login.getUserId().toString();
				if(login.getIsAdmin() || T_Bus_EventInfo.dao.isStatus(ids, null, uid)){
					success = T_Bus_EventInfo.dao.deleteByIDs(ids);
				}else{
					errorCode="error";
					msg = "只有删除自己登记的事件！";
				}
			}else{
				errorCode="error";
				msg = "只有新登记的事件才能删除！";
			}
		} catch (Exception e) {
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
	
	public void view(){
		String id = getPara(0);
		String flag = getPara(1);
		setAttr("tflag",flag);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(id);
		setAttr("t",t);
		//事发单位
		String dept = t.get("organid")==null?null:t.get("organid").toString();
		if(dept!=null){
			T_Sys_Department d = T_Sys_Department.dao.findById(dept);
			setAttr("organ",d.getStr("d_name"));
		}
		render("view.jsp");
	}
	
	//附件
	public void fjmain(){
		setAttr("eventid",getPara(0));
		render("fjmain.jsp");
	}
	//获取相关附件
	public void getFjGrid(){
		String eventid = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(eventid);
		String jsonStr="[]";
		if(t!=null){
			String fjid = t.getStr("ev_fjid");
			if(fjid!=null && !"".equals(fjid)){
				List<Record> list = T_Attachment.dao.getListRecordByids(fjid);
				int totalCount=list.size();
				//调用JsonUtil函数返回datagrid表格json数据
				jsonStr=JsonUtil.getGridData(list, totalCount);
			}
		}
		renderText(jsonStr);
	}
	public void addfj(){
		setAttr("eventid",getPara(0));
		render("fjAdd.jsp");
	}
	public void fjSave(){
		try {
			String eventid = getPara("eventid");
			T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(eventid);
			//获取附件ids
			String[] fjids = getParaValues("fjid");
			String fjid = ArrayUtils.ArrayToString(fjids); // 附件ID
			String ofj = t.getStr("ev_fjid");
			if(ofj!=null && !"".equals(ofj)){
				fjid = ofj+","+fjid;
			}
			t.set("ev_fjid", fjid);
			t.update();
			toDwzText(true, "保存成功！", "", "eventfjDialog", "eventFjGrid", "closeCurrent");
		} catch (Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}
	}
	//删除相关附件
	public void deletefj(){
		String eventid = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(eventid);
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="删除成功！";
		String errorCode="info";
		try {
			if(t!=null){
				String fjid = t.getStr("ev_fjid");
				if(fjid!=null && !"".equals(fjid)){
					String nfjid = "";
					String[] fjids = fjid.split(",");
					for(String fj : fjids){
						if((","+ids+",").indexOf(","+fj+",")<0){
							nfjid = nfjid+","+fj;
						}
					}
					if(nfjid.length()>0){
						nfjid = nfjid.substring(1);
					}
					//删除文件
					T_Attachment.dao.deleteByIds(ids);
					t.set("ev_fjid", nfjid);
					success = t.update();
				}
			}else{
				errorCode="error";
				msg = "该事件不存在，请检查！";
			}
		} catch (Exception e) {
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
	//结办
	public void eventOver(){
		String eventid = getPara("eventid");
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(eventid);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="处理完成！";
		String errorCode="info";
		try {
			if(t!=null){
				if(!"00D".equals(t.getStr("ev_status"))){
					t.set("ev_status", "00D");
					t.set("finishnotes", getPara("fincontent"));
					t.set("lastoperatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
					success = t.update();
				}else{
					errorCode="error";
					msg = "该事件已处理完成，请检查！";
				}
			}else{
				errorCode="error";
				msg = "该事件不存在，请检查！";
			}
		} catch (Exception e) {
			e.printStackTrace();
			errorCode="error";
			msg=e.getMessage();
		}finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
	
	//手机快报
	public void appmain(){
		setAttr("eventid",getPara(0));
		render("appmain.jsp");
	}
	public void getAppGrid(){
		String eventid = getPara(0);
		String jsonStr="[]";
		List<Record> list = T_Bus_EventAppNews.dao.getListByEid(eventid);
		int totalCount=list.size();
		//调用JsonUtil函数返回datagrid表格json数据
		jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	//推送手机快报
	public void appNews(){
		String eid = getPara(0);
		T_Bus_EventInfo e = T_Bus_EventInfo.dao.findById(eid);
		setAttr("e",e);
		render("appNews.jsp");
	}
	
	public void appNewsSave(){
		T_Bus_EventAppNews a = getModel(T_Bus_EventAppNews.class);
		String content = a.getStr("content");
		String x_point = a.getStr("pointx");
		String y_point = a.getStr("pointy");
		String eventid = a.get("eventid").toString();
		String title = "事件："+a.getStr("evname")+" 手机快报";
		LoginModel login = getSessionAttr("loginModel");
		String sender = login.getUserId().toString();
		String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		//推送给所有终端用户
		try {
			List<Record> ulist = T_MobileUser.dao.getAllusers();
			if(ulist!=null && ulist.size()>0){
				for(Record r : ulist){
					String token = r.getStr("token");
					S_Bas_SendTask t = new S_Bas_SendTask();
					String id = AutoId.nextval(t).toString();
					t.set("id", id);
					t.set("pointx", x_point);
					t.set("pointy", y_point);
					t.set("title", title);
					t.set("content", content);
					t.set("sender", sender);
					t.set("status", "0");
					t.set("time", now);
					String sendstatus = "1";
					//推送
					if(token!=null && !"".equals(token)){
						//String njson = JsonKit.toJson(t);
						JSONObject notification = new JSONObject();
						notification.put("ID", id);
						notification.put("POINTX", x_point);
						notification.put("POINTY",y_point);
						notification.put("TITLE",title);
						notification.put("CONTENT",content);
						notification.put("SENDER", sender);
						notification.put("TIME", now);
						notification.put("STATUS", 0); 
						notification.put("ISNEWS", 1);
						notification.put("FLAG", 3); 
						sendstatus = SendTask.send(notification, token);
					}else{
						sendstatus = "0";
					}
					t.set("sendstatus", sendstatus);
					t.set("arriver", r.getBigDecimal("id"));
					t.set("eventid", eventid);//关联事件
					t.save();
				}
			}
			T_Bus_EventAppNews.dao.insert(a);
			toDwzText(true, "发布手机快报成功！", "", "eventAppNewsDialog", "eventAppNewsGrid", "closeCurrent");
		} catch (Exception e) {
			toDwzText(false, "发布手机快报异常，请检查！！", "", "", "", "");
			e.printStackTrace();
		}
	}
}
