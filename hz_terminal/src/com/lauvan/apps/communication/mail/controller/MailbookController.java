package com.lauvan.apps.communication.mail.controller;

import java.io.File;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.communication.mail.model.T_Bus_Mailbook;
import com.lauvan.apps.communication.mail.model.T_Bus_Mailbook_Qun;
import com.lauvan.apps.event.model.T_Bus_EventProcess;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/mailbook", viewPath = "/communication/mail/mailbook")
public class MailbookController extends BaseController {
	private static final Logger log = Logger.getLogger(MailbookController.class);
	private String	saveDirectory	= JFWebConfig.saveDirectory;
	private int		maxPostSize		= JFWebConfig.maxPostSize;
	public void index() {
		render("main.jsp");
	}
	public void getjsp(){
		setAttr("did",getPara("did"));
		render("mailbook.jsp");
	}
	public void addllw(){
		String qid=getPara("qid").replace("p_", "");
		T_Bus_Mailbook_Qun qun=T_Bus_Mailbook_Qun.dao.findById(qid);
		setAttr("qun",qun);
		render("addllw.jsp");
	}
	public void getllw(){
		List<Record> olist = T_Sys_Department.dao.getAllDepartments();
		if(olist != null && olist.size() > 0) {
			for(Record organ : olist) {
				String pid = organ.get("d_pid").toString();
				organ.set("pid", "d_" + pid);
				organ.set("upid", "u_" + pid);
			}
		}
		setAttr("orglist", olist);
		List<Record> deptlist = T_Bus_Organ.dao.getAllOrgans();
		if(deptlist != null && deptlist.size() > 0) {
			for(Record organ2 : deptlist) {
				String pid = organ2.get("or_pid").toString();
				organ2.set("pid", "od_" + pid);
				organ2.set("upid", "ou_" + pid);
			}
		}
		setAttr("orglist2", deptlist);
		String faxno = JFWebConfig.attrMap.get("ccmsFaxNos");
		setAttr("faxno", "," + faxno + ",");
		render("findData/checkllw.jsp");
	}
	public void getllwList() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String id = getPara(0);
		//String bname = getPara("bname");
		String jsonStr = "[]";
		if(!"0".equals(id)) {
			Page<Record> page = T_Bus_EventProcess.dao.getPageByllwid(pageSize, pageNumber, id);
			List<Record> list = page.getList();
			int totalCount = page.getTotalRow();
			//调用JsonUtil函数返回datagrid表格json数据
			jsonStr = JsonUtil.getGridData(list, totalCount);
		}
		renderText(jsonStr);
	}
	public void importSave(){
		int namenum=getParaToInt("namenum")-1;
		int mailnum=getParaToInt("mailnum")-1;
		int deptnum=getParaToInt("deptnum")-1;
		int positionnum=getParaToInt("positionnum")-1;
		int remarknum=getParaToInt("remarknum")-1;
		String fjid=getPara("fjid");
		if(fjid==null||fjid.equals("")){
			toDwzText(false, "请上传附件！", "", "", "", "");
			return;
		}
		T_Attachment fj=T_Attachment.dao.findById(fjid);
		String url = fj.getStr("url");
		if(!url.startsWith("/") && url.indexOf(":") != 1) {
			url = PathKit.getWebRootPath() + "/" + url;
		}
		File file = new File(url);
		try{
		jxl.Workbook wb = jxl.Workbook.getWorkbook(file);
		jxl.Sheet sheet = wb.getSheet(0);
		int rows=sheet.getRows();
		if(rows>0){
		//String number = "^0?1[3|4|5|8][0-9]\\d{8}$";
		for(int i = 0; i < rows; i++) {
		T_Bus_Mailbook mb=T_Bus_Mailbook.dao.findbymail(sheet.getCell(mailnum,i).getContents().trim());
		//if(sheet.getCell(mailnum,i).getContents().trim().matches(number)&&mb==null){
		T_Bus_Mailbook mailbook=new T_Bus_Mailbook();
		mailbook.set("id", AutoId.nextval(mailbook)).set("name", sheet.getCell(namenum,i).getContents()).set("mail", sheet.getCell(mailnum,i).getContents().trim());
		mailbook.set("dept", sheet.getCell(deptnum,i).getContents()).set("position", sheet.getCell(positionnum, i).getContents()).set("remark", sheet.getCell(remarknum, i).getContents());
		mailbook.save();
		}
		}
		//}
		if(file.exists()) {
			file.delete();
		}
		fj.delete();
		toDwzText(true, "导入成功！", "", "mailbookDialog", "mailbookGrid", "closeCurrent");
		}catch(Exception e){
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "导入异常！", "", "", "", "");
		}

	}
	public void importxjqSave(){
		int namenum=getParaToInt("namenum")-1;
		int mailnum=getParaToInt("mailnum")-1;
		int deptnum=getParaToInt("deptnum")-1;
		int positionnum=getParaToInt("positionnum")-1;
		int remarknum=getParaToInt("remarknum")-1;
		String fjid=getPara("fjid");
		if(fjid==null||fjid.equals("")){
			toDwzText(false, "请上传附件！", "", "", "", "");
			return;
		}
		T_Attachment fj=T_Attachment.dao.findById(fjid);
		String url = fj.getStr("url");
		if(!url.startsWith("/") && url.indexOf(":") != 1) {
			url = PathKit.getWebRootPath() + "/" + url;
		}
		File file = new File(url);
		try{
		jxl.Workbook wb = jxl.Workbook.getWorkbook(file);
		jxl.Sheet sheet = wb.getSheet(0);
		int rows=sheet.getRows();
		if(rows>0){
		//String number = "^0?1[3|4|5|8][0-9]\\d{8}$";
		String cid=",";
		T_Bus_Mailbook_Qun qun=getModel(T_Bus_Mailbook_Qun.class);
		for(int i = 0; i < rows; i++) {
		T_Bus_Mailbook mb=T_Bus_Mailbook.dao.findbymail(sheet.getCell(mailnum,i).getContents().trim());
		//if(sheet.getCell(mailnum,i).getContents().trim().matches(number)){
		if(mb==null){
		T_Bus_Mailbook mailbook=new T_Bus_Mailbook();
		Number id=AutoId.nextval(mailbook);
		mailbook.set("id", id).set("name", sheet.getCell(namenum,i).getContents()).set("mail", sheet.getCell(mailnum,i).getContents().trim());
		mailbook.set("dept", sheet.getCell(deptnum,i).getContents()).set("position", sheet.getCell(positionnum, i).getContents()).set("remark", sheet.getCell(remarknum, i).getContents());
		mailbook.save();
		cid+=id+",";	
		}else{
		mb.set("name", sheet.getCell(namenum,i).getContents());
		mb.set("dept", sheet.getCell(deptnum,i).getContents()).set("position", sheet.getCell(positionnum, i).getContents()).set("remark", sheet.getCell(remarknum, i).getContents());
		mb.update();
		cid+=mb.get("id").toString()+",";	
		}
		//}
		}
		if(cid.length()>2){
			cid=cid.substring(1, cid.length()-1);
			}else if(cid.length()>1){
		cid=cid.substring(0, cid.length()-1);
		}
		qun.set("id", AutoId.nextval(qun)).set("cid", cid).save();
		}
		
		if(file.exists()) {
			file.delete();
		}
		fj.delete();
		toDwzText(true, "导入成功！", "", "mailbookDialog", "mailbookGrid", "closeCurrent");
		}catch(Exception e){
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "导入异常！", "", "", "", "");
		}

	}
	public void importqSave(){
		int namenum=getParaToInt("namenum")-1;
		int mailnum=getParaToInt("mailnum")-1;
		int deptnum=getParaToInt("deptnum")-1;
		int positionnum=getParaToInt("positionnum")-1;
		int remarknum=getParaToInt("remarknum")-1;
		Boolean flag=false;
		String qunname=getPara("qunname");
		String fjid=getPara("fjid");
		if(fjid==null||fjid.equals("")){
			toDwzText(false, "请上传附件！", "", "", "", "");
			return;
		}
		T_Attachment fj=T_Attachment.dao.findById(fjid);
		String url = fj.getStr("url");
		if(!url.startsWith("/") && url.indexOf(":") != 1) {
			url = PathKit.getWebRootPath() + "/" + url;
		}
		File file = new File(url);
		try{
		jxl.Workbook wb = jxl.Workbook.getWorkbook(file);
		jxl.Sheet sheet = wb.getSheet(0);
		int rows=sheet.getRows();
		if(rows>0){
		//String number = "^0?1[3|4|5|8][0-9]\\d{8}$";
		String cid=",";
		String qid=getPara("qid");
		T_Bus_Mailbook_Qun qun=T_Bus_Mailbook_Qun.dao.findById(qid);
		if(qun!=null){
			flag=true;
			if(qun.getStr("cid")!=null&&!qun.getStr("cid").equals("")){
			cid=","+qun.getStr("cid")+",";
			}
		}
		for(int i = 0; i < rows; i++) {
		T_Bus_Mailbook mb=T_Bus_Mailbook.dao.findbymail(sheet.getCell(mailnum,i).getContents().trim());
		//if(sheet.getCell(mailnum,i).getContents().trim().matches(number)){
		if(mb==null){
		T_Bus_Mailbook mailbook=new T_Bus_Mailbook();
		Number id=AutoId.nextval(mailbook);
		mailbook.set("id", id).set("name", sheet.getCell(namenum,i).getContents()).set("mail", sheet.getCell(mailnum,i).getContents().trim());
		mailbook.set("dept", sheet.getCell(deptnum,i).getContents()).set("position", sheet.getCell(positionnum, i).getContents()).set("remark", sheet.getCell(remarknum, i).getContents());
		mailbook.save();
		if(!flag){
		cid+=id+",";	
		}else{
		if(cid.indexOf(","+id+",")==-1){
		cid+=id+",";	
		}	
		}
		
		}else{
		mb.set("name", sheet.getCell(namenum,i).getContents());
		mb.set("dept", sheet.getCell(deptnum,i).getContents()).set("position", sheet.getCell(positionnum, i).getContents()).set("remark", sheet.getCell(remarknum, i).getContents());
		mb.update();
		if(!flag){
			cid+=mb.get("id").toString()+",";	
			}else{
			if(cid.indexOf(","+mb.get("id").toString()+",")==-1){
			cid+=mb.get("id").toString()+",";	
			}	
			}
		}
		//}
		}
		if(cid.length()>2){
			cid=cid.substring(1, cid.length()-1);
			}else if(cid.length()>1){
		cid=cid.substring(0, cid.length()-1);
		}
		if(!flag){
		qun=new T_Bus_Mailbook_Qun();
		qun.set("id", AutoId.nextval(qun)).set("pid", "0").set("name", qunname).set("cid", cid).save();
		}else{
			qun.set("cid", cid).set("name", qunname);
			qun.update();
		}
		}
		
		if(file.exists()) {
			file.delete();
		}
		fj.delete();
		toDwzText(true, "导入成功！", "", "mailbookDialog", "mailbookGrid", "closeCurrent");
		}catch(Exception e){
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "导入异常！", "", "", "", "");
		}

	}
	public void getTree() {
		String idKey = StringUtils.isBlank(getPara("idKey")) ? "id" : getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "pid" : getPara("pidKey");
		List<Record> deptlist=T_Bus_Mailbook.dao.getdeptlist();
		List<Record> qunlist=T_Bus_Mailbook_Qun.dao.getqunlist();
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> row = new HashMap<String, Object>();
		//Map<String, Object> root = new HashMap<String, Object>();
		Map<String, Object> qroot = new HashMap<String, Object>();
		/*root.put(idKey, "0");
		root.put("name", "单位");
		root.put("p_acode", null);
		root.put(pidKey, "");
		dataList.add(root);*/
		qroot.put(idKey, "p_0");
		qroot.put("name", "群组");
		qroot.put("p_acode", null);
		qroot.put(pidKey, "");
		dataList.add(qroot);
		/*for(Record de : deptlist) {
			row = new HashMap<String, Object>();
			row.put(idKey,de.get("did"));
			row.put("name", de.get("dept"));
			row.put(pidKey, "0");
			dataList.add(row);
		}*/
		for(Record q : qunlist) {
			row = new HashMap<String, Object>();
			row.put(idKey,"p_"+q.get("id"));
			row.put("name", q.get("name"));
			row.put(pidKey, "p_"+q.get("pid"));
			dataList.add(row);
		}
		renderJson(dataList);
	}
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String mail = getPara("mailbookmail");
		String name = getPara("mailbookname");
		String did = getPara("did");
		Page<Record> page = null;
		if(did.indexOf("p_")==-1){
		T_Bus_Mailbook lm=T_Bus_Mailbook.dao.findById(did);
		String deptname="";
		if(lm!=null){
			deptname=lm.getStr("dept");
		}
		page = T_Bus_Mailbook.dao.getGridPage(pageNumber, pageSize, name, mail, deptname);
		}else{
		did=did.replace("p_", "");
		T_Bus_Mailbook_Qun qun=T_Bus_Mailbook_Qun.dao.findById(did);
		if(qun!=null){
		String ids=qun.getStr("cid");
		String llwid=qun.getStr("llwid");
		page=T_Bus_Mailbook.dao.getQGridPage(pageNumber, pageSize, name, mail, ids,llwid,did);
		}else{
		page=T_Bus_Mailbook.dao.getQGridPage(pageNumber, pageSize, name, mail, "-1","-1",did);
		}
		}
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		String id = getPara(0);
		T_Bus_Mailbook mb=T_Bus_Mailbook.dao.findById(id);
		String deptname="";
		if(mb!=null){
		deptname=mb.getStr("dept");
		}
		setAttr("deptname", deptname);
		render("add.jsp");
	}
   public void addq(){
	   render("addq.jsp");
   }
   public void updq(){
	   String qid=getPara(0);
	   qid=qid.replace("p_", "");
	   T_Bus_Mailbook_Qun qun=T_Bus_Mailbook_Qun.dao.findById(qid);
	   String ids=qun.getStr("cid");
	   List<Record> mailbook=T_Bus_Mailbook.dao.getlistinid(ids);
	   String cid="";
	   String qname="";
	   if(!mailbook.isEmpty()){
		 for(Record mb:mailbook){
			 cid+=mb.get("id")+",";
			 qname+=mb.getStr("name")+",";
		 }
		 cid=cid.substring(0, cid.length()-1);
		 qname=qname.substring(0, qname.length()-1);
	   }
	   setAttr("cid",cid);
	   setAttr("qname",qname);
	   setAttr("qun",qun);
	   render("updateq.jsp");  
   }
   public void delq(){
	   String id = getPara("qid");
	   id=id.replace("p_", "");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		try {
			T_Bus_Mailbook_Qun dif = T_Bus_Mailbook_Qun.dao.findById(id);
				//dif.delete();
			T_Bus_Mailbook_Qun.dao.deletequn(id);
			T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mailbook/delq", "delete", dif, getRequest());
			success = true;
		} catch(Exception e) {
			log.error(e.getMessage());
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
   public void llwSave() {
	   try {
			boolean success = false;
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			String methodname = "add";
			T_Bus_Mailbook_Qun mb = getModel(T_Bus_Mailbook_Qun.class);
			String llwid=getPara("llwid");
			T_Bus_Mailbook_Qun oldmbq=T_Bus_Mailbook_Qun.dao.findById(mb.get("id"));
			if(oldmbq!=null){
				String oldllwid=",";
			if(oldmbq.getStr("llwid")!=null&&!oldmbq.getStr("llwid").equals("")){
				oldllwid=","+oldmbq.getStr("llwid")+",";
			}
			
			String[] llws=llwid.split(",");
			for(String llw:llws){
				if(oldllwid.indexOf(","+llw+",")==-1){
					oldllwid+=llw+",";
				}
			}
			if(oldllwid.length()>2){
				llwid=oldllwid.substring(1, oldllwid.length()-1);
			}
			}
			String alt = "";
			mb.set("llwid", llwid);
				mb.update();
				success = true;
				methodname = "update";
				alt = "保存成功！";
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mailbook/addllw", methodname, mb, getRequest());
			toDwzText(success, alt, "", "mailbookDialog", "mailbookGrid", "closeCurrent");
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}  
   }
   public void qSave() {
		try {
			boolean success = false;
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			String methodname = "add";
			String act = getPara("act");
			T_Bus_Mailbook_Qun mb = getModel(T_Bus_Mailbook_Qun.class);
			String alt = "";
			if(act.equals("upd")) {
				mb.update();
				success = true;
				methodname = "update";
				alt = "修改成功！";
			} else {
				mb.set("id", AutoId.nextval(mb));
				mb.save();
				success = true;
				alt = "保存成功！";
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mailbook/addq", methodname, mb, getRequest());
			}
			toDwzText(success, alt, "", "mailbookDialog", "mailbookGrid", "closeCurrent");
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}
   public void getLinkman() {
		List<Record> mblist =T_Bus_Mailbook.dao.getlist();
		String mbJson = JsonKit.toJson(mblist);
		setAttr("lmList", mbJson);
		render("findData/checklinkman.jsp");
	}
   public void getCheckData() {
		int totalCount = 0;
		String pid = "name";
		List<Record> deptlist=T_Bus_Mailbook.dao.getdeptlist();
		totalCount = deptlist.size();
		String jsonStr = JsonUtil.getTreeGridData(deptlist, totalCount, pid);
		renderText(jsonStr);
   }
	public void update() {
		String id = getPara(0);
		T_Bus_Mailbook mb = T_Bus_Mailbook.dao.findById(id);
		setAttr("lm", mb);
		render("update.jsp");
	}

	public void view() {
		String id = getPara(0);
		T_Bus_Mailbook dif = T_Bus_Mailbook.dao.findById(id);
		setAttr("lm", dif);
		render("view.jsp");
	}

	public void save() {
		try {
			boolean success = false;
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			String methodname = "add";
			String act = getPara("act");
			T_Bus_Mailbook mb = getModel(T_Bus_Mailbook.class);
			T_Bus_Mailbook mailbook=T_Bus_Mailbook.dao.findbymail(mb.getStr("mail").trim());
			if(mailbook!=null&&!act.equals("upd")){
				toDwzText(false, "已存在此邮箱的联系人，请检查！", "", "", "", "");
				return;
			}
			String alt = "";
			if(act.equals("upd")) {
				mb.update();
				success = true;
				methodname = "update";
				alt = "修改成功！";
			} else {
				mb.set("id", AutoId.nextval(mb));
				mb.save();
				success = true;
				alt = "保存成功！";
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mailbook/add", methodname, mb, getRequest());
			}
			toDwzText(success, alt, "", "mailbookDialog", "mailbookGrid", "closeCurrent");
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}

	public void delete() {
		String ids = getPara("ids");
		String qid=getPara("qid").replace("p_", "");
		String[] id = ids.split(",");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		try {
			T_Bus_Mailbook_Qun qun=T_Bus_Mailbook_Qun.dao.findById(qid);
			String cid=",";
			String llwid=","+qun.getStr("llwid")+",";
			if(qun.getStr("cid")!=null&&!qun.getStr("cid").equals("")){
				cid=","+qun.getStr("cid")+",";
			}
			if(qun.getStr("llwid")!=null&&!qun.getStr("llwid").equals("")){
				llwid=","+qun.getStr("llwid")+",";
			}
			for(String i : id) {
				if(i.indexOf("_")!=-1){
				llwid=llwid.replace(","+i+",", ",");
				}else{
				cid=cid.replace(","+i+",", ",");
				}
				//T_Bus_Linkman dif = T_Bus_Linkman.dao.findById(i);
				//dif.delete();
				//T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/linkman/delete", "delete", dif, getRequest());
			}
			if(cid.length()>2){
				cid=cid.substring(1,cid.length()-1);
			}
			if(cid.equals(",")){
				cid="";
			}
			if(llwid.length()>2){
				llwid=llwid.substring(1,llwid.length()-1);
			}
			if(llwid.equals(",")){
				llwid="";
			}
			qun.set("cid", cid).set("llwid", llwid);
			qun.update();
			success = true;
		} catch(Exception e) {
			log.error(e.getMessage());
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
	public void importip(){
		render("import.jsp");
	}
	public void importqip(){
		String qid=getPara("qid").replace("p_", "");
		T_Bus_Mailbook_Qun qun=T_Bus_Mailbook_Qun.dao.findById(qid);
		setAttr("qun",qun);
		render("importq.jsp");
	}
	public void importxjqip(){
		String qid=getPara("qid").replace("p_", "");
		T_Bus_Mailbook_Qun qun=T_Bus_Mailbook_Qun.dao.findById(qid);
		if(qun==null){
			qun=new T_Bus_Mailbook_Qun();
			qun.set("id", "0").set("name", "群组");
		}
		setAttr("qun",qun);
		render("importxjq.jsp");
	}
	public void export() {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			WritableFont font = new WritableFont(WritableFont.createFont("宋体"), 20, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE);
			//表头样式
			WritableCellFormat headerFormat = new WritableCellFormat(NumberFormats.TEXT);
			headerFormat.setFont(font);
			headerFormat.setBorder(Border.ALL, BorderLineStyle.THICK, Colour.BLACK);
			headerFormat.setAlignment(Alignment.CENTRE);
			WritableFont font2 = new WritableFont(WritableFont.createFont("宋体"), 10, WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE);
			//内容样式
			WritableCellFormat bodyFormat = new WritableCellFormat(font2);
			bodyFormat.setBackground(Colour.WHITE);
			bodyFormat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
			bodyFormat.setWrap(true);
			HttpServletResponse res = getResponse();
			res.setContentType("application/vnd.ms-excel");
			res.setHeader("Content-disposition", "attachment;filename=mailbook.xls");
			OutputStream os = res.getOutputStream();
			jxl.WorkbookSettings settings = new jxl.WorkbookSettings();
			jxl.write.WritableWorkbook wb = jxl.Workbook.createWorkbook(os, settings);
			jxl.write.WritableSheet sheet = wb.createSheet("联系人", 0);
			sheet.setColumnView(0, 20); 
			sheet.setColumnView(1, 20); 
			sheet.setColumnView(2, 20); 
			sheet.setColumnView(3, 20); 
			sheet.setColumnView(4, 20); 
			sheet.addCell(new jxl.write.Label(0, 0, "联系人明细表", headerFormat));
			sheet.addCell(new jxl.write.Label(0, 1, "姓名", bodyFormat));
			sheet.addCell(new jxl.write.Label(1, 1, "邮箱", bodyFormat));
			sheet.addCell(new jxl.write.Label(2, 1, "单位", bodyFormat));
			sheet.addCell(new jxl.write.Label(3, 1, "职称", bodyFormat));
			sheet.addCell(new jxl.write.Label(4, 1, "备注", bodyFormat));
			sheet.mergeCells(0, 0,4, 0);
			List<Record> lmlist=T_Bus_Mailbook.dao.getlist();
			int i=1;
			if(!lmlist.isEmpty()){
				for(Record lm:lmlist){
					i=i+1;
					sheet.addCell(new jxl.write.Label(0, i, lm.getStr("name"), bodyFormat));
					sheet.addCell(new jxl.write.Label(1, i, lm.getStr("mail"), bodyFormat));
					sheet.addCell(new jxl.write.Label(2, i, lm.getStr("dept"), bodyFormat));
					sheet.addCell(new jxl.write.Label(3, i, lm.getStr("position"), bodyFormat));
					sheet.addCell(new jxl.write.Label(4, i, lm.getStr("remark"), bodyFormat));	
				}
			}
			wb.write();
			wb.close();
			success = true;
        } catch(Exception e) {
			log.error(e.getMessage());
			errorCode = "error";
			msg = e.getMessage();
			e.printStackTrace();
		} finally {
			renderNull();
		}
}
	
	//获取邮箱通讯录信息
			public void getMail() {
				//获取部门
				//List<Record> organ2 = T_Bus_Linkman.dao.getdeptlist();
				//setAttr("orglist2",organ2);
				//获取群组
				List<Record> clulist = T_Bus_Mailbook_Qun.dao.getqunlist();
				setAttr("clulist",clulist);
				//接收对象
				String mail = getPara("rmail");
				String pname = getPara("rname");
				List<Record> list = new ArrayList<Record>();
				if(mail!=null && !"".equals(mail)){
					String[] str = mail.split(",");
					String[] str2 = pname.split(",");
					for(int i=0;i<str.length;i++){
						Record r = new Record();
						r.set("MAIL", str[i]);
						r.set("SMSNAME", str2[i]);
						list.add(r);
					}	
				}
				setAttr("rplist",JsonKit.toJson(list));
				setAttr("rmail",mail);
				setAttr("rpname",pname);
				render("findData/selMailbook.jsp");
			}
			
			//联系人列表
			public void getMailList(){
				Integer pageSize = getParaToInt("rows");
				Integer pageNumber = getParaToInt("page");
				String did = getPara(0);
				String pid = getPara(1);
				//String bname = getPara("bname");
				String jsonStr = "[]";
				if(!"0".equals(did)&&!"c_0".equals(did)&&!"dept".equals(did)&&!"cluster".equals(did)) {
					Page<Record> page = T_Bus_Mailbook.dao.getPageLink(pageSize, pageNumber, did,pid);
					List<Record> list = page.getList();
					int totalCount = page.getTotalRow();
					//调用JsonUtil函数返回datagrid表格json数据
					jsonStr = JsonUtil.getGridData(list, totalCount);
				}
				renderText(jsonStr);
			}
}
