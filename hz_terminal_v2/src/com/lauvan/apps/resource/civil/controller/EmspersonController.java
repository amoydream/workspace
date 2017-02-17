package com.lauvan.apps.resource.civil.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.assets.model.T_Bus_Team;
import com.lauvan.apps.resource.civil.model.T_Civisuccordep;
import com.lauvan.apps.resource.civil.model.T_Emsperson;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 民间组织人员信息
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/emsperson", viewPath="/resource/emsperson")
public class EmspersonController extends BaseController{

	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String deptid = getPara(0); //所属组织id
		String type = getPara(1); //所属组织类型 00A-救援组织，00B应急队伍
		Page<Record> page = T_Emsperson.dao.getPage( pageSize, pageNumber, deptid, type);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		//民族列表
		List<T_Sys_Parameter> mzList = T_Sys_Parameter.dao.getChildByAcode("MZ");
		//职务列表
		//List<T_Sys_Parameter> zwList = T_Sys_Parameter.dao.getChildByAcode("POS");
		//职称列表
		//List<T_Sys_Parameter> zcList = T_Sys_Parameter.dao.getChildByAcode("TECHPOSE");
		setAttr("mzList", mzList);
		//setAttr("zwList", zwList);
		//setAttr("zcList", zcList);
		setAttr("deptid", getPara(0));
		setAttr("type", getPara(1));
		renderJsp("add.jsp");
	}
	
	/**
	 * 获取职能部门结构
	 */
	public void getBusOrg(){
		List<Record> busorgList = T_Bus_Organ.dao.getAllOrgans();
		setAttr("busorgList", busorgList);
		renderJsp("findData/busorg.jsp");
		
	}
	
	public void getBusOrgGridData(){
		String pid = getPara(0);
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		Page<Record> page = T_Bus_Organ.dao.getPageByPid(pageSize, pageNumber,pid);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		setAttr("apId", pid);
		renderText(jsonStr);
	}
	
	public void edit(){
		String id = getPara(0);
		//民族列表
		List<T_Sys_Parameter> mzList = T_Sys_Parameter.dao.getChildByAcode("MZ");
		//职务列表
		//List<T_Sys_Parameter> zwList = T_Sys_Parameter.dao.getChildByAcode("POS");
		//职称列表
		//List<T_Sys_Parameter> zcList = T_Sys_Parameter.dao.getChildByAcode("TECHPOSE");
		T_Emsperson person = T_Emsperson.dao.findById(id);
		setAttr("person", person);
		setAttr("mzList", mzList);
		//setAttr("zwList", zwList);
		//setAttr("zcList", zcList);
		renderJsp("edit.jsp");
	}
	
	//@Before(Tx.class)
	public void save(){
		T_Emsperson person = getModel(T_Emsperson.class);
		//T_Bus_OrganPerson op = null;
		boolean success = false;
		try {
			if(person.get("id") == null){
				//T_Bus_OrganPerson，与这个表保持同步
				//op = new T_Bus_OrganPerson();
				//op.set("p_name", person.getStr("persname"));
				//op.set("p_address", person.get("familyaddr"));
				//op.set("p_orid",person.get("deptno"));
				//op.set("p_id", AutoId.nextval(op)).save();
				String deptid = getPara(0); //获取救援组织ID
				if("00A".equals(getPara(1))){
					T_Civisuccordep c = T_Civisuccordep.dao.findById(deptid); //获取救援组织信息
					person.set("equteamname", c.getStr("deptname"));
					person.set("equteamtype", "00A");
				}else{
					T_Bus_Team t = T_Bus_Team.dao.findById(deptid);//获取应急队伍信息
					person.set("equteamname", t.getStr("name")); //对应应急队伍名称
					person.set("equteamtype", "00B");
				}
				person.set("equteamno", deptid);
				//person.set("opid", op.get("p_id")); //保存表T_Bus_OrganPerson中对应的id
				success = T_Emsperson.dao.insert(person);
			}else{
				//op = T_Bus_OrganPerson.dao.findById(person.get("opid"));
				//op.set("p_name", person.getStr("persname"));
				//op.set("p_address", person.get("familyaddr"));
				//op.set("p_orid",person.get("deptno")).update();
				success = person.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "personDialog", "emsperson_data", "closeCurrent");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	//删除
	@Before(Tx.class)
	public void delete(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			//删除T_Bus_OrganPerson表中对应的记录
			String idStr = ArrayUtils.ArrayToString(ids);
			//String opids = T_Emsperson.dao.getOpidsbyIds(idStr);
			//T_Bus_OrganPerson.dao.deleteByIds(opids); //删除
			String fjids =T_Emsperson.dao.getfjidsByids(idStr); 
			T_Attachment.dao.deleteByIds(fjids); //删除附件
			T_Emsperson.dao.delByIds(idStr);
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
		T_Emsperson person = T_Emsperson.dao.findById(id);
		setAttr("person", person);
		renderJsp("view.jsp");
	}
}
