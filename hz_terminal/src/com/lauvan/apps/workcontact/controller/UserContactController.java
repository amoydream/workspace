package com.lauvan.apps.workcontact.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Clear;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import com.lauvan.apps.workcontact.model.T_Bus_ContactBook;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

/**
 * 机构人员通讯录控制器
 * @author Bob
 */
@RouteBind(path = "/Main/systemcontact/usercontact", viewPath = "/workcontact/baseworkcontact/systemcontact/usercontact")
public class UserContactController extends BaseController {

	public void main() {
		render("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String pid = getPara("pid");
		String userName = getPara("user_name");
		StringBuffer sql = new StringBuffer();
		//sql.append("t_sys_user u left join t_bus_contactbook b on b.bo_userid = u.user_id");
		/*String sql = "t_sys_user u left join t_bus_contactbook b on b.bo_userid = u.user_id where u.dept_id ="
				+ pid;*/
		// 获取表格表页数据
		if(pid != null && !"".equals(pid)) {
			sql.append(" u.dept_id =" + pid);
		}
		if(userName != null && !"".equals(userName)) {
			if(pid != null && !"".equals(pid)) {
				sql.append(" and ");
			}
			sql.append("u.user_name like '%").append(userName).append("%'");
		}
		Page<Record> page = T_Bus_ContactBook.dao.getUserPage(pageSize, pageNumber, sql.toString(), null, null);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	// 获取岗位类型树
	public void getTypeTree() {
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("EMPOSITION", true);
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "p_acode");
			outputKey.put("text", "p_name");
			jsonStr = JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
		} catch(Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}

	public void getBookGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		Integer pid = getParaToInt("pid");
		String sql = "t_sys_user u inner join t_bus_contactbook b on b.bo_userid = u.user_id where u.dept_id =" + pid;
		// 获取表格表页数据
		Page<Record> page = Paginate.dao.getPage(pageSize, pageNumber, sql, null, null);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void delete() {
		Integer[] ids = getParaValuesToInt("ids");
		LoginModel loginModel = getSessionAttr("loginModel");
		Number orgid = loginModel.getOrgId();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		
		try {
			if(isSameOrgan(ids, orgid)==false){
				errorCode = "error";
				msg = "不可以删除非本机构人员的通讯录！";
			}else{
			success = T_Bus_ContactBook.dao.delete(ids);
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

	// 导入机构人员通讯录
	public void importusercontact() {
		render("import.jsp");
	}

	public void importusercontactSave() {
		// 获取导入文件
		String saveDirectory = JFWebConfig.saveDirectory;
		int maxPostSize = JFWebConfig.maxPostSize;
		UploadFile file = getFile("file", saveDirectory, maxPostSize);
		File f = file.getFile();
		Map<String, Object> result = new HashMap<String, Object>();
		LoginModel loginModel = getSessionAttr("loginModel");
		try {
			jxl.Workbook wb = jxl.Workbook.getWorkbook(f);
			jxl.Sheet sheet = wb.getSheet(0);
			if(sheet == null) {
				result.put("success", false);
				result.put("msg", "导入用户通讯信息异常，请联系管理员！");
				renderJson(result);
				return;
			}
			int rows = sheet.getRows();

			// 存放错误记录编号
			StringBuffer errorNum = new StringBuffer();
			// 记录数据插入情况
			int error = 0;
			int success = 0;
			for(int i = 4; i < rows; i++) {
				if(sheet.getCell(0, i).getContents() == null || "".equals(sheet.getCell(0, i).getContents().toString())) {
					break;
				}
				final int j = i;
				// 判断用户是否已存在
				boolean fuser = T_Sys_User.dao.ifExsitAccount(sheet.getCell(0, i).getContents().toString(), loginModel.getUserId().intValue());
				if(fuser) {
					T_Sys_User user = T_Sys_User.dao.getUserByAccount(sheet.getCell(0, i).getContents().toString());
					T_Bus_ContactBook book = T_Bus_ContactBook.dao.getBookByUserId(user.getBigDecimal("USER_ID"));

					String aname = sheet.getCell(1, i).getContents().toString();
					// 如果用户已存在通讯信息则更新，否则添加
					if(book != null) {
						if(StringUtils.isNotBlank(aname)) {
							T_Sys_Parameter param = T_Sys_Parameter.dao.getByCode(sheet.getCell(1, i).getContents().toString(), "EMPOSITION");
							if(param != null) {
								book.set("bo_position", param.getStr("P_ACODE"));
							}
						}
						book.set("bo_worknumber", sheet.getCell(2, j).getContents().toString());
						book.set("bo_mobile", sheet.getCell(3, j).getContents().toString());
						book.set("bo_homenumber", sheet.getCell(4, j).getContents().toString());
						book.set("bo_fax", sheet.getCell(5, j).getContents().toString());
						book.set("bo_email", sheet.getCell(6, j).getContents().toString());
						book.set("bo_address", sheet.getCell(7, j).getContents().toString());
						book.update();
						success++;
					} else {
						T_Bus_ContactBook book1 = new T_Bus_ContactBook();
						if(StringUtils.isNotBlank(aname)) {
							T_Sys_Parameter param1 = T_Sys_Parameter.dao.getByCode(sheet.getCell(1, i).getContents().toString(), "EMPOSITION");
							if(param1 != null) {
								book1.set("bo_position", param1.getStr("P_ACODE"));
							}
						}
						book1.set("bo_worknumber", sheet.getCell(2, j).getContents().toString());
						book1.set("bo_mobile", sheet.getCell(3, j).getContents().toString());
						book1.set("bo_homenumber", sheet.getCell(4, j).getContents().toString());
						book1.set("bo_fax", sheet.getCell(5, j).getContents().toString());
						book1.set("bo_email", sheet.getCell(6, j).getContents().toString());
						book1.set("bo_address", sheet.getCell(7, j).getContents().toString());
						book1.set("bo_userid", user.getBigDecimal("USER_ID"));
						book1.set("bo_id", AutoId.nextval(book1));
						book1.save();
						success++;
					}
				} else {
					errorNum.append(",第" + (j + 1)).append("行：不存在该用户");
					error++;
				}

			}
			f.delete();
			result.put("success", true);
			result.put("msg", "系统应急人员用户通讯信息导入完成！数据总共有" + (error + success) + "行，导入成功" + success + "行,不存在的系统应急人员用户" + error + "行!");

			if(!"".equals(errorNum.toString())) {
				String errorStr = errorNum.length() > 0 ? errorNum.substring(1) : "";
				errorStr = errorStr.replaceAll(",", "</br>");
				result.put("errorStr", errorStr);
			} else {
				result.put("errorStr", "");
			}

			renderJson(result);
		} catch(Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("msg", "导入异常，请联系管理员！");
			renderJson(result);
		}
	}

	@Clear
	public void callview() {
		String worknum = getPara("worknum");
		String mobilenum = getPara("mobilenum");
		String homenum = getPara("homenum");	
		String[] wnarr = StringUtils.split(worknum, ",");
		String[] mnarr = StringUtils.split(mobilenum,",");
		String[] hnarr = StringUtils.split(homenum,",");
		List<String> wnlist  = new ArrayList<String>();
		List<String> mnlist  = new ArrayList<String>();
		List<String> hnlist  = new ArrayList<String>();
		for(String str:wnarr){
			if(!"null".equals(str)&&StringUtils.isNotBlank(str)){				
				wnlist.add(str);
			}
		}
		for(String str:mnarr){
			if(!"null".equals(str)&&StringUtils.isNotBlank(str)){
			mnlist.add(str);
			}
		}
		for(String str:hnarr){		
           if(!"null".equals(str)&&StringUtils.isNotBlank(str)){	
			   hnlist.add(str);
			}
		}
		
		setAttr("wnlist", wnlist);
		setAttr("mnlist", mnlist);
		setAttr("hnlist", hnlist);
		render("callview.jsp");

	}
	
	//判断是否是同部门
	public boolean isSameOrgan(Integer[] ids,Number orgid){
		      boolean flag = true;
		      for(Integer id:ids){
		    	 T_Bus_ContactBook book = T_Bus_ContactBook.dao.findById(id);
		    	 if(book!=null){
		    		Number userid = book.getNumber("BO_USERID");
		    		T_Sys_User user = T_Sys_User.dao.findById(userid);
		    		if(user!=null){
		    			if(user.getNumber("DEPT_ID").intValue()!=orgid.intValue()){
		    				flag = false;
		    				return  flag;
		    			}
		    		}
		    		 
		    	 }
		      }
		    return flag;  
	}
	
	
}
