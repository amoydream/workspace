package com.lauvan.apps.resource.assets.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.focusmanager.danger.model.T_Bus_Danger;
import com.lauvan.apps.resource.assets.model.T_Bus_Cases;
import com.lauvan.apps.resource.assets.model.T_Bus_Cases_Element;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/cases", viewPath = "/resource/assets/cases")
public class CasesController extends BaseController {
	public void index() {
		render("main.jsp");
	}

	public void getData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String caTitle = getPara("caTitle");
		Integer did = getParaToInt(0); //所属单位id
		StringBuffer str = new StringBuffer(" 1=1 ");
		if(caTitle != null && !"".equals(caTitle)) {
			str.append(" and title like '%").append(caTitle).append("%'");
		}
		if(did != null && did != 0) {
			str.append(" and sourcedept =").append(did);
		}
		Page<Record> page = Paginate.dao.getPage("T_BUS_CASES", pageSize, pageNumber, str.toString(), "cas_id", null);
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
		T_Bus_Cases model = T_Bus_Cases.dao.getById(id);

		T_Bus_Danger danger = T_Bus_Danger.dao.getDangerByDanid(model.getBigDecimal("dangerid"));
		if(danger != null) {
			String dangername = danger.getStr("dangername");
			setAttr("dangername", dangername);
		}

		setAttr("model", model);
		render("edit.jsp");
	}

	public void save() {
		T_Bus_Cases cases = getModel(T_Bus_Cases.class);
		boolean success = false;
		try {
			cases.set("fjid", getPara("fjid"));
			if(cases.get("cas_id") == null) {
				success = T_Bus_Cases.dao.insert(cases);
			} else {
				success = T_Bus_Cases.dao.upd(cases);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		if(success) {
			toDwzText(success, "保存成功！", "", "casesDialog", "casesGrid", "closeCurrent");
		} else {
			toDwzText(success, "保存异常！", "", "", "", "");
		}
	}

	public void delete() {
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Bus_Cases_Element.dao.deleteByCasesIds(idStr); //删除案例下的要素配置信息
			String fjids = T_Bus_Cases.dao.getfjidsByIds(idStr);
			if(fjids != null && !"".equals(fjids)) {
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_Cases.dao.deleteByIds(idStr);
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
		T_Bus_Cases cases = T_Bus_Cases.dao.getById(id);
		setAttr("cases", cases);
		//事发单位
		String dept = cases.get("sourcedept") == null ? null : cases.get("sourcedept").toString();
		if(dept != null) {
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			setAttr("sourcedeptname", d.getStr("or_name"));
		}

		T_Bus_Danger danger = T_Bus_Danger.dao.getDangerByDanid(cases.getBigDecimal("dangerid"));
		if(danger != null) {
			String dangername = danger.getStr("dangername");
			setAttr("dangername", dangername);
		}
		renderJsp("view.jsp");
	}

}
