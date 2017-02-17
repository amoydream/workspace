package com.lauvan.apps.resource.safeguardorg.controller;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_CollDept;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_CollFund;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_SubCollFund;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;
/**
 * 募捐机构
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/colldept", viewPath="/resource/safeguardorg/colldept")
public class CollDeptController extends BaseController{

	public void index(){
		renderJsp("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String colldeptname = getPara("colldeptname"); //机构名称
		String depttype = getPara("colldepttype"); //机构类型
		Page<Record> page = T_Bus_CollDept.dao.getPage(pageSize, pageNumber, colldeptname, depttype);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		renderJsp("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Bus_CollDept dept = T_Bus_CollDept.dao.getById(id);
		setAttr("dept", dept);
		renderJsp("edit.jsp");
	}
	
	public void save(){
		T_Bus_CollDept dept = getModel(T_Bus_CollDept.class);
		boolean success = false;
		try {
			dept.set("fjid", getPara("fjid"));
			if(dept.get("deptid") == null){
				success = T_Bus_CollDept.dao.insert(dept);
			}else{
				success = T_Bus_CollDept.dao.upd(dept);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "colldeptDialog", "colldept_data", "closeCurrent");
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
			//删除募捐机构下的现存资金和分项资金记录
			T_Bus_CollFund.dao.deleteByDeptIds(idStr); //现存资金
			T_Bus_SubCollFund.dao.deleteByDeptIds(idStr); //分项资金
			String fjids = T_Bus_CollDept.dao.getfjidsByIds(idStr);
			if(fjids != null && !"".equals(fjids)){
				T_Attachment.dao.deleteByIds(fjids); //删除附件
			}
			T_Bus_CollDept.dao.deleteByIds(idStr);
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
		String id = getPara(0);
		T_Bus_CollDept dept = T_Bus_CollDept.dao.getById(id);
		setAttr("dept", dept);
		renderJsp("view.jsp");
	}
}
