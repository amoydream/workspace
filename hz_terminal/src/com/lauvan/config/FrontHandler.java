package com.lauvan.config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jfinal.handler.Handler;

public class FrontHandler extends Handler {

	@Override
	public void handle(String target, HttpServletRequest request, HttpServletResponse response, boolean[] isHandled) {
		if(!target.startsWith("/Main") && !target.startsWith("/main") && !target.equals("/Login/doLogin") && !target.equals("/Login/logout") && target.indexOf(".") == -1) {
			request.setAttribute("paths", target.substring(1));
			target = "/front";
		}
		nextHandler.handle(target, request, response, isHandled);
	}

}
