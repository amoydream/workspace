package com.lauvan.apps.resource.assets.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.assets.model.T_Bus_Equipname;
import com.lauvan.apps.resource.assets.model.T_Bus_Equipstore;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/equipstore", viewPath = "/resource/assets/equipstore")
public class EquipStoreController extends BaseController {
	public void index() {
		T_Sys_Parameter root = T_Sys_Parameter.dao.getByCode3("EQTYPE");
		BigDecimal rootId = root.getBigDecimal("id");
		setAttr("rootId", rootId);
		render("main.jsp");
	}

	public void getTypeTree() {
		String dataList = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("EQTYPE", true);
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "id");
			outputKey.put("name", "p_name");
			dataList = JsonUtil.getTreeData(list.get(0), false, list, "id", "sup_id", outputKey);
		} catch(Exception e) {
			e.printStackTrace();
		}
		renderText(dataList);
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		Integer pid = getParaToInt("pid");
		String eqName = getPara("eqName");
		Integer departid = getParaToInt(0); //所属单位
		StringBuffer str = new StringBuffer();
		String sql = "t_bus_equipstore e left join t_bus_equipname n on e.equipnameid = n.eqn_id left join t_sys_parameter p on n.type= p.id where 1=1";
		str.append(sql);
		if(pid != null && !"".equals(pid)) {
			str.append(" and p.id=" + pid);
		}
		if(eqName != null && !"".equals(eqName)) {
			str.append(" and eqn_name like '%").append(eqName).append("%'");
		}
		if(departid != null && departid != 0) {
			str.append(" and e.organid =").append(departid);
		}
		Page<Record> page = Paginate.dao.getPage(pageSize, pageNumber, str.toString(), null, null);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		render("add.jsp");
	}

	public void edit() {
		Integer id = getParaToInt(0);
		T_Bus_Equipstore model = T_Bus_Equipstore.dao.findById(id);

		String equipname = "";
		BigDecimal equipnameid = model.getBigDecimal("equipnameid");
		if(equipnameid != null) {
			T_Bus_Equipname equip = T_Bus_Equipname.dao.getEquipnameByEquipnameid(model.getBigDecimal("equipnameid"));
			equipname = equip.getStr("eqn_name");
		}
		setAttr("equipname", equipname);

		setAttr("model", model);
		render("edit.jsp");
	}

	public void save() {
		String act = getPara("act");
		boolean success = false;
		T_Bus_Equipstore equipstore = getModel(T_Bus_Equipstore.class);
		if(act.equals("add")) {
			equipstore.set("eqs_id", AutoId.nextval(equipstore));
			success = equipstore.save();
		} else {
			success = equipstore.update();
		}
		if(success) {
			toDwzText(success, "保存成功！", "", "equipstoreDialog", "equipstoreGrid", "closeCurrent");
		} else {
			toDwzText(success, "保存异常！", "", "", "", "");
		}
	}

	public void delete() {
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Bus_Equipstore.dao.deleteByIds(idStr);
			success = true;
			errorCode = "info";
		} catch(Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally {
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			renderJson(tips);
		}
	}

	public void getComboTree() {
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("EQTYPE", true);
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "id");
			outputKey.put("text", "p_name");
			jsonStr = JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
			renderText(jsonStr);
		} catch(Exception e) {
			e.printStackTrace();
			renderText("[]");
		}
	}

	public void getview() {
		Integer id = getParaToInt(0);
		T_Bus_Equipstore model = T_Bus_Equipstore.dao.findById(id);

		String equipname = "";
		BigDecimal equipnameid = model.getBigDecimal("equipnameid");
		if(equipnameid != null) {
			T_Bus_Equipname equip = T_Bus_Equipname.dao.getEquipnameByEquipnameid(model.getBigDecimal("equipnameid"));
			equipname = equip.getStr("eqn_name");
		}
		setAttr("equipname", equipname);

		//主管单位
		String dept = model.get("organid") == null ? null : model.get("organid").toString();
		if(dept != null) {
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			setAttr("organ", d.getStr("or_name"));
		}

		//数据来源单位
		String sourcedept = model.get("sourcedept") == null ? null : model.get("sourcedept").toString();
		if(sourcedept != null) {
			T_Bus_Organ d = T_Bus_Organ.dao.findById(sourcedept);
			setAttr("sourcedept", d.getStr("or_name"));
		}

		setAttr("model", model);
		render("view.jsp");
	}

}
