package com.lauvan.apps.resource.safeguardorg.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_Healthdept;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 医疗机构信息管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/healthdept", viewPath = "/resource/safeguardorg/healthdept")
public class HealthdeptController extends BaseController {

	public void index() {
		renderJsp("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String deptname = getPara("deptname"); //机构名称
		String levelcode = getPara("levelcode");//级别代码
		String classcode = getPara("classcode");//密级代码
		String gradecode = getPara("gradecode"); //等级代码
		Page<Record> page = T_Bus_Healthdept.dao.getPage(pageSize, pageNumber, deptname, levelcode, classcode, gradecode);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_Healthdept hdept = T_Bus_Healthdept.dao.getById(id);
		setAttr("hdept", hdept);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Bus_Healthdept hdept = getModel(T_Bus_Healthdept.class);
		boolean success = false;
		try {
			hdept.set("fjid", getPara("fjid"));
			if(hdept.get("deptid") == null) {
				success = T_Bus_Healthdept.dao.insert(hdept);
			} else {
				success = T_Bus_Healthdept.dao.upd(hdept);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "healthdeptDialog", "healthdept_data", "closeCurrent");
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
			String fjids = T_Bus_Healthdept.dao.getfjidsByids(idStr);
			if(fjids != null && !"".equals(fjids)) {
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_Healthdept.dao.deleteByIds(idStr); //删除医疗机构记录
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
		T_Bus_Healthdept hdept = T_Bus_Healthdept.dao.getById(id);
		setAttr("hdept", hdept);
		renderJsp("view.jsp");
	}

}
