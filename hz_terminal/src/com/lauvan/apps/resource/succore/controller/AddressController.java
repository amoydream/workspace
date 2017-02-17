package com.lauvan.apps.resource.succore.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.succore.model.T_Address;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 志愿者通讯录管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/address", viewPath = "/resource/address")
public class AddressController extends BaseController {

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String personid = getPara(0);
		Page<Record> page = T_Address.dao.getPage(pageSize, pageNumber, personid);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		setAttr("personid", getPara(0));
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Address ads = T_Address.dao.findById(id);
		setAttr("ads", ads);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Address ads = getModel(T_Address.class);
		boolean success = false;
		try {
			if(ads.get("add_code") == null) {
				ads.set("user_code", getPara(0));
				success = T_Address.dao.insert(ads);
			} else {
				success = ads.update();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "addressDialog", "address_data", "closeCurrent");
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
			T_Address.dao.deleteByIds(ArrayUtils.ArrayToString(ids));
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
