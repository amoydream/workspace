package com.lauvan.listener;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.lauvan.apps.massms.service.SmsTask;

public class SmsListener implements ServletContextListener {
	private Timer timer = null;

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		timer.cancel();
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		try {
			Calendar calendar = Calendar.getInstance();
			//calendar.set(Calendar.HOUR_OF_DAY,0);//0点开始
			//calendar.set(Calendar.MINUTE,0);
			//calendar.set(Calendar.SECOND,0);
			Date time = calendar.getTime();
			//System.out.println("+++++++++++++"+time+"++++++++++");
			timer = new Timer(true);
			//3分钟扫一次短信表
			timer.scheduleAtFixedRate(new SmsTask(), time, 1000 * 60 * 3);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
