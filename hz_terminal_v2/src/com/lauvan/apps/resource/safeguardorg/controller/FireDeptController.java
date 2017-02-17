package com.lauvan.apps.resource.safeguardorg.controller;

import java.math.BigDecimal;
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
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_FireDept;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 消防队管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/firedept", viewPath="/resource/safeguardorg/firedept")
public class FireDeptController extends BaseController{

	public void index(){
		//List<T_Bus_FireDept> fireList = T_Bus_FireDept.dao.getListById(null);
		//setAttr("fireList", fireList);
		renderJsp("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String firedeptname = getPara("firedeptname");
		String levelcode = getPara("levelcode");
		Integer pid = getParaToInt(0);
		Page<Record> page = T_Bus_FireDept.dao.getPage(pageSize, pageNumber, pid,firedeptname, levelcode);
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
		T_Bus_FireDept firedept = T_Bus_FireDept.dao.getById(id);
		setAttr("firedept", firedept);
		renderJsp("edit.jsp");
	}
	
	public void save(){
		T_Bus_FireDept firedept = getModel(T_Bus_FireDept.class);
		boolean success = false;
		try {
			firedept.set("fjid", getPara("fjid"));
			if(firedept.get("deptid") == null){
				firedept.set("superdept_id", getPara(0)); //上级行政机关ID
				success = T_Bus_FireDept.dao.insert(firedept);
			}else{
				success = T_Bus_FireDept.dao.upd(firedept);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				//if("0".equals(getPara(0)) || "0".equals(firedept.get("superdept_id").toString())){
				//	renderText("{\"success\":true, \"msg\":\"保存成功！\",\"dialogid\":\"firedeptDialog\", \"gridid\":\"firedept_data\", \"tabid\":\"消防队\",\"furl\":\"Main/firedept/index\"}");
				//}else{
					renderText("{\"success\":true, \"msg\":\"保存成功！\",\"dialogid\":\"firedeptDialog\", \"gridid\":\"firedept_data\", \"treeObj\":\"firedepttree\",\"reloadid\":" + 
							(getPara(0)==null?firedept.get("superdept_id"):getPara(0))+",\"idkey\":\"d_id\"}");
				//}
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
			if(ids[0] != null && !"".equals(ids[0])){
				BigDecimal supid = T_Bus_FireDept.dao.findById(ids[0]).getBigDecimal("superdept_id");
				if(supid.intValue() == 0){
					tips.put("reflashtab", true);
				}else{
					tips.put("reloadid", supid);
					tips.put("idkey", "d_id");
				}
			}
			String idStr = ArrayUtils.ArrayToString(ids);
			idStr = T_Bus_FireDept.dao.getChildIdsByDeptids(idStr);// 查找出所有下属id（包含自身id）
			String fjids = T_Bus_FireDept.dao.getfjidsByIds(idStr);
			if(fjids !=null && !"".equals(fjids)){
				T_Attachment.dao.deleteByIds(idStr);//删除附件
			}
			T_Bus_FireDept.dao.deleteByIds(idStr);
			success = true;
			errorCode = "info";
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally{
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			tips.put("treeObj", "firedepttree");
			renderJson(tips);
		}
	}
	
	public void view(){
		String id = getPara(0);
		T_Bus_FireDept firedept = T_Bus_FireDept.dao.getById(id);
		setAttr("firedept", firedept);
		renderJsp("view.jsp");
	}
	
	public void getTreeData(){
		String idKey = StringUtils.isBlank(getPara("idKey")) ? "d_id" :getPara("idKey");
		String pidKey = StringUtils.isBlank(getPara("pidKey")) ? "d_pid" : getPara("pidKey");
		List<Map<String, Object>> firList = new ArrayList<Map<String, Object>>();
		String sql = " 1=1";
		if(getPara(idKey) != null && !"".equals(getPara(idKey))){
			sql += " and superdept_id= " + getPara(idKey);
		}else{
			Map<String, Object> root = new HashMap<String, Object>();
			root.put(idKey, "0");
			root.put("name", "消防机关");
			root.put(pidKey, "");
			firList.add(root);
			
		}
		sql += " order by deptid";
		List<Record> list = Paginate.dao.getList("T_Bus_FireDept", sql);
		Map<String, Object> node = null;
		
		for(Record r : list){
			node = new HashMap<String, Object>();
			node.put(idKey, r.get("deptid"));
			node.put("name", r.get("deptname"));
			node.put(pidKey, r.get("superdept_id") == null ? 0: r.get("superdept_id"));
			firList.add(node);
		}
		renderJson(firList);
	}

}
