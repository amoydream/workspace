package com.lauvan.apps.resource.assets.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.assets.model.T_Bus_Equipname;
import com.lauvan.apps.resource.assets.model.T_Bus_Team_Equip;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * @author zhouyuanhuan
 *民间救援设备管理
 */
@RouteBind(path="Main/teamequip", viewPath="/resource/assets/team/equip")
public class TeamEquipController extends BaseController{

	
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String teaId = getPara(0);
		StringBuffer str = new StringBuffer();
		String sql = "t_bus_team_equip teq left join t_bus_equipname eqn on teq.equipnameid = eqn.eqn_id where teq.teamid="+teaId;
		str.append(sql);
		
		Page<Record> page = Paginate.dao.getPage(pageSize, pageNumber, str.toString(),
				null, null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void add(){
		String teaId = getPara(0);
		setAttr("tea_id", teaId);
		renderJsp("add.jsp");
	}
	
	public void save(){
		T_Bus_Team_Equip info = getModel(T_Bus_Team_Equip.class);
		boolean success = false;
		try {
			if(info.get("teq_id") == null){
				String teaId = getPara(0); //获取队伍ID
				info.set("teamid", teaId);
				success = T_Bus_Team_Equip.dao.insert(info);
			}else{
				success = T_Bus_Team_Equip.dao.upd(info);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "teamEquipDialog", "teamEquipGrid", "closeCurrent");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	public void edit(){
		String id = getPara(0);
		T_Bus_Team_Equip model = T_Bus_Team_Equip.dao.findById(id);
		
		String equipname = "";
		BigDecimal equipnameid = model.getBigDecimal("equipnameid");
		if(equipnameid!=null){
			T_Bus_Equipname equip= T_Bus_Equipname.dao.getEquipnameByEquipnameid(model.getBigDecimal("equipnameid"));
			equipname= equip.getStr("eqn_name");
		}
		setAttr("equipname",equipname);
		
		setAttr("model", model);
		renderJsp("edit.jsp");
	}
	
	public void delete(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Bus_Team_Equip.dao.delByIds(idStr);
			errorCode = "info";
			success = true;
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
	
	public void getEquipList(){
		List<Record> list = T_Sys_Parameter.dao.getParamByCode("EQTYPE", true);
		setAttr("list", list);
		renderJsp("findData/equlist.jsp");
	}
	
	public void getview(){
		String id = getPara(0);
		T_Bus_Team_Equip model = T_Bus_Team_Equip.dao.findById(id);
		
		String equipname = "";
		BigDecimal equipnameid = model.getBigDecimal("equipnameid");
		if(equipnameid!=null){
			T_Bus_Equipname equip= T_Bus_Equipname.dao.getEquipnameByEquipnameid(model.getBigDecimal("equipnameid"));
			equipname= equip.getStr("eqn_name");
		}
		setAttr("equipname",equipname);
		
		setAttr("model", model);
		renderJsp("view.jsp");
	}
	
}
