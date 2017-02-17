package com.lauvan.apps.resource.succore.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.succore.model.T_Succoremp_d;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;
/**
 * 志愿者个人简历管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/succorempd", viewPath="/resource/succorempd")
public class SuccorempdController extends BaseController{

	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String personid = getPara(0);
		Page<Record> page = T_Succoremp_d.dao.getPage( pageSize, pageNumber, personid);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		String nowdate = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		setAttr("personid", getPara(0));
		setAttr("nowdate",nowdate);
		renderJsp("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Succoremp_d d = T_Succoremp_d.dao.getByIds(id);
		setAttr("d", d);
		renderJsp("edit.jsp");
	}
	
	public void save(){
		T_Succoremp_d d = getModel(T_Succoremp_d.class);
		boolean success = false;
		try {
			if(d.get("persid") == null){
				d.set("personid", getPara(0));
				success = T_Succoremp_d.dao.insert(d);
			}else{
				success = d.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "succorempdDialog", "succorempd_data", "closeCurrent");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	public void delete(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			T_Succoremp_d.dao.deleteByIds(ArrayUtils.ArrayToString(ids));
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
}
