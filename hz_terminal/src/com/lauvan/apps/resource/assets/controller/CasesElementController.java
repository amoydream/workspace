package com.lauvan.apps.resource.assets.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.assets.model.T_Bus_Cases_Element;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/caseselement", viewPath = "/resource/assets/cases/element")
public class CasesElementController extends BaseController {
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String casId = getPara(0);//所属案例id
		String sqlWhere = null;
		if(casId != null && !"".equals(casId)) {
			sqlWhere = " casesid =" + casId;
		}
		Page<Record> page = Paginate.dao.getPage("t_bus_cases_element", pageSize, pageNumber, sqlWhere, "ele_id", "desc");
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		String casId = getPara(0);
		setAttr("casId", casId);
		renderJsp("add.jsp");
	}

	public void save() {
		T_Bus_Cases_Element element = getModel(T_Bus_Cases_Element.class);
		boolean success = false;
		try {
			element.set("fjid", getPara("fjid"));
			if(element.get("ele_id") == null) {
				String casId = getPara(0); //获取救援组织ID
				element.set("casesid", casId);
				System.out.println("222222222");
				System.out.println(element.getStr("fjid"));
				success = T_Bus_Cases_Element.dao.insert(element);
			} else {
				success = element.update();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "elementDialog", "elementGrid", "closeCurrent");
			} else {
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}

	public void edit() {
		Integer id = getParaToInt(0);
		T_Bus_Cases_Element model = T_Bus_Cases_Element.dao.getById(id);
		setAttr("model", model);
		renderJsp("edit.jsp");
	}

	public void delete() {
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Bus_Cases_Element.dao.deleteByIds(idStr);
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

	public void getview() {
		Integer id = getParaToInt(0);
		T_Bus_Cases_Element model = T_Bus_Cases_Element.dao.getById(id);
		//数据源单位
		String dept = model.get("sourcedept") == null ? null : model.get("sourcedept").toString();
		if(dept != null) {
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			setAttr("organ", d.getStr("or_name"));
		}
		setAttr("model", model);
		renderJsp("view.jsp");
	}

}
