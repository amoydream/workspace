package com.lauvan.interceptor;


import javax.servlet.http.HttpServletRequest;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.lauvan.base.basemodel.model.T_Sys_Module;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.util.PermitHandler;

public class PermitInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation ai) {
		// TODO Auto-generated method stub
		HttpServletRequest request = ai.getController().getRequest();
		String requrl = request.getServletPath();
		System.out.println(requrl);
		System.err.println("***********requrl:" + requrl);
		if (requrl.endsWith(".js") || requrl.endsWith(".gif")
				|| requrl.endsWith(".jpg") || requrl.endsWith(".png")
				|| requrl.endsWith(".css") || requrl.endsWith(".html")
				|| requrl.endsWith(".htm") || requrl.endsWith(".xml")
				|| requrl.endsWith(".swf") || requrl.endsWith(".htc")
				|| requrl.endsWith(".cab")) {
			ai.invoke();
			return;
		}
		if(!requrl.startsWith("/Main") && 
				!requrl.startsWith("/main") && 
				!requrl.equals("/Login/doLogin")){
			ai.invoke();
			return;
		}
		if (null == ai.getController().getSession().getAttribute("loginModel")) {

			try {
				request.setAttribute("loginAgain", "用户未登录或者登录超时，请重新登录！");
				ai.getController().getResponse().setHeader("sessionstatus", "timeout");
				if(ai.getActionKey().equals("/Main/aioIndex")){//一体机主页
					ai.getController().forwardAction("/AIOLogin");
				}else if(ai.getActionKey().equals("/Main")){
					ai.getController().forwardAction("/Login");
				}else{
					ai.getController().renderNull();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return;
		}
		String actionKey=ai.getActionKey();
		
		if(actionKey.equals("/Main") || actionKey.equals("/Main/getMenu") || actionKey.equals("/Main/menu")
				|| actionKey.equals("/Main/pwordset") || actionKey.equals("/Main/pwordSave")
				|| actionKey.equals("/Main/systemSet") || actionKey.equals("/Main/systemSetSave")|| actionKey.equals("/Login/logout")){
			ai.invoke();
			return;
		}
		String methodname = ai.getMethodName();
		
		if(methodname.startsWith("get") || methodname.equals("save") 
				|| methodname.endsWith("Save")){ //以get开头的方法或者save方法直接通过部拦截
			ai.invoke();
			return;
		}
		LoginModel loginModel=(LoginModel)request.getSession().getAttribute("loginModel");
		if(!loginModel.getIsAdmin() && !loginModel.getIsSuper()){
			String maddress=ai.getActionKey().substring(1);
			T_Sys_Module module=T_Sys_Module.dao.getByAddress(maddress);
			
			if(module==null){
				System.out.println("该功能不存在:"+ai.getActionKey());
				ai.getController().renderText("{\"success\":false,\"msg\":\"该功能不存在！\"}");
				//ai.getController().renderText("该功能不存在！");
				//ai.getController().renderJson("{\"success\":false,\"message\":\"该功能不存在！\"}");
				return;
			}
			
			Integer moduleId=module.getNumber("id").intValue();
		
			//判断模块是否有权限
			if(!PermitHandler.haspermit(moduleId, loginModel.getLimit()) && 
					"0".equals(module.getStr("modeltype"))){
				
				System.out.println("无权限进行该操作:"+ai.getActionKey());
				//ai.getController().renderText("无权限进行该操作！");
				ai.getController().renderText("{\"success\":false,\"msg\":\"无权限进行该操作！\"}");
				//ai.getController().renderText("无权限进行该操作！");
				return;
			}
			
			//判断功能点是否有权限
			if(!PermitHandler.haspermit(moduleId, loginModel.getXdlimit(), module.getNumber("p_id").intValue(), 
					loginModel.getLimit()) && "1".equals(module.getStr("modeltype")) ){
				
				System.out.println("无权限进行该操作:"+ai.getActionKey());
				//ai.getController().renderText("无权限进行该操作！");
				ai.getController().renderText("{\"success\":false,\"msg\":\"无权限进行该操作！\"}");
				//ai.getController().renderText("无权限进行该操作！");
				return;
			}
		}
		
		ai.invoke();
		/*Controller acont = ai.getTarget();
		acont.getRender();
		//操作记录
		T_Sys_Operation_Log log = new T_Sys_Operation_Log();
		log.set("opt_user", loginModel.getUserId());
		log.set("opt_moudle", moduleId);
		String opt_type = "0";
		if("add".equals(methodname)){
			opt_type = "1";
		}else if("update".equals(methodname)|| "edit".equals(methodname)){
			opt_type = "2";
		}else if("delete".equals(methodname)){
			opt_type = "3";
		}else{
			opt_type = "4";
		}
		log.set("opt_type", opt_type);
		T_Sys_Operation_Log.dao.insert(log);*/
	}

}
