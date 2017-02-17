package com.lauvan.apps.event.controller;

/**
 * 值班要情快报控制类
 * @author 黄丽凯
 * */
import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.event.model.T_Bus_EventDutyReport;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/eventDuty", viewPath = "/event/duty")
public class EventDutyController extends BaseController {
	public void index() {
		render("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String evname = getPara("evname");
		StringBuffer sqlWhere = new StringBuffer();
		if(evname != null && !"".equals(evname)) {
			sqlWhere.append(" and e.evname like '%").append(evname).append("%'");
		}
		Page<Record> page = T_Bus_EventDutyReport.dao.getPageList(pageSize, pageNumber, sqlWhere.toString());
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		String eventid = getPara("eids");
		setAttr("eventids", eventid);
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate", nowdate);
		LoginModel login = getSessionAttr("loginModel");
		setAttr("rOrgan", login.getOrgName());
		render("add.jsp");
	}

	public void edit() {
		String id = getPara(0);
		T_Bus_EventDutyReport d = T_Bus_EventDutyReport.dao.findById(id);
		setAttr("d", d);
		render("edit.jsp");
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
			String uid = login.getUserId().toString();
			if(login.getIsAdmin() || T_Bus_EventDutyReport.dao.isCreate(ids, uid)) {
				//删除文件
				List<T_Bus_EventDutyReport> list = T_Bus_EventDutyReport.dao.getListByIds(ids);
				if(list != null && list.size() > 0) {
					for(T_Bus_EventDutyReport d : list) {
						String url = d.getStr("conurl");
						if(url != null && !"".equals(url)) {
							if(!url.startsWith("/") && url.indexOf(":") != 1) {
								url = PathKit.getWebRootPath() + "/" + url;
							}
							File file = new File(url);
							if(file.exists()) {
								file.delete();
							}
						}
					}
				}
				//删除数据
				success = T_Bus_EventDutyReport.dao.deleteByIDs(ids);
			} else {
				errorCode = "error";
				msg = "只有删除自己创建的值班要情快报！";
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

	public void save() {
		try {
			String act = getPara("act");
			T_Bus_EventDutyReport d = getModel(T_Bus_EventDutyReport.class);
			if("add".equals(act)) {
				LoginModel login = getSessionAttr("loginModel");
				d.set("user_id", login.getUserId());
				T_Bus_EventDutyReport.dao.insert(d);
			} else {
				d.update();
			}
			toDwzText(true, "保存成功！", "", "evDutyDialog", "evDutyGrid", "closeCurrent");
		} catch(Exception e) {
			toDwzText(false, "保存异常！", "", "", "", "");
			e.printStackTrace();
		}
	}

	public void getContent() {
		String id = getPara(0);
		T_Bus_EventDutyReport d = T_Bus_EventDutyReport.dao.findById(id);
		if(d != null) {
			String url = d.getStr("conurl");
			String newPath = "";
			if(url != null && !"".equals(url)) {
				newPath = url;
			} else {
				newPath = PathKit.getWebRootPath() + "/upload/template/zbkb.doc";
				//填充快报
				com.zhuozhengsoft.pageoffice.wordwriter.WordDocument doc = new com.zhuozhengsoft.pageoffice.wordwriter.WordDocument();
				doc.openDataTag("{PO_year}").setValue(d.getStr("er_noyear"));
				doc.openDataTag("{PO_num}").setValue(d.getStr("er_no"));
				doc.openDataTag("{PO_bsdw}").setValue(d.getStr("er_reportunit"));

				//日期转换
				doc.openDataTag("{PO_date}").setValue(DateTimeUtil.formatDate(new Date(), DateTimeUtil.ZHCN_Y_M_D_FORMAT));

				doc.openDataTag("{PO_zsdw}").setValue(d.get("er_mainsupply") == null ? "" : d.getStr("er_mainsupply"));
				doc.openDataTag("{PO_csdw}").setValue(d.get("er_copysupply") == null ? "" : d.getStr("er_copysupply"));
				doc.openDataTag("{PO_bj}").setValue(d.get("er_contact") == null ? "" : d.getStr("er_contact"));
				doc.openDataTag("{PO_tel}").setValue(d.get("er_contactphone") == null ? "" : d.getStr("er_contactphone"));
				doc.openDataTag("{PO_issuser}").setValue(d.get("er_issuer") == null ? "" : d.getStr("er_issuer"));
				setAttr("doc", doc);
			}
			setAttr("newPath", newPath);
			LoginModel login = getSessionAttr("loginModel");
			setAttr("username", login.getUserName());
			setAttr("id", id);
		}
		render("view.jsp");
	}

	public void pageSave() {
		String id = getPara(0);
		T_Bus_EventDutyReport d = T_Bus_EventDutyReport.dao.findById(id);
		String filename = d.getStr("er_noyear") + "_" + d.getStr("er_no") + ".doc";
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("KBDZ", "UPDZ");
		String path = "upload/eventDutyReport";
		if(p != null) {
			path = p.getStr("p_acode");
		}
		if(!path.startsWith("/") && path.indexOf(":") != 1) {
			path = PathKit.getWebRootPath() + "/" + path;
		}
		path = path + "/" + filename;
		com.zhuozhengsoft.pageoffice.FileSaver fs = new com.zhuozhengsoft.pageoffice.FileSaver(getRequest(), getResponse());
		fs.saveToFile(path);
		fs.close();
		//保存地址
		d.set("conurl", path);
		d.update();
		renderNull();
	}
}
