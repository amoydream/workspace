package com.lauvan.apps.web.manager.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.web.manager.model.T_Bus_Channel;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;
/**
 * 网站栏目管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/channel", viewPath="web/manager/channel")
public class ChannelController extends BaseController{

	public void index(){
		/*List<Record> channelList = Paginate.dao.getList("t_bus_channel", "1=1");
		setAttr("channelList", channelList);*/
		renderJsp("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String pid = getPara(0);
		String sql = "";
		if(pid != null && !"".equals(pid)){
			sql = " parentid =" + pid;
		}else{
			sql = " parentid =" + 0;
		}
		Page<Record> page = Paginate.dao.getPage("t_bus_channel", pageSize, pageNumber, sql, "priority", null);
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		Integer pid = getParaToInt(0, 0);
		T_Bus_Channel channel = T_Bus_Channel.dao.findById(pid);
		setAttr("pid", pid);
		setAttr("c", channel);
		renderJsp("add.jsp");
	}
	
	public void edit(){
		Integer id=getParaToInt(0, 0);
		T_Bus_Channel channel=T_Bus_Channel.dao.findById(id);
		if(null==channel){
			renderText("修改的栏目不存在！");
		}else{
			T_Bus_Channel pChannel=T_Bus_Channel.dao.findById(channel.get("parentid"));
			setAttr("c", channel);
			setAttr("pchannel", pChannel);
			renderJsp("edit.jsp");
		}
	}
	
	public void save(){
		T_Bus_Channel channel=getModel(T_Bus_Channel.class,"c");
		Boolean success = false;
		try {
			channel.set("isdisplay", null == getPara("c.isdisplay")?0:getPara("c.isdisplay"));
			//channel.set("issinglepage", null == getPara("c.issinglepage")?0:getPara("c.issinglepage"));
			if(null == getPara("c.issinglepage")){
				channel.set("issinglepage",0);
				channel.set("content", "");
			}else{
				channel.set("issinglepage",getPara("c.issinglepage"));
			}
			//去除空格
			String[] attrs = channel.getAttrNames();
			for(int i=0; i<attrs.length; i++){
				Object o = channel.get(attrs[i]);
				if(o != null){
					channel.set(attrs[i], o.toString().trim());
				}
			}
			if(channel.get("channelid") == null){
				String channelCode=T_Bus_Channel.dao.getNextChannelCode(getParaToInt("c.parentid"));
				channel.set("channelcode", channelCode);
				success = T_Bus_Channel.dao.insert(channel);
			}else{
				success = channel.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				//toDwzText(success, "保存成功！", "", "channelDialog", "channel_data", "closeCurrent");
				renderText("{\"success\":true, \"msg\":\"保存成功！\",\"dialogid\":\"channelDialog\", \"gridid\":\"channel_data\", \"treeObj\":\"channeltree\",\"reloadid\":" + 
						(getPara(0)==null?channel.get("parentid"):getPara(0))+",\"idkey\":\"d_id\"}");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	public void delete(){
		Integer[] ids=getParaValuesToInt("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			if(ids!=null && ids.length>0){
				if(ids.length>1){
					tips.put("reloadid", "0");
				}else{
					BigDecimal parentid = T_Bus_Channel.dao.findById(ids[0]).getBigDecimal("parentid");
					tips.put("reloadid", parentid);
				}
				
				if(T_Bus_Channel.dao.ifExistChildren(ids)){
					msg = "删除栏目存在子栏目，请先删除子栏目！";
				}else{
					T_Bus_Channel.dao.del(ids);
					success = true;
					errorCode = "info";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally{
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			tips.put("idkey", "d_id");
			tips.put("treeObj", "channeltree");
			renderJson(tips);
		}
	}
	
	public void getTreeData(){
		//String pid = getPara("d_id");
		//List<Record> channelList = Paginate.dao.getList("t_bus_channel", " parentid="+pid);
		String idKey=StringUtils.isBlank(getPara("idKey"))?"d_id":getPara("idKey");
		String pidKey=StringUtils.isBlank(getPara("pidKey"))?"d_pid":getPara("pidKey");
		List<Map<String,Object>> channelList = new ArrayList<Map<String,Object>>();
		String sql = " 1=1 ";
		if(getPara("d_id") != null && !"".equals(getPara("d_id"))){
			sql += " and parentid = "+getPara("d_id");
		}else{
			Map<String,Object> root = new HashMap<String,Object>();
			
			root.put(idKey, "0");
			root.put("name", "网站栏目");
			root.put(pidKey, "");
			channelList.add(root);
		}
		sql += " order by priority ";
		List<Record> list=Paginate.dao.getList("t_bus_channel", sql);
		Map<String,Object> row = null;
		
		for(Record de:list){
			row=new HashMap<String,Object>();
			row.put(idKey, de.get("channelid"));
			row.put("name", de.get("channelname"));
			row.put(pidKey, de.get("parentid")==null?0:de.get("parentid"));
			channelList.add(row);
		}
		renderJson(channelList);
	}
	
	public void view(){
		Integer id=getParaToInt(0, 0);
		T_Bus_Channel channel=T_Bus_Channel.dao.findById(id);
		if(null==channel){
			renderText("栏目信息不存在！");
		}else{
			T_Bus_Channel pChannel=T_Bus_Channel.dao.findById(channel.get("parentid"));
			setAttr("c", channel);
			setAttr("pchannel", pChannel);
			renderJsp("view.jsp");
		}
	}
	
	public void getChannelComboTree(){
		List<Record> channelList = Paginate.dao.getList("t_bus_channel", "1=1 order by priority ");
		String jsonStr = "[]";
		try {
			if(channelList != null && channelList.size()>0){
				Map<String, String> outputKey = new HashMap<String, String>();
				outputKey.put("id", "channelid");
				outputKey.put("text", "channelname");
				// root = new Record();
				//root.set("channelid", 0);
				//root.set("channelname", "网站栏目");
				jsonStr = JsonUtil.getTreeData(null, false, channelList, "channelid", "parentid", outputKey);
				System.out.println(jsonStr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			renderText(jsonStr);
		}
		
	}
	
	//校验栏目路径唯一性
	public void ifExistChannel(){
		String channelpath = getPara("channelpath");
		Integer channelid = getParaToInt("channelid");
		Map<String, Object> tips = new HashMap<String, Object>();
		T_Bus_Channel channel =  T_Bus_Channel.dao.findByPath(channelpath);
		if(channel == null){
			tips.put("success", false);
		}else{
			if(channelid != null && !"".equals(channelid)
					&& channel.getBigDecimal("channelid").intValue()==channelid){
				tips.put("success", false);
			}else{
				tips.put("success", true);
			}
		}
		renderJson(tips);
		
	}
	
	
}
