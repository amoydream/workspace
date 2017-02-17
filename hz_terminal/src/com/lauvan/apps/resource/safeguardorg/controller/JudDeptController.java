package com.lauvan.apps.resource.safeguardorg.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_JudDept;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 司法行政机构管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path = "Main/juddept", viewPath = "/resource/safeguardorg/juddept")
public class JudDeptController extends BaseController {

	public void index() {
		List<T_Bus_JudDept> judList = T_Bus_JudDept.dao.getListById(null);
		setAttr("deptlist", judList);
		renderJsp("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String juddeptname = getPara("juddeptname");
		String levelcode = getPara("levelcode");
		Integer pid = getParaToInt(0);
		Page<Record> page = T_Bus_JudDept.dao.getPage(pageSize, pageNumber, pid, juddeptname, levelcode);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}

	public void add() {
		String supid = getPara(0);
		setAttr("supid", supid);
		renderJsp("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_JudDept juddept = T_Bus_JudDept.dao.getById(id);
		setAttr("juddept", juddept);
		renderJsp("edit.jsp");
	}

	public void save() {
		T_Bus_JudDept juddept = getModel(T_Bus_JudDept.class);
		boolean success = false;
		try {
			juddept.set("fjid", getPara("fjid"));
			if(juddept.get("deptid") == null) {
				juddept.set("superdept_id", getPara(0)); //上级行政机关ID
				success = T_Bus_JudDept.dao.insert(juddept);
			} else {
				success = T_Bus_JudDept.dao.upd(juddept);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(success) {
				//toDwzText(success, "保存成功！", "", "juddeptDialog", "juddept_data", "closeCurrent");
				if("0".equals(getPara(0)) || "0".equals(juddept.get("superdept_id").toString())) {
					renderText("{\"success\":true, \"msg\":\"保存成功！\",\"dialogid\":\"juddeptDialog\", \"tabid\":\"司法行政机关\", \"furl\":\"Main/juddept/index\"}");
				} else {
					renderText("{\"success\":true, \"msg\":\"保存成功！\",\"dialogid\":\"juddeptDialog\", \"gridid\":\"juddept_data\", \"treeObj\":\"juddepttree\",\"reloadid\":" + (getPara(0) == null ? juddept.get("superdept_id") : getPara(0)) + ",\"idkey\":\"d_id\"}");
				}
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
			if(ids[0] != null && !"".equals(ids[0])) { //查找刷新的上级节点id
				BigDecimal supid = T_Bus_JudDept.dao.findById(ids[0]).getBigDecimal("superdept_id");
				if(supid.intValue() == 0) {
					tips.put("reflashtab", true);
				} else {
					tips.put("reloadid", supid);
					tips.put("idkey", "d_id");
				}
			}
			String idStr = ArrayUtils.ArrayToString(ids);
			idStr = T_Bus_JudDept.dao.getChildIdsByDeptids(idStr); //查找下属id，包含自身ID
			String fjids = T_Bus_JudDept.dao.getfjidsByIds(idStr);
			if(fjids != null && !"".equals(fjids)) {
				T_Attachment.dao.deleteByIds(idStr);//删除附件
			}
			T_Bus_JudDept.dao.deleteByIds(idStr);
			success = true;
			errorCode = "info";
		} catch(Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally {
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			//tips.put("reflashtab", true);
			tips.put("treeObj", "juddepttree");
			renderJson(tips);
		}
	}

	public void view() {
		String id = getPara(0);
		T_Bus_JudDept juddept = T_Bus_JudDept.dao.getById(id);
		setAttr("juddept", juddept);
		renderJsp("view.jsp");
	}

	public void getTreeData() {
		String pid = getPara("d_id");
		List<T_Bus_JudDept> judList = T_Bus_JudDept.dao.getListById(pid);
		renderJson(judList);
	}
}
