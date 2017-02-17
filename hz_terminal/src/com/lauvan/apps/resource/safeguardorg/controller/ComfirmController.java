package com.lauvan.apps.resource.safeguardorg.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_Comfirm;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 通讯保障机构管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/comfirm", viewPath = "/resource/safeguardorg/comfirm")
public class ComfirmController extends BaseController {

	public void index() {
		renderJsp("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String levelcode = getPara("levelcode"); //级别代码
		String firmname = getPara("firmname"); //机构名称
		String classcode = getPara("classcode"); //级别代码
		Page<Record> page = T_Bus_Comfirm.dao.getPage(pageSize, pageNumber, firmname, levelcode, classcode);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_Comfirm firm = T_Bus_Comfirm.dao.getById(id);
		setAttr("firm", firm);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Bus_Comfirm firm = getModel(T_Bus_Comfirm.class);
		boolean success = false;
		try {
			firm.set("fjid", getPara("fjid"));
			if(firm.get("firmid") == null) {
				success = T_Bus_Comfirm.dao.insert(firm);
			} else {
				success = T_Bus_Comfirm.dao.upd(firm);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "comfirmDialog", "comfirm_data", "closeCurrent");
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
			String fjids = T_Bus_Comfirm.dao.getfjidsByIds(idStr);
			if(fjids != null && !"".equals(fjids)) {
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_Comfirm.dao.deleteByIds(idStr);
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
		T_Bus_Comfirm firm = T_Bus_Comfirm.dao.getById(id);
		setAttr("firm", firm);
		renderJsp("view.jsp");
	}
}
