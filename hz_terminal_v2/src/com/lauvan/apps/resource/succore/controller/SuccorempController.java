package com.lauvan.apps.resource.succore.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.resource.succore.model.T_Address;
import com.lauvan.apps.resource.succore.model.T_Succoremp;
import com.lauvan.apps.resource.succore.model.T_Succoremp_d;
import com.lauvan.apps.workcontact.model.T_Bus_OrganPerson;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;
/**
 * 志愿人员管理
 * @author zhouyuanhuan
 *
 */

@RouteBind(path="Main/succoremp", viewPath="/resource/succoremp")
public class SuccorempController extends BaseController{

	public void index(){
		List<T_Sys_Parameter> typeList = T_Sys_Parameter.dao.getChildByAcode("ZYRYFL");
		setAttr("typelist", typeList);
		render("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("pname");
		String type = getPara("type");
		Page<Record> page = T_Succoremp.dao.getPage(pageSize, pageNumber, name, type);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		String type = getPara(0);
		setAttr("type", type);
		setAttr("nowdate",nowdate);
		renderJsp("add.jsp");
		
	}
	
	public void edit(){
		String id = getPara(0);
		T_Succoremp s = T_Succoremp.dao.findById(id);
		setAttr("s", s);
		renderJsp("edit.jsp");
	}
	
	public void save(){
		T_Succoremp s = getModel(T_Succoremp.class);
		boolean success = false;
		T_Bus_OrganPerson op = null;
		try {
			if(s.get("personid") == null){
				//T_Bus_OrganPerson，与这个表保持同步
				op = new T_Bus_OrganPerson();
				op.set("p_name", s.getStr("personname"));
				op.set("p_address", s.getStr("familyaddr"));
				op.set("p_orid", s.get("persondeptid"));
				op.set("p_email", s.getStr("personemail"));
				op.set("p_id", AutoId.nextval(op)).save();
				s.set("opid", op.get("p_id"));
				success = T_Succoremp.dao.insert(s);
			}else{
				op = T_Bus_OrganPerson.dao.findById(s.get("opid"));
				op.set("p_name", s.getStr("personname"));
				op.set("p_address", s.getStr("familyaddr"));
				op.set("p_email", s.getStr("personemail"));
				op.set("p_orid", s.get("persondeptid")).update();
				success = s.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "succorempDialog", "succoremp_data", "closeCurrent");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	@Before(Tx.class)
	public void delete(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			//DbKit.getConfig().getConnection().setAutoCommit(false);
			String idStr = ArrayUtils.ArrayToString(ids);
			String opids = T_Succoremp.dao.getOpidsByIds(idStr);
			T_Bus_OrganPerson.dao.deleteByIds(opids); //删除主表人员信息
			//删除对应的简历、通讯录信息
			T_Succoremp_d.dao.deleteByPersonid(idStr);
			T_Address.dao.deleteByPersonids(idStr);
			T_Succoremp.dao.deleteByIds(idStr);
			success = true;
			errorCode = "info";
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally{
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			renderJson(tips);
			
		}
	}
	
	public void view(){
		String id = getPara(0);
		T_Succoremp s = T_Succoremp.dao.getById(id);
		setAttr("s", s);
		renderJsp("view.jsp");
	}
}
