package com.lauvan.apps.focusmanager.protectobj.controller;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.focusmanager.protectobj.model.T_Bus_DefenceObj;
import com.lauvan.apps.focusmanager.protectobj.model.T_Bus_Exp_Relation;
import com.lauvan.apps.focusmanager.protectobj.model.T_Bus_TableAttr;
import com.lauvan.apps.focusmanager.protectobj.model.T_Bus_TableForm;
import com.lauvan.apps.plan.model.T_Bus_Preschinfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/protectobj", viewPath = "/focusmanager/protectobj")
public class ProtectObjController extends BaseController {
	private static final Logger log = Logger.getLogger(ProtectObjController.class);
	public void index() {
		render("main.jsp");
	}
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String protectobjname = getPara("protectobjname");
		Integer did = getParaToInt(0); //所属单位id
		String depart = null;
		if(did != null && did !=0){
			depart = "od_"+did;
		}
		Page<Record> page;
		page = T_Bus_DefenceObj.dao.getGridPage(pageNumber, pageSize,protectobjname, depart);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void protectview(){
		String id=getPara(0);
		boolean isviewexp=false;
		T_Bus_DefenceObj obj=T_Bus_DefenceObj.dao.findById(id);
		String defobjtypecode=obj.getStr("defobjtypecode");
		T_Bus_Exp_Relation relation=T_Bus_Exp_Relation.dao.getbybhlxcode(defobjtypecode);
		if(relation!=null){
		String tablecode=relation.getStr("exptablename");
		List<T_Bus_TableAttr> tableattr=T_Bus_TableAttr.dao.getListisview(tablecode);
		setAttr("tableattr",tableattr);
		setAttr("tablecode",tablecode);
		Record record=T_Bus_Exp_Relation.dao.getexistbytablename(tablecode);
		if(record!=null){
			isviewexp=true;	
		}
		}
		setAttr("isviewexp",isviewexp);
		setAttr("defenceobj",obj);
		render("view.jsp");
	}
	public void getGridcontent(){
		String defobjid=getPara("defobjid");
		String tablecode=getPara("tablecode");
		String json="";
		List<Record> list = null;
		if(tablecode!=null&&!"".equals(tablecode)){
		Record record=T_Bus_Exp_Relation.dao.getexistbytablename(tablecode);
		if(record!=null){
		list=T_Bus_TableForm.dao.getcontentlist(tablecode,defobjid);
		}
		}
		json=JsonKit.toJson(list);
		renderText(json);	
	}
	public void protectadd(){
		render("add.jsp");
	}
	public void protectupd(){
		String defobjid=getPara(0);
		T_Bus_DefenceObj defenceobj=T_Bus_DefenceObj.dao.findById(defobjid);
		setAttr("defenceobj",defenceobj);
		render("update.jsp");
	}
	public void getTypes(){
		render("findData/checktype.jsp");
	}
	public void getCheckData(){
		int totalCount = 0;
		List<Record> list = new ArrayList<Record>();
		String pid = "";
		list=T_Bus_DefenceObj.dao.getTypeList();
		pid = "pid";
		totalCount = list.size();
		String jsonStr=JsonUtil.getTreeGridData(list, totalCount, pid);
		renderText(jsonStr);
	}
	public void save(){
		try{	
		boolean success=false;
		String alt="";
		LoginModel loginModel=getSessionAttr("loginModel");
		Number userid=loginModel.getUserId();
		String methodname="add";
		String act = getPara("act");
		T_Bus_DefenceObj bdo=getModel(T_Bus_DefenceObj.class);
		Date date=new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		bdo.set("updatetime", sdf.format(date));
		String deptname=T_Bus_Preschinfo.dao.getOrganName(bdo.getStr("deptid"));
		bdo.set("dept", deptname);
		if(act.equals("upd")){
			bdo.update();
			success=true;
			methodname="update";
			alt="修改成功！";
		}else{
			Number id=AutoId.nextval(bdo);
			bdo.set("defobjid",id );
			bdo.save();
			success=true;
			alt="保存成功！";	
			T_Bus_Exp_Relation ber=T_Bus_Exp_Relation.dao.getbybhlxcode(bdo.getStr("defobjtypecode"));
			if(ber!=null){
				alt=ber.getStr("bhlxcode")+","+id;
			}
		}
		T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/protectobj/protectadd", methodname,bdo,getRequest());
		toDwzText(success, alt, "", "protectobjDialog", "protectobjGrid", "closeCurrent");
	} catch (Exception e) {
		log.error(e.getMessage());
		e.printStackTrace();
		toDwzText(false, "保存异常！", "", "", "", "");
	}
	}
	//扩展数据页面
	public void getexptand(){
	String tablecode=getPara("tablecode");
	T_Bus_Exp_Relation relation=T_Bus_Exp_Relation.dao.getbybhlxcode(tablecode);
	if(relation==null){
	toDwzText(false, "不存在扩展内容！", "", "", "", "");	
	return;
	}
	Record record=T_Bus_Exp_Relation.dao.getexistbytablename(relation.getStr("exptablename"));
	if(record==null){
	toDwzText(false, "此扩展内容尚未建立扩展实体表，请先建立扩展实体表后再进行扩展！", "", "", "", "");	
	return;	
	}
	String tablename=relation.getStr("exptablename");
	String tableid=getPara("tableid");
	setAttr("tablename",tablename);
	setAttr("tableid",tableid);
	render("expadd.jsp");
	}
	public void getview(){
		String tablename = getPara("tablename");
		T_Bus_TableForm f = T_Bus_TableForm.dao.findByfocde(tablename);
		if(f!=null){
			String fname = f.getStr("fname");
			setAttr("fname",fname);
			String fcode = f.getStr("fcode");
			List<Record> alist = T_Bus_TableAttr.dao.getViewByFcode(fcode);
			setAttr("alist",alist);
			render("findData/view.jsp");
		}else{
			renderText("该表单不存在，请检查！");
		}
	}
	public void getattr(){
		String tablename=getPara("tablename");
		List<Record> alist = T_Bus_TableAttr.dao.getViewByFcode(tablename);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("required", alist);
		renderJson(map);	
	}
	public void expSave(){
		try{	
			boolean success=false;
			String alt="";
			LoginModel loginModel=getSessionAttr("loginModel");
			Number userid=loginModel.getUserId();
			String methodname="add";
			String act = getPara("act");
			Record record=new Record();
			String tablename=getPara("tablename");
			String tableid=getPara("tableid");
			List<Record> alist = T_Bus_TableAttr.dao.getattrByFcode(tablename);
			for(Record attr:alist){
			record.set(attr.getStr("acode"), getPara(attr.getStr("acode")));	
			}
			if(act.equals("upd")){
				success=true;
				methodname="update";
				alt="修改成功！";
			}else{
				BigDecimal maxid=new BigDecimal(0);
				BigDecimal tempid=Db.findFirst("select max(id) as maxid from "+tablename).getBigDecimal("maxid");
				if(tempid!=null&&!"".equals(tempid)){
				maxid=tempid;	
				}
				record.set("id",maxid.add(new BigDecimal(1))).set("fkid", tableid);
				Db.save(tablename, record);
				success=true;
				alt="保存成功！";	
			}
			//T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/protectobj/expadd", methodname,record,getRequest());
			toDwzText(success, alt, "", "proobjDialog", "expcontentgrid", "closeCurrent");
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}	
	}
	public void protectdel(){
		String ids=getPara("ids");
		String[] id=ids.split(",");
		 LoginModel loginModel=getSessionAttr("loginModel");
		 Number userid=loginModel.getUserId();
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		try {
		for(String i:id){
		T_Bus_DefenceObj defenceobj=T_Bus_DefenceObj.dao.findById(i);
		T_Bus_Exp_Relation relation=T_Bus_Exp_Relation.dao.getbybhlxcode(defenceobj.getStr("defobjtypecode"));
		if(relation!=null){
			String tablecode=relation.getStr("exptablename");
			Record record=T_Bus_Exp_Relation.dao.getexistbytablename(tablecode);
			if(record!=null){
			List<Record> list=T_Bus_TableForm.dao.getcontentlist(tablecode, i);
			if(list!=null){
			for(Record l:list){
			Db.deleteById(tablecode, l.getBigDecimal("id"));
			}
			}
			}
		}
		defenceobj.delete();
		T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/protectobj/protectdel", "delete",null,getRequest());
		}
		success=true;
		} catch (Exception e) {
			log.error(e.getMessage());
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
	public void expdel(){
	String ids=getPara("ids");
	String[] id=ids.split(",");
	String tableode=getPara("tablecode");
	 LoginModel loginModel=getSessionAttr("loginModel");
	 Number userid=loginModel.getUserId();
	Map<String,Object> map = new HashMap<String,Object>();
	boolean success=false;
	String msg="";
	String errorCode="info";
	try {
	for(String i:id){
	Db.deleteById(tableode, i);
	T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/protectobj/expdel", "delete",null,getRequest());
	}
	success=true;
	} catch (Exception e) {
		log.error(e.getMessage());
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
	/**
	 * 根据名称返回重点防护目标详细信息
	 * */
	public void getContent(){
		String name = getPara("pname");
		List<Record> list = T_Bus_DefenceObj.dao.getListByName(name);
		String jsonlist = JsonKit.toJson(list);
		renderJson(jsonlist);
	}
}
