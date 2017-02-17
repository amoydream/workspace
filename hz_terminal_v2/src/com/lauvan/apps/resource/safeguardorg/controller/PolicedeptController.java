package com.lauvan.apps.resource.safeguardorg.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_Policedept;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;
/**
 * 公安机关信息管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/policedept", viewPath="/resource/safeguardorg/policedept")
public class PolicedeptController extends BaseController{

	public void index(){
		////List<T_Bus_Policedept> deptlist = T_Bus_Policedept.dao.getAllList();
		//setAttr("deptlist", deptlist);
		renderJsp("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String deptname = getPara("deptname");
		String pid = "0".equals(getPara(0))?null:getPara(0);
		Page<Record> page = T_Bus_Policedept.dao.getPage(pageSize, pageNumber, deptname, pid);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		String supid = getPara(0);
		setAttr("supid", supid);
		renderJsp("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Bus_Policedept poldept = T_Bus_Policedept.dao.getById(id);
		setAttr("poldept", poldept);
		renderJsp("edit.jsp");
	}
	
	public void save(){
		T_Bus_Policedept policedept = getModel(T_Bus_Policedept.class);
		boolean success = false;
		try {
			policedept.set("fjid", getPara("fjid"));
			if(policedept.get("deptid") == null){
				policedept.set("superdept_id", getPara(0));
				success = T_Bus_Policedept.dao.insert(policedept);
			}else{
				success = T_Bus_Policedept.dao.upd(policedept);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				//toDwzText(success, "保存成功！", "", "policedeptDialog", "policedept_data", "closeCurrent");
				renderText("{\"success\":true, \"msg\":\"保存成功！\",\"dialogid\":\"policedeptDialog\", \"gridid\":\"policedept_data\", \"treeObj\":\"depttree\",\"reloadid\":" + 
						(getPara(0)==null?policedept.get("superdept_id"):getPara(0))+",\"idkey\":\"d_id\"}");
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
			idStr = T_Bus_Policedept.dao.getChildIdsByDeptids(idStr);//将下属部门deptid查找出来，删除时，下属部门也将删除
			String fjids = T_Bus_Policedept.dao.getfjidsByids(idStr);
			if(fjids != null && !"".equals(fjids)){
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_Policedept.dao.deleteByIds(idStr);//删除包含下属部门
			success = true;
			errorCode = "info";
		}catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally{
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			tips.put("reflashtab", true);
			renderJson(tips);
		}
	}
	
	public void view(){
		String id = getPara(0);
		T_Bus_Policedept poldept = T_Bus_Policedept.dao.getById(id);
		setAttr("poldept", poldept);
		renderJsp("view.jsp");
	}
	
	public void getTreeData(){
		String idKey = StringUtils.isBlank(getPara("idKey"))? "d_id": getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "d_pid":getPara("pidKey");
		List<Map<String, Object>> policeList = new ArrayList<Map<String, Object>>();
		String sql = " 1=1";
		if(getPara(idKey) != null && !"".equals(getPara(idKey))){
			sql += " and superdept_id =" + getPara(idKey);
		}else{
			Map<String, Object> root = new HashMap<String, Object>();
			root.put(idKey, "0");
			root.put("name", "公安机关");
			root.put(pidKey, "");
			policeList.add(root);
		}
		sql += " order by deptid ";
		List<Record> list = Paginate.dao.getList("T_Bus_Policedept", sql);
		Map<String, Object> node = null;
		
		for(Record r : list){
			node = new HashMap<String, Object>();
			node.put(idKey, r.get("deptid"));
			node.put("name", r.get("deptname"));
			node.put(pidKey, r.get("superdept_id") == null ?0:r.get("superdept_id"));
			policeList.add(node);
		}
		renderJson(policeList);
	}
}
