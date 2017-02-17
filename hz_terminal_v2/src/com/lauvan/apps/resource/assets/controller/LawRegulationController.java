package com.lauvan.apps.resource.assets.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.assets.model.T_Bus_LawRegulation;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

/**
 * 法律法规控制器
 * @author Bob
 *
 */
@RouteBind(path = "Main/lawrul", viewPath = "/resource/assets/lawrul")
public class LawRegulationController extends BaseController {

	public void main() {
		render("main.jsp");
	}

	public void getTreeData() {
		String idKey = StringUtils.isBlank(getPara("idKey")) ? "id"
				: getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "pid"
				: getPara("pidKey");
		List<T_Sys_Parameter> typelist = T_Sys_Parameter.dao
				.getChildByAcode("YJLAWRUL");
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> row = new HashMap<String, Object>();
		Map<String, Object> root = new HashMap<String, Object>();
		root.put(idKey, "0");
		root.put("name", "应急法律法规");
		root.put("p_acode", null);
		root.put(pidKey, "");
		dataList.add(root);
		for (T_Sys_Parameter de : typelist) {
			row = new HashMap<String, Object>();
			row.put(idKey, de.get("id"));
			row.put("name", de.get("p_name"));
			row.put("p_acode", de.get("p_acode"));
			row.put(pidKey, "0");
			dataList.add(row);
		}
		renderJson(dataList);

	}

	public void getComboTree() {
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("YJLAWRUL",
					true);
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "id");
			outputKey.put("text", "p_name");
			jsonStr = JsonUtil.getTreeData(list.get(0), true, list, "id",
					"sup_id", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String lr_title = getPara("lr_title");
		String lr_typeid = getPara("lr_typeid");
		// 获取表格表页数据
		StringBuffer sqlWhere = new StringBuffer();
		if(lr_typeid!=null && !"".equals(lr_typeid)){
		String lr_type = T_Sys_Parameter.dao.findById(lr_typeid).getStr("P_ACODE");
		sqlWhere.append("lr_type=" + lr_type);
		}
		if(lr_title!=null && !"".equals(lr_title)){
			if(lr_typeid!=null && !"".equals(lr_typeid)){
				sqlWhere.append(" and ");	
			}
			sqlWhere.append("lr_title like '%").append(lr_title).append("%'");
		}		
		Page<Record> page = Paginate.dao.getPage("t_bus_lawregulation",
				pageSize, pageNumber, sqlWhere.toString(), "lr_id", "asc");
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);

	}

	public void add() {
		Integer parid = getParaToInt(0);
		LoginModel login = getSessionAttr("loginModel");
		String lr_type = T_Sys_Parameter.dao.findById(parid).getStr("P_ACODE");
		setAttr("userid", login.getUserId());
		setAttr("lr_type", lr_type);
		setAttr("nowdate", DateTimeUtil.formatDate(new Date(),
				DateTimeUtil.Y_M_D_HMS_FORMAT));
		render("add.jsp");
	}

	public void edit() {
		Integer lr_id = getParaToInt(0);
		LoginModel login = getSessionAttr("loginModel");
		T_Bus_LawRegulation lr = T_Bus_LawRegulation.dao.findById(lr_id);
		List<T_Attachment> fileList = T_Attachment.dao.getListByIds(lr
				.getStr("lr_attachmentid"));
		setAttr("userid", login.getUserId());
		setAttr("lawrul", lr);
		setAttr("fileList", fileList);
		render("edit.jsp");
	}

	public void save() {
		String[] addidsArr = getParaValues("addfileids");
		String[] existidsArr = getParaValues("existfileids");
		String[] attidsArr = null;
		String attids = null;
		String act = getPara("act");
		boolean success = true;
		T_Bus_LawRegulation lr = getModel(T_Bus_LawRegulation.class);
		try {
			if ("add".equals(act)) {
				attids = StringUtils.join(existidsArr, ",");
				lr.set("lr_attachmentid", attids);
				lr.set("lr_id", AutoId.nextval(lr));
				success = lr.save();
			} else{
				attidsArr = (String[]) ArrayUtils
						.addAll(existidsArr, addidsArr);
				attids = StringUtils.join(attidsArr, ",");
				lr.set("lr_attachmentid", attids);
				success = lr.update();
			}
			if (success) {
				toDwzText(true, "保存成功！", "", "lawrulDialog", "lawrulGrid",
						"closeCurrent");
			} else{
				toDwzText(false, "保存异常！", "", "", "", "");
			}
		} catch (Exception e) {
			toDwzText(false, "程序异常！", "", "", "", "");
			e.printStackTrace();
		}

	}

	public void delete() {
		Integer[] ids = getParaValuesToInt("ids");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			success = T_Bus_LawRegulation.dao.delete(ids);
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
	
	public void addcloseDelete(){
		String[] existidsArr  = getParaValues("existfileids");
		oncloseDelete(existidsArr);
	}
	
	public void editcloseDelete(){
		String[] addidsArr = getParaValues("addfileids");
		oncloseDelete(addidsArr);
	}

	// 删除：直接关闭，但已经上传的文件
	public void oncloseDelete(String[] arr) {
		String[] idsArr = arr;				
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String code = "info";
		try {
			if (idsArr != null && !"".equals(idsArr)) {
				String idsStr = StringUtils.join(idsArr, ",");
				List<T_Attachment> attlist = T_Attachment.dao.getListByIds(idsStr);
				if (attlist != null) {
					for (T_Attachment model : attlist) {
						String url = model.getStr("url");
						if (!url.startsWith("/") && url.indexOf(":") != 1) {
							url = PathKit.getWebRootPath() + "/"
									+ model.getStr("url");
						}
						File file = new File(url);
						if (file.exists()) {
							file.delete();
						}
					success = model.delete();
					if(success){
						code = "success";
					 }
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			code = "error";
			msg = e.getMessage();
		} finally {
			map.put("msg", msg);
			map.put("code", code);
			renderText("{\"msg\":\""+msg+",\"code\":\""+ code+"\"}");
		}
	}
	
	public void view(){
		Integer id = getParaToInt(0);
		T_Bus_LawRegulation lr = T_Bus_LawRegulation.dao.findById(id);
		List<T_Attachment> fileList = T_Attachment.dao.getListByIds(lr
				.getStr("lr_attachmentid"));
		setAttr("lawrul", lr);
		setAttr("fileList", fileList);
		render("view.jsp");
		
	}
	
	
	// 打开文件
	public void getfileview() {
		String id = getPara(0);
		String type = getPara(1);
		LoginModel login = getSessionAttr("loginModel");
		Number uid = login.getUserId();
		T_Sys_User user = T_Sys_User.dao.findById(uid);
		T_Attachment attachment = T_Attachment.dao.findById(id);
		setAttr("newPath",
				PathKit.getWebRootPath() + "/" + attachment.getStr("URL"));
		setAttr("username", user.get("user_name"));
		setAttr("type", type);
		render("findData/fjview.jsp");
	}

	// 打开pdf
	public void getpdfview() {
		String id = getPara("id");
		String title = getPara("title");
		T_Attachment attachment = T_Attachment.dao.findById(id);
		setAttr("newPath",
				PathKit.getWebRootPath() + "/" + attachment.getStr("URL"));
		setAttr("title", title);
		render("findData/pdfview.jsp");
	}

}
