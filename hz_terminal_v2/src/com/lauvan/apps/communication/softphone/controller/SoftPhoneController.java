package com.lauvan.apps.communication.softphone.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.ccms.controller.CcmsController;
import com.lauvan.apps.communication.ccms.model.V_Call_Record;
import com.lauvan.apps.communication.ccms.model.V_Contact;
import com.lauvan.apps.communication.ccms.util.CcmsUtil;
import com.lauvan.apps.communication.smsmanagement.model.T_Bus_Moblie_To;
import com.lauvan.apps.communication.softphone.model.T_Bus_SpeedDial;
import com.lauvan.apps.massms.service.MasSms;
import com.lauvan.apps.workcontact.model.T_Bus_EmergencyContact;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;
import com.zhuozhengsoft.pageoffice.excelwriter.Workbook;
@RouteBind(path="Main/softphone",viewPath="/communication/softphone")
public class SoftPhoneController extends CcmsController {
	
	protected String	vocRecdUrl		= JFWebConfig.attrMap.get("vocRecdUrl");
	
	public void main(){
		render("main.jsp");
	}
    
	//获取通讯薄信息
		public void getBook(){
			//获取组织机构
			List<Record> olist = T_Sys_Department.dao.getAllDepartments();
			if(olist!=null && olist.size()>0){
				for(Record organ : olist){
					String pid = organ.get("d_pid").toString();
					organ.set("pid", "d_"+pid);
					organ.set("upid", "u_"+pid);
				}
			}
			setAttr("orglist",olist);
			//日常机构人员
			List<Record> deptlist = T_Bus_Organ.dao.getAllOrgans();
			if(deptlist!=null && deptlist.size()>0){
				for(Record organ2 : deptlist){
					String pid = organ2.get("or_pid").toString();
					organ2.set("pid", "od_"+pid);
					organ2.set("upid", "ou_"+pid);
				}
			}
			setAttr("orglist2",deptlist);
			//获取群组
			//获取群组
			List<Record> clulist = T_Bus_EmergencyContact.dao.getAllEmergencys();
			if(clulist!=null && clulist.size()>0){
				for(Record clu : clulist){
					String pid = clu.get("e_pid").toString();
					clu.set("epid", "c_"+pid);
				}
			}
			setAttr("clulist",clulist);
			render("dialbook.jsp");
		}
		
		//编辑一键拨号通讯录
		public void getEditXls(){
			String newPath = PathKit.getWebRootPath() +"/upload/template/speeddial.xls";
			LoginModel loginModel=getSessionAttr("loginModel");
			String username = loginModel.getUserName();
			com.zhuozhengsoft.pageoffice.excelwriter.Workbook xls = new Workbook();
			setAttr("username", username);
			setAttr("newPath", newPath);
			setAttr("xls", xls);
			render("speeddial.jsp");
		}
		
