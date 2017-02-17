package com.lauvan.apps.resource.civil.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.resource.civil.model.T_Civisuccordep;
import com.lauvan.apps.resource.civil.model.T_Emsequinfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * @author zhouyuanhuan
 *民间救援设备管理
 */
@RouteBind(path="Main/emsequinfo", viewPath="/resource/emsequinfo")
public class EmsequinfoController extends BaseController{

	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String civid = getPara(0);//所属救援组织id
		String sqlWhere = null;
		if(civid != null && !"".equals(civid)){
			sqlWhere = " equteamno =" + civid;
		}
		Page<Record> page = Paginate.dao.getPage("t_emsequinfo",pageSize, pageNumber, sqlWhere, "equid", "desc");
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		String civid = getPara(0);
		setAttr("cid", civid);
		renderJsp("add.jsp");
	}
	
	public void save(){
		T_Emsequinfo info = getModel(T_Emsequinfo.class);
		boolean success = false;
		try {
			if(info.get("equid") == null){
				String civiid = getPara(0); //获取救援组织ID
				T_Civisuccordep c = T_Civisuccordep.dao.findById(civiid); //获取救援组织信息
				info.set("equteamno",c.get("deptid"));
				info.set("equteamname", c.getStr("deptname"));
				success = T_Emsequinfo.dao.insert(info);
			}else{
				if(info.get("equphoto") == null){
					info.set("equphoto", null);
				}
				success = info.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "equinfoDialog", "equinfo_data", "closeCurrent");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	public void edit(){
		String id = getPara(0);
		Record info = T_Emsequinfo.dao.getById(id);
		String url = info.getStr("url");
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("FJDZ", "UPDZ"); //转换图片路径
		if(p!=null && url != null
				&& (url.startsWith("/") || url.indexOf(":") == 1)){
			url = url.replace(p.getStr("p_acode"), "/yj/fjdoc");
			info.set("url", url);
			
		}
		setAttr("info", info);
		renderJsp("edit.jsp");
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
			String fjids = T_Emsequinfo.dao.getfjidsByids(idStr);
			T_Attachment.dao.deleteByIds(fjids); //删除附件
			T_Emsequinfo.dao.delByIds(idStr);
			errorCode = "info";
			success = true;
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
	
	public void getEquipList(){
		List<Record> list = T_Sys_Parameter.dao.getParamByCode("EQTYPE", true);
		setAttr("list", list);
		renderJsp("findData/equlist.jsp");
	}
	
}
