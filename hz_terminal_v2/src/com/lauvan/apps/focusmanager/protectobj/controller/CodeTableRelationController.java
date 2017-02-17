package com.lauvan.apps.focusmanager.protectobj.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.focusmanager.protectobj.model.T_Bus_Exp_Relation;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/codetablerelation", viewPath = "/focusmanager/relation")
public class CodeTableRelationController extends BaseController {
	private static final Logger log = Logger.getLogger(CodeTableRelationController.class);
	public void index() {
		render("main.jsp");
	}
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String bhlxcode = getPara("bhlxcode");
		String exptablename = getPara("exptablename");
		String type=getPara("exptype");
		Page<Record> page;
		page = T_Bus_Exp_Relation.dao.getGridPage(pageNumber, pageSize,type,bhlxcode, exptablename);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void add(){
	render("add.jsp");
	}
	public void upd(){
	String id=getPara(0);
	T_Bus_Exp_Relation exp=T_Bus_Exp_Relation.dao.findById(id);
	setAttr("exp",exp);
	render("update.jsp");
	}
	public void save(){
		try {
    		boolean success=false;
    		LoginModel loginModel=getSessionAttr("loginModel");
    		Number userid=loginModel.getUserId();
    		String methodname="add";
			String act = getPara("act");
			T_Bus_Exp_Relation exp = getModel(T_Bus_Exp_Relation.class);
			String alt="";
					if(act.equals("upd")){
						exp.update();
						success=true;
						methodname="update";
						alt="修改成功！";
					}else{
						exp.set("id", AutoId.nextval(exp));
						exp.save();
						success=true;
						alt="保存成功！";
						T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/codetablerelation/add", methodname,exp,getRequest());
					}
		toDwzText(success, alt, "", "relationDialog", "relationGrid", "closeCurrent");	
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}
	public void del(){
		String ids=getPara("ids");
		String[] id=ids.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		LoginModel loginModel=getSessionAttr("loginModel");
		Number userid=loginModel.getUserId();
		try {
		for(String i:id){
		T_Bus_Exp_Relation exp=T_Bus_Exp_Relation.dao.findById(i);
		exp.delete();
		T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/codetablerelation/del", "delete",exp,getRequest());
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
}
