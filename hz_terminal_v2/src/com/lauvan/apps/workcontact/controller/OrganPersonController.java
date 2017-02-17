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
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.apps.workcontact.model.T_Bus_OrganPerson;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;

/**
 * 日常机构人员控制器 
 * @author Bob
 */
@RouteBind(path = "/Main/personcontact", viewPath = "/workcontact/baseworkcontact/personcontact")
public class OrganPersonController extends BaseController {

	public void index() {
		render("main.jsp");
	}

	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String p_orid = getPara("p_orid");
		String p_name = getPara("p_name");
		String p_position = getPara("p_position");
		StringBuffer sqlWhere = new StringBuffer();
		if(p_orid!=null && !"".equals(p_orid)){
		  if(!"0".equals(p_orid)){	
		    List<Record> oridList = T_Bus_Organ.dao.getAllChildId(p_orid);
		    String ids = null;
			if(oridList.size()>0){
				 String strings[]=new String[oridList.size()];
				 for(int i=0,j=oridList.size();i<j;i++){
				     strings[i]=oridList.get(i).get("or_id").toString();
				 }
				 ids = StringUtils.join(strings, ",");
			} 			  
		  sqlWhere.append("p_orid in(" +ids+")");
		  }
		}		
		if(p_name!=null && !"".equals(p_name)){
			if(p_orid!=null && !"".equals(p_orid)){
				sqlWhere.append(" and ");
			}
			sqlWhere.append("p_name like '%").append(p_name).append("%'");
		}
		if(p_position!=null && !"".equals(p_position)){
			if((p_orid!=null && !"".equals(p_orid))||(p_name!=null && !"".equals(p_name))){
				sqlWhere.append(" and ");
			}
			sqlWhere.append("p_position like '%").append(p_position).append("%'");
		}
		// 获取表格表页数据
		Page<Record> page = T_Bus_OrganPerson.dao.getPage(pageSize, pageNumber, sqlWhere.toString(), "P_SORT", "ASC");
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
		T_Bus_OrganPerson person = T_Bus_OrganPerson.dao.findById(id);
		setAttr("person", person);
		render("edit.jsp");
	}

	public void save() {
		String act = getPara("act");
		String[] positionids = getParaValues("p_position");
		String pids = StringUtils.join(positionids,",");
		boolean success = false;
		T_Bus_OrganPerson model = getModel(T_Bus_OrganPerson.class);
		String regEx="[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";  
		Pattern   p   =   Pattern.compile(regEx);     
		Matcher   m   =   null;
		if(StringUtils.isNotBlank(model.getStr("p_homenumber"))){
			m   =   p.matcher(model.getStr("p_homenumber"));
			model.set("p_homenumber", m.replaceAll(",").trim());
		}
		if(StringUtils.isNotBlank(model.getStr("p_worknumber"))){
			m   =   p.matcher(model.getStr("p_worknumber"));
			model.set("p_worknumber", m.replaceAll(",").trim());
		}
		
		if(StringUtils.isNotBlank(model.getStr("p_mobile"))){		
			m   =   p.matcher(model.getStr("p_mobile"));
			model.set("p_mobile", m.replaceAll(",").trim());
		}
		if (act.equals("add")) {
			model.set("p_position", pids);
			model.set("p_id", AutoId.nextval(model));
			success = model.save();
		} else {
			model.set("p_position", pids);
			success = model.update();
		}
		renderText("{\"success\":" + success + "}");
	}

	public void delete() {
		Integer[] ids = getParaValuesToInt("ids");

		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			success = T_Bus_OrganPerson.dao.delete(ids);
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

	// 获取岗位类型树
	public void getTypeTree() {
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("RPOSITION",
					true);
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "p_acode");
			outputKey.put("text", "p_name");
			jsonStr = JsonUtil.getTreeData(list.get(0), true, list, "id",
					"sup_id", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}

	// 导入组织机构通讯信息
	public void importPerson() {
		render("import.jsp");
	}

	public void importSave() {
		// 获取导入文件
		String saveDirectory = JFWebConfig.saveDirectory;
		int maxPostSize = JFWebConfig.maxPostSize;
		UploadFile file = getFile("file", saveDirectory, maxPostSize);
		File f = file.getFile();
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			jxl.Workbook wb = jxl.Workbook.getWorkbook(f);
			jxl.Sheet sheet = wb.getSheet(0);
			if (sheet == null) {
				result.put("success", false);
				result.put("msg", "导入日常机构人员通讯信息异常，请联系管理员！");
				renderJson(result);
				return;
			}
			int rows = sheet.getRows();

			// 存放错误记录编号
			StringBuffer errorNum = new StringBuffer();
			// 记录数据插入情况
			int error = 0;
			int success = 0;
			for (int i = 4; i < rows; i++) {
				if (sheet.getCell(0, i).getContents() == null
						|| "".equals(sheet.getCell(0, i).getContents()
								.toString())) {
					break;
				}
				final int j = i;
                String orName = sheet.getCell(1, i).getContents().toString();
				boolean fuser = T_Bus_Organ.dao.ifExsitOrgan(orName);
				if (fuser) {
					T_Bus_OrganPerson person = new T_Bus_OrganPerson();
					T_Bus_Organ organ = T_Bus_Organ.dao.getOrganByName(sheet
							.getCell(1, j).getContents().toString());
					String aname = sheet.getCell(2, i).getContents().toString();		

					person.set("p_name", sheet.getCell(0, j).getContents()
							.toString());
					person.set("p_orid", organ.getBigDecimal("or_id"));
					if (StringUtils.isNotBlank(aname)) {
						T_Sys_Parameter param = T_Sys_Parameter.dao.getByCode(
								sheet.getCell(2, i).getContents().toString(),
								"RPOSITION");
						if (param != null) {
							person.set("p_position", param.getStr("P_ACODE"));
						}
					}
					person.set("p_worknumber", sheet.getCell(3, j).getContents()
							.toString());
					person.set("p_mobile", sheet.getCell(4, j).getContents()
							.toString());
					person.set("p_homenumber", sheet.getCell(5, j)
							.getContents().toString());
					person.set("p_fax", sheet.getCell(6, j).getContents()
							.toString());
					person.set("p_email", sheet.getCell(7, j).getContents()
							.toString());
					person.set("p_address", sheet.getCell(8, j).getContents()
							.toString());
					person.set("p_id", AutoId.nextval(person));
					person.save();
					success++;
				} else {
					if(StringUtils.isBlank(orName)){
					errorNum.append(",第" + (j + 1)).append("行：所属部门空白！"+orName);	
					}else{
					errorNum.append(",第" + (j + 1)).append("行：系统不存在部门："+orName);
					}
					error++;
				}

			}
			f.delete();
			result.put("success", true);
			result.put("msg", "用户信息导入完成！数据总共有" + (error + success) + "行，导入成功"
					+ success + "行,无效数据" + error + "行!");

			if (!"".equals(errorNum.toString())) {
				String errorStr = errorNum.length() > 0 ? errorNum.substring(1)
						: "";
				errorStr = errorStr.replaceAll(",", "</br>");
				result.put("errorStr", errorStr);
			}else{
				result.put("errorStr", "");	
			}

			renderJson(result);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("msg", "导入异常，导入模板可能不对应，请联系管理员！");
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
	
	//在事件中新增联系人
		public void getEPersonAdd(){
			String phone = getPara("phone");
			String flag = getPara("flag");
			if("check".equals(flag)){
				if(phone==null || "".equals(phone)){
					toDwzText(false, "请输入电话号码！", "", "", "","");
					return;
				}
				//判断电话是否已经存在
				boolean aflag = T_Bus_OrganPerson.dao.isExitNumber(phone);
				if(aflag){
					toDwzText(false, "该号码已经存在，请检查！", "", "", "","");
					return;
				}else{
					toDwzText(true, "", "", "", "","");
					return;
				}
			}
			
			String bgphone = getPara("worknum");
			String fax = getPara("fax");
			String phname = getPara("phname");
			setAttr("phone",phone);
			setAttr("worknumber",bgphone);
			setAttr("fax",fax);
			setAttr("phname",phname);
			render("edit_event.jsp");
		}
		
		public void ePersonSave(){
			try {
				T_Bus_OrganPerson t = getModel(T_Bus_OrganPerson.class);
				String phone = t.getStr("p_mobile");
				String bgphone = t.getStr("p_worknumber");
				String fax =  t.getStr("p_fax");
				
				T_Bus_OrganPerson p = null;
				if( (phone!=null && !"".equals(phone)) 
						|| (bgphone!=null && !"".equals(bgphone)) 
						|| (fax!=null && !"".equals(fax)) ){
					p = T_Bus_OrganPerson.dao.getByNumber(bgphone, phone, fax);
				}
				if(p!=null){
					toDwzText(false, "该联系信息已经存在，请检查！", "", "", "","");
					return;
				}
				String[] positionids = getParaValues("p_position");
				String pids = StringUtils.join(positionids, ",");
				t.set("p_position", pids);
				t.set("p_id", AutoId.nextval(t));
				t.save();
				toDwzText(true, "新增联系成功！", "", "_epersonAddDialog", "","closecurrent");
			} catch (Exception e) {
				toDwzText(false, "新增联系人异常，请检查！", "", "", "","");
				e.printStackTrace();
			}
		}

}