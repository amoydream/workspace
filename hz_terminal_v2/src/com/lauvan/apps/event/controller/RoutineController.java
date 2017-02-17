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
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/eventRoutine",viewPath="/event/routine")
public class RoutineController extends BaseController {
	public void index(){
		setAttr("ev_reporttel", getPara("ev_reporttel"));
		setAttr("callId", getPara("callId"));
		render("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String ename = getPara("ename");
		String etype = getPara("etype");
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
		sqlWhere.append(" ev_state = '00A'");
		if(ename!=null && !"".equals(ename)){
			sqlWhere.append(" and ev_name like '%").append(ename).append("%'");
		}
		if(etype!=null && !"".equals(etype)){
			sqlWhere.append(" and ev_type = '").append(etype).append("'");
		}
		//Page<Record> page = Paginate.dao.getServicePage(pageSize, pageNumber, "t_bus_eventinfo", dept, sqlWhere.toString(), "s.Ev_date", "desc");
		Page<Record> page = Paginate.dao.getPage("t_bus_eventinfo", pageSize, pageNumber, sqlWhere.toString(), "Ev_date", "desc");
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void add(){
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate",nowdate);
		setAttr("ev_reporttel", getPara("ev_reporttel"));
		setAttr("callid", getPara("callid"));
		render("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(id);
		if(t!=null){
			/*LoginModel login = getSessionAttr("loginModel");
			Number user = login.getUserId();
			Number creater = t.getNumber("user_id");
			if(!login.getIsAdmin() && !creater.toString().equals(user.toString())){
				toDwzText(false, "只能由事件的登记人修改，请检查！", "", "", "", "closeCurrent");
				return;
			}*/
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
			if("add".equals(act)){
				LoginModel login = getSessionAttr("loginModel");
				t.set("user_id", login.getUserId());
				t.set("ev_state", "00A");//日常事件
				t.set("ev_status", "00A");
				T_Bus_EventInfo.dao.insert(t);
			}else{
				t.update();
			}
			toDwzText(true, "保存成功！", "", "eventDialog", "routineGrid", "closeCurrent");
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
			LoginModel login = getSessionAttr("loginModel");
			String uid = login.getUserId().toString();
			if(login.getIsAdmin() || T_Bus_EventInfo.dao.isStatus(ids, null, uid)){
				success = T_Bus_EventInfo.dao.deleteByIDs(ids);
			}else{
				errorCode="error";
				msg = "只有删除自己登记的事件！";
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
	//转突发事件
	public void changeEvent(){
		String id = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(id);
		setAttr("t",t);
		render("changevent.jsp");
	}
}
