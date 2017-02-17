package com.lauvan.base.basemodel.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.jfinal.core.Controller;

public class BaseController extends Controller {
	/** 转换格式输出 */
	public void toDwzText(boolean success, String message, String treegid, String dialogid, String gridid, String callbackType, String... forwardUrl) {
		StringBuffer jsonMap = new StringBuffer();
		jsonMap.append("{\"success\":" + success + "");
		if(message != null)
			jsonMap.append(",\"msg\":\"" + message + "\"");
		if(treegid != null)
			jsonMap.append(",\"treegid\":\"" + treegid + "\"");
		if(dialogid != null)
			jsonMap.append(",\"dialogid\":\"" + dialogid + "\"");
		if(gridid != null)
			jsonMap.append(",\"gridid\":\"" + gridid + "\"");
		if(callbackType != null) {
			jsonMap.append(",\"callbackType\":\"" + callbackType + "\"");
			if("forward".equals(callbackType)) {
				jsonMap.append(",\"furl\":\"" + forwardUrl[0] + "\"");
			} else if(forwardUrl != null && forwardUrl.length > 0) {
				jsonMap.append(",\"reloadid\":" + forwardUrl[0]);
			}
		}
		jsonMap.append("}");
		this.renderText(jsonMap.toString());
	}

	/** 转换dwz json格式输出 */
	public void toDwzJson(boolean success, String message, String tabid, String dialogid, String gridid, String callbackType, String... forwardUrl) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success", success);
		if(message != null)
			jsonMap.put("msg", message);
		if(tabid != null)
			jsonMap.put("tabid", tabid);
		if(dialogid != null)
			jsonMap.put("dialogid", dialogid);
		if(gridid != null)
			jsonMap.put("gridid", gridid);
		if(callbackType != null) {
			jsonMap.put("callbackType", callbackType);
			if("forward".equals(callbackType)) {
				jsonMap.put("forwardUrl", forwardUrl);
			}
		}
		this.renderJson(jsonMap);
	}

	public <T> T getContextAttr(String key) {
		HttpSession session = getSession(false);
		return session != null ? (T)session.getServletContext().getAttribute(key) : null;
	}

	public BaseController setContextAttr(String key, Object obj) {
		HttpSession session = getSession(false);
		getSession().getServletContext().setAttribute(key, obj);
		return this;
	}
}
