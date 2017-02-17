package com.lauvan.apps.resource.material.controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.material.model.T_Bus_Materialname;
import com.lauvan.apps.resource.material.model.T_Bus_Repertory;
import com.lauvan.apps.resource.material.model.T_Bus_Store;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

@RouteBind(path="Main/store",viewPath="/resource/material/store")
public class StoreController extends BaseController{
	public void index(){
		T_Sys_Parameter root = T_Sys_Parameter.dao.getByCode3("MATYPE");
		BigDecimal rootId = root.getBigDecimal("id");
		setAttr("rootId",rootId);
		render("main.jsp");
	}
	
	public void getTypeTree(){
		String dataList = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("MATYPE",true);
			Map<String,String> outputKey = new HashMap<String,String>();
			outputKey.put("id", "id");
			outputKey.put("name", "p_name");
			dataList=JsonUtil.getTreeData(list.get(0), false, list, "id", "sup_id", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(dataList);
	}
	
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		Integer pid=getParaToInt("pid");
		String maName = getPara("maName");
		String reName = getPara("reName");
		Integer departid  = getParaToInt(0);
		StringBuffer str = new StringBuffer();
		String sql = "t_bus_store u left join t_bus_repertory b on b.rep_id = u.repertoryid left join t_bus_materialname m on u.materialid= m.mn_id left join t_sys_parameter p on m.type= p.id where 1=1 ";
		str.append(sql);
		if(pid!=null && !"".equals(pid)){
			  str.append(" and id=" + pid);
			}
		
		if(maName!=null && !"".equals(maName)){
			str.append(" and mn_name like '%").append(maName).append("%'");
		}
		if(reName!=null && !"".equals(reName)){
			str.append(" and name like '%").append(reName).append("%'");
		}
		if(departid != null && departid !=0 ){
			str.append(" and u.organid=").append(departid);
		}
		Page<Record> page = Paginate.dao.getPage(pageSize, pageNumber, str.toString(),
				null, null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void add(){
		render("add.jsp");
	}
	
	public void edit(){
		Integer id=getParaToInt(0);
		T_Bus_Store model=T_Bus_Store.dao.findById(id);
		
		String repertoryname = "";
		BigDecimal repertoryid = model.getBigDecimal("repertoryid");
		if(repertoryid!=null){
			T_Bus_Repertory repertory= T_Bus_Repertory.dao.getRepertoryByRepid(model.getBigDecimal("repertoryid"));
			repertoryname= repertory.getStr("name");
		}
		setAttr("repertoryname",repertoryname);
		
		String materialname = "";
		BigDecimal meterialid = model.getBigDecimal("materialid");
		if(meterialid!=null){
			T_Bus_Materialname material= T_Bus_Materialname.dao.getMaterialByMaterialid(model.getBigDecimal("materialid"));
			materialname= material.getStr("mn_name");
		}
		setAttr("materialname",materialname);
		
		setAttr("model", model);
		render("edit.jsp");
	}
	
	public void save(){
		String act=getPara("act");
		boolean success=false;
		T_Bus_Store store=getModel(T_Bus_Store.class);
		if(act.equals("add")){
			store.set("sto_id", AutoId.nextval(store));
			store.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
			success=store.save();
		}else{
			store.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
			success=store.update();
		}
		if(success){
			toDwzText(success, "保存成功！","", "storeDialog", "storeGrid", "closeCurrent");
		}else{
			toDwzText(success, "保存异常！", "", "", "", "");
		}
	}
	
	public void delete(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Bus_Store.dao.deleteByIds(idStr);
			success = true;
			errorCode = "info";
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally{
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			renderJson(tips);
		}
	}
	
	public void getComboTree(){
		String jsonStr = "[]";
		try {
			List<Record> list = T_Sys_Parameter.dao.getParamByCode("MATYPE",true);
			Map<String,String> outputKey = new HashMap<String,String>();
			outputKey.put("id", "id");
			outputKey.put("text", "p_name");
			jsonStr=JsonUtil.getTreeData(list.get(0), true, list, "id", "sup_id", outputKey);
			renderText(jsonStr);
		} catch (Exception e) {
			e.printStackTrace();
			renderText("[]");
		}
	}
	
	public void getview(){
		Integer id=getParaToInt(0);
		T_Bus_Store model=T_Bus_Store.dao.findById(id);
		
		String repertoryname = "";
		BigDecimal repertoryid = model.getBigDecimal("repertoryid");
		if(repertoryid!=null){
			T_Bus_Repertory repertory= T_Bus_Repertory.dao.getRepertoryByRepid(model.getBigDecimal("repertoryid"));
			repertoryname= repertory.getStr("name");
		}
		setAttr("repertoryname",repertoryname);
		
		String materialname = "";
		BigDecimal meterialid = model.getBigDecimal("materialid");
		if(meterialid!=null){
			T_Bus_Materialname material= T_Bus_Materialname.dao.getMaterialByMaterialid(model.getBigDecimal("materialid"));
			materialname= material.getStr("mn_name");
		}
		setAttr("materialname",materialname);
		
		//所属单位
				String dept = model.get("organid")==null?null:model.get("organid").toString();
				if(dept!=null){
					T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
					if(d!=null){
					setAttr("organ",d.getStr("or_name"));
					}
				}
		
		setAttr("model", model);
		render("view.jsp");
	}
	
	
}
