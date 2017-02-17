package com.lauvan.aoplog;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.fastjson.JSONArray;
import com.lauvan.system.entity.T_Syslog_Info;
import com.lauvan.system.service.SyslogInfoService;
import com.lauvan.system.vo.UserInfoVo;

/**
 * 
 * ClassName: SystemLogAspect
 * 
 * @Description: 捕获日志
 * @author 钮炜炜
 * @date 2015年9月11日 上午9:00:49
 */
@Aspect
@Component
public class SystemLogAspect {

	@Autowired
	private SyslogInfoService syslogInfoService;

	@Pointcut("@annotation(com.lauvan.aoplog.MethodLog)")
	public void methodAspect() {
	}

	@Before("methodAspect()")
	public void doBefore(JoinPoint joinPoint) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		UserInfoVo uVo = (UserInfoVo) session.getAttribute("userVo");
		// 请求的IP
		String ip = request.getRemoteAddr();
		// 获取用户请求方法的参数并序列化为JSON格式字符串
		String params = "";
		if (joinPoint.getArgs() != null && joinPoint.getArgs().length > 0) {
			for (int i = 0; i < joinPoint.getArgs().length; i++) {
				params += JSONArray.toJSONString(joinPoint.getArgs()[i]) + ";";
			}
		}
		if (params.length() > 1000) {
			params = params.substring(0, 999);
		}
		T_Syslog_Info s = new T_Syslog_Info();
		s.setLo_Describe(getControllerMethodDescription(joinPoint));
		s.setLo_Method(joinPoint.getTarget().getClass().getName() + "."
				+ joinPoint.getSignature().getName() + "()");
		s.setLo_Params(params);
		s.setLo_Type("0");
		s.setLo_Usercode(uVo.getUs_Code());
		s.setLo_Username(uVo.getUs_Name());
		s.setLo_Ip(ip);
		syslogInfoService.save(s);
	}

	@AfterThrowing(pointcut = "methodAspect()", throwing = "e")
	public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		UserInfoVo uVo = (UserInfoVo) session.getAttribute("userVo");
		// 请求的IP
		String ip = request.getRemoteAddr();

		// 获取用户请求方法的参数并序列化为JSON格式字符串
		String params = "";
		if (joinPoint.getArgs() != null && joinPoint.getArgs().length > 0) {
			for (int i = 0; i < joinPoint.getArgs().length; i++) {
				params += JSONArray.toJSONString(joinPoint.getArgs()[i]) + ";";
			}
		}
		if (params.length() > 1000) {
			params = params.substring(0, 999);
		}

		T_Syslog_Info s = new T_Syslog_Info();
		s.setLo_Describe(getControllerMethodDescription(joinPoint));
		s.setLo_Method(joinPoint.getTarget().getClass().getName() + "."
				+ joinPoint.getSignature().getName() + "()");
		s.setLo_Params(params);
		s.setLo_Type("1");
		s.setLo_Usercode(uVo.getUs_Code());
		s.setLo_Username(uVo.getUs_Name());
		s.setLo_Ip(ip);
		s.setLo_Exceptioncode(e.getClass().getName());
		s.setLo_Exceptiondetail(e.getMessage());
		syslogInfoService.save(s);
	}

	/**
	 * 获取注解中对方法的描述信息 用于Controller层注解
	 * 
	 * @param joinPoint
	 *            切点
	 * @return 方法描述
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static String getControllerMethodDescription(JoinPoint joinPoint) {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();
		Class targetClass = null;
		try {
			targetClass = Class.forName(targetName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Method[] methods = targetClass.getMethods();
		String description = "";
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length) {
					description = method.getAnnotation(MethodLog.class)
							.description();
					break;
				}
			}
		}
		return description;
	}
}
