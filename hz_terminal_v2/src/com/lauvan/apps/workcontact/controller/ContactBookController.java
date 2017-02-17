package com.lauvan.apps.workcontact.controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.lauvan.apps.workcontact.model.T_Bus_ContactBook;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;

/**
 * @author Bob 通讯录控制器
 */
@RouteBind(path = "/Main/systemcontact/contactbook", viewPath = "/workcontact/baseworkcontact/systemcontact")
public class ContactBookController extends BaseController {

	public void main() {
		render("contactbook/main.jsp");
	}

	// 机构人员通讯信息编辑
	public void editForUser() {
		Integer id = getParaToInt(0);
		T_Sys_User user = T_Sys_User.dao.findById(id);
		T_Bus_ContactBook book = T_Bus_ContactBook.dao.getBookByUserId(user
				.getBigDecimal("USER_ID"));
		if (book != null) {
			setAttr("book", book);
		} else {
			setAttr("add", "add");
		}
		setAttr("user", user);
		render("usercontact/edit.jsp");
	}

	// 组织机构通讯信息编辑
	public void editForDepart() {
		Integer id = getParaToInt(0);
		T_Sys_Department depart = T_Sys_Department.dao.findById(id);
		T_Bus_ContactBook book = T_Bus_ContactBook.dao.getBookByDepartId(depart
				.getBigDecimal("d_id"));
		if (book != null) {
			setAttr("book", book);
		} else {
			setAttr("add", "add");
		}
		setAttr("depart", depart);
		render("departmentcontact/edit.jsp");
	}

	// 保存通讯录
	public void save() {
		String act = getPara("act");
		String fromDepart = getPara("depart");
		String d_pid = getPara("p_id");
		String[] positionids = getParaValues("bo_position");
		String pids = StringUtils.join(positionids,",");
		boolean success = false;
		T_Bus_ContactBook model = getModel(T_Bus_ContactBook.class);
		String regEx="[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";  
		Pattern   p   =   Pattern.compile(regEx);     
		Matcher   m   =   null;
		if(StringUtils.isNotBlank(model.getStr("bo_homenumber"))){
			m   =   p.matcher(model.getStr("bo_homenumber"));
			model.set("bo_homenumber", m.replaceAll(",").trim());
		}
		if(StringUtils.isNotBlank(model.getStr("bo_worknumber"))){
			m   =   p.matcher(model.getStr("bo_worknumber"));
			model.set("bo_worknumber", m.replaceAll(",").trim());
		}
		
		if(StringUtils.isNotBlank(model.getStr("bo_mobile"))){		
			m   =   p.matcher(model.getStr("bo_mobile"));
			model.set("bo_mobile", m.replaceAll(",").trim());
		}
		if (act.equals("add")) {
			model.set("bo_position", pids);
			model.set("bo_id", AutoId.nextval(model));
			success = model.save();
		} else {
			model.set("bo_position", pids);
			success = model.update();
		}
		if ("true".equals(fromDepart)) {
			if (success) {
				toDwzText(success, "保存成功！", "departcontactTree",
						"departDialog", "", "closeCurrent", d_pid);
			} else {
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		} else {
			renderText("{\"success\":" + success + "}");
		}
	}

}
