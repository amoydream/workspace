package com.lauvan.apps.resource.knowlege.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.knowlege.model.T_Bus_Chemdistinfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 应急处置管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/chemdistinfo", viewPath = "/resource/knowlege/chemistry/chemdistinfo")
public class ChemdistinfoController extends BaseController {

	public void index() {
		renderJsp("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String chemname = getPara("chemdistname");
		Page<Record> page = T_Bus_Chemdistinfo.dao.getPage(pageSize, pageNumber, chemname);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);

	}

	public void add() {
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_Chemdistinfo info = T_Bus_Chemdistinfo.dao.getById(id);
		setAttr("info", info);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Bus_Chemdistinfo info = getModel(T_Bus_Chemdistinfo.class);
		boolean success = false;
		try {
			if(info.get("id") == null) {
				success = T_Bus_Chemdistinfo.dao.insert(info);
			} else {
				success = info.update();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "chemdistinfoDialog", "chemdistinfo_data", "closeCurrent");
			} else {
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}

	}

	public void delete() {
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			T_Bus_Chemdistinfo.dao.deleteByIds(ArrayUtils.ArrayToString(ids));
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

	public void view() {
		String id = getPara(0);
		T_Bus_Chemdistinfo info = T_Bus_Chemdistinfo.dao.getById(id);
		setAttr("info", info);
		renderJsp("view.jsp");
	}

	public void getChemList() {
		renderJsp("findData/chemList.jsp");
	}
}
