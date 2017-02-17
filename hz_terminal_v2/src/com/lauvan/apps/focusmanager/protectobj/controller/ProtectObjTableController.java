package com.lauvan.apps.focusmanager.protectobj.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.focusmanager.protectobj.model.T_Bus_TableAttr;
import com.lauvan.apps.focusmanager.protectobj.model.T_Bus_TableForm;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/protectobjtable", viewPath = "/focusmanager/protectobjtable")
public class ProtectObjTableController extends BaseController {
	private static final Logger log = Logger.getLogger(ProtectObjTableController.class);
	public void index() {
		render("main.jsp");
	}
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String formname = getPara("formname");
		String formcode = getPara("formcode");
		Page<Record> page;
		page = T_Bus_TableForm.dao.getGridPage(pageNumber, pageSize,formname,formcode);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void getGridDataView(){
		String fcode = getPara("fcode");
		List<Record> list = T_Bus_TableAttr.dao.getListByfcode(fcode);
		String json=JsonUtil.getGridData(list, list.size());
		renderText(json);
	}
	public void add(){
		render("add.jsp");
	}
	public void attrView(){
		String fname = getPara("fname");
		Integer rsize = getParaToInt("total");
		ArrayList<HashMap<String, String>> alist = new ArrayList<HashMap<String,String>>();
		if(rsize!=null && rsize>0){
			int count=0;
			for(int i=0;i<rsize;i++){
				String name = getPara("rows["+i+"][ATTRNAME]");
				String atype = getPara("rows["+i+"][SQLTYPE]");
				String remark = getPara("rows["+i+"][REMARK]");
				HashMap<String,String> map = new HashMap<String,String>();
				map.put("attrname", name);
				map.put("sqltype", atype);
				map.put("acode", name);
				map.put("remark", remark);
				if("005".equals(atype)){
					count++;
				}
				map.put("seq", String.valueOf(i-count));
				if("006".equals(atype)){
					map.put("selcontent", getPara("rows["+i+"][SELCONTENT]"));
					map.put("selvalue", getPara("rows["+i+"][SELVALUE]"));
					map.put("selfalg", getPara("rows["+i+"][SELFALG]"));
				}
				alist.add(0, map);
			}
			setAttr("alist",alist);
			setAttr("fname",fname);
			//根据属性展示表单
			render("view.jsp");
		}else{
			renderNull();
		}
	}
	public void save(){
		T_Bus_TableForm btf = getModel(T_Bus_TableForm.class);
		String fcode = btf.getStr("fcode");
		//插入表单记录
		T_Bus_TableForm.dao.insert(btf);
		//获取表单属性并保存表单属性
		Integer fnum = getParaToInt("fnum");
		if(fnum!=null && fnum>0){
			for(int i=0;i<fnum;i++){
				T_Bus_TableAttr attr = new T_Bus_TableAttr();
				attr.set("attrname", getPara("_attrname_"+i));
				attr.set("acode", getPara("_attrname_"+i));
				attr.set("sqltype", getPara("_sqltype_"+i));
				if(getPara("_isnull_"+i)!=null&&!"".equals(getPara("_isnull_"+i))){
				attr.set("isnull", getPara("_isnull_"+i));
				}else{
				attr.set("isnull","0");	
				}
				attr.set("numgs", getPara("_numgs_"+i));
				attr.set("selcontent", getPara("_selcontent_"+i));
				attr.set("selvalue", getPara("_selvalue_"+i));
				attr.set("selfalg", getPara("_selfalg_"+i));
				attr.set("remark", getPara("_remark_"+i));
				if(getPara("_attrsize_"+i)!=null&&!"".equals(getPara("_attrsize_"+i))){
				attr.set("attrsize", getPara("_attrsize_"+i));	
				}
				if(getPara("_isview_"+i)!=null&&!"".equals(getPara("_isview_"+i))){
				attr.set("isview", getPara("_isview_"+i));
				}else{
				attr.set("isview","1");	
				}
				attr.set("fcode", fcode);
				T_Bus_TableAttr.dao.insert(attr);
			}
		}
		//创建表
		boolean flag = T_Bus_TableForm.dao.createTable(fcode);
		if(!flag){
			T_Bus_TableForm.dao.deleteByFcode(fcode);
			T_Bus_TableAttr.dao.deleteByFcode(fcode);
			renderText("{\"success\":false,\"msg\":\"建表不成功，请重新建表单！\"}");
		}else{
			renderText("{\"success\":true,\"msg\":\"建表成功！\",\"dialogid\":\"proobjtableDialog\",\"gridid\":\"proobjtablegrid\"}");
			
		}
	}
	//校验表单编码是否唯一
		public void check(){
			String signcode = getPara("signcode");
			T_Bus_TableForm f = T_Bus_TableForm.dao.getByFcode(signcode);
			if(f!=null){
				renderText("false");
			}else{
				//判断该表在数据库中是否已存在
				if(T_Bus_TableForm.dao.isExit(signcode)){
					renderText("false");
				}else{
					renderText("true");
				}
			}
		}
		//查看
		public void view(){
			String id = getPara(0);
			T_Bus_TableForm f = T_Bus_TableForm.dao.findById(id);
			if(f!=null){
				String fname = f.getStr("fname");
				setAttr("fname",fname);
				String fcode = f.getStr("fcode");
				List<Record> alist = T_Bus_TableAttr.dao.getViewByFcode(fcode);
				setAttr("alist",alist);
				render("view.jsp");
			}else{
				renderText("该表单不存在，请检查！");
			}
		}
		//删除
		public void delete(){
			String ids=getPara("ids");
			String[] id=ids.split(",");
			Map<String,Object> map = new HashMap<String,Object>();
			boolean success=false;
			String msg="";
			String errorCode="info";
			try {
				for(String i:id){
				T_Bus_TableForm f = T_Bus_TableForm.dao.findById(i);
				if(f!=null){
					String fcode = f.getStr("fcode");
					//查询当前表单是否有数据
					if(T_Bus_TableForm.dao.isData(fcode)){
						//禁用
						f.set("status", "00X");
						f.update();
					}else{
						//删除表单
						T_Bus_TableForm.dao.deleteByFcode(fcode);
						T_Bus_TableAttr.dao.deleteByFcode(fcode);
						//删除表
						T_Bus_TableForm.dao.droptable(fcode);
					}
				
					success=true;
				}else{
					errorCode="error";
					msg="该表单不存在，请检查！";
				}
				}
			} catch (Exception e) {
				errorCode="error";
				msg=e.getMessage();
				e.printStackTrace();
				e.printStackTrace();
			}finally{
				map.put("success", success);
				map.put("msg", msg);
				map.put("errorcode", errorCode);
				renderJson(map);
			}	
		}
}
