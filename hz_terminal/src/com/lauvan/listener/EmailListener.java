package com.lauvan.listener;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.lauvan.apps.communication.mail.utils.EmailTask;

public class EmailListener implements ServletContextListener {
	private Timer timer = null;

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		timer.cancel();
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		try {
			Calendar calendar = Calendar.getInstance();
			Date time = calendar.getTime();
			timer = new Timer(true);
			//5分钟扫一次
			timer.scheduleAtFixedRate(new EmailTask(), time, 1000 * 60 * 5);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
