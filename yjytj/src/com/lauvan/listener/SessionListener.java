package com.lauvan.listener;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.lauvan.base.main.model.LoginModel;

public class SessionListener implements HttpSessionListener {
	@Override
	public void sessionCreated(HttpSessionEvent event) {
	}

	@Override
	@SuppressWarnings(value = "unchecked")
	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		ServletContext context = session.getServletContext();
		List<LoginModel> onlineUsers = (List<LoginModel>)context.getAttribute("onlineUsers");
		for(int i = 0; i < onlineUsers.size(); i++) {
			LoginModel onlineUser = onlineUsers.get(i);
			if(onlineUser.getSessionId().equals(session.getId())) {
				onlineUsers.remove(i);
				break;
			}
		}
	}
}
