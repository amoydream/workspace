package com.lauvan.apps.workcontact.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Clear;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import com.lauvan.apps.workcontact.model.T_Bus_ContactBook;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

/**
 * @author Bob 组织机构通讯录控制器
 */
@RouteBind(path = "/Main/systemcontact/departmentcontact",
	viewPath = "/workcontact/baseworkcontact/systemcontact/departmentcontact")
public class DepartmentContactController extends BaseController {

	public void main() {
		render("main.jsp");
	}

	public void getGridData() {
		String sql = "t_sys_department d left join t_bus_contactbook b ON b.BO_DEPTID = d.D_ID";
		List<Record> list = Paginate.dao.getList(" * ", sql, "d.orderid", "asc");
		int totalCount = list.size();
		String jsonStr = JsonUtil.getTreeGridData(list, totalCount, "d_pid");
		renderText(jsonStr);
	}

	public void delete() {
		Integer[] ids = getParaValuesToInt("ids");

		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		LoginModel loginModel = getSessionAttr("loginModel");
		int orgid = loginModel.getOrgId().intValue();
		
		try {
			if(isSameDept(ids,orgid)==false){
				errorCode = "error";
			    msg = "登录用户不能删除非所属机构的通讯录！";
			}else{
			success = T_Bus_ContactBook.dao.deleteForDepart(ids);
			if(success == false) {
				msg = "此组织机构没有关联通讯录！";
			}
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

	// 导入组织机构通讯信息
	public void importdepartcontact() {
		render("import.jsp");
	}

	public void importdepartcontactSave() {
		// 获取导入文件
		String saveDirectory = JFWebConfig.saveDirectory;
		int maxPostSize = JFWebConfig.maxPostSize;
		UploadFile file = getFile("file", saveDirectory, maxPostSize);
		File f = file.getFile();
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			jxl.Workbook wb = jxl.Workbook.getWorkbook(f);
			jxl.Sheet sheet = wb.getSheet(0);
			if(sheet == null) {
				result.put("success", false);
				result.put("msg", "导入组织机构通讯信息异常，请联系管理员！");
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
				// 判断组织机构是否已存在
				T_Sys_Department depart = T_Sys_Department.dao.getDepartByName(sheet.getCell(0, i).getContents().toString(), null);
				if(depart != null) {
					T_Bus_ContactBook book = T_Bus_ContactBook.dao.getBookByDepartId(depart.getBigDecimal("D_ID"));
					// 如果组织机构已存在通讯信息则更新，否则添加
					if(book != null) {
						book.set("bo_worknumber", sheet.getCell(1, j).getContents().toString());
						book.set("bo_fax", sheet.getCell(2, j).getContents().toString());
						book.set("bo_email", sheet.getCell(3, j).getContents().toString());
						book.set("bo_address", sheet.getCell(4, j).getContents().toString());
						book.update();
						success++;
					} else {
						T_Bus_ContactBook book1 = new T_Bus_ContactBook();
						book1.set("bo_worknumber", sheet.getCell(1, j).getContents().toString());
						book1.set("bo_fax", sheet.getCell(2, j).getContents().toString());
						book1.set("bo_email", sheet.getCell(3, j).getContents().toString());
						book1.set("bo_address", sheet.getCell(4, j).getContents().toString());
						book1.set("bo_deptid", depart.getBigDecimal("D_ID"));
						book1.set("bo_id", AutoId.nextval(book1));
						book1.save();
						success++;
					}
				} else {
					errorNum.append("第" + (j + 1)).append("行：系统组织机构不存在该部门");
					error++;
				}

			}
			f.delete();
			result.put("success", true);
			result.put("msg", "应急机构通讯信息导入完成！数据总共有" + (error + success) + "行，导入成功" + success + "行,系统组织机构不存部门" + error + "行!");

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
	//是否相同部门
	public boolean isSameDept(Integer[] ids,int orgid){
		boolean flag = true;
		for(Integer id : ids){
			if(id!=orgid){
				flag = false;
				return flag;
			}
		}
		return flag;
	}

}
