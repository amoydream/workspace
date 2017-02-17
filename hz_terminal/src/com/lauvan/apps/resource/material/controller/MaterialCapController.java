package com.lauvan.apps.resource.material.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.material.model.T_Bus_Materialcap;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/materialcap", viewPath = "/resource/material/materialfirm/materialcap")
public class MaterialCapController extends BaseController {
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String mfId = getPara(0);//所属企业id
		String sqlWhere = null;
		if(mfId != null && !"".equals(mfId)) {
			sqlWhere = " firmid =" + mfId;
		}
		Page<Record> page = Paginate.dao.getPage("t_bus_materialcap", pageSize, pageNumber, sqlWhere, "cap_id", "desc");
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		String mfId = getPara(0);
		setAttr("mfId", mfId);
		renderJsp("add.jsp");
	}

	public void save() {
		T_Bus_Materialcap cap = getModel(T_Bus_Materialcap.class);
		boolean success = false;
		try {
			if(cap.get("cap_id") == null) {
				String mfId = getPara(0); //获取救援组织ID
				cap.set("firmid", mfId);
				success = T_Bus_Materialcap.dao.insert(cap);
			} else {
				success = cap.update();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "macapDialog", "macapGrid", "closeCurrent");
			} else {
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}

	public void edit() {
		Integer id = getParaToInt(0);
		T_Bus_Materialcap model = T_Bus_Materialcap.dao.findById(id);
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
			T_Bus_Materialcap.dao.deleteByIds(idStr);
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
		T_Bus_Materialcap model = T_Bus_Materialcap.dao.findById(id);
		setAttr("model", model);
		renderJsp("view.jsp");
	}

}
