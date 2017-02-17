package com.lauvan.apps.resource.assets.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.assets.model.T_Bus_Team;
import com.lauvan.apps.resource.assets.model.T_Bus_Team_Equip;
import com.lauvan.apps.resource.assets.model.T_Bus_Team_Person;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 应急队伍管理
 *@author zzg
 */
@RouteBind(path = "Main/team", viewPath = "/resource/assets/team")
public class TeamController extends BaseController {

	public void index() {
		render("main.jsp");
	}

	//民间救援组织列表
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("teName");
		Integer departid = getParaToInt(0);
		Page<Record> page = T_Bus_Team.dao.getPage(pageSize, pageNumber, name, departid);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);

	}

	public void add() {
		renderJsp("add.jsp");
	}

	public void edit() {
		Integer id = getParaToInt(0);
		T_Bus_Team team = T_Bus_Team.dao.getById(id);
		setAttr("model", team);
		renderJsp("edit.jsp");

	}

	public void save() {
		T_Bus_Team team = getModel(T_Bus_Team.class);
		boolean success = false;
		try {
			team.set("fjid", getPara("fjid"));
			if(team.get("tea_id") == null) {
				success = T_Bus_Team.dao.insert(team);
			} else {
				success = T_Bus_Team.dao.upd(team);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		if(success) {
			toDwzText(success, "保存成功！", "", "teamDialog", "teamGrid", "closeCurrent");
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
			T_Bus_Team_Equip.dao.deleteByTeamIds(idStr); //删除队伍下装备配置信息
			T_Bus_Team_Person.dao.deleteByTeamIds(idStr); //删除队伍下人员配置信息
			String fjids = T_Bus_Team.dao.getfjidsByIds(idStr);
			if(fjids != null && !"".equals(fjids)) {
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_Team.dao.deleteByIds(idStr);
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
		T_Bus_Team team = T_Bus_Team.dao.getById(id);
		//所属单位
		String dept = team.get("organid") == null ? null : team.get("organid").toString();
		if(dept != null) {
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			setAttr("organ", d.getStr("or_name"));
		}
		setAttr("team", team);
		renderJsp("view.jsp");
	}
}
