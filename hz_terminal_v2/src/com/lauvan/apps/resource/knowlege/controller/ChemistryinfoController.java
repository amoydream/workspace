package com.lauvan.apps.resource.knowlege.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.resource.knowlege.model.T_Bus_Chemdistinfo;
import com.lauvan.apps.resource.knowlege.model.T_Chemistryinfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;
/**
 * 危化品信息管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/chemistryinfo", viewPath="/resource/knowlege/chemistry/chemistryinfo")
public class ChemistryinfoController extends BaseController{

	public void index(){
		renderJsp("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String name = getPara("colName");
		String val = getPara("colVal");
		Page<Record> page = 
			T_Chemistryinfo.dao.getPage(pageSize, pageNumber, name, val);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("nowdate", nowdate);
		renderJsp("add.jsp");
	}
	
	public void edit(){
		String chemid = getPara(0);
		T_Chemistryinfo info = T_Chemistryinfo.dao.getById(chemid);
		setAttr("info", info);
		renderJsp("edit.jsp");
	}
	
	public void save(){
		T_Chemistryinfo info = getModel(T_Chemistryinfo.class);
		boolean success = false;
		try {
			if(info.get("chemid") == null){
				success = T_Chemistryinfo.dao.insert(info);
			}else{
				success = info.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "cheminfoDialog", "cheminfo_data", "closeCurrent");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	@Before(Tx.class)
	public void delete(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Chemistryinfo.dao.deleteByIds(idStr);
			//删除关联的危化品处置方式
			T_Bus_Chemdistinfo.dao.deleteByChemId(idStr);
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
	
	public void view(){
		String chemid = getPara(0);
		T_Chemistryinfo info = T_Chemistryinfo.dao.getById(chemid);
		//主要组成成分
		//T_Chemcompinfo compinfo = T_Chemcompinfo.dao.getByChemid(chemid);
		//setAttr("compinfo", compinfo);
		setAttr("info", info);
		renderJsp("view.jsp");
	}

}
