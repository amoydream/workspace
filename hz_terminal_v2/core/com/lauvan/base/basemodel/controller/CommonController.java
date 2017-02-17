package com.lauvan.base.basemodel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Module;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.GridData;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path="/Main/common",viewPath="/base/basemodel/common")
public class CommonController extends BaseController {
	public void index(){
		render("main.jsp");
	}
	
	public void getTreeGridData(){
		Integer pid=getParaToInt("pid");
		String str = "sup_id=0";
		if(pid!=null){
			str = "sup_id="+pid;
		}
		//str = str + " and ptype is null ";
		List<Record> list = GridData.dao.treeList("t_sys_parameter", "sup_id", "", str, "id", null);
		int totalCount=list!=null?list.size():0;
		String jsonStr=JsonUtil.getTreeGridData(list, totalCount, "sup_id");
		renderText(jsonStr);
	}
	
	public void add(){
		String pid = getPara(0);
		setAttr("pid",pid);
		render("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Sys_Parameter t = T_Sys_Parameter.dao.findById(id);
		setAttr("t",t);
		render("edit.jsp");
	}
	
	public void delete(){
		String[] ids=getParaValues("ids");
		ids = ArrayUtils.removeDuplicate(ids);
		String id = ArrayUtils.ArrayToString(ids);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="删除异常，请检查！";
		String errorCode="info";
		success = T_Sys_Parameter.dao.deleteByIds(id);
		if(success){
			msg = "删除成功！";
		}
		map.put("success", success);
		map.put("msg", msg);
		map.put("errorcode", errorCode);
		renderJson(map);
	}
	
	public void save(){
		String act = getPara("act");
		T_Sys_Parameter t = getModel(T_Sys_Parameter.class);
		String sup_id = t.get("sup_id").toString();
		boolean success = false;
		if("add".equals(act)){
			success = T_Sys_Parameter.dao.insert(t);
		}else{
			success = t.update();
		}
		if(success){
			toDwzText(success, "保存成功！", "commonGrid", "commonDialog", "", "closeCurrent",sup_id);
		}else{
			toDwzText(success, "保存异常！", "", "", "", "");
		}
	}
	/**
	 * 根据父级编码，获取参数数据列表
	 * */
	public void getStaticAttr(){
		String acode = getPara("acode");
		//List<T_Sys_Parameter> list = T_Sys_Parameter.dao.getChildByAcode(acode);
		List<Record> list = T_Sys_Parameter.dao.getParamByCode(acode,false);
		renderJson(list);
	}
	/**
	 * 系统参数转业务字典
	 * */
	public void changeBus(){
		String ids = getPara("ids");
		String sup = getPara("supid");
		List<Record> tlist = T_Sys_Parameter.dao.getListByIDS(ids);
		if(tlist!=null && tlist.size()>0){
			StringBuffer str = new StringBuffer();
			StringBuffer str2 = new StringBuffer();
			for(Record r : tlist){
				String id = r.get("id").toString();
				String name = r.getStr("p_name");
				if(str.length()>0){
					str.append(",");
					str2.append(",");
				}
				str.append(id);
				str2.append(name);
			}
			setAttr("tid",str.toString());
			setAttr("tname",str2.toString());
		}
		setAttr("sup_id",sup);
		render("changeBus.jsp");
	}
	
	public void changeBusSave(){
		try {
			String tids = getPara("tids");
			String sup_id = getPara("sup_id");
			//String modname = getPara("modname");
			String model_id = getPara("model_id");
			String modsel = getPara("modsel");
			//将该参数的状态改为00B
			T_Sys_Parameter.dao.updateType(tids, "00B");
			T_Sys_Parameter.dao.updateTypeIds(tids, "00B");
			//新建菜单
			if("0".equals(modsel)){
				modsel = "";
			}else{
				modsel = "-1";
			}
			int max = T_Sys_Module.dao.getMaxIndex(model_id);
			List<Record> tlist = T_Sys_Parameter.dao.getListByIDS(tids);
			if(tlist!=null && tlist.size()>0){
				max++;
				for(Record r : tlist){
					String pcode = r.getStr("p_acode");
					String pname = r.getStr("p_name");
					T_Sys_Module m = T_Sys_Module.dao.getByMark("busParam_"+pcode.toLowerCase());
					if(m!=null){
						m.set("name", pname);
						m.set("mark", "busParam_"+pcode.toLowerCase());
						m.set("address", "Main/busParam/main/"+pcode+modsel);
						m.set("p_id", model_id);
						m.set("opentype", "0");
						m.set("iconclass", "icon-applicationform");
						m.set("modeltype", "0");
						m.set("usable", "1");
						m.update();
					}else{
						m=new T_Sys_Module();
						m.set("name", pname);
						m.set("mark", "busParam_"+pcode.toLowerCase());
						m.set("address", "Main/busParam/main/"+pcode+modsel);
						m.set("p_id", model_id);
						m.set("opentype", "0");
						m.set("iconclass", "icon-applicationform");
						m.set("modeltype", "0");
						m.set("usable", "1");
						m.set("orderindex", max);
						String mid = AutoId.nextval(m).toString();
						m.set("id", mid);
						m.save();
						max++;
						//查看功能能点
						T_Sys_Module m1 = new T_Sys_Module();
						m1.set("name", "查看");
						m1.set("mark", "busParam_"+pcode.toLowerCase()+"View");
						m1.set("p_id", mid);
						m1.set("opentype", "0");
						m1.set("modeltype", "1");
						m1.set("usable", "1");
						m1.set("orderindex", 1);
						m1.set("id", AutoId.nextval(m1));
						m1.save();
					}
				}
			}
			toDwzText(true, "操作成功！", "commonGrid", "commonDialog", "", "closeCurrent",sup_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
