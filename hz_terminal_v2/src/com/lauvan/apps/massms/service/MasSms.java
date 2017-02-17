package com.lauvan.apps.massms.service;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import com.jfinal.kit.PathKit;
import com.lauvan.apps.communication.smsmanagement.model.T_Bus_Moblie_Rev;
import com.lauvan.apps.communication.smsmanagement.model.T_Bus_Moblie_Rpt;
import com.lauvan.apps.communication.smsmanagement.model.T_Bus_Moblie_To;
import com.lauvan.apps.event.model.T_Bus_SmsRevRD;
import com.lauvan.apps.event.model.T_Bus_SmsSendRD;
import com.lauvan.apps.massms.model.T_Bus_Moblie_Mas;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.util.AutoId;

public class MasSms {
	private static String apicode="hyyj";
	//private static String loginName="hyyj";
	//private static String loginPwd="hyyj";
	private static HashMap<String,String> attrMap = JFWebConfig.attrMap;
	private static String loginName=attrMap.get("smsaccount");
	private static String loginPwd=attrMap.get("smspwd");
	public static long send(String senderid,String[] tels,String content,String type){
		try {
			long maxsn=T_Bus_Moblie_Mas.dao.getMaxsn();
			SMsgService service=new SMsgServiceLocator();
			SMsg_PortType client=service.getSMsg();
			 int result=client.sendSM(apicode,loginName,loginPwd,tels,content,maxsn);
			if(tels.length!=0){
			for(String tel:tels){
			T_Bus_Moblie_Mas mas=new T_Bus_Moblie_Mas();
			Number id=AutoId.nextval(mas);
			Date d=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			mas.set("id",id ).set("mobile", tel).set("content", content).set("send_time", sdf.format(d)).set("sender_id", senderid).set("type", type).set("status", result).set("sn_id", maxsn);
			mas.save();
			}
			}
			return maxsn;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}	
	}
	public static String getnode(String str,String node){
		return str.substring(str.indexOf("<"+node+">")+node.length()+2, str.indexOf("</"+node+">"));
	}
	public static void getRPT(){
		try {
		SMsgService service=new SMsgServiceLocator();
		 SMsg_PortType client=service.getSMsg();
		String report=client.recvRPT(apicode, loginName, loginPwd);
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("SMSTEMPDZ", "UPDZ");
		Date d=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
		String rootPath=PathKit.getWebRootPath();
		String url="";
		String parenturl="";
		if(p.getStr("p_acode").startsWith("/") || p.getStr("p_acode").indexOf(":")==1){
			url = p.getStr("p_acode")+"/rpt"+sdf.format(d)+".txt";
			parenturl=p.getStr("p_acode");
		}else{
			url=rootPath+"/"+p.getStr("p_acode")+"/rpt"+sdf.format(d)+".txt";
			parenturl=rootPath+"/"+p.getStr("p_acode");
		}
		File parent = new File(parenturl);
		if(!parent.exists()){
			parent.mkdirs();
		}
		   File file=new File(url);
		   if(!file.exists()){
			   file.createNewFile();
		   }
		    PrintWriter pfp;
			pfp = new PrintWriter(file);
			 pfp.print(report);
			 pfp.close();
		if(report.indexOf("<rpt>")!=-1){
		report=report.substring(report.indexOf("<rpt>"),report.indexOf("</mas>"));
		String[] rpts=report.split("</rpt>");
		String smid="";//发送id
		String mobile="";//发送号码
		String rptcode="";//回执状态
		String rptdesc="";//回执内容
		String rpttime="";//回执时间
		for(String rpt:rpts){
		if(rpt!=null&&rpt.length()>10){
		smid=getnode(rpt,"smid");
		mobile=getnode(rpt,"mobile");
		rptcode=getnode(rpt,"rptcode");
		rptdesc=getnode(rpt,"rptdesc");
		rpttime=getnode(rpt,"rpttime");
		T_Bus_Moblie_Mas mas=T_Bus_Moblie_Mas.dao.getbysntel(smid,mobile);
		if(mas!=null){
		if(mas.getStr("type").equals("00A")){
			//事件回执
			T_Bus_SmsRevRD rd=new T_Bus_SmsRevRD();
			rd.set("id", AutoId.nextval(rd)).set("smsid", smid).set("callno", mobile).set("revtime", rpttime).set("smsdata", rptdesc);
			rd.save();
			T_Bus_SmsSendRD sd = T_Bus_SmsSendRD.dao.getBySmsId(smid, mobile);
			if("0".equals(rptcode)){
				//发送成功
				sd.set("sendstate", "T");
			}else{
				//发送失败
				sd.set("sendstate", "F");
			}
			sd.update();
		}else{
			//短信回执
			T_Bus_Moblie_Rpt mobilerpt=new T_Bus_Moblie_Rpt();
			mobilerpt.set("repeatid", AutoId.nextval(mobilerpt)).set("sm_id",smid).set("mobile", mobile).set("rpt_code", rptcode).set("rpt_desc", rptdesc).set("rpt_time", rpttime);
			mobilerpt.save();
			T_Bus_Moblie_To sd = T_Bus_Moblie_To.dao.getBySmId(smid, mobile);
			if("0".equals(rptcode)){
				//发送成功
				sd.set("send_state", "T");
			}else{
				//发送失败
				sd.set("send_state", "F");
			}
			sd.update();
		}
		if(rptcode.equals("0")){
		mas.set("status", "T");	
		}else{
		mas.set("status", "F");		
		}
		mas.update();
		}
		}
		}
		}
		file.delete();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void getMo(){
		 try {
		SMsgService service=new SMsgServiceLocator();
		SMsg_PortType client=service.getSMsg();
		String moinfo=client.recvMo(apicode, loginName, loginPwd);
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("SMSTEMPDZ", "UPDZ");
		Date d=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
		String rootPath=PathKit.getWebRootPath();
		String url="";
		String parenturl="";
		if(p.getStr("p_acode").startsWith("/") || p.getStr("p_acode").indexOf(":")==1){
			url = p.getStr("p_acode")+"/rpt"+sdf.format(d)+".txt";
			parenturl=p.getStr("p_acode");
		}else{
			url=rootPath+"/"+p.getStr("p_acode")+"/rpt"+sdf.format(d)+".txt";
			parenturl=rootPath+"/"+p.getStr("p_acode");
		}
		File parent = new File(parenturl);
		if(!parent.exists()){
			parent.mkdirs();
		}
		   File file=new File(url);
		   if(!file.exists()){
			   file.createNewFile();
		   }
		    PrintWriter pfp;
			pfp = new PrintWriter(file);
			 pfp.print(moinfo);
			 pfp.close();
		if(moinfo.indexOf("<sms>")!=-1){
			moinfo=moinfo.substring(moinfo.indexOf("<sms>"),moinfo.indexOf("</mas>"));
			String[] mos=moinfo.split("</sms>");
			String smid="";//发送id
			String mobile="";//发送号码
			String content="";//回复内容
			String motime="";//回复时间
			for(String mo:mos){
			if(mo!=null&&mo.length()>10){
			smid=getnode(mo,"smid");
			mobile=getnode(mo,"mobile");
			content=getnode(mo,"content");
			motime=getnode(mo,"motime");
			T_Bus_Moblie_Rev rev=new T_Bus_Moblie_Rev();
			rev.set("mobileid", AutoId.nextval(rev)).set("sm_id", smid).set("mobile", mobile).set("content", content).set("mo_time", motime).set("state", "0");
			rev.save();
			}
			}
		}
		file.delete();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	}
/*	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			SMsgService service=new SMsgServiceLocator();
			 SMsg_PortType client=service.getSMsg();
			 //client.init("113.106.94.173", "mas", "31102", "lauvan", "lauvan@123");
		  String [] tel={"18219234235","1382548"};
		  int result=client.sendSM("hyyj","hyyj","hyyj",tel,"你好立沃",10); 
		  System.out.println(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/

}
