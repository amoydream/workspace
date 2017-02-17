package com.lauvan.apps.geographic.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.NumberUtils;

import com.jfinal.aop.Clear;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.communication.gpsinfo.model.T_UserLocator;
import com.lauvan.apps.communication.gpsinfo.model.T_UserRealLocator;
import com.lauvan.apps.geographic.model.T_Bus_MapConfig;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;

/**
 * GIS地图控制类
 * @author chen  2016/06/06
 *
 */
@SuppressWarnings("deprecation")
@RouteBind(path="Main/geographic/common",viewPath="/geographic/common")
public class CommonController extends BaseController {

	
	@Clear
	public void openMedia(){
		String lat="",lng="";
//		Map<String, Object> map=new HashMap<String, Object>();
		initParams();
		
		lng=((BigDecimal)getAttr("lng")).toString();
		lat=((BigDecimal)getAttr("lat")).toString();
		
		String paramLat=getPara("lat");
		String paramLng=getPara("lng");
		String filePath=getPara("path");
		String filetype=getPara("type");
		
		if(NumberUtils.isNumber(paramLng) && NumberUtils.isNumber(paramLat)){
			lng=paramLng;
			lat=paramLat;
			setAttr("lng",lng);
			setAttr("lat",lat);
		}
		
		
		setAttr("path", filePath);
		setAttr("type", filetype);
		
		String fileName=getAttr("online")?"online":"offline";
		render(fileName+"/openmedia.jsp");
	}
	
	private  void initParams(){
		
		T_Bus_MapConfig config=T_Bus_MapConfig.dao.getData();
		if(config==null){
			renderText("未配置地图基本信息！");
			return;
		}
		
		boolean isOnline=!config.getStr("onlinemap").equals("0");
		
		
		setAttr("lng", config.get("lng"));
		setAttr("lat", config.get("lat"));
		setAttr("zoom",config.get("zoom"));
		setAttr("online", isOnline);
		
		if(!isOnline){
			String apiUrl=config.getStr("apiurl"),gisUrl=config.getStr("gisurl");
			if(apiUrl.isEmpty()){
				renderText("未配置离线地图api地址");
				return;
			}
			if(gisUrl.isEmpty()){
				renderText("未配置离线地图地址");
				return;
			}
			setAttr("gisUrl", gisUrl);
			setAttr("apiUrl", apiUrl);
			
		}
	}
	
	@Clear
	public void getGeoPosition(){
		String lat="",lng="";
		Map<String, Object> map=new HashMap<String, Object>();
		boolean isDisplay=false;
		initParams();
		lng=((BigDecimal)getAttr("lng")).toString();
		lat=((BigDecimal)getAttr("lat")).toString();
		
		String paramLat=getPara("lat");
		String paramLng=getPara("lng");
		if(NumberUtils.isNumber(paramLng) && NumberUtils.isNumber(paramLat)){
			lng=paramLng;
			lat=paramLat;
			isDisplay=true;
		}
		
		setAttr("lng", lng);
		setAttr("lat", lat);
		setAttr("display", isDisplay);
		
		String fileName=getAttr("online")?"online":"offline";
		
		render(fileName+"/geoposition.jsp");
	}
	
	@Clear
	public void openTrack(){
		Map<String, Object> map=new HashMap<String, Object>();
		initParams();
		
		String userId=getPara("uid");
		String btime=getPara("btime");
		String etime=getPara("etime");
		
		if(userId.isEmpty() || btime.isEmpty() ||etime.isEmpty()){
			renderText("传入的参数不正确，请检查！");
			return;
		}else{
			try{
				List<Record> uList=T_UserLocator.dao.getListUidAndTime(userId, btime, etime);
				setAttr("list", JsonKit.toJson(uList));

				String fileName=getAttr("online")?"online":"offline";
				render(fileName+"/opentrack.jsp");
			}catch (Exception e) {
				renderText(e.getMessage());
			}
		}
	}
	
	@Clear
	public void openRealTimePoint(){
		initParams();
		
		setAttr("uids", getPara("uids"));
		String fileName=getAttr("online")?"online":"offline";
		render(fileName+"/openrealpoint.jsp");
	}
	
	@Clear
	public void getRealTimePoint(){
		String uList=getPara("uids");
		List<Record> list;
		Integer[] userIds;
		if(uList==null  || uList.isEmpty()){
			userIds=null;
		}
		else
			userIds=ArrayUtils.ArrayToInteger(uList.split(","));
		list=T_UserRealLocator.dao.getByUserId(userIds);
		
		renderJson(list);
	}
	
	
	@Clear
	public void download(){
		String path=getPara("path");
		String fname="";
		if(!path.isEmpty()){

			T_Sys_Parameter parData= T_Sys_Parameter.dao.getByCode("MOBILEFILE", "UPDZ");
			if(parData!=null){
				String tempPath=parData.getStr("p_acode");
				tempPath=tempPath.endsWith("\\")?tempPath:tempPath+"\\";
				path=tempPath+path;
			}
			
			if(!path.startsWith("/") && path.indexOf(":")==-1){
				path=PathKit.getWebRootPath()+"/"+path;
			}
			fname=path.substring(path.lastIndexOf("/")+1);
			
			try{
				HttpServletResponse res = getResponse();
				res.setContentType("text/html; charset=UTF-8");
				res.setContentType("application/x-msdownload");
				res.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode(fname, "UTF-8"));
				OutputStream out = res.getOutputStream();
				File file = new File(path);
				if(file.exists()){
					FileInputStream fis=new FileInputStream(file);
			        BufferedInputStream buff=new BufferedInputStream(fis);
			        byte [] b=new byte[1024];//相当于我们的缓存
			        long k=0;//该值用于计算当前实际下载了多少字节
			        while(k<file.length()){
			            int j=buff.read(b,0,1024);
			            k+=j;
			            //将b中的数据写到客户端的内存
			            out.write(b,0,j);
			        }
			        fis.close();
				}
		        //将写入到客户端的内存的数据,刷新到磁盘
		        out.flush();
		        out.close();
		        
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				renderNull();
			}	
		}else{
			renderText("该文件不存在！");
		}
	}
}
