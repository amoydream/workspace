package com.lauvan.base.main.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Clear;
import com.lauvan.apps.communication.ccms.model.T_Ccms_Seat;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_LoginLog;
import com.lauvan.base.basemodel.model.T_Sys_Module;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.basemodel.model.T_Sys_Role;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.IpAddr;
import com.lauvan.util.Pwd;
@RouteBind(path = "/AIOLogin", viewPath = "/aio")
public class AIOLoginController extends BaseController {
	public static Map<String, HttpSession> userMap = new HashMap<String, HttpSession>();

	@Clear
	public void index() {
		String aiomsg = getSessionAttr("aioPCmsg");
		if(aiomsg!=null && !"".equals(aiomsg)){
			setAttr("aioPCmsg", aiomsg);
		}
		if(getSessionAttr("loginModel") == null)
			render("login.jsp");
		else
			redirect("/Main/aioIndex");
	}

	@Clear
	public void doLogin() {
		String loginAccount = getPara("loginAccount");
		String loginPwd = getPara("loginPwd");
		String msg = "";

		if(StringUtils.isBlank(loginAccount) || StringUtils.isBlank(loginPwd)) {
			msg = "登录帐号或密码不能为空!";
			setAttr("msg", msg);
			index();
			return;
		}
		String regex = "^[A-Za-z0-9]+$";
		if(!Pattern.matches(regex, loginAccount) || !Pattern.matches(regex, loginPwd)) {
			msg = "输入错误,用户名和密码为英文字母和数字组合！";
			setAttr("msg", msg);
			index();
			return;
		}

		T_Sys_User user = T_Sys_User.dao.getUserByAccount(loginAccount);
		if(user != null) {
			if(user.get("password").equals(Pwd.encrypt(loginPwd))) {
				if("1".equals(user.getStr("status"))) {
					if("1".equals(user.getStr("pcstate"))){
						msg = "注意：当前用户没有登录一体机权限！";
						setSessionAttr("aioPCmsg", msg);
						redirect("/Login/index");
						return;
					}else{
						removeAttr("aioPCmsg");
					}
					if(userMap.containsKey(loginAccount)) {

						T_Sys_LoginLog.dao.logout(userMap.get(loginAccount).getId());
						try {
							userMap.get(loginAccount).invalidate();
						} catch(Exception e) {
							System.out.println("session已注销！");
							// e.printStackTrace();
						}
						userMap.remove(loginAccount);
					}

					LoginModel loginModel = new LoginModel();
					loginModel.setUserId(user.getNumber("user_id"));
					loginModel.setUserAccount(user.getStr("user_account"));
					loginModel.setUserName(user.getStr("user_name"));
					Number ugrpNO = user.getNumber("ugrpno");
					loginModel.setUgrpNO(ugrpNO != null ? ugrpNO.intValue() : 1);
					Number opLevel = user.getNumber("oplevel");
					loginModel.setOpLevel(opLevel != null ? opLevel.intValue() : 0);
					Number callLevel = user.getNumber("calllevel");
					loginModel.setCallLevel(callLevel != null ? callLevel.intValue() : 5);

					HttpSession session = getSession(true);
					loginModel.setSessionId(session.getId());
					T_Sys_Department dept = null;
					if(null != user.get("dept_id")) {
						dept = T_Sys_Department.dao.findById(user.get("dept_id"));
						if(dept != null) {
							loginModel.setOrgCode(dept.getStr("d_number"));
							loginModel.setOrgName(dept.getStr("d_name"));
							loginModel.setOrgId(dept.getNumber("d_id"));
							loginModel.setDTMFKEY(dept.getStr("DTMFKEY"));

							T_Sys_Department rootDept = T_Sys_Department.dao.getRootDepartment(dept.getNumber("d_id").intValue());
							if(rootDept != null) {
								loginModel.setRootOrgId(rootDept.getNumber("d_id"));
								loginModel.setRootOrgCode(rootDept.getStr("d_number"));
							} else {
								loginModel.setRootOrgId(dept.getNumber("d_id"));
								loginModel.setRootOrgCode(dept.getStr("d_number"));
							}
						}
					}

					// loginModel.setIsAdmin(T_User.dao.isAdmin(user.getBigDecimal("id")));//设置是否是管理员标识
					loginModel.setIsAdmin(T_Sys_Parameter.dao.isExist(loginModel.getUserAccount(), "GLCS"));// 设置是否是管理员标识
					loginModel.setIsSuper(T_Sys_User.dao.isSuperAdmin(loginModel.getUserId().toString()));// 设置是否是超级管理标识

					List<T_Sys_Role> roleList = T_Sys_Role.dao.getRoles(loginModel.getUserId().toString());
					if(roleList == null || roleList.size() == 0) {
						setAttr("msg", "您没有权限登录，请联系管理员添加角色！");
						loginModel.setLimit("");
					} else {

						String menuIds = "";
						for(T_Sys_Role role : roleList) {
							String temp = role.getStr("opt_permissions");
							menuIds += (temp != null) ? temp + "," : "";

							// temp=role.getStr("no_permissions");
						}

						// 对角色允许访问菜单、限制功能点去重复数据
						loginModel.setLimit("");
						loginModel.setXdlimit("");

						if(StringUtils.isNotBlank(menuIds)) {
							menuIds = menuIds.substring(0, menuIds.length() - 1);
							String[] menuArray = ArrayUtils.removeDuplicate(menuIds.split(","));
							loginModel.setLimit(ArrayUtils.ArrayToString(menuArray));

							Integer[] excludeFunIds = T_Sys_Module.dao.getExcludeModuleIds(roleList);
							if(excludeFunIds != null)
								loginModel.setXdlimit(ArrayUtils.ArrayToString(excludeFunIds));
						}

						String loginIP = IpAddr.getIpAddr(getRequest());
						loginModel.setLoginIP(loginIP);
						Number dept_id = dept.getNumber("D_ID");
						T_Ccms_Seat seat = T_Ccms_Seat.dao.getSeat(dept_id.intValue(), loginIP);
						if(seat != null) {
							loginModel.setSeatID(seat.getStr("SEATID"));
							loginModel.setSeatIP(seat.getStr("SEATIP"));
							loginModel.setSeatSort(seat.getNumber("SORT").intValue());
						}
						setSessionAttr("loginModel", loginModel);
						setSessionAttr("AIOFLAG", true);

						List<LoginModel> onlineUsers = getContextAttr("onlineUsers");
						if(onlineUsers == null) {
							onlineUsers = new ArrayList<LoginModel>();
							setContextAttr("onlineUsers", onlineUsers);
						}
						for(int i = 0; i < onlineUsers.size(); i++) {
							LoginModel onlineUser = onlineUsers.get(i);
							if(onlineUser.getSessionId().equals(session.getId())) {
								onlineUsers.remove(i);
								break;
							}
						}
						onlineUsers.add(loginModel);

						String ccmsHost = getContextAttr("ccmsHost");
						if(ccmsHost == null) {
							setSessionAttr("ccmsHost", JFWebConfig.attrMap.get("ccmsHost"));
						}
						String ccmsPort = getContextAttr("ccmsPort");
						if(ccmsPort == null) {
							setSessionAttr("ccmsPort", JFWebConfig.attrMap.get("ccmsPort"));
						}
						String ccmsTelNos = getContextAttr("ccmsTelNos");
						if(ccmsTelNos == null) {
							setSessionAttr("ccmsTelNos", JFWebConfig.attrMap.get("ccmsTelNos"));
						}
						String ccmsFaxNos = getContextAttr("ccmsFaxNos");
						if(ccmsFaxNos == null) {
							setSessionAttr("ccmsFaxNos", JFWebConfig.attrMap.get("ccmsFaxNos"));
						}
						userMap.put(loginAccount, session);
						T_Sys_LoginLog.dao.login(loginIP, loginModel);

						HttpServletRequest request = getRequest();
						String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
						setContextAttr("basePath", basePath);

						String userAgent = request.getHeader("USER-AGENT").toLowerCase();
						if(userAgent.contains("msie")) {
							userAgent = "IE";
						} else if(userAgent.contains("chrome")) {
							userAgent = "Chrome";
						} else if(userAgent.contains("firefox")) {
							userAgent = "Firefox";
						} else if(userAgent.contains("safari")) {
							userAgent = "Safari";
						} else if(userAgent.contains("opera")) {
							userAgent = "Opera";
						} else {
							userAgent = "Other";
						}

						setSessionAttr("userAgent", userAgent);

						redirect("/Main/aioIndex");
						return;
					}
				} else {
					setAttr("msg", "用户已禁用！");
				}
			} else {
				setAttr("msg", "用户名或者密码错误！");
			}
		} else {
			setAttr("msg", "用户名或者密码错误！");
		}
		setAttr("account", loginAccount);
		index();
	}
	@Clear
	public void logout() {
		try {
			LoginModel loginModel = getSessionAttr("loginModel");
			if(loginModel != null) {
				T_Sys_LoginLog.dao.logout(loginModel.getSessionId());
				if(userMap.get(loginModel.getUserAccount()) != null) {
					userMap.get(loginModel.getUserAccount()).invalidate();
					userMap.remove(loginModel.getUserAccount());
				} else {
					getSession().invalidate();
				}
				List<LoginModel> onlineUsers = getContextAttr("onlineUsers");
				if(onlineUsers!=null && onlineUsers.size()>0){
					onlineUsers.remove(loginModel.getSessionId());
				}
			}
			removeAttr("AIOFLAG");
		} catch(Exception e) {
			e.printStackTrace();
		}
		redirect("/AIOLogin/index");
	}
}
