package com.lauvan.apps.resource.material.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.material.model.T_Bus_Materialname;
import com.lauvan.apps.resource.material.model.T_Bus_Store;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/materialname", viewPath = "/resource/material/materialname")
public class MaterialNameController extends BaseController {
	public void index() {
		T_Sys_Parameter root = T_Sys_Parameter.dao.getByCode3("MATYPE");
		BigDecimal rootId = root.getBigDecimal("id");
		setAttr("rootId", rootId);
		render("main.jsp");
	}

	public void getTypeTree() {
		String dataList = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("MATYPE", true);
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
		String maName = getPara("maName");
		StringBuffer str = new StringBuffer();
		String sql = "T_Bus_Materialname m left join t_sys_parameter p on p.id = m.type where 1=1";
		str.append(sql);
		if(pid != null && !"".equals(pid)) {
			str.append(" and m.type=" + pid);
		}
		if(maName != null && !"".equals(maName)) {
			str.append(" and mn_name like '%").append(maName).append("%'");
		}
		//获取表格表页数据
		Page<Record> page = Paginate.dao.getPage(pageSize, pageNumber, str.toString(), null, null);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		Integer pid = getParaToInt(0);
		setAttr("pid", pid);
		render("add.jsp");
	}

	public void edit() {
		Integer id = getParaToInt(0);
		T_Bus_Materialname model = T_Bus_Materialname.dao.findById(id);
		setAttr("model", model);
		render("edit.jsp");
	}

	public void save() {
		String act = getPara("act");
		boolean success = false;
		T_Bus_Materialname maname = getModel(T_Bus_Materialname.class);
		if(act.equals("add")) {
			maname.set("mn_id", AutoId.nextval(maname));
			success = maname.save();
		} else {
			success = maname.update();
		}
		if(success) {
			toDwzText(success, "保存成功！", "", "manameDialog", "manameGrid", "closeCurrent");
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
			T_Bus_Materialname.dao.deleteByIds(idStr);
			T_Bus_Store.dao.beNullByMaIds(idStr);
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
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("MATYPE", true);
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

	/**
	 * 获取物资名录页面供其他模块选择物资
	 */
	public void getMaterial() {
		T_Sys_Parameter root = T_Sys_Parameter.dao.getByCode3("MATYPE");
		BigDecimal rootId = root.getBigDecimal("id");
		setAttr("rootId", rootId);
		renderJsp("select.jsp");
	}

	public void getview() {
		Integer id = getParaToInt(0);
		T_Bus_Materialname model = T_Bus_Materialname.dao.findById(id);
		//物资类型
		T_Sys_Parameter type = T_Sys_Parameter.dao.findById(model.get("type"));
		setAttr("typename", type.get("p_name"));
		setAttr("model", model);
		render("view.jsp");
	}
}
