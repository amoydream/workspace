package com.lauvan.apps.massms.service;

import java.util.TimerTask;

import com.jfinal.plugin.activerecord.DbKit;

public class SmsTask extends TimerTask {
	public static boolean flag = false;
	@Override
	public void run() {
		if(DbKit.getConfig() != null && !flag) {//判断数据库是否连接上，以及其他线程是否正在调用，防止产生死锁
			flag = true;
			MasSms.getRPT();
			MasSms.getMo();
			flag = false;
		}
	}
}