		public void getXlsSave(){
			String newPath = PathKit.getWebRootPath() +"/upload/template/speeddial.xls";
				com.zhuozhengsoft.pageoffice.FileSaver fs = new com.zhuozhengsoft.pageoffice.FileSaver(getRequest(),getResponse());
				try {
					fs.saveToFile(newPath);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				fs.close();
				renderNull();
		}
		
		//读取一键拨号通讯录信息
		public void getBookXls(){
			String newPath = PathKit.getWebRootPath() +"/upload/template/speeddial.xls";
			Map<String, Object> map = new HashMap<String, Object>();
			boolean success = true;
			List<T_Bus_SpeedDial> datalist = new ArrayList<T_Bus_SpeedDial>();
			try {
				jxl.Workbook wb = jxl.Workbook.getWorkbook(new File(newPath));
				jxl.Sheet sheet = wb.getSheet(0);
				int rows = sheet.getRows();
				for (int i = 4; i < rows; i++) {
					T_Bus_SpeedDial model = new T_Bus_SpeedDial();
					
					
					if (sheet.getCell(1, i).getContents() == null
							|| "".equals(sheet.getCell(1, i).getContents()
									.toString())) {
						break;
					}else{
						model.setName(sheet.getCell(0, i).getContents()
								.toString());
						model.setNumber(sheet.getCell(1, i).getContents()
								.toString());
					}
					datalist.add(model);
				}
			} catch (Exception e) {
				success = false;
				e.printStackTrace();
			}
			map.put("success", success);
			map.put("datalist", datalist);
			renderJson(map);
		}
		
		public void getSmsBook(){
			//获取组织机构
			List<Record> olist = T_Sys_Department.dao.getAllDepartments();
			if(olist!=null && olist.size()>0){
				for(Record organ : olist){
					String pid = organ.get("d_pid").toString();
					organ.set("pid", "d_"+pid);
					organ.set("upid", "u_"+pid);
				}
			}
			setAttr("orglist",olist);
			//日常机构人员
			List<Record> deptlist = T_Bus_Organ.dao.getAllOrgans();
			if(deptlist!=null && deptlist.size()>0){
				for(Record organ2 : deptlist){
					String pid = organ2.get("or_pid").toString();
					organ2.set("pid", "od_"+pid);
					organ2.set("upid", "ou_"+pid);
				}
			}
			setAttr("orglist2",deptlist);
			//获取群组
			//获取群组
			List<Record> clulist = T_Bus_EmergencyContact.dao.getAllEmergencys();
			if(clulist!=null && clulist.size()>0){
				for(Record clu : clulist){
					String pid = clu.get("e_pid").toString();
					clu.set("epid", "c_"+pid);
				}
			}
			setAttr("clulist",clulist);
			render("smsbook.jsp");
		}
		
		public void getSendSms(){
			String smsnum = getPara("smsnum");
			String content = getPara("smscontent");
			String[] phones = smsnum.split(",");
			String smsname = getPara("smsname");
			String[] mobname = (smsname!=null&&!"".equals(smsname))?smsname.split(","):phones;
			String msg = "发送成功！";
			boolean success = true;
			Map<String,Object> map = new HashMap<String,Object>();
			try {
				if(phones.length>1000){
					map.put("success", success);
					map.put("msg", "发送短信号码不能超过1000个，请检查！");
					renderJson(map);
					return;
				}
				LoginModel login = getSessionAttr("loginModel");
				//调用短信接口
				//int smsid = SmsUtil.sendSMS2(phones, content);
				long smsid = MasSms.send(login.getUserId().toString(), phones, content, "00B");
				if(smsid!=0){
					String state = "V";
					if(smsid<0){
						state = "F";
						success = false;
						msg = "发送失败，请检查！";
					}
					for(int i=0;i<phones.length;i++){
						T_Bus_Moblie_To t = new T_Bus_Moblie_To();
						t.set("content", content);
						t.set("sm_id", smsid);
						t.set("mobile", phones[i]);
						t.set("user_id", login.getUserId());
						t.set("send_user", login.getUserName());
						t.set("send_state", state);
						t.set("mobname", i<mobname.length?mobname[i]:phones[i]);
						T_Bus_Moblie_To.dao.insert(t);
					}
					/*if(success){
						//扫描回执
						SmsUtil.getSmsStatus2();
					}*/
				}else{
					msg = "连接短信接口失败，请检查！";
					success = false;
				}
				map.put("success", success);
				map.put("msg", msg);
				renderJson(map);
				
			} catch (Exception e) {
				map.put("success", false);
				map.put("msg", "发送异常！");
				renderJson(map);
				/*toDwzText(false, "发送异常！", "", "", "", "");*/
				e.printStackTrace();
			}
		}
		
		public void getAllDialRecord(){
			setAttr("voice", "N");
			render("dialrecord.jsp");
		}
		
		public void getYDialRecord(){
			setAttr("voice", "Y");
			render("dialrecord.jsp");
		}
		
		public void getCallRecord() {
			Integer maxResults = getParaToInt("rows");
			Integer page = getParaToInt("page");
			StringBuffer sql = new StringBuffer();
			String contact_name = getPara("contact_name");
			String or_name = getPara("or_name");
			String caller = getPara("caller");
			if(!StringUtils.isEmpty(contact_name)) {
				sql.append(" AND TEL_NUMBER IN (SELECT DISTINCT(CONTACT_NUMBER) FROM V_CONTACT_SEARCH WHERE CONTACT_NAME LIKE '%" + contact_name + "%'");
				if(!StringUtils.isEmpty(or_name)) {
					sql.append(" AND OR_NAME LIKE '%" + or_name + "%')");
				} else {
					sql.append(")");
				}
			}

			if(!StringUtils.isEmpty(or_name)) {
				sql.append(" AND TEL_NUMBER IN (SELECT DISTINCT(CONTACT_NUMBER) FROM V_CONTACT_SEARCH WHERE OR_NAME LIKE '%" + or_name + "%')");
			}

			String tel_number = getPara("tel_number");
			if(!StringUtils.isEmpty(tel_number)) {
				sql.append(" AND TEL_NUMBER LIKE '%" + tel_number + "%'");
			}

			String ev_name = getPara("ev_name");
			if(!StringUtils.isEmpty(ev_name)) {
				sql.append(" AND EV_NAME LIKE '%" + ev_name + "%'");
			}

			String dateTime = getPara("dateTime");
			if(!StringUtils.isEmpty(dateTime)) {
				sql.append(" AND DATETIME LIKE '" + dateTime + "%'");
			}

			sql.append(" AND CALLER='" + caller + "'");

			Page<Record> recordPage = V_Call_Record.dao.getPageList(maxResults, page, sql.toString());
			List<Record> list = recordPage.getList();
			for(Record rec : list) {
				Map<String, Object> columns = rec.getColumns();
				String TEL_NUMBER = (String)columns.get("TEL_NUMBER");
				V_Contact contact = getContact(TEL_NUMBER);
				columns.put("CONTACT_ID", contact.get("CONTACT_ID"));
				columns.put("CONTACT_TYPE", contact.get("CONTACT_TYPE"));
				columns.put("OR_ID", contact.get("OR_ID"));
				columns.put("OR_NAME", contact.get("OR_NAME"));
				if("Y".equals(columns.get("CALLER"))) {
					columns.put("CONTACT_NAME", contact.get("CONTACT_NAME"));
				} else {
					columns.put("CONTACT_NAME", contact.get("CONTACT_NAME"));
				}

				if("Y".equals(columns.get("ANSWERED"))) {
					String RECDFILE = (String)columns.get("RECDFILE");
					if(RECDFILE != null) {
						RECDFILE = CcmsUtil.VOCR_URL + "/" + RECDFILE.replace("\\", "/");
						columns.put("RECDFILE", RECDFILE);
					}
				} else {
					columns.put("RECDFILE", "");
				}
			}

			String data = JsonUtil.getGridData(list, recordPage.getTotalRow());
			renderText(data);
		}
		
		
		
}
