package com.lauvan.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.lauvan.system.service.ModuleInfoService;
import com.lauvan.system.service.RoleModuleService;
import com.lauvan.system.service.UserInfoService;
import com.lauvan.system.service.UserLimitService;
import com.lauvan.system.service.UserRoleService;
import com.lauvan.system.vo.UserInfoVo;
/**
 * 
 * ClassName: PermitInterceptor 
 * @Description: 权限控制
 * @author 钮炜炜
 * @date 2015年9月10日 上午9:49:06
 */
public class PermitInterceptor implements HandlerInterceptor{

	@Autowired
	private UserLimitService userLimitService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserRoleService userRoleService;
	@Autowired
	private RoleModuleService roleModuleService;
	@Autowired
	private ModuleInfoService moduleInfoService;
	/**
	 * 不需要拦截的url
	 */
	private List<String> excludeUrls;
	public List<String> getExcludeUrls() {
		return excludeUrls;
	}

	public void setExcludeUrls(List<String> excludeUrls) {
		this.excludeUrls = excludeUrls;
	}

	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String url = requestUri.substring(contextPath.length());
		
		//过滤不需要拦截的url
		if (excludeUrls.contains(url)) {
			return true;
		}
		
		HttpSession session = request.getSession();
		UserInfoVo uVo = (UserInfoVo) session.getAttribute("userVo");
		if (uVo==null) {
			if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){ //如果是ajax请求响应头会有，x-requested-with  
	            response.setHeader("sessionstatus", "timeout");//在响应头设置session状态  
	        }else{
	        	response.sendRedirect(contextPath+"/login.jsp");
	        }
			
			return false;
		}
		
		HandlerMethod method = (HandlerMethod)handler;
        Perm perm = method.getMethodAnnotation(Perm.class);
        if (perm==null) {//不需要权限验证
			return true;
		}
        
        if (!uVo.getPermissions().contains(perm.privilegeValue())) {
			request.setAttribute("msg", "您还没有该操作权限！");
			request.getRequestDispatcher("/include/msg.jsp").forward(request, response);
			return false;
		}
		return true;
	}

}
