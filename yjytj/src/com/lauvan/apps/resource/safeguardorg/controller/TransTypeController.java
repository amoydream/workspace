package com.lauvan.apps.resource.safeguardorg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_TransTool;
import com.lauvan.apps.resource.safeguardorg.model.T_Bus_TransType;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;
/**
 * 运输工具型号管理
 * @author zhouyuanhuan
 *
 */

@RouteBind(path="Main/transtype", viewPath="/resource/safeguardorg/transtype")
public class TransTypeController extends BaseController{

	public void index(){
		renderJsp("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String transcode = getPara("transtype"); //运输工具型号
		String transwaycode = getPara("transwaycode"); //运输方式
		Page<Record> page = T_Bus_TransType.dao.getPage(pageSize, pageNumber, transcode, transwaycode);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		renderJsp("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Bus_TransType transtype = T_Bus_TransType.dao.findById(id);
		setAttr("transtype", transtype);
		renderJsp("edit.jsp");
	}
	
	public void save(){
		T_Bus_TransType transtype = getModel(T_Bus_TransType.class);
		boolean success = false;
		try {
			if(transtype.get("transtypeid") == null){
				success = T_Bus_TransType.dao.insert(transtype);
			}else{
				success = T_Bus_TransType.dao.upd(transtype);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "transtypeDialog", "transtype_data", "closeCurrent");
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
			String idStr = ArrayUtils.ArrayToString(ids);
			List<T_Bus_TransType> typelist = T_Bus_TransType.dao.getListByIds(idStr);
			boolean flag = true;
			for(T_Bus_TransType t: typelist){
				if(T_Bus_TransTool.dao.isExistBytranstype(t.getNumber("transtypeid").intValue())){
					msg += "，" + t.getStr("transtype");
					flag = false;
				}
			}
			if(flag){
				T_Bus_TransType.dao.deleteByIds(idStr);
				success = true;
				errorCode = "info";
			}else{
				msg = "【" + msg.substring(1) +"】，以上运输工具类型被运输工具引用，不能删除！";
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
		T_Bus_TransType transtype = T_Bus_TransType.dao.findById(id);
		setAttr("transtype", transtype);
		renderJsp("view.jsp");
	}
}
