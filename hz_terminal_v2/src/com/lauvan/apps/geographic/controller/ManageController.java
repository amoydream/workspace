package com.lauvan.apps.geographic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.jfinal.kit.JsonKit;
import com.lauvan.apps.geographic.model.T_Bus_MapConfig;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.core.annotation.RouteBind;

/**
 * 后台地图管理
 * @author chen  2016/06/06
 *
 */
@RouteBind(path="Main/geographic/manage",viewPath="/geographic/manage")
public class ManageController extends BaseController {

	public void index(){
		T_Bus_MapConfig model=T_Bus_MapConfig.dao.getData();
		
		List<T_Sys_Parameter> paramList=T_Sys_Parameter.dao.getChildByAcode("OFFLINEGIS");
		String gisUrl="",apiUrl="",tempStr,value;
		for(T_Sys_Parameter param:paramList){
			tempStr=param.getStr("p_name");
			value=param.getStr("p_acode");
			if(tempStr.equals("APIURL"))
				apiUrl=value;
			else if(tempStr.equals("GISURL"))
				gisUrl=value;
		}
		if(model!=null){
			if(model.getStr("apiurl")!=null)
				apiUrl=model.getStr("apiurl");
			
			if(model.getStr("gisurl")!=null)
				gisUrl=model.getStr("gisurl");
		}
		setAttr("apiUrl", apiUrl);
		setAttr("gisUrl", gisUrl);
		setAttr("data", model);
	}
	
	public void save(){
		T_Bus_MapConfig model=getModel(T_Bus_MapConfig.class,"c");
		Map<String, Object> map=new HashMap<String, Object>();
		try{
			boolean flag=T_Bus_MapConfig.dao.update(model);
			map.put("success", flag);
			if(!flag)
				map.put("msg", "更新失败");
			
		}catch (Exception e) {
			map.put("success",false);
			map.put("msg", e.getMessage());
		}finally{
			renderText(JsonKit.toJson(map));
		}
	}
}
