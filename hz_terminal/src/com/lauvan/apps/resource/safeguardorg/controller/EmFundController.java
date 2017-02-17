package com.lauvan.apps.resource.safeguardorg.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_EmFund;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 应急救援资金管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/emfund", viewPath = "/resource/safeguardorg/emfund")
public class EmFundController extends BaseController {

	public void index() {
		renderJsp("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String fundname = getPara("fundname"); //机构名称
		String levelcode = getPara("levelcode"); //级别代码
		String classcode = getPara("classcode"); //级别代码
		Page<Record> page = T_Bus_EmFund.dao.getPage(pageSize, pageNumber, fundname, levelcode, classcode);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_EmFund fund = T_Bus_EmFund.dao.findById(id);
		setAttr("fund", fund);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Bus_EmFund fund = getModel(T_Bus_EmFund.class);
		boolean success = false;
		try {
			if(fund.get("fundid") == null) {
				success = T_Bus_EmFund.dao.insert(fund);
			} else {
				success = T_Bus_EmFund.dao.upd(fund);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "emfundDialog", "emfund_data", "closeCurrent");
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
			T_Bus_EmFund.dao.deleteByIds(ArrayUtils.ArrayToString(ids));
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
		T_Bus_EmFund fund = T_Bus_EmFund.dao.findById(id);
		setAttr("fund", fund);
		renderJsp("view.jsp");
	}
}
