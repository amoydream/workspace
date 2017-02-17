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
		if(p_orid != null && !"".equals(p_orid)) {
			if(!"0".equals(p_orid)) {
				List<Record> oridList = T_Bus_Organ.dao.getAllChildId(p_orid);
				String ids = null;
				if(oridList.size() > 0) {
					String strings[] = new String[oridList.size()];
					for(int i = 0, j = oridList.size(); i < j; i++) {
						strings[i] = oridList.get(i).get("or_id").toString();
					}
					ids = StringUtils.join(strings, ",");
				}
				sqlWhere.append("p_orid in(" + ids + ")");
			}
		}
		if(p_name != null && !"".equals(p_name)) {
			if(p_orid != null && !"".equals(p_orid)) {
				sqlWhere.append(" and ");
			}
			sqlWhere.append("p_name like '%").append(p_name).append("%'");
		}
		if(p_position != null && !"".equals(p_position)) {
			if(p_orid != null && !"".equals(p_orid) || p_name != null && !"".equals(p_name)) {
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
		String pids = StringUtils.join(positionids, ",");
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
		if(act.equals("add")) {
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

	// 获取岗位类型树
	public void getTypeTree() {
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("RPOSITION", true);
			Map<String, String> outputKey = new HashMap<String, String>();
			outputKey.put("id", "p_acode");
			outputKey.put("text", "p_name");
			jsonStr = JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
		} catch(Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}

	// 导入组织机构通讯信息
	public void importPerson() {
		String orid = getPara(0);
		setAttr("orpid", orid);
		render("import1.jsp");
	}

	public void importSave() {
		String orpid = getPara("orpid");
		int namenum=getParaToInt("namenum")-1;
		int organum=getParaToInt("organum")-1;
		int positionum=getParaToInt("positionum")-1;
		int worknum=getParaToInt("worknum")-1;
		int phonenum=getParaToInt("phonenum")-1;
		int homenum=getParaToInt("homenum")-1;
		int faxnum=getParaToInt("faxnum")-1;
		int emailnum=getParaToInt("emailnum")-1;
		int addressnum=getParaToInt("addressnum")-1;
		String fjid=getPara("fjid");
		if(fjid==null||fjid.equals("")){
			toDwzText(false, "请上传附件！", "", "", "", "");
			return;
		}		
		if(StringUtils.isBlank(orpid)){
			toDwzText(false, "请选中机构节点！", "", "", "", "");
			return;	
		}
		T_Attachment fj=T_Attachment.dao.findById(fjid);
		String url = fj.getStr("url");
		if(!url.startsWith("/") && url.indexOf(":") != 1) {
			url = PathKit.getWebRootPath() + "/" + url;
		}
		// 获取导入文件
		File file = new File(url);
		
		// 获取导入文件
		/*String saveDirectory = JFWebConfig.saveDirectory;
		int maxPostSize = JFWebConfig.maxPostSize;
		UploadFile file = getFile("file", saveDirectory, maxPostSize);
		File f = file.getFile();*/
		boolean sucsflag = false;
		String message = "";
		String errorStr = "";
		try {
			jxl.Workbook wb = jxl.Workbook.getWorkbook(file);
			jxl.Sheet sheet = wb.getSheet(0);
			if(sheet == null) {
				toDwzText(false, "导入日常机构人员通讯信息异常，请联系管理员！", "", "", "", "");
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
				String pname = null;
				String orName = null;
				String positname = null;
				if(namenum<cols){
					pname = sheet.getCell(namenum, j).getContents().toString();
				if(StringUtils.isBlank(pname)){
					error++;
					 continue;
				 }
				}
				if(organum<cols){
					orName = sheet.getCell(organum, j).getContents().toString();
				}
				if(StringUtils.isBlank(orName)){
					  error++;
					  continue;
				}else{
					T_Bus_OrganPerson person = new T_Bus_OrganPerson();
					T_Bus_Organ organ = T_Bus_Organ.dao.getOrganByName(orName);				
					person.set("p_name", pname);
					if(organ!=null){
						person.set("p_orid", organ.getBigDecimal("or_id"));						
					}else{					
							organ = new T_Bus_Organ();
							organ.set("or_name", orName);	
							organ.set("or_pid", orpid);
							Number neworid = AutoId.nextval(organ);
							organ.set("or_id", neworid);
							boolean sucs =	organ.save();
							if(sucs==true){
								person.set("p_orid", neworid);	 
							}else{
								continue;							  
							}						
					}
					if(positionum<cols){						
						positname = sheet.getCell(positionum, j).getContents().toString();
					}
					if(StringUtils.isNotBlank(positname)) {
						T_Sys_Parameter param = T_Sys_Parameter.dao.getByCode(positname, "RPOSITION");
						if(param != null) {
							person.set("p_position", param.getStr("P_ACODE"));
						}
					}
					person.set("p_worknumber", worknum<cols?sheet.getCell(worknum, j).getContents().toString():null);
					person.set("p_mobile", phonenum<cols?sheet.getCell(phonenum, j).getContents().toString():null);
					person.set("p_homenumber", homenum<cols?sheet.getCell(homenum, j).getContents().toString():null);
					person.set("p_fax", faxnum<cols?sheet.getCell(faxnum, j).getContents().toString():null);
					person.set("p_email", emailnum<cols?sheet.getCell(emailnum, j).getContents().toString():null);
					person.set("p_address", addressnum<cols?sheet.getCell(addressnum, j).getContents().toString():null);
					person.set("p_id", AutoId.nextval(person));
					person.save();
					success++;						
				}
				

			}
			file.delete();
			sucsflag = true;
			message = "用户信息导入完成！数据总共有" + (error + success) + "行，导入成功" + success + "行,无效数据" + error + "行!";
			errorStr = "";
			if(!"".equals(errorNum.toString())) {
				errorStr = errorNum.length() > 0 ? errorNum.substring(1) : "";
				errorStr = errorStr.replaceAll(",", "</br>");
				
			}

		} catch(Exception e) {
			e.printStackTrace();
			sucsflag = false;
			message = "导入异常，请联系管理员！";
		}
		renderText("{\"success\":"+sucsflag+",\"msg\":\""+message+"\",\"errorStr\":\""+errorStr+"\"}");

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