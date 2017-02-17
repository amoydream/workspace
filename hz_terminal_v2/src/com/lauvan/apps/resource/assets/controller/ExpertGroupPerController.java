package com.lauvan.apps.resource.assets.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.assets.model.T_Bus_Expert;
import com.lauvan.apps.resource.assets.model.T_Bus_Expertgroup_Per;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path="Main/expertgroupper",viewPath="/resource/assets/expertgroup/per")
public class ExpertGroupPerController extends BaseController{
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String egId = getPara(0);//所属专家组id
		String sql = "t_bus_expertgroup_per e left join t_bus_expert n on e.expertid = n.ex_id where exgroupid="+egId;
		//获取表格表页数据
		Page<Record> page=Paginate.dao.getPage(pageSize, pageNumber, sql, null, null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void add(){
		String egId = getPara(0);
		setAttr("egId", egId);
		renderJsp("add.jsp");
	}
	
	public void save(){
		T_Bus_Expertgroup_Per person = getModel(T_Bus_Expertgroup_Per.class);
		boolean success = false;
		try {
			if(person.get("egp_id") == null){
				String egId = getPara(0); //获取专家组组织ID
				person.set("exgroupid",egId);
				person.set("egp_id", AutoId.nextval(person));
				success = person.save();
			}else{
				success = person.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "exgroupPerDialog", "exgroupPerGrid", "closeCurrent");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	public void edit(){
		Integer id=getParaToInt(0);
		T_Bus_Expertgroup_Per model = T_Bus_Expertgroup_Per.dao.findById(id);
		setAttr("model", model);
		
		String expertname = "";
		BigDecimal expertid = model.getBigDecimal("expertid");
		if(expertid!=null){
			T_Bus_Expert expert= T_Bus_Expert.dao.findById(model.getBigDecimal("expertid"));
			expertname= expert.getStr("name");
			setAttr("expertname",expertname);
		}
		
		renderJsp("edit.jsp");
	}
	
	public void delete(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Bus_Expertgroup_Per.dao.deleteByIds(idStr);
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
	
	public void getview(){
		Integer id=getParaToInt(0);
		T_Bus_Expertgroup_Per model = T_Bus_Expertgroup_Per.dao.findById(id);
		setAttr("model", model);
		
		String expertname = "";
		BigDecimal expertid = model.getBigDecimal("expertid");
		if(expertid!=null){
			T_Bus_Expert expert= T_Bus_Expert.dao.findById(model.getBigDecimal("expertid"));
			expertname= expert.getStr("name");
			setAttr("expertname",expertname);
		}
		
		renderJsp("view.jsp");
	}
	
	
}
