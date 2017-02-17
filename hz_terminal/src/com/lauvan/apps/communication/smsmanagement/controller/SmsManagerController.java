package com.lauvan.apps.communication.smsmanagement.controller;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
/**
 * 短信管理（发信箱，收信箱）控制类
 * @author 黄丽凯
 * */
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Clear;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.render.JsonRender;
import com.jfinal.upload.UploadFile;
import com.lauvan.apps.communication.linkman.model.T_Bus_Linkman;
import com.lauvan.apps.communication.linkman.model.T_Bus_Linkman_Qun;
import com.lauvan.apps.communication.smsmanagement.model.T_Bus_Moblie_Rev;
import com.lauvan.apps.communication.smsmanagement.model.T_Bus_Moblie_Rpt;
import com.lauvan.apps.communication.smsmanagement.model.T_Bus_Moblie_To;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.event.model.T_Bus_EventProcess;
import com.lauvan.apps.event.model.T_Bus_SmsSendRD;
import com.lauvan.apps.massms.service.MasSms;
import com.lauvan.apps.workcontact.model.T_Bus_EmergencyContact;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.FileUtils;
import com.lauvan.util.JsonUtil;

import jxl.read.biff.BiffException;

@RouteBind(path = "Main/smsMg", viewPath = "/communication/sms/management")
public class SmsManagerController extends BaseController {
	//发件箱
	public void sendMain() {
		render("sendmain.jsp");
	}

	//收件箱
	public void receMain() {
		render("recemain.jsp");
	}

