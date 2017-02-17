package com.lauvan.apps.massms.service;

import java.util.TimerTask;

import com.jfinal.plugin.activerecord.DbKit;
import com.lauvan.apps.massms.service.MasSms;

public class SmsTask extends TimerTask {
	public static boolean flag = false;
	@Override
	public void run() {
		//System.out.println(flag);
		if(DbKit.getConfig()!=null && !flag){//判断数据库是否连接上
			//SmsUtil.getSmsList();
			flag = true;
			System.out.println("#######开始扫描回执、回复######");
			MasSms.getRPT();
			MasSms.getMo();
			System.out.println("#######结束扫描回执、回复######");
			flag = false;
		}
		//System.out.println("end======"+flag);
	}

}
