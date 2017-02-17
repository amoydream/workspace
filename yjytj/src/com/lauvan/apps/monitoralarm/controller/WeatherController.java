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

@RouteBind(path="Main/weather",viewPath="/monitoralarm/weather/")
public class WeatherController extends BaseController{
	
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
	
	public void getData() {
		String sdate = getPara("sdate");
		String edate = getPara("edate");
		Map<String, Object> result = new HashMap<String, Object>();
		List<Record> tmpdata = T_Monitor_Temp.dao.getData(sdate,edate);
		List<Record> windvdata = T_Monitor_Windv.dao.getData(sdate,edate);
		List<Record> windxdata = T_Monitor_Windx.dao.getData(sdate,edate);
		List<Record> wetdata = T_Monitor_Wet.dao.getData(sdate,edate);
		List<Record> pmdata = T_Monitor_Pm.dao.getData(sdate,edate);
		List<Record> weiyidata = T_Monitor_Weiyi.dao.getData(sdate,edate);
		for(int i=0; i< tmpdata.size(); i++){
		     Record r = tmpdata.get(i);
			 Record r2 = new Record();
			 r2.set("time", r.getStr("TP_TIME"));
			 r2.set("value", r.getNumber("TP_VALUE"));
			 tmpdata.remove(i);
			 tmpdata.add(i, r2);
		}
		for(int i=0; i< windvdata.size(); i++){
		     Record r = windvdata.get(i);
			 Record r2 = new Record();
			 r2.set("time", r.getStr("WV_TIME"));
			 r2.set("value", r.getNumber("WV_VALUE"));
			 windvdata.remove(i);
			 windvdata.add(i, r2);
		}
		for(int i=0; i< windxdata.size(); i++){
		     Record r = windxdata.get(i);
			 Record r2 = new Record();
			 r2.set("time", r.getStr("WX_TIME"));
			 r2.set("value", r.getNumber("WX_VALUE"));
			 windxdata.remove(i);
			 windxdata.add(i, r2);
		}
		for(int i=0; i< wetdata.size(); i++){
		     Record r = wetdata.get(i);
			 Record r2 = new Record();
			 r2.set("time", r.getStr("WT_TIME"));
			 r2.set("value", r.getNumber("WT_VALUE"));
			 wetdata.remove(i);
			 wetdata.add(i, r2);
		}
		for(int i=0; i< pmdata.size(); i++){
		     Record r = pmdata.get(i);
			 Record r2 = new Record();
			 r2.set("time", r.getStr("PM_TIME"));
			 r2.set("value", r.getNumber("PM_VALUE"));
			 pmdata.remove(i);
			 pmdata.add(i, r2);
		}
		for(int i=0; i< weiyidata.size(); i++){
		     Record r = weiyidata.get(i);
			 Record r2 = new Record();
			 r2.set("time", r.getStr("WY_TIME"));
			 r2.set("value", r.getNumber("WY_VALUE"));
			 weiyidata.remove(i);
			 weiyidata.add(i, r2);
		}
		result.put("tmpdata", tmpdata.toArray());
		result.put("windvdata", windvdata.toArray());
		result.put("windxdata", windxdata.toArray());
		result.put("wetdata", wetdata.toArray());
		result.put("pmdata", pmdata.toArray());
		renderJson(result);
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