	public void getSendGridDate() {
		LoginModel login = getSessionAttr("loginModel");
		String uid = login.getUserId().toString();
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String phonenum = getPara("phonenum");
		String scontent = getPara("scontent");
		String smobname = getPara("smobname");
		StringBuffer sqlWhere = new StringBuffer();
		//sqlWhere.append(" and s.user_id=").append(uid);看到所有发送记录
		/*if(phonenum != null && !"".equals(phonenum)) {
			sqlWhere.append(" and s.mobile like '%").append(phonenum).append("%'");
		}*/
		if(phonenum != null && !"".equals(phonenum)) {
			sqlWhere.append(" and ','||s.phone||',' like '%,").append(phonenum).append(",%'");
		}
		if(scontent != null && !"".equals(scontent)) {
			sqlWhere.append(" and s.content like '%").append(scontent).append("%'");
		}
		/*if(smobname != null && !"".equals(smobname)) {
			sqlWhere.append(" and s.mobname like '%").append(smobname).append("%'");
		}*/
		if(smobname != null && !"".equals(smobname)) {
			sqlWhere.append(" and ','||s.pname||',' like '%,").append(smobname).append(",%'");
		}
		//Page<Record> page = T_Bus_Moblie_To.dao.getPageList(pageSize, pageNumber, sqlWhere.toString());
		Page<Record> page = T_Bus_Moblie_To.dao.getSmIdPageList(pageSize, pageNumber, sqlWhere.toString());
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void getReceGridDate() {
		//LoginModel login = getSessionAttr("loginModel");
		//String uid = login.getUserId().toString();
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String phonenum = getPara("phonenum");
		String scontent = getPara("scontent");
		String smobname = getPara("smobname");
		StringBuffer sqlWhere = new StringBuffer();
		//sqlWhere.append(" and r.user_id=").append(uid);
		if(phonenum != null && !"".equals(phonenum)) {
			sqlWhere.append(" and r.mobile like '%").append(phonenum).append("%'");
		}
		if(scontent != null && !"".equals(scontent)) {
			sqlWhere.append(" and r.content like '%").append(scontent).append("%'");
		}
		if(smobname != null && !"".equals(smobname)) {
			sqlWhere.append(" and r.mobname like '%").append(smobname).append("%'");
		}
		Page<Record> page = T_Bus_Moblie_Rev.dao.getPageList(pageSize, pageNumber, sqlWhere.toString());
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		setAttr("flag", getPara(0));
		if("onemore".equals(getPara(0))){
			//重新发送短信
			String id = getPara(1);
			T_Bus_Moblie_To t = T_Bus_Moblie_To.dao.findById(id);
			setAttr("t",t);
			//接收号码以及人员
			String sm_id = t.getStr("sm_id");
			List<Record> smsrecelist = T_Bus_Moblie_To.dao.getListBySmid(sm_id);
			setAttr("smsreclist",JsonKit.toJson(smsrecelist));
			Record rec = T_Bus_Moblie_To.dao.getBySmId(sm_id);
			setAttr("rec",rec);
			//render("add2.jsp");
			render("add4.jsp");
		}else{
			//render("add.jsp");
			render("add3.jsp");
		}
	}

	public void save() {
		String smsnum = getPara("smsnum");
		String content = getPara("smscontent");
		String[] phones = smsnum.split(",");
		String smsname = getPara("smsname");
		String[] mobname = smsname != null && !"".equals(smsname) ? smsname.split(",") : phones;
		String msg = "发送成功！";
		String grid = "smsSendGrid";
		if("rece".equals(getPara("flag"))) {
			grid = "smsReceGrid";
		}
		boolean success = true;
		try {
			if(phones.length > 1000) {
				toDwzText(false, "发送短信号码不能超过1000个，请检查！", "", "", "", "");
				return;
			}
			LoginModel login = getSessionAttr("loginModel");
			//调用短信接口
			//int smsid = SmsUtil.sendSMS2(phones, content);
			long smsid = MasSms.send(login.getUserId().toString(), phones, content, "00B");
			if(smsid != 0) {
				String state = "V";
				if(smsid < 0) {
					state = "F";
					success = false;
					msg = "发送失败，请检查！";
				}
				for(int i = 0; i < phones.length; i++) {
					T_Bus_Moblie_To t = new T_Bus_Moblie_To();
					t.set("content", content);
					t.set("sm_id", smsid);
					t.set("mobile", phones[i]);
					t.set("user_id", login.getUserId());
					t.set("send_user", login.getUserName());
					t.set("send_state", state);
					//查询收件人名称
					T_Bus_Linkman linkman = T_Bus_Linkman.dao.findbytelnum(phones[i]);
					if(linkman!=null){
						t.set("mobname",  linkman.getStr("name"));
					}else{
						t.set("mobname",  phones[i]);
					}
					//t.set("mobname", i < mobname.length ? mobname[i] : phones[i]);
					T_Bus_Moblie_To.dao.insert(t);
				}
				/*if(success){
					//扫描回执
					SmsUtil.getSmsStatus2();
				}*/
			} else {
				msg = "连接短信接口失败，请检查！";
				success = false;
			}
			if(success) {
				toDwzText(true, msg, "", "smsMgDialog", grid, "closeCurrent");
			} else {
				toDwzText(false, msg, "", "", grid, "");
			}
		} catch(Exception e) {
			toDwzText(false, "发送异常！", "", "", "", "");
			e.printStackTrace();
		}
	}

	public void delete() {
		String flag = getPara(0);
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "删除成功！";
		String errorCode = "info";
		try {
			LoginModel login = getSessionAttr("loginModel");
			String user_id = login.getUserId().toString();
			if("send".equals(flag)) {
				//发件箱删除
				success = T_Bus_Moblie_To.dao.deleteByIDS(ids, user_id);
			} else {
				//收件箱删除
				success = T_Bus_Moblie_Rev.dao.deleteByIDS(ids);
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

	public void view() {
		String flag = getPara(0);
		String id = getPara(1);
		T_Bus_Moblie_To t = null;
		String sm_id = "";
		if("send".equals(flag)) {
			//发件箱
			t = T_Bus_Moblie_To.dao.findById(id);
			sm_id = t.getStr("sm_id");
		} else {
			//收件箱
			Record r = T_Bus_Moblie_Rev.dao.getBYid(id);
			sm_id = r.getStr("sm_id");
			String mobile = r.getStr("mobile");
			t = T_Bus_Moblie_To.dao.getBySmId(sm_id, mobile);
			if(t==null){
				//查询反馈短信表
				t = T_Bus_Moblie_To.dao.getSendBySmId(sm_id, mobile);
			}
			//更新状态为已读
			T_Bus_Moblie_Rev rc = T_Bus_Moblie_Rev.dao.findById(id);
			rc.set("state", "1");
			rc.update();
		}
		if(t != null) {
			String sendcontent = t.getStr("content");
			if(sendcontent != null && !"".equals(sendcontent)) {
				sendcontent = sendcontent.replaceAll(" ", "&nbsp;&nbsp;&nbsp;");
				sendcontent = sendcontent.replace("\r\n", "</br>");
			}
			setAttr("sendcontent", sendcontent);
			//关联事件
			String eventid = t.get("eventid") == null ? "" : t.get("eventid").toString();
			if(!"".equals(eventid)) {
				T_Bus_EventInfo event = T_Bus_EventInfo.dao.findById(eventid);
				setAttr("eventName", event.getStr("ev_name"));
			}
			setAttr("t", t);
			//获取发送记录中的接收信息
			Record rec = T_Bus_Moblie_To.dao.getBySmId(sm_id);
			setAttr("rec",rec);
		}
		//查询回复信息
		List<Record> recelist = T_Bus_Moblie_Rev.dao.getListBySMID(sm_id);
		if(recelist != null && recelist.size() > 0) {
			for(Record r : recelist) {
				String content = r.getStr("content");
				if(content != null && !"".equals(content)) {
					content = content.replaceAll(" ", "&nbsp;&nbsp;&nbsp;");
					content = content.replace("\r\n", "</br>");
				}
				r.set("reccontent", content);
			}
		}
		setAttr("recelist", recelist);
		setAttr("flag", flag);
		render("view.jsp");
	}

	//获取短信模板
	public void getSmsTemp() {
		render("findData/smsTemplate.jsp");
	}

	//获取通讯薄信息
	public void getMobile() {
		//获取部门
		//List<Record> organ2 = T_Bus_Linkman.dao.getdeptlist();
		//setAttr("orglist2",organ2);
		//获取群组
		List<Record> clulist = T_Bus_Linkman_Qun.dao.getqunlist();
		setAttr("clulist",clulist);
		//接收对象
		String phone = getPara("rphone");
		String pname = getPara("rpname");
		List<Record> list = new ArrayList<Record>();
		if(phone!=null && !"".equals(phone)){
			String[] str = phone.split(",");
			String[] str2 = pname.split(",");
			for(int i=0;i<str.length;i++){
				Record r = new Record();
				r.set("PHONENUM", str[i]);
				r.set("SMSNAME", str2[i]);
				list.add(r);
			}	
		}
		setAttr("rplist",JsonKit.toJson(list));
		setAttr("rphone",phone);
		setAttr("rpname",pname);
		render("findData/smsMobile3.jsp");
		/*//获取组织机构
		List<Record> olist = T_Sys_Department.dao.getAllDepartments();
		if(olist != null && olist.size() > 0) {
			for(Record organ : olist) {
				String pid = organ.get("d_pid").toString();
				organ.set("pid", "d_" + pid);
				organ.set("upid", "u_" + pid);
			}
		}
		setAttr("orglist", olist);
		//日常机构人员
		List<Record> deptlist = T_Bus_Organ.dao.getAllOrgans();
		if(deptlist != null && deptlist.size() > 0) {
			for(Record organ2 : deptlist) {
				String pid = organ2.get("or_pid").toString();
				organ2.set("pid", "od_" + pid);
				organ2.set("upid", "ou_" + pid);
			}
		}
		setAttr("orglist2", deptlist);
		//获取群组
		//获取群组
		List<Record> clulist = T_Bus_EmergencyContact.dao.getAllEmergencys();
		if(clulist != null && clulist.size() > 0) {
			for(Record clu : clulist) {
				String pid = clu.get("e_pid").toString();
				clu.set("epid", "c_" + pid);
			}
		}
		setAttr("clulist", clulist);
		render("findData/smsMobile.jsp");*/
	}
	
	//联系人列表
	public void getSmsList(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String did = getPara(0);
		String pid = getPara(1);
		//String bname = getPara("bname");
		String jsonStr = "[]";
		if(!"0".equals(did)&&!"c_0".equals(did)&&!"dept".equals(did)&&!"cluster".equals(did)) {
			Page<Record> page = T_Bus_Linkman.dao.getPageLink(pageSize, pageNumber, did,pid);
			List<Record> list = page.getList();
			int totalCount = page.getTotalRow();
			//调用JsonUtil函数返回datagrid表格json数据
			jsonStr = JsonUtil.getGridData(list, totalCount);
		}
		renderText(jsonStr);
	}

	//获取短信模板
	public void getSmsEvent() {
		render("findData/smsEvent.jsp");
	}

	//短信关联事件
	public void relaEvent() {
		//String ids = getPara("ids");
		String smid = getPara("smid");
		String eventid = getPara("eventid");
		String flag = getPara("flag");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "关联成功！";
		String errorCode = "info";
		try {
			if("unrelate".equals(flag)){
				//取消关联事件
				msg = "取消关联事件成功！";
				success = T_Bus_Moblie_To.dao.unrelaEventSmid(smid);
				//删除事件短信信息表中的关联短信
				T_Bus_SmsSendRD.dao.deleteBySmids(smid);
			}else{
				if(eventid == null || "".equals(eventid)) {
					errorCode = "error";
					msg = "请选择关联事件！";
				} else {
					//发送记录关联事件id
					//success = T_Bus_Moblie_To.dao.relaEvent(ids, eventid);
					success = T_Bus_Moblie_To.dao.relaEventSmid(smid, eventid);
					//往事件短信表添加记录
					String ids = T_Bus_Moblie_To.dao.getIdsBySmid(smid);
					String[] id = ids.split(",");
					for(int i = 0; i < id.length; i++) {
						T_Bus_Moblie_To t = T_Bus_Moblie_To.dao.findById(id[i]);
						T_Bus_SmsSendRD s = new T_Bus_SmsSendRD();
						s.set("smsid", t.getStr("sm_id"));
						s.set("sendstate", t.getStr("send_state"));
						s.set("smsdata", t.getStr("content"));
						s.set("sendtime", t.getStr("send_time"));
						s.set("senduser", t.getStr("send_user"));
						s.set("eventid", eventid);
						String callno = t.getStr("mobile");
						String callname = t.getStr("mobname");
						if(callno.indexOf(",") > 0) {
							String[] mobile = callno.split(",");
							String[] mobname = callname.split(",");
							for(int j = 0; j < mobile.length; j++) {
								s.set("callno", mobile[j]);
								s.set("callname", j < mobname.length ? mobname[j] : mobile[j]);
								T_Bus_SmsSendRD.dao.insert(s);
							}
						} else {
							s.set("callno", callno);
							s.set("callname", callname);
							T_Bus_SmsSendRD.dao.insert(s);
						}

					}

				}
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
	
	//打开导入号码文件页面
	public void getMobileImport(){
		render("findData/smsMobileImport.jsp");
	}
	//导入号码文件
	public void getMobileImportSave(){
		//上传到临时文件夹下
		String	saveDirectory = JFWebConfig.saveDirectory;
		String url = saveDirectory+"smstemp";
		int	maxPostSize	= JFWebConfig.maxPostSize;
		UploadFile upfile = getFile("file", url, maxPostSize);
		int num = 0;
		StringBuffer str = new StringBuffer();
		String fileName = "";
		try {
			File file = upfile.getFile();
			if(file.exists()){
				fileName = file.getName();
				jxl.Workbook wb = jxl.Workbook.getWorkbook(file);
				jxl.Sheet sheet = wb.getSheet(0);
				int rows=sheet.getRows();
				String reg = "^0?1[3|4|5|8][0-9]\\d{8}$";
				for(int i =0;i<rows;i++){
					String phone = sheet.getCell(0, i)==null?"":sheet.getCell(0, i).getContents();
					if(phone!=null && !"".equals(phone) && phone.matches(reg)){
						if(str.length()>0){
							str.append(",");
						}
						str.append(phone);
						num++;
					}
				}
				file.delete();
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", str.toString());
			map.put("name", fileName);
			map.put("size", num);
			if(isIE()) {
				render(new JsonRender(map).forIE()); //ie返回json，会出现下载提示
			} else {
				renderJson(map);
			}
		
		}  catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private boolean isIE() {
		String user_agent = getRequest().getHeader("User-Agent");
		if(null == user_agent || "".equals(user_agent)) {
			return false;
		}
		String upperStr = user_agent.toUpperCase();
		return upperStr.indexOf("MSIE") >= 0 || upperStr.indexOf("RV:11") >= 0 && upperStr.indexOf("GECKO") >= 0 ? true : false;
	}
	
	//查询未读短信数
	@Clear
	public void showSMSnotic(){
		String flag = getPara("flag");
		boolean success = false;
		Map<String, Object> map = new HashMap<String, Object>();
		if("1".equals(flag)){
			map.put("smsflag", flag);
			Number smssum = T_Bus_Moblie_Rev.dao.getUnReadNum();
			if(smssum!=null && smssum.intValue()>0){
				success=true;
				map.put("smssum", smssum.intValue());
			}
		}else{
			String max = JFWebConfig.attrMap.get("_smsmaxID_");
			if(max==null || "".equals(max)){
				max  = "0";
			}
			Number smsnum = T_Bus_Moblie_Rev.dao.getUnReadNum2("0",max);
			if(smsnum!=null && smsnum.intValue()>0){
				success=true;
				map.put("smsnum", smsnum.intValue());
			}
		}
		//缓存当前最大的回复id值
		JFWebConfig.attrMap.put("_smsmaxID_", T_Bus_Moblie_Rev.dao.getmaxNum());
		map.put("success", success);
		renderJson(map);

	}
	//上传提示音
	@Clear
	public void uploadvoice() {
		String saveDirectory = PathKit.getWebRootPath() + "\\sound\\";
		int maxPostSize = JFWebConfig.maxPostSize;
		Integer size = getParaToInt(3);
		if(size != null && !"".equals(size)) {
			maxPostSize = size;
		}
		UploadFile file = getFile("file", saveDirectory, maxPostSize);
		File newFile = file.getFile();
		String fileName = getPara("fileName");
		if(newFile.exists()) {
			File oldFile = new File(saveDirectory + "\\" + fileName);
			if(oldFile.exists()) {
				oldFile.delete();
			}
			newFile.renameTo(new File(saveDirectory + "\\" + fileName));
		}

		String m_size = FileUtils.getFileSize(file.getFile().length());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", fileName);
		map.put("url", "sound/" + fileName);
		map.put("error", 0);
		map.put("size", m_size);
		map.put("type", "mp3");
		renderJson(map);
	}
	//短信回执详情
	public void getRPTview(){
		String smid = getPara(0);
		if(smid!=null && !"".equals(smid)){
			List<T_Bus_Moblie_Rpt> list = T_Bus_Moblie_Rpt.dao.getListBySmid(smid);
			setAttr("rptlist",list);
		}
		render("viewRPT.jsp");
	}
}
