package com.lauvan.apps.resource.dutydepart;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.core.annotation.RouteBind;
/**
 * 职能部门
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/dutydepart", viewPath="/resource/dutydepart")
public class DutyDepartController extends BaseController{

	public void index(){
		List<Record> busorgList = T_Bus_Organ.dao.getAllOrgans();
		setAttr("busorgList", busorgList);
		renderJsp("main.jsp");
	}
	
	public void getDutyInfo(){
		String type = getPara(0);
		Integer deptid = getParaToInt(1);
		setAttr("deptid", deptid);
		if("plan".equals(type)){
			
			renderJsp("duty/planinfo.jsp");
			
		}else if("store".equals(type)){
			
			T_Sys_Parameter root = T_Sys_Parameter.dao.getByCode3("MATYPE");
			BigDecimal rootId = root.getBigDecimal("id");
			setAttr("rootId",rootId);
			renderJsp("duty/storeinfo.jsp");
			
		}else if("expertinfo".equals(type)){
			
			List<Record> typeList= T_Sys_Parameter.dao.getParamByCode("YJZJ",false);		
			String typeJson=JsonKit.toJson(typeList);
			setAttr("typeJson", typeJson);
			T_Sys_Parameter root = T_Sys_Parameter.dao.getByCode3("YJZJ");
			BigDecimal rootId = root.getBigDecimal("id");
			setAttr("rootId",rootId);
			renderJsp("duty/expertinfo.jsp");
			
		}else if("team".equals(type)){
		
			renderJsp("duty/teaminfo.jsp");
			
		}else if("equip".equals(type)){
			
			T_Sys_Parameter root = T_Sys_Parameter.dao.getByCode3("EQTYPE");
			BigDecimal rootId = root.getBigDecimal("id");
			setAttr("rootId",rootId);
			renderJsp("duty/equipinfo.jsp");
		}else if("shelter".equals(type)){
			
			renderJsp("duty/shelterinfo.jsp");
		}else if("cases".equals(type)){
			
			renderJsp("duty/caseinfo.jsp");
		}else if("troubleobj".equals(type)){
			
			renderJsp("duty/troubleinfo.jsp");
		}else if("danger".equals(type)){
			
			renderJsp("duty/dangerinfo.jsp");
		}else{
			
			renderJsp("duty/defenceinfo.jsp");
		}
		
	}
	
	public void getDepartInfo(){
		String did = getPara("departid");
		Map<String, Object> result = new HashMap<String, Object>();
		T_Bus_Organ organ = T_Bus_Organ.dao.findById(did);
		result.put("organ", organ);
		renderJson(result);
		
	}
}
