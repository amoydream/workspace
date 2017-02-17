package com.lauvan.base.basemodel.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.jfinal.core.Controller;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.JsonUtil;
import com.lauvan.util.Pwd;

@RouteBind(path = "/Main/user", viewPath = "/base/basemodel/user")
public class UserController extends Controller {

	public void index(){
		
		List<Record> deptList= T_Sys_Department.dao.getAllDepartments();
		String deptJson=JsonKit.toJson(deptList);

		setAttr("deptJson", deptJson);
		render("list.jsp");
	}
	
	public void add(){
		Integer pid=getParaToInt(0);
		
		setAttr("pid", pid);
		render("add.jsp");
	}
	
	public void edit(){
		Integer id=getParaToInt(0);
		T_Sys_User user=T_Sys_User.dao.findById(id);
		//String password = Pwd.decrypt(user.getStr("password"));
		//setAttr("password", password);
		setAttr("user", user);
		render("edit.jsp");
	}
	
	public void delete(){
		Integer[] ids=getParaValuesToInt("ids");
		
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		try{
			success=T_Sys_User.dao.delete(ids);
		}catch(Exception e){
			e.printStackTrace();
			errorCode="error";
			msg=e.getMessage();
		}
		finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
	
	public void save(){
		String act=getPara("act");
		boolean success=false;
		T_Sys_User model=getModel(T_Sys_User.class);
		String password = getPara("password");
		if(password!=null && !"".equals(password)){
			model.set("password", Pwd.encrypt(password));
		}
		if(act.equals("add")){
			model.set("user_id", AutoId.nextval(model));
			success=model.save();
		}else{
			success=model.update();
		}
		renderText("{\"success\":"+success+"}");
	}
	
	public void ifExistAccount(){
		String code=getPara("account");
		Integer did=getParaToInt("uid");
		boolean flag=T_Sys_User.dao.ifExsitAccount(code, did);
		
		renderJson("{\"success\":"+flag+"}");
	}
	
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		Integer pid=getParaToInt("pid");
		StringBuffer str = new StringBuffer();
		if(pid!=null){
			str.append("dept_id="+pid);
		}
		String uname = getPara("uname");
		String uaccount = getPara("uaccount");
		if(uname!=null && !"".equals(uname)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append(" user_name like '%").append(uname).append("%' ");
		}
		if(uaccount!=null && !"".equals(uaccount)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append(" user_account like '%").append(uaccount).append("%' ");
		}
		//获取表格表页数据
		Page<Record> page=Paginate.dao.getPage("t_sys_user", pageSize, pageNumber, str.toString(), "orderid", "asc");
		//LoginModel login = getSessionAttr("loginModel");
		//Page<Record> page = Paginate.dao.getServicePage(pageSize, pageNumber, "t_sys_user", login.getOrgId().toString(), "and s.dept_id="+pid, "s.user_id", null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	//导入用户
	public void importuser(){
		render("import.jsp");
	}
	public void importuserSave(){
		//获取导入文件
		String saveDirectory = JFWebConfig.saveDirectory ;
		int maxPostSize = JFWebConfig.maxPostSize;
		UploadFile file = getFile("file",saveDirectory,maxPostSize);
		File f = file.getFile();
		Map<String,Object> result = new HashMap<String,Object>();
		LoginModel loginModel = getSessionAttr("loginModel");
		try {
			jxl.Workbook wb = jxl.Workbook.getWorkbook(f);
			jxl.Sheet sheet = wb.getSheet(0);
			if(sheet == null){
				result.put("success",false);
				result.put("msg","导入用户信息异常，请联系管理员！");
				renderJson(result);
				return;
			}
			int rows = sheet.getRows();
			
			//存放错误记录编号
			StringBuffer errorNum = new StringBuffer();
			//记录数据插入情况
			int error = 0 ;
			int success = 0;
			for(int i = 4; i < rows; i++){
				if(sheet.getCell(0,i).getContents() == null ||
						"".equals(sheet.getCell(0,i).getContents().toString())){
					break;
				}
				final int j = i;
				Boolean errorFlag = true;
				//检查用户名（英文+数字）格式
				String regDld = "^[0-9a-zA-Z]{1,255}$";
				if("".equals(sheet.getCell(0,j).getContents().toString()) ||
						!sheet.getCell(0,j).getContents().toString().matches(regDld)){
					errorNum.append(","+(j+1)).append("行：登录账号格式错误，格式（英文+数字）");
					//错误记录+1
					error++;
					errorFlag = false;
				}
				//检查姓名是否为空
				if("".equals(sheet.getCell(1,j).getContents().toString())){
					//错误记录+1
					if(errorFlag){
						errorNum.append(","+(j+1)).append("行：姓名为空");
						error++;
						errorFlag = false;
					}else{
						errorNum.append("、姓名为空");
					}
					
				}
				//检验部门格式是否正确
				String departName = 
						sheet.getCell(2,j).getContents().toString();
				T_Sys_Department organ = T_Sys_Department.dao.getDepartByName(departName, loginModel.getRootOrgId()==null?null:loginModel.getRootOrgId().toString()) ;
				if("".equals(departName)){
					if(errorFlag){
						errorNum.append(","+(j+1)).append("行：部门为空");
						//错误记录+1
						error++;
						errorFlag = false;
					}else{
						errorNum.append("、部门为空");
					}
				}else{
					if(errorFlag){
						if(organ == null){
							errorNum.append(","+(j+1)).append("行：部门不存在当前局");;
							//错误记录+1
							error++;
							errorFlag = false;
						}
					}else{
						if(organ == null){
							errorNum.append("、部门不存在当前局");
						}
					}
				}
				//判断用户名是否已存在
				boolean fuser = T_Sys_User.dao.ifExsitAccount(sheet.getCell(0,j).getContents().toString(), loginModel.getUserId().intValue());
				if(fuser){
					if(errorFlag){
						//用户已存在
						errorNum.append(","+(j+1)).append("行：该登录账号已存在");
						error++;
						errorFlag = false;
					}else{
						errorNum.append("、该登录账号已存在");
					}
				}
				if(errorFlag){
					//插入记录
					T_Sys_User user = new T_Sys_User();
					user.set("user_account", sheet.getCell(0,j).getContents().toString());
					user.set("user_name", sheet.getCell(1,j).getContents().toString());
					user.set("dept_id", organ.get("d_id"));
					user.set("status", "1");
					user.set("password", Pwd.encrypt("123456"));
					user.set("user_id", AutoId.nextval(user));
					user.save();
					success++;
				}
			}
			f.delete();
			result.put("success",true);
			result.put("msg","用户信息导入完成！数据总共有" + (error+success) + "行，导入成功" + success + "行,失败"+error+"行!");
			
			if(!"".equals(errorNum.toString())){
				String errorStr = errorNum.length()>0?errorNum.substring(1):"";
				errorStr = errorStr.replaceAll(",", "</br>");
				result.put("errorStr",errorStr);
			}
			
			renderJson(result);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success",false);
			result.put("msg","导入异常，请联系管理员！");
			renderJson(result);
		}
		
	}
}
