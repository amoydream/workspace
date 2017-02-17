package com.lauvan.apps.workcontact.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Clear;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.communication.linkman.model.T_Bus_Linkman;
import com.lauvan.apps.communication.linkman.model.T_Bus_Linkman_Qun;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

/**
 * @author Bob 组织机构控制器
 */
@RouteBind(path = "/Main/organcontact", viewPath = "/workcontact/baseworkcontact/organcontact")
public class OrganController extends BaseController {

	public void index() {
		render("main.jsp");
	}

	public void getTreeData() {
		String idKey = StringUtils.isBlank(getPara("idKey")) ? "id" : getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "pid" : getPara("pidKey");

		List<Record> organList = T_Bus_Organ.dao.getAllOrgans();

		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> row = new HashMap<String, Object>();
		Map<String, Object> root = new HashMap<String, Object>();

		root.put(idKey, "0");
		root.put("name", "组织机构");
		root.put(pidKey, "");
		dataList.add(root);

		for(Record de : organList) {
			row = new HashMap<String, Object>();
			row.put(idKey, de.get("or_id"));
			row.put("name", de.get("or_name"));
			row.put(pidKey, de.get("or_pid"));
			dataList.add(row);
		}
		renderJson(dataList);
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String pid = getPara("pid");
		String or_name = getPara("or_name");
		StringBuffer sqlWhere = new StringBuffer();
		if(pid != null && !"".equals(pid)) {
			sqlWhere.append("or_pid=" + pid);
		}
		if(or_name != null && !"".equals(or_name)) {
			if(pid != null && !"".equals(pid)) {
				sqlWhere.append(" and ");
			}
			sqlWhere.append("or_name like '%").append(or_name).append("%'");
		}
		// 获取表格表页数据
		Page<Record> page = Paginate.dao.getPage("t_bus_organ", pageSize, pageNumber, sqlWhere.toString(), "or_sort", "asc");
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void add() {
		Integer pid = getParaToInt(0);
		setAttr("pid", pid);
		render("add.jsp");
	}

	public void edit() {
		Integer id = getParaToInt(0);
		T_Bus_Organ model = T_Bus_Organ.dao.findById(id);

		setAttr("organ", model);
		render("edit.jsp");
	}

	public void save() {
		String act = getPara("act");
		boolean success = false;
		T_Bus_Organ model = getModel(T_Bus_Organ.class);
		if(StringUtils.isNotBlank(model.getStr("or_worknumber"))){
			String regEx="[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";  
			Pattern   p   =   Pattern.compile(regEx);     
			Matcher m   =   p.matcher(model.getStr("or_worknumber"));
			model.set("or_worknumber", m.replaceAll(",").trim());
		}
		if(act.equals("add")) {
			model.set("or_id", AutoId.nextval(model));
			success = model.save();
		} else {
			success = model.update();
		}
		renderText("{\"success\":" + success + ",\"or_id\":" + model.getBigDecimal("or_id") + ",\"or_name\":\"" + model.getStr("or_name") + "\"}");
	}

	public void delete() {
		Integer[] ids = getParaValuesToInt("ids");

		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			if(!T_Bus_Organ.dao.hasSonOrgan(ids)) {
				success = T_Bus_Organ.dao.delete(ids);
			} else {
				msg = "删除节点存在子机构信息";
				errorCode = "info";
			}
		} catch(Exception e) {
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

	public void getComboTree() {
		try {
			// Integer rootId=47;
			List<Record> organList = T_Bus_Organ.dao.getAllOrgans();

			String json = T_Bus_Organ.dao.getOrganTreeData(null, organList);
			System.out.println(json);
			renderText(json);
		} catch(Exception e) {
			e.printStackTrace();
			renderText("[]");
		}
	}

	public void importOrgan() {
		render("import1.jsp");
	}
	
	
	public void importSave() {
		int orgnamenum=getParaToInt("orgnamenum")-1;
		int sonamenum=getParaToInt("sonamenum")-1;
		int telnum=getParaToInt("telnum")-1;
		int faxnum=getParaToInt("faxnum")-1;
		int emailnum=getParaToInt("emailnum")-1;
		int addressnum=getParaToInt("addressnum")-1;
		String fjid=getPara("fjid");
		if(fjid==null||fjid.equals("")){
			toDwzText(false, "请上传附件！", "", "", "", "");
			return;
		}
		T_Attachment fj=T_Attachment.dao.findById(fjid);
		String url = fj.getStr("url");
		if(!url.startsWith("/") && url.indexOf(":") != 1) {
			url = PathKit.getWebRootPath() + "/" + url;
		}
		// 获取导入文件
		File file = new File(url);
		/*String saveDirectory = JFWebConfig.saveDirectory;
		int maxPostSize = JFWebConfig.maxPostSize;
		UploadFile file = getFile("file", saveDirectory, maxPostSize);
		File f = file.getFile();*/
		boolean sucsFlag = false;
		String message = "";
		String errorStr = "";
		try {
			jxl.Workbook wb = jxl.Workbook.getWorkbook(file);
			jxl.Sheet sheet = wb.getSheet(0);
			if(sheet == null) {
				toDwzText(false, "导入组织机构通讯信息异常，请联系管理员！", "", "", "", "");
				return;
			}
			int rows = sheet.getRows();
            int cols = sheet.getColumns();
			// 存放错误记录编号
			StringBuffer errorNum = new StringBuffer();
			// 记录数据插入情况
			int error = 0;
			int success = 0;
			for(int i = 3; i < rows; i++) {
				final int j = i;
				String orgname = null;
				String parentName = null;
				if(orgnamenum<cols){
					orgname = sheet.getCell(orgnamenum, j).getContents().toString();
					if(StringUtils.isBlank(orgname)){
						error++;
						 continue;
					 }
				}else{
					 error++;
					 continue;
				}
				if(sonamenum<cols){				
					parentName = sheet.getCell(sonamenum, i).getContents().toString();
				}
				T_Bus_Organ organ = T_Bus_Organ.dao.getOrganByName(orgname);
				T_Bus_Organ parent = T_Bus_Organ.dao.getOrganByName(parentName);
				// 如果组织机构已存在通讯信息则更新，否则添加
				if(organ != null) {
					if(StringUtils.isBlank(parentName)) {
						organ.set("or_pid", 0);
					} else if(StringUtils.isNotBlank(parentName) && parent == null) {
						errorNum.append(",第" + (j + 1)).append("行：系统内不存在上级部门'" + parentName + "'");
						error++;
						continue;
					} else {
						organ.set("or_pid", parent.getBigDecimal("or_id"));
					}

					organ.set("or_worknumber", telnum<cols?sheet.getCell(telnum, j).getContents().toString():null);
					organ.set("or_fax", faxnum<cols?sheet.getCell(faxnum, j).getContents().toString():null);
					organ.set("or_email", emailnum<cols?sheet.getCell(emailnum, j).getContents().toString():null);
					organ.set("or_address", addressnum<cols?sheet.getCell(addressnum, j).getContents().toString():null);
					organ.update();
					success++;

				} else {

					T_Bus_Organ organ1 = new T_Bus_Organ();
					organ1.set("or_name", orgname);
					organ1.set("or_worknumber", telnum<cols?sheet.getCell(telnum, j).getContents().toString():null);
					organ1.set("or_fax", faxnum<cols?sheet.getCell(faxnum, j).getContents().toString():null);
					organ1.set("or_email", emailnum<cols?sheet.getCell(emailnum, j).getContents().toString():null);
					organ1.set("or_address", addressnum<cols?sheet.getCell(addressnum, j).getContents().toString():null);
					if(StringUtils.isBlank(parentName)) {
						organ1.set("or_pid", 0);
					} else if(StringUtils.isNotBlank(parentName) && parent == null) {
						errorNum.append(",第" + (j + 1)).append("行：不存在上级部门'" + parentName + "'");
						error++;
						continue;
					} else {
						organ1.set("or_pid", parent.getBigDecimal("or_id"));
					}
					organ1.set("or_id", AutoId.nextval(organ1));
					organ1.save();
					success++;
				}

			}
			file.delete();
			sucsFlag = true;
			message="用户信息导入完成！数据总共有" + (error + success) + "行，导入成功" + success + "行,无效数据" + error + "行!";

			if(StringUtils.isNotBlank(errorNum.toString())) {
				errorStr = errorNum.length() > 0 ? errorNum.substring(1) : "";
				errorStr = errorStr.replaceAll(",", "</br>");
			} 

		} catch(Exception e) {
			e.printStackTrace();
			sucsFlag = false;
			message = "导入异常，请联系管理员！";
		}
		renderText("{\"success\":"+sucsFlag+",\"msg\":\""+message+"\",\"errorStr\":\""+errorStr+"\"}");
	}

	@Clear
	public void callview() {
		String worknum = getPara("worknum");
		String[] wnarr = StringUtils.split(worknum, ",");
		List<String> wnlist  = new ArrayList<String>();
		for(String str:wnarr){
			if(!"null".equals(str)&&StringUtils.isNotBlank(str)){				
				wnlist.add(str);
			}
		}			
		setAttr("wnlist", wnlist);
		render("callview.jsp");

	}

}
