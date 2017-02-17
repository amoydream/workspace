package com.lauvan.apps.resource.knowlege.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.knowlege.model.T_Bus_Stand;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 标准及技术规范管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/stand", viewPath = "/resource/knowlege/stand")
public class StandController extends BaseController {

	public void index() {
		renderJsp("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String typecode = getPara("typecode");
		String standname = getPara("standname");
		Page<Record> page = T_Bus_Stand.dao.getPage(pageSize, pageNumber, standname, typecode);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_Stand s = T_Bus_Stand.dao.getById(id);
		setAttr("s", s);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Bus_Stand stand = getModel(T_Bus_Stand.class);
		boolean success = false;
		try {
			stand.set("fjid", getPara("fjid"));
			if(stand.get("standid") == null) {
				success = T_Bus_Stand.dao.insert(stand);
			} else {
				success = T_Bus_Stand.dao.upd(stand);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "standDialog", "stand_data", "closeCurrent");
			} else {
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}

	@Before(Tx.class)
	public void delete() {
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			String fjids = T_Bus_Stand.dao.getfjidsByids(idStr);
			if(fjids != null && !"".equals(fjids)) {
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_Stand.dao.deleteByIds(idStr);
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
		T_Bus_Stand s = T_Bus_Stand.dao.getById(id);
		setAttr("s", s);
		renderJsp("view.jsp");
	}
}
