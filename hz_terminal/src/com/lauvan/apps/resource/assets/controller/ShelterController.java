package com.lauvan.apps.resource.assets.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.assets.model.T_Bus_Shelter;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/shelter", viewPath = "/resource/assets/shelter")
public class ShelterController extends BaseController {
	public void index() {
		render("main.jsp");
	}

	public void getData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String shName = getPara("shName");
		Integer departid = getParaToInt(0);
		StringBuffer str = new StringBuffer();
		if(shName != null && !"".equals(shName)) {

			str.append(" name like '%").append(shName).append("%'");
		}
		if(departid != null && departid != 0) {
			if(str.length() > 0) {
				str.append(" and ");
			}
			str.append(" organid=").append(departid);
		}
		Page<Record> page = Paginate.dao.getPage("T_BUS_SHELTER", pageSize, pageNumber, str.toString(), "she_id", null);
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
		Integer id = getParaToInt(0);
		T_Bus_Shelter model = T_Bus_Shelter.dao.findById(id);
		setAttr("model", model);
		render("edit.jsp");
	}

	public void save() {
		String act = getPara("act");
		boolean success = false;
		T_Bus_Shelter shelter = getModel(T_Bus_Shelter.class);
		if(act.equals("add")) {
			shelter.set("she_id", AutoId.nextval(shelter));
			success = shelter.save();
		} else {
			success = shelter.update();
		}
		if(success) {
			toDwzText(success, "保存成功！", "", "shelterDialog", "shelterGrid", "closeCurrent");
		} else {
			toDwzText(success, "保存异常！", "", "", "", "");
		}
	}

	public void delete() {
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			T_Bus_Shelter.dao.deleteByIds(ids);
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
		T_Bus_Shelter model = T_Bus_Shelter.dao.findById(id);
		//所属单位
		String dept = model.get("organid") == null ? null : model.get("organid").toString();
		if(dept != null) {
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			setAttr("organ", d.getStr("or_name"));
		}
		setAttr("model", model);
		render("view.jsp");
	}

}
