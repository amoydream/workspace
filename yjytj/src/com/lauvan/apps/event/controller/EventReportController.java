package com.lauvan.apps.event.controller;
/**
 * 信息专报控制类
 * @author 黄丽凯
 * */
import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.event.model.T_Bus_EventDutyReport;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.event.model.T_Bus_EventReport;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/eventReport",viewPath="/event/report")
public class EventReportController extends BaseController {
	public void index(){
		setAttr("eventid",getPara("eventid"));
		render("main.jsp");
	}
	public void getDataGrid(){
		String eventid = getPara(0);
		List<Record> list = T_Bus_EventReport.dao.getListByEventId(eventid);
		int totalCount=list.size();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void add(){
		setAttr("eventid",getPara(0));
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate",nowdate);
		LoginModel login = getSessionAttr("loginModel");
		setAttr("rOrgan",login.getOrgName());
		render("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Bus_EventReport t = T_Bus_EventReport.dao.findById(id);
		setAttr("t",t);
		render("edit.jsp");
	}
	
	public void save(){
		try {
			String act = getPara("act");
			T_Bus_EventReport t = getModel(T_Bus_EventReport.class);
			if("add".equals(act)){
				LoginModel login = getSessionAttr("loginModel");
				t.set("user_id", login.getUserId());
				T_Bus_EventReport.dao.insert(t);
			}else{
				t.update();
			}
			toDwzText(true, "保存成功！", "", "eventReoprtDialog", "eventReportGrid", "closeCurrent");
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
			//T_Bus_EventReport t = T_Bus_EventReport.dao.findById(id);
			LoginModel login = getSessionAttr("loginModel");
			String uid = login.getUserId().toString();
			boolean flag = T_Bus_EventReport.dao.isStatus(ids, uid);
			if(login.getIsAdmin()||flag){
				//专报存放地址
				T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("ZBDZ", "UPDZ");
				String path = "upload/eventReport";
				if(p!=null){
					path = p.getStr("p_acode");
				}
				if(!path.startsWith("/") && path.indexOf(":")!=1){
					path  = PathKit.getWebRootPath() +"/"+ path;
				}
				for(int i=0;i<id.length;i++){
					//判断是否存在该专报文件。。
					File file = new File(path+"/"+id[i]+".doc");
					if(file.exists()){
						file.delete();
					}
				}
				success = T_Bus_EventReport.dao.deleteByIDS(ids);
			}else{
				errorCode="error";
				msg = "只能删除自己创建的专报，请检查！";
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
		T_Bus_EventReport t = T_Bus_EventReport.dao.findById(id);
		setAttr("t",t);
		if("0".equals(flag)){
			//pageoffice展开
			T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("ZBDZ", "UPDZ");
			String path = "upload/eventReport";
			if(p!=null){
				path = p.getStr("p_acode");
			}
			if(!path.startsWith("/") && path.indexOf(":")!=1){
				path  = PathKit.getWebRootPath() +"/"+ path;
			}
			//判断是否存在该专报文件。。
			File file = new File(path+"/"+id+".doc");
			//获取模板文件路径
			String newPath = "";
			if(file.exists()){
				newPath = path+"/"+id+".doc";
			}else{
				newPath = PathKit.getWebRootPath() +"/upload/template/tfsj.doc";
				//填充专报模板文件
				//T_Bus_EventInfo event = T_Bus_EventInfo.dao.findById(t.get("eventid"));
				Record event = T_Bus_EventInfo.dao.getByid(t.get("eventid").toString());
				com.zhuozhengsoft.pageoffice.wordwriter.WordDocument doc = new com.zhuozhengsoft.pageoffice.wordwriter.WordDocument();
				doc.openDataTag("{PO_year}").setValue(t.getStr("er_noyear"));
				doc.openDataTag("{PO_num}").setValue(t.getStr("er_no"));
				doc.openDataTag("{PO_bsdw}").setValue(t.getStr("er_reportunit"));
				
				//日期转换
				String zhdate = t.getStr("er_date").substring(0,10);
				zhdate = zhdate.replaceFirst("-", "年").replaceFirst("-", "月")+"日";
				doc.openDataTag("{PO_date}").setValue(zhdate);
				
				doc.openDataTag("{PO_zsdw}").setValue(t.get("er_mainsupply")==null?"":t.getStr("er_mainsupply"));
				doc.openDataTag("{PO_csdw}").setValue(t.get("er_copysupply")==null?"":t.getStr("er_copysupply"));
				doc.openDataTag("{PO_bj}").setValue(t.get("er_contact")==null?"":t.getStr("er_contact"));
				doc.openDataTag("{PO_tel}").setValue(t.get("er_contactphone")==null?"":t.getStr("er_contactphone"));
				doc.openDataTag("{PO_issuser}").setValue(t.get("er_issuer")==null?"":t.getStr("er_issuer"));
				
				doc.openDataTag("{PO_name}").setValue(event.get("ev_name")==null?"":event.getStr("ev_name"));
				doc.openDataTag("{PO_address}").setValue(event.get("ev_address")==null?"":event.getStr("ev_address"));
				doc.openDataTag("{PO_next}").setValue(event.get("ev_nextstep")==null?"":event.getStr("ev_nextstep"));
				doc.openDataTag("{PO_repunit}").setValue(t.get("er_reportUnit")==null?"":t.getStr("er_reportUnit"));
				doc.openDataTag("{PO_etname}").setValue(event.get("evtype_name")==null?"":event.getStr("evtype_name"));
				
				doc.openDataTag("{PO_level}").setValue(event.get("evlevel_name")==null?"":event.getStr("evlevel_name"));
				doc.openDataTag("{PO_evdate}").setValue(event.get("ev_date")==null?"":event.getStr("ev_date"));
				doc.openDataTag("{PO_repdate}").setValue(event.get("ev_reportdate")==null?"":event.getStr("ev_reportdate"));
				doc.openDataTag("{PO_othUser}").setValue(event.get("ev_relatedpersonnel")==null?"":event.getStr("ev_relatedpersonnel"));
				doc.openDataTag("{PO_repuser}").setValue(event.get("ev_reporter")==null?"":event.getStr("ev_reporter"));
				
				doc.openDataTag("{PO_reppost}").setValue(event.get("ev_reportpost")==null?"":event.getStr("ev_reportpost"));
				doc.openDataTag("{PO_evrepunit}").setValue(event.get("ev_reportunit")==null?"":event.getStr("ev_reportunit"));
				doc.openDataTag("{PO_repphone}").setValue(event.get("ev_reporttel")==null?"":event.getStr("ev_reporttel"));
				
				doc.openDataTag("{PO_repaddress}").setValue(event.get("ev_reportaddress")==null?"":event.getStr("ev_reportaddress"));
				doc.openDataTag("{PO_cause}").setValue(event.get("ev_cause")==null?"":event.getStr("ev_cause"));
				doc.openDataTag("{PO_parnum}").setValue(event.get("ev_participationnumber")==null?"":event.get("ev_participationnumber").toString());
				doc.openDataTag("{PO_affArea}").setValue(event.get("ev_affectedarea")==null?"":event.get("ev_affectedarea").toString());
				doc.openDataTag("{PO_deanum}").setValue(event.get("ev_deathtoll")==null?"":event.get("ev_deathtoll").toString());
				doc.openDataTag("{PO_injnum}").setValue(event.get("ev_injuredpeople")==null?"":event.get("ev_injuredpeople").toString());
				doc.openDataTag("{PO_ecoloss}").setValue(event.get("ev_economicloss")==null?"":event.get("ev_economicloss").toString());
				doc.openDataTag("{PO_advdis}").setValue(event.get("ev_advanceddisposal")==null?"":event.getStr("ev_advanceddisposal"));
				setAttr("doc",doc);
			}
			setAttr("newPath",newPath);
			LoginModel login = getSessionAttr("loginModel");
			setAttr("username",login.getUserName());
			setAttr("id",id);
			render("eventReport.jsp");
		}else if("1".equals(flag)){
			//pageoffice展开
			//获取模板文件路径
			String newPath = "";
			T_Bus_EventDutyReport duty = T_Bus_EventDutyReport.dao.getByERID(id);
			if(duty!=null){
				newPath = duty.getStr("conurl");
			}else{
				newPath = PathKit.getWebRootPath() +"/upload/template/zbkb.doc";
				//填充快报
				com.zhuozhengsoft.pageoffice.wordwriter.WordDocument doc = new com.zhuozhengsoft.pageoffice.wordwriter.WordDocument();
				doc.openDataTag("{PO_year}").setValue(t.getStr("er_noyear"));
				doc.openDataTag("{PO_num}").setValue(t.getStr("er_no"));
				doc.openDataTag("{PO_bsdw}").setValue(t.getStr("er_reportunit"));
				
				//日期转换
				doc.openDataTag("{PO_date}").setValue(DateTimeUtil.formatDate(new Date(), DateTimeUtil.ZHCN_Y_M_D_FORMAT));
				
				doc.openDataTag("{PO_zsdw}").setValue(t.get("er_mainsupply")==null?"":t.getStr("er_mainsupply"));
				doc.openDataTag("{PO_csdw}").setValue(t.get("er_copysupply")==null?"":t.getStr("er_copysupply"));
				doc.openDataTag("{PO_bj}").setValue(t.get("er_contact")==null?"":t.getStr("er_contact"));
				doc.openDataTag("{PO_tel}").setValue(t.get("er_contactphone")==null?"":t.getStr("er_contactphone"));
				doc.openDataTag("{PO_issuser}").setValue(t.get("er_issuer")==null?"":t.getStr("er_issuer"));
				setAttr("doc",doc);
			}
			setAttr("newPath",newPath);
			LoginModel login = getSessionAttr("loginModel");
			setAttr("username",login.getUserName());
			setAttr("id",id);
			render("eventDutyReport.jsp");
		}else{
			render("view.jsp");
		}
	}
	
	//保存专报
	public void pageSave(){
		com.zhuozhengsoft.pageoffice.FileSaver fs = new com.zhuozhengsoft.pageoffice.FileSaver(getRequest(),getResponse());
		String id = getPara(0);
		String flag = getPara(1);
		if("duty".equals(flag)){
			//值班快报保存
			T_Bus_EventReport t = T_Bus_EventReport.dao.findById(id);
			T_Bus_EventDutyReport d = T_Bus_EventDutyReport.dao.getByERID(id);
			String path = "upload/eventDutyReport";
			if(d==null){
				d = new T_Bus_EventDutyReport();
				d.set("er_id", id);
				d.set("er_no", t.getStr("er_no"));
				d.set("er_noyear", t.getStr("er_noyear"));
				d.set("er_date", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_FORMAT));
				d.set("er_unit", t.getStr("er_unit"));
				d.set("er_reportunit", t.getStr("er_reportunit"));
				d.set("er_issuer", t.getStr("er_issuer"));
				d.set("er_issueunit", t.getStr("er_issueunit"));
				d.set("er_issuedate", t.getStr("er_issuedate"));
				d.set("er_mainsupply", t.getStr("er_mainsupply"));
				d.set("er_copysupply", t.getStr("er_copysupply"));
				
				d.set("er_contact", t.getStr("er_contact"));
				d.set("er_contactPhone", t.getStr("er_contactPhone"));
				d.set("eventid", t.get("eventid").toString());
				LoginModel login = getSessionAttr("loginModel");
				d.set("user_id", login.getUserId());
				T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("KBDZ", "UPDZ");
				if(p!=null){
					path = p.getStr("p_acode");
				}
				if(!path.startsWith("/") && path.indexOf(":")!=1){
					path  = PathKit.getWebRootPath() +"/"+ path;
				}
				File folder = new File(path+"/report");
				if(!folder.exists()){
					folder.mkdirs();
				}
				path = path+"/report/"+id+".doc";
				d.set("conurl", path);
				T_Bus_EventDutyReport.dao.insert(d);
			}else{
				path = d.getStr("conurl");
			}
			fs.saveToFile(path);
		}else{
			//专报保存
			T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("ZBDZ", "UPDZ");
			String path = "upload/eventReport";
			if(p!=null){
				path = p.getStr("p_acode");
			}
			path = path+"/"+id+".doc";
			if(!path.startsWith("/") && path.indexOf(":")!=1){
				path  = PathKit.getWebRootPath() +"/"+ path;
			}
			fs.saveToFile(path);
		}
		fs.close();
		renderNull();
	}
}
