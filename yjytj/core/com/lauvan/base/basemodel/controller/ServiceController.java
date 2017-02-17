package com.lauvan.base.basemodel.controller;
/**
 * 业务表控制类
 * */
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_DataService;
import com.lauvan.base.basemodel.model.T_Sys_Module;
import com.lauvan.base.main.model.GridData;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path="Main/service",viewPath="/base/basemodel/service")
public class ServiceController extends BaseController {
	//主页
	public void index(){
		render("main.jsp");
	}
	public void getDataGrid(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String sname = getPara("sname");
		String scode = getPara("scode");
		StringBuffer str = new StringBuffer();
		if(sname!=null && !"".equals(sname)){
			str.append(" and s.servicename like '%").append(sname).append("%'");
		}
		if(scode!=null && !"".equals(scode)){
			str.append(" and s.servicetable  like '%").append(scode).append("%'");
		}
		
		Page<Record> page=T_Sys_DataService.dao.getPage( pageSize, pageNumber, str.toString(), "s.id", null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	//新增
	public void add(){
		render("add.jsp");
	}
	//修改
	public void edit(){
		String id = getPara(0);
		T_Sys_DataService s = T_Sys_DataService.dao.findById(id);
		setAttr("s",s);
		render("edit.jsp");
	}
	//删除
	public void delete(){
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="删除成功！";
		String errorCode="info";
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		try {
			/*T_Sys_DataService s = T_Sys_DataService.dao.findById(id);
			if(s!=null){
				s.delete();
			}else{
				errorCode="error";
				msg = "该业务不存在，请检查！";
			}*/
			success = T_Sys_DataService.dao.deleteByIds(ids);
		} catch (Exception e) {
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
	//保存
	public void save(){
		T_Sys_DataService s = getModel(T_Sys_DataService.class);
		String act = getPara("act");
		boolean success = false;
		if("add".equals(act)){
			success = T_Sys_DataService.dao.insert(s);
		}else{
			success = s.update();
		}
		if(success){
			toDwzText(success, "保存成功！", "", "serviceDialog", "serviceGrid", "closeCurrent");
		}else{
			toDwzText(success, "保存异常，请检查！", "", "", "", "");
		}
	}
	//功能模块树
	public void getModelTree(){
		String jsonStr = "";
		try {
			List<Record> list = T_Sys_Module.dao.getAllModel();
			Map<String,String> outputKey = new HashMap<String,String>();
			outputKey.put("id", "id");
			outputKey.put("text", "name");
			jsonStr=JsonUtil.getTreeData(null, false, list, "id", "p_id", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}
}
