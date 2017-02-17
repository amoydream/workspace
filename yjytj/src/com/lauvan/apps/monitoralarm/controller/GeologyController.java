package com.lauvan.apps.monitoralarm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;
import com.jfinal.upload.UploadFile;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.monitoralarm.data.Send;
import com.lauvan.apps.monitoralarm.model.T_Monitor_Pm;
import com.lauvan.apps.monitoralarm.model.T_Monitor_Temp;
import com.lauvan.apps.monitoralarm.model.T_Monitor_Weiyi;
import com.lauvan.apps.monitoralarm.model.T_Monitor_Wet;
import com.lauvan.apps.monitoralarm.model.T_Monitor_Windv;
import com.lauvan.apps.monitoralarm.model.T_Monitor_Windx;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;

@RouteBind(path="Main/geology",viewPath="/monitoralarm/geology/")
public class GeologyController extends BaseController{
	
	public void index(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		String edate = sdf.format(c.getTime());
		String sdate = sdf.format(c.getTime());
		setAttr("sdate", sdate);
		setAttr("edate", edate);
		render("main.jsp");
	}
	
	//查看图表
	public void getChart(){
		String sdate = getPara("sdate");
		String edate = getPara("edate");
		setAttr("sdate", sdate);
		setAttr("edate", edate);
		renderJsp("chart.jsp");
	}
	
	public void getWyData(){
		float a = 0;
		if(CacheKit.get("monitordata","lastWY")!=null){
			a = CacheKit.get("monitordata", "lastWY");
		} 
		renderJson(a);
	}
	
    public void uploadFile(){
        UploadFile uploadFile=this.getFile();
        String fileName=uploadFile.getOriginalFileName();
        File file=uploadFile.getFile();    
        CacheKit.put("weiyi", "temp", file);
        
        FileInputStream fis;
        byte[] b = new byte[(int)file.length()];
         
		try {
			fis = new FileInputStream(file);
	        try {
				while(fis.read(b) == -1){  
				CacheKit.put("weiyi", "byte", b);
				fis.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		Send send = new Send();
		send.setSendData(b,fileName);
		Thread thread = new Thread(send);
		thread.start();
        }  
}
