package com.lauvan.apps.resource.civil.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.civil.model.T_Civisuccordep;
import com.lauvan.apps.resource.civil.model.T_Emsequinfo;
import com.lauvan.apps.resource.civil.model.T_Emsperson;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

/**
 * 民间救援组织管理
 *@author zhouyuanhuan
 */
@RouteBind(path = "Main/civisuccordep", viewPath = "/resource/civisuccordep")
public class CivisuccordepController extends BaseController {

	public void index() {
		render("main.jsp");
	}

	//民间救援组织列表
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("civiname");
		Page<Record> page = T_Civisuccordep.dao.getPage(pageSize, pageNumber, name);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);

	}

	public void add() {
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate", nowdate);
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Civisuccordep civi = T_Civisuccordep.dao.getById(id);
		setAttr("civi", civi);
		renderJsp("edit.jsp");

	}

	public void save() {
		T_Civisuccordep civi = getModel(T_Civisuccordep.class);
		boolean success = false;
		try {
			if(civi.get("deptid") == null) {
				success = T_Civisuccordep.dao.insert(civi);
			} else {
				success = civi.update();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				toDwzText(success, "保存成功！", "", "civilDialog", "civil_data", "closeCurrent");
			} else {
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}

	@Before(Tx.class)
	public void delete() {
		//String[] id = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			//删除救援组织下所属的人员信息、设备信息
			String allphotos = "";
			String idStr = getPara("ids");
			String equids = T_Emsequinfo.dao.getIdStrByCivids(idStr);
			String photos = T_Emsequinfo.dao.getfjidsByids(equids); //救援组织设备对应图片
			//T_Attachment.dao.deleteByIds(photos);
			if(photos != null) {
				allphotos += "," + photos;
			}
			T_Emsequinfo.dao.delByIds(equids); //删除救援组织对应设备信息
			String persids = T_Emsperson.dao.getIdStrByCivids(idStr);
			photos = T_Emsperson.dao.getfjidsByids(persids); //救援组织人员对应图片
			//T_Attachment.dao.deleteByIds(photos);
			if(photos != null) {
				allphotos += "," + photos;
			}
			T_Emsperson.dao.delByIds(persids); //删除救援组织对应人员信息
			photos = T_Civisuccordep.dao.getfjidsByids(idStr);
			if(photos != null) {
				allphotos += "," + photos;
			}
			if(allphotos != null && !"".equals(allphotos)) {
				T_Attachment.dao.deleteByIds(allphotos.substring(1)); //删除民间组织对应图片记录、图片文件
			}
			T_Civisuccordep.dao.delByIds(idStr);
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
		T_Civisuccordep civi = T_Civisuccordep.dao.getById(id);
		setAttr("civi", civi);
		setAttr("deptid", civi.get("deptid"));
		setAttr("deptype", "00A"); //标记救援组织
		renderJsp("view.jsp");
	}
}
