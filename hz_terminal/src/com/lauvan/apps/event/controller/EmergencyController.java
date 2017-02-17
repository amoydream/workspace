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
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.event.model.T_Bus_EventProcess;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/event", viewPath = "/event/emergency")
public class EmergencyController extends BaseController {
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
		sqlWhere.append("  e.ev_state = '00X'");
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
		//Page<Record> page = Paginate.dao.getServicePage(pageSize, pageNumber, "t_bus_eventinfo", dept, sqlWhere.toString(), "s.Ev_date", "desc");
		//Page<Record> page = Paginate.dao.getPage("t_bus_eventinfo", pageSize, pageNumber, sqlWhere.toString(), "Ev_date", "desc");
		Page<Record> page=T_Bus_EventInfo.dao.getPage(pageSize, pageNumber,sqlWhere);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	//获取类型树
	public void getTypeTree() {
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("EVTP", true);
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "p_acode");
			outputKey.put("text", "p_name");
			jsonStr = JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
		} catch(Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}

	//获取区域信息树
	public void getoccurAreaTree() {
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("EVQY", true);
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "p_acode");
			outputKey.put("text", "p_name");
			jsonStr = JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
		} catch(Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}
	
	public void getComboTree(){
		try{
			//Integer rootId=47;
			List<Record> deptList=T_Bus_Organ.dao.getAllOrgans();
			
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "or_id");
			outputKey.put("text", "or_name");
			String jsonStr = JsonUtil.getTreeData(null, true, deptList, "or_id", "or_pid", outputKey);
			renderText(jsonStr);
		}catch (Exception e) {
			e.printStackTrace();
			renderText("[]");
		}
	}

	public void add() {
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate", nowdate);
		render("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(id);
		if(t != null) {
			String status = t.getStr("ev_status");
			if("00D".equals(status)) {
				toDwzText(false, "该事件已经处理完成，不能修改，请检查！", "", "", "", "closeCurrent");
				return;
			}
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
			LoginModel login = getSessionAttr("loginModel");
			String grid = "eventGrid";
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
				t.set("user_id", login.getUserId());
				t.set("ev_state", "00X");//突发事件
				t.set("ev_status", "00A");
				T_Bus_EventInfo.dao.insert(t);
			} else if("upd".equals(act)) {
				t.update();
			} else {
				//日常事件转突发事件
				t.set("ev_state", "00X");//突发事件
				t.set("ev_status", "00A");
				t.update();
				//新增一条过程信息记录
				T_Bus_EventProcess p = new T_Bus_EventProcess();
				p.set("eventid", t.get("id"));
				T_Bus_EventProcess.dao.insert(p, "日常事件转突发事件", login.getUserName(), login.getOrgName(), login.getUserId().toString());
				grid = "routineGrid";
			}
			toDwzText(true, "保存成功！", "", "eventDialog", grid, "closeCurrent");
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
			/*if(T_Bus_EventInfo.dao.isStatus(ids, "'00A'", null)) {
				LoginModel login = getSessionAttr("loginModel");
				String uid = login.getUserId().toString();
				if(login.getIsAdmin() || T_Bus_EventInfo.dao.isStatus(ids, null, uid)) {
					success = T_Bus_EventInfo.dao.deleteByIDs(ids);
				} else {
					errorCode = "error";
					msg = "只能删除自己登记的事件！";
				}
			} else {
				errorCode = "error";
				msg = "只能删除新登记的事件！";
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

	//附件
	public void fjmain() {
		setAttr("eventid", getPara(0));
		render("fjmain.jsp");
	}

	//获取相关附件
	public void getFjGrid() {
		String eventid = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(eventid);
		String jsonStr = "[]";
		if(t != null) {
			String fjid = t.getStr("ev_fjid");
			if(fjid != null && !"".equals(fjid)) {
				List<Record> list = T_Attachment.dao.getListRecordByids(fjid);
				int totalCount = list.size();
				//调用JsonUtil函数返回datagrid表格json数据
				jsonStr = JsonUtil.getGridData(list, totalCount);
			}
		}
		renderText(jsonStr);
	}

	public void addfj() {
		setAttr("eventid", getPara(0));
		render("fjAdd.jsp");
	}

	public void fjSave() {
		try {
			String eventid = getPara("eventid");
			T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(eventid);
			//获取附件ids
			String[] fjids = getParaValues("fjid");
			String fjid = ArrayUtils.ArrayToString(fjids); // 附件ID
			String ofj = t.getStr("ev_fjid");
			if(ofj != null && !"".equals(ofj)) {
				fjid = ofj + "," + fjid;
			}
			t.set("ev_fjid", fjid);
			t.update();
			toDwzText(true, "保存成功！", "", "eventfjDialog", "eventFjGrid", "closeCurrent");
		} catch(Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}
	}

	//删除相关附件
	public void deletefj() {
		String eventid = getPara(0);
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(eventid);
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "删除成功！";
		String errorCode = "info";
		try {
			if(t != null) {
				String fjid = t.getStr("ev_fjid");
				if(fjid != null && !"".equals(fjid)) {
					String nfjid = "";
					String[] fjids = fjid.split(",");
					for(String fj : fjids) {
						if(("," + ids + ",").indexOf("," + fj + ",") < 0) {
							nfjid = nfjid + "," + fj;
						}
					}
					if(nfjid.length() > 0) {
						nfjid = nfjid.substring(1);
					}
					//删除文件
					T_Attachment.dao.deleteByIds(ids);
					t.set("ev_fjid", nfjid);
					success = t.update();
				}
			} else {
				errorCode = "error";
				msg = "该事件不存在，请检查！";
			}
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

	//结办
	public void eventOver() {
		String eventid = getPara("eventid");
		T_Bus_EventInfo t = T_Bus_EventInfo.dao.findById(eventid);
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "处理完成！";
		String errorCode = "info";
		try {
			if(t != null) {
				if(!"00D".equals(t.getStr("ev_status"))) {
					t.set("ev_status", "00D");
					t.set("finishnotes", getPara("fincontent"));
					t.set("lastoperatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
					success = t.update();
				} else {
					errorCode = "error";
					msg = "该事件已处理完成，请检查！";
				}
			} else {
				errorCode = "error";
				msg = "该事件不存在，请检查！";
			}
		} catch(Exception e) {
			e.printStackTrace();
			errorCode = "error";
			msg = e.getMessage();
		} finally {
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
}
