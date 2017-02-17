package com.lauvan.apps.workcontact.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.workcontact.model.T_Bus_EmergencyContact;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

/**
 * 应急工作联络网控制器
 * 
 * @author Bob
 */
@RouteBind(path = "/Main/emergencycontact", viewPath = "/workcontact/emergencycontact")
public class EmergencyContactController extends BaseController {

	public void main() {
		render("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		Integer e_id = getParaToInt("e_id");
		T_Bus_EmergencyContact em = T_Bus_EmergencyContact.dao.findById(e_id);
		String bookids = null;
		String personids = null;
		if (em != null) {
			bookids = em.getStr("e_bookid");
			personids = em.getStr("e_personid");
		}
		// 获取表格表页数据
		Page<Record> page = T_Bus_EmergencyContact.dao.getContactPage(pageSize,
				pageNumber, bookids, personids);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void getTreeData() {
		String idKey = StringUtils.isBlank(getPara("idKey")) ? "id"
				: getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "pid"
				: getPara("pidKey");

		List<Record> emergencyList = T_Bus_EmergencyContact.dao
				.getAllEmergencys();

		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> row = new HashMap<String, Object>();
		Map<String, Object> root = new HashMap<String, Object>();

		root.put(idKey, "0");
		root.put("name", "应急分组");
		root.put(pidKey, "");
		dataList.add(root);

		for (Record de : emergencyList) {
			row = new HashMap<String, Object>();
			row.put(idKey, de.get("e_id"));
			row.put("name", de.get("e_name"));
			row.put(pidKey, de.get("e_pid"));
			dataList.add(row);
		}
		renderJson(dataList);
	}

	// 编辑分组-机构人员通讯
	public void editPersonContact() {
		Integer e_id = getParaToInt(0);
		T_Bus_EmergencyContact e = T_Bus_EmergencyContact.dao.findById(e_id);
		String personids = e.getStr("e_personid");
		setAttr("e_id", e_id);
		setAttr("personids", personids);
		render("selectperson.jsp");
	}

	public void personcontactSave() {
		String ids = getPara("ids").trim();
		Integer e_id = getParaToInt("e_id");
		T_Bus_EmergencyContact e = T_Bus_EmergencyContact.dao.findById(e_id);
		boolean success = false;
		String msg = "";
		if (e != null) {
			e.set("e_personid", ids);
			success = e.update();
		} else {
			msg = "添加机构人员通讯失败！";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("msg", msg);
		renderJson(map);
	}

	// 编辑分组-系统用户通讯
	public void editUserContact() {
		Integer e_id = getParaToInt(0);
		T_Bus_EmergencyContact e = T_Bus_EmergencyContact.dao.findById(e_id);
		String bookids = e.getStr("e_bookid");
		setAttr("e_id", e_id);
		setAttr("bookids", bookids);
		render("selectuser.jsp");
	}

	public void usercontactSave() {
		String ids = getPara("ids").trim();
		Integer e_id = getParaToInt("e_id");
		T_Bus_EmergencyContact e = T_Bus_EmergencyContact.dao.findById(e_id);
		boolean success = false;
		String msg = "";
		if (e != null) {
			e.set("e_bookid", ids);
			success = e.update();
		} else {
			msg = "添加系统用户通讯失败！";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("msg", msg);
		renderJson(map);
	}

	public void edit() {
		Integer id = getParaToInt(0);
		T_Bus_EmergencyContact e = T_Bus_EmergencyContact.dao.findById(id);
		setAttr("e", e);
		render("editgroup.jsp");
	}

	public void add() {
		Integer pid = getParaToInt(0);
		setAttr("pid", pid);
		render("addgroup.jsp");
	}

	public void save() {
		String act = getPara("act");
		boolean success = false;
		T_Bus_EmergencyContact model = getModel(T_Bus_EmergencyContact.class);
		if ("add".equals(act)) {
			model.set("e_id", AutoId.nextval(model));
			success = model.save();
		} else {
			success = model.update();
		}
		renderText("{\"success\":"+success+",\"e_id\":"+model.getBigDecimal("e_id")+",\"e_name\":\""+ model.getStr("e_name")+"\"}");
	}

	// 删除分组
	public void delete() {
		Integer id = getParaToInt("id");

		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			if (!T_Bus_EmergencyContact.dao.hasSonGroup(id)) {
				success = T_Bus_EmergencyContact.dao.deleteById(id);
			} else {
				msg = "删除节点存在子分组";
				errorCode = "info";
			}
		} catch (Exception e) {
			e.printStackTrace();
			errorCode = "error";
			msg = e.getMessage();
		} finally {
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}

	}

	// 删除分组人员
	public void deletePerson() {
		String[] ids = getParaValues("ids");
		Integer e_id = getParaToInt("e_id");
		T_Bus_EmergencyContact ec = T_Bus_EmergencyContact.dao.findById(e_id);
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			List<String> plist = new ArrayList<String>();
			List<String> blist = new ArrayList<String>();
			for (String id : ids) {
				if ("p".equals(id.substring(0, 1))) {
					plist.add(id.replace("p_", "").trim());
				} else {
					if ("b".equals(id.substring(0, 1))) {
						blist.add(id.replace("b_", "").trim());
					}
				}
			}
			//plist为已经去除"p_"标记的id集合
			if (plist.size() != 0) {
				String epids = ec.getStr("e_personid");
				List<String> oldplist = strToList(epids);
				for (int i = 0; i < plist.size(); i++) {
					if (oldplist.contains(plist.get(i))) {
						oldplist.remove(plist.get(i));
					}
				}
				String[] newpidsArr = (String[]) oldplist
						.toArray(new String[oldplist.size()]);
				String newpids = StringUtils.join(newpidsArr, ",");				
				ec.set("e_personid", newpids);
			}
            //blist为已经去除"b_"标记的id集合
			if (blist.size() != 0) {
				String ebids = ec.getStr("e_bookid");
				List<String> oldblist = strToList(ebids);
				for (int i = 0; i < blist.size(); i++) {
					if (oldblist.contains(blist.get(i))) {
						oldblist.remove(blist.get(i));
					}
				}
				String[] newbidsArr = (String[]) oldblist
						.toArray(new String[oldblist.size()]);
				String newbids = StringUtils.join(newbidsArr, ","); 
				ec.set("e_bookid", newbids);
			}
			success = ec.update();
		} catch (Exception e) {
			e.printStackTrace();
			errorCode = "error";
			msg = e.getMessage();
		} finally {
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
    //以，分隔的字符串转List
	private List<String> strToList(String arr) {
		String[] epidsArr = arr.split(",");
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < epidsArr.length; i++) {
			list.add(epidsArr[i]);
		}
		return list;
	}

}
