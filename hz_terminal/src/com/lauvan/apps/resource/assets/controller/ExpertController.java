package com.lauvan.apps.resource.assets.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.assets.model.T_Bus_Expert;
import com.lauvan.apps.resource.assets.model.T_Bus_Expertgroup_Per;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/expert", viewPath = "/resource/assets/expert")
public class ExpertController extends BaseController {
	public void index() {
		List<Record> typeList = T_Sys_Parameter.dao.getParamByCode("YJZJ", false);
		String typeJson = JsonKit.toJson(typeList);
		setAttr("typeJson", typeJson);

		T_Sys_Parameter root = T_Sys_Parameter.dao.getByCode3("YJZJ");
		BigDecimal rootId = root.getBigDecimal("id");
		setAttr("rootId", rootId);

		render("main.jsp");
	}

	public void getTypeTree() {
		String dataList = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("YJZJ", true);
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
		String expName = getPara("expName");
		Integer departid = getParaToInt(0);
		StringBuffer str = new StringBuffer();
		String sql = "t_bus_expert e left join t_sys_parameter p on p.id = e.typeid where 1=1 ";
		str.append(sql);
		if(pid != null && !"".equals(pid)) {
			str.append("  and e.typeid=" + pid);
		}
		if(expName != null && !"".equals(expName)) {
			str.append(" and name like '%").append(expName).append("%'");
		}
		if(departid != null && departid != 0) {
			str.append(" and e.organid = ").append(departid);
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
		T_Bus_Expert model = T_Bus_Expert.dao.findById(id);
		setAttr("model", model);
		render("edit.jsp");
	}

	public void save() {
		String act = getPara("act");
		boolean success = false;
		T_Bus_Expert expert = getModel(T_Bus_Expert.class);
		if(act.equals("add")) {
			expert.set("ex_id", AutoId.nextval(expert));
			success = expert.save();
		} else {
			success = expert.update();
		}
		if(success) {
			toDwzText(success, "保存成功！", "", "expertDialog", "expertGrid", "closeCurrent");
		} else {
			toDwzText(success, "保存异常！", "", "", "", "");
		}
	}

	public void delete() {
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			T_Bus_Expert.dao.deleteByIds(ids);
			T_Bus_Expertgroup_Per.dao.beNullByExpIds(ids);
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
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("YJZJ", true);
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "id");
			outputKey.put("text", "p_name");
			jsonStr = JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
		} catch(Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}

	/**
	 * 获取专家名录页面供其他模块选择专家
	 */
	public void getExpert() {
		renderJsp("select.jsp");
	}

	public void getview() {
		Integer id = getParaToInt(0);
		T_Bus_Expert model = T_Bus_Expert.dao.findById(id);
		//所在单位
		String dept = model.get("organid") == null ? null : model.get("organid").toString();
		if(dept != null) {
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			setAttr("organ", d.getStr("or_name"));
		}
		//专家类型
		T_Sys_Parameter type = T_Sys_Parameter.dao.findById(model.get("typeid"));
		setAttr("typename", type.get("p_name"));

		setAttr("model", model);
		render("view.jsp");
	}

}
