package com.lauvan.apps.resource.safeguardorg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_TransFirm;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_TransTool;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 运输企业管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/transfirm", viewPath="/resource/safeguardorg/transfirm")
public class TransFirmController extends BaseController{

	public void index(){
		renderJsp("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String firmname = getPara("firmname"); //运输企业名称
		String levelcode = getPara("levelcode");//级别代码
		String classcode = getPara("classcode");//级别代码
		Page<Record> page = T_Bus_TransFirm.dao.getPage(pageSize, pageNumber, firmname, levelcode, classcode);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		renderJsp("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Bus_TransFirm firm = T_Bus_TransFirm.dao.getById(id);
		setAttr("firm", firm);
		renderJsp("edit.jsp");
	}
	
	public void save(){
		T_Bus_TransFirm firm = getModel(T_Bus_TransFirm.class);
		boolean success = false;
		try {
			firm.set("fjid", getPara("fjid"));
			if(firm.get("firmid") == null){
				success = T_Bus_TransFirm.dao.insert(firm);
			}else{
				success = T_Bus_TransFirm.dao.upd(firm);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "transfirmDialog", "transfirm_data", "closeCurrent");
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
			List<T_Bus_TransFirm> list = T_Bus_TransFirm.dao.getListByIds(idStr);
			boolean flag = true;
			for(T_Bus_TransFirm f : list){
				if(T_Bus_TransTool.dao.isExistByFirmname(f.getNumber("firmid").intValue())){
					msg += "，" + f.getStr("firmname");
					flag = false;
				}
			}
			if(flag){
				String fjids = T_Bus_TransFirm.dao.getfjidsByIds(idStr);
				if(fjids != null && !"".equals(fjids)){
					T_Attachment.dao.deleteByIds(fjids);
				}
				T_Bus_TransFirm.dao.deleteByIds(idStr);
				success = true;
				errorCode = "info";
			}else{
				msg = "【" + msg.substring(1) + "】，以上运输企业被运输工具引用，不能删除！";
			}
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
		T_Bus_TransFirm firm = T_Bus_TransFirm.dao.getById(id);
		setAttr("firm", firm);
		renderJsp("view.jsp");
	}
	
}
