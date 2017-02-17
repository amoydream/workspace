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
import com.jfinal.plugin.activerecord.Db;
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

@RouteBind(path = "/Login", viewPath = "/base")
public class LoginController extends BaseController {
	public static Map<String, HttpSession> userMap = new HashMap<String, HttpSession>();

	@Clear
	public void index() {
		if(getSessionAttr("loginModel") == null) {
			render("../web/front/default.jsp");
		} else {
			redirect("/Main");
		}
	}

	@Clear
	public void doLogin() {
		String loginAccount = getPara("loginAccount");
		String loginPwd = getPara("loginPwd");
		setAttr("loginAccount", loginAccount);
		setAttr("loginPwd", loginPwd);
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
		String forceLogin = getPara("forceLogin");
		if(user != null) {
			if(user.get("password").equals(Pwd.encrypt(loginPwd))) {
				if("1".equals(user.getStr("status"))) {
					if(userMap.containsKey(loginAccount)) {
						if("Y".equals(forceLogin)) {
							T_Sys_LoginLog.dao.logout(userMap.get(loginAccount).getId());
							try {
								userMap.get(loginAccount).invalidate();
							} catch(Exception e) {
								System.out.println("session已注销！");
							}
							userMap.remove(loginAccount);
						} else {
							msg = "用户【" + user.getStr("USER_NAME") + "】已登录, 可选择【强行登录】进入系统";
							setAttr("msg", msg);
							index();
							return;
						}
					}

					List<LoginModel> onlineUsers = getContextAttr("onlineUsers");
					String loginIP = IpAddr.getIpAddr(getRequest());
					/*if(onlineUsers != null && onlineUsers.size() > 0) {
						for(int i = 0; i < onlineUsers.size(); i++) {
							LoginModel onlineUser = onlineUsers.get(i);
							String ip = onlineUser.getLoginIP();
							String userAccount = onlineUser.getUserAccount();
							if(ip.equals(loginIP)) {
								if("Y".equals(forceLogin)) {
									if(userMap.containsKey(userAccount)) {
										T_Sys_LoginLog.dao.logout(userMap.get(userAccount).getId());
										try {
											userMap.get(userAccount).invalidate();
										} catch(Exception e) {
											System.out.println("session已注销！");
										}
										userMap.remove(userAccount);
									}
									break;
								} else {
									msg = "IP【" + loginIP + "】已被【" + user.getStr("USER_NAME") + "】暂用, 可选择【强行登录】进入系统";
									setAttr("msg", msg);
									index();
									return;
								}
							}
						}
					}*/

					Number user_id = user.getNumber("user_id");
					LoginModel loginModel = new LoginModel();
					loginModel.setUserId(user_id);
					loginModel.setUserAccount(user.getStr("user_account"));
					loginModel.setUserName(user.getStr("user_name"));

					loginModel.setSeatID(user.getStr("SEATID"));
					loginModel.setUgrpNO(user.getNumber("UGRPNO").intValue());
					loginModel.setCallLevel(user.getNumber("CALLLEVEL").intValue());
					loginModel.setOpLevel(user.getNumber("OPLEVEL").intValue());

					HttpSession session = getSession(true);
					loginModel.setSessionId(session.getId());
					T_Sys_Department dept = null;
					if(null != user.get("dept_id")) {
						dept = T_Sys_Department.dao.findById(user.get("dept_id"));
						if(dept != null) {
							loginModel.setOrgCode(dept.getStr("d_number"));
							loginModel.setOrgName(dept.getStr("d_name"));
							loginModel.setOrgId(dept.getNumber("d_id"));

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
					String leaderRole = Db.queryStr("SELECT ROLE_NAME FROM T_SYS_ROLE WHERE ROLE_NAME='值班领导' AND ROLE_ID IN (SELECT ROLE_ID FROM T_SYS_USERROLES WHERE USER_ID = " + user_id + ")");
					loginModel.setLeader(leaderRole != null);

					List<T_Sys_Role> roleList = T_Sys_Role.dao.getRoles(loginModel.getUserId().toString());
					//是否有ccms权限
					T_Sys_Role roleccms = T_Sys_Role.dao.getroleccms(loginModel.getUserId().toString());
					if(roleccms != null) {
						setSessionAttr("CCMSRole", true);
					} else {
						setSessionAttr("CCMSRole", false);
					}
					if(roleList == null || roleList.size() == 0) {
						setAttr("msg", "您没有权限登录，请联系管理员添加角色！");
						loginModel.setLimit("");
					} else {
						String menuIds = "";
						for(T_Sys_Role role : roleList) {
							String temp = role.getStr("opt_permissions");
							menuIds += temp != null ? temp + "," : "";
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
							if(excludeFunIds != null) {
								loginModel.setXdlimit(ArrayUtils.ArrayToString(excludeFunIds));
							}
						}

						loginModel.setLoginIP(loginIP);
						Number dept_id = dept.getNumber("D_ID");
						setSessionAttr("loginModel", loginModel);

						if(onlineUsers == null) {
							onlineUsers = new ArrayList<LoginModel>();
							setContextAttr("onlineUsers", onlineUsers);
						}
						for(int i = 0; i < onlineUsers.size(); i++) {
							LoginModel onlineUser = onlineUsers.get(i);
							if(onlineUser.getSessionId().equals(session.getId()) || onlineUser.getUserId() == loginModel.getUserId()) {
								onlineUsers.remove(i);
								break;
							}
						}
						onlineUsers.add(loginModel);

						userMap.put(loginAccount, session);
						T_Sys_LoginLog.dao.login(loginIP, loginModel);

						HttpServletRequest request = getRequest();
						String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
						setSessionAttr("basePath", basePath);

						String userAgent = request.getHeader("USER-AGENT").toLowerCase();
						if(userAgent.contains("msie") || userAgent.contains("rv:11.0")) {
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
						setSessionAttr("sysconf", JFWebConfig.attrMap);

						redirect("/Main");
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
		} catch(Exception e) {
			e.printStackTrace();
		}
		redirect("/Login/index");
	}
}
