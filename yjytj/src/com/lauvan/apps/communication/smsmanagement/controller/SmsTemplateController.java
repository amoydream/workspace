package com.lauvan.apps.communication.smsmanagement.controller;

/**
 * 短信模板控制类
 * @author 黄丽凯
 * */
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.smsmanagement.model.T_Send_Temp;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/smsTemp", viewPath = "/communication/sms/template")
public class SmsTemplateController extends BaseController {
	public void index() {
		render("main.jsp");
	}

	public void getDataGrid() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String scontent = getPara("scontent");
		StringBuffer sqlWhere = new StringBuffer();
		if(scontent != null && !"".equals(scontent)) {
			sqlWhere.append(" and s.content like '%").append(scontent).append("%'");
		}
		Page<Record> page = T_Send_Temp.dao.getPageList(pageSize, pageNumber, sqlWhere.toString());
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		render("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Send_Temp t = T_Send_Temp.dao.findById(id);
		if(t != null) {
			LoginModel login = getSessionAttr("loginModel");
			if(!login.getIsAdmin() && !t.getNumber("user_id").equals(login.getUserId())) {
				toDwzText(false, "只能修改自己创建的短信模板，请检查！", "", "", "", "closeCurrent");
				return;
			}
			setAttr("t", t);
		} else {
			toDwzText(false, "该短信模板不存在，请检查！", "", "", "", "closeCurrent");
			return;
		}
		render("edit.jsp");
	}

	public void save() {
		try {
			String act = getPara("act");
			T_Send_Temp t = getModel(T_Send_Temp.class);
			if("add".equals(act)) {
				LoginModel login = getSessionAttr("loginModel");
				t.set("user_id", login.getUserId());
				t.set("username", login.getUserName());
				T_Send_Temp.dao.insert(t);
			} else {
				t.update();
			}
			toDwzText(true, "保存成功！", "", "smsTempDialog", "smsTempGrid", "closeCurrent");
		} catch(Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}
	}

	public void delete() {
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "删除成功！";
		String errorCode = "info";
		try {
			LoginModel login = getSessionAttr("loginModel");
			if(login.getIsAdmin() || T_Send_Temp.dao.isDelete(ids, login.getUserId().toString())) {
				success = T_Send_Temp.dao.deleteByIds(ids);
			} else {
				errorCode = "error";
				msg = "只有删除自己创建的短信模板！";
			}
		} catch(Exception e) {
			errorCode = "error";
			msg = e.getMessage();
			e.printStackTrace();
		} finally {
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
}
