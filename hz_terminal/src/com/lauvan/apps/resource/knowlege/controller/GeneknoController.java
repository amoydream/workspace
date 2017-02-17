package com.lauvan.apps.resource.knowlege.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.knowlege.model.T_Bus_Genekno;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 应急常识管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/genekno", viewPath = "/resource/knowlege/genekno")
public class GeneknoController extends BaseController {

	public void index() {
		renderJsp("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String typecode = getPara("typecode");
		String title = getPara("title");
		Page<Record> page = T_Bus_Genekno.dao.getPage(pageSize, pageNumber, title, typecode);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_Genekno kno = T_Bus_Genekno.dao.getById(id);
		setAttr("kno", kno);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Bus_Genekno kno = getModel(T_Bus_Genekno.class);
		boolean success = false;
		try {
			kno.set("fjid", getPara("fjid"));
			if(kno.get("knoid") == null) {
				success = T_Bus_Genekno.dao.insert(kno);
			} else {
				success = T_Bus_Genekno.dao.upd(kno);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "geneknoDialog", "genekno_data", "closeCurrent");
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
			String fjids = T_Bus_Genekno.dao.getfjidsByids(idStr);
			T_Attachment.dao.deleteByIds(fjids); //删除附件
			T_Bus_Genekno.dao.deleteByIds(idStr);
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

	//获取分类tree
	public void getTypeTreeByAcode() {
		String acode = getPara(0);
		String jsonStr = "[]";
		try {
			if(acode != null && !"".equals(acode)) {
				List<Record> list = T_Sys_Parameter.dao.getParamByCode(acode, true);
				Map<String, String> outputKey = new HashMap<String, String>();
				outputKey.put("id", "p_acode");
				outputKey.put("text", "p_name");
				jsonStr = JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			renderText(jsonStr);
		}
	}

	public void view() {
		String id = getPara(0);
		T_Bus_Genekno kno = T_Bus_Genekno.dao.getById(id);
		setAttr("kno", kno);
		renderJsp("view.jsp");
	}
}
