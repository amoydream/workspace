package com.lauvan.apps.resource.safeguardorg.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_CollFund;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 募捐现存资金管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/collfund", viewPath = "/resource/safeguardorg/collfund")
public class CollFundController extends BaseController {

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String deptid = getPara(0); //机构名称
		String sqlWhere = null;
		if(deptid != null && !"".equals(deptid)) {
			sqlWhere = " deptid =" + deptid;
		}
		Page<Record> page = Paginate.dao.getPage("t_bus_collfund", pageSize, pageNumber, sqlWhere, "updatetime", "desc");
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		setAttr("deptid", getPara(0));
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_CollFund fund = T_Bus_CollFund.dao.findById(id);
		setAttr("fund", fund);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Bus_CollFund fund = getModel(T_Bus_CollFund.class);
		boolean success = false;
		try {
			if(fund.get("fundid") == null) {
				fund.set("deptid", getPara(0)); // 对应募捐机构id
				success = T_Bus_CollFund.dao.insert(fund);
			} else {
				success = T_Bus_CollFund.dao.upd(fund);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "collfundDialog", "collfund_data", "closeCurrent");
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
			T_Bus_CollFund.dao.deleteByIds(ArrayUtils.ArrayToString(ids));
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

}
