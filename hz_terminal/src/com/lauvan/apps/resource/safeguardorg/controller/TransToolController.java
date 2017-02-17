package com.lauvan.apps.resource.safeguardorg.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_TransTool;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 运输工具
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/transtool", viewPath = "/resource/safeguardorg/transtool")
public class TransToolController extends BaseController {

	public void index() {
		renderJsp("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String toolname = getPara("toolname"); //工具名称
		String transtypeid = getPara("transtypeid"); //型号编码
		String firmname = getPara("firmname");
		Page<Record> page = T_Bus_TransTool.dao.getPage(pageSize, pageNumber, toolname, firmname, transtypeid);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_TransTool tool = T_Bus_TransTool.dao.getById(id);
		setAttr("tool", tool);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Bus_TransTool tool = getModel(T_Bus_TransTool.class);
		boolean success = false;
		try {
			if(tool.get("toolid") == null) {
				success = T_Bus_TransTool.dao.insert(tool);
			} else {
				success = T_Bus_TransTool.dao.upd(tool);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "transtoolDialog", "transtool_data", "closeCurrent");
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
			T_Bus_TransTool.dao.deleteByIds(ArrayUtils.ArrayToString(ids));
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
		T_Bus_TransTool tool = T_Bus_TransTool.dao.getById(id);
		setAttr("tool", tool);
		renderJsp("view.jsp");
	}

	public void getTransFirmList() {
		renderJsp("findData/transfirmList.jsp");
	}

	public void getTransTypeList() {
		renderJsp("findData/transtypeList.jsp");
	}
}
