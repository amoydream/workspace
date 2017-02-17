package com.lauvan.apps.communication.mobilefile.controller;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.gpsinfo.model.T_UserLocator;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/mobilefile", viewPath = "/communication/mobilefile")
public class MobileFileController extends BaseController {
	private static final Logger log = Logger.getLogger(MobileFileController.class);
	public void index() {
		render("main.jsp");
	}
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String id = getPara("pid");
		Page<Record> page;
		page = T_UserLocator.dao.getfileGridPage(pageNumber, pageSize,id);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void filedel(){
		String ids=getPara("ids");
		String[] id=ids.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		LoginModel loginModel=getSessionAttr("loginModel");
		Number userid=loginModel.getUserId();
		try {
		for(String i:id){
		T_UserLocator ul=T_UserLocator.dao.findById(i);
		//删除文件
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("MOBILEFILE", "UPDZ");
		String url = p.getStr("p_acode");
		if(url!=null&&!url.equals("")){
		if(!url.startsWith("/") && url.indexOf(":")!=1){
			url = PathKit.getWebRootPath() +(url.endsWith("/")||url.endsWith("\\")?url:(url+"/"))+ ul.getStr("path");
		}else{
			url = url.endsWith("/")||url.endsWith("\\")?url:(url+"/")+ ul.getStr("path");
		}
		File file = new File(url);
		if (file.exists()) {
			file.delete();
		}
		}
		ul.set("isupload", "0");
		ul.update();
		T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mobilefile/filedel", "delete",ul,getRequest());
		}
		success=true;								
		} catch (Exception e) {
			log.error(e.getMessage());
			errorCode="error";
			msg=e.getMessage();
			e.printStackTrace();
		}finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}	
	}
}
