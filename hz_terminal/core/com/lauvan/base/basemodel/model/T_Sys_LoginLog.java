package com.lauvan.base.basemodel.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_sys_login_log", pk = "sessionid")
public class T_Sys_LoginLog extends Model<T_Sys_LoginLog> {

	private static final long serialVersionUID = 1L;
	
	public static final T_Sys_LoginLog dao=new T_Sys_LoginLog();
	
	/**
	 * 登录日志记录
	 * @param		loginIp		登录IP地址	
	 * @param		user		登录用户对象
	 * @return					返回true/false
	 */
	public boolean login(String loginIp,LoginModel user){
		T_Sys_LoginLog log=new T_Sys_LoginLog();
		
		log.set("sessionid", user.getSessionId());
		log.set("logintype", "正常");
		log.set("logintime", DateTimeUtil.formatDate(new Date(),DateTimeUtil.Y_M_D_HMS_FORMAT));
		log.set("loginip", loginIp);
		log.set("userId", user.getUserId());
		return log.save();
	}
	
	/**
	 * 登出日志记录
	 * @param		sessionId		
	 * @return					
	 */
	public boolean logout(String sessionId){
		T_Sys_LoginLog log=dao.findById(sessionId);
		if(log==null)
			return false;
		log.set("logouttime", DateTimeUtil.formatDate(new Date(),DateTimeUtil.Y_M_D_HMS_FORMAT));
		log.set("logintype", "注销");
		return log.update();
	}
	/**
	 * 查询登陆日志
	 * @param		sessionId		
	 * @return					
	 */
	public Page<Record> getGridPage(Integer pageNum,Integer pageSize,String name, String type){
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,u.user_account,u.user_name";
		StringBuffer str = new StringBuffer();
		str.append(" from t_sys_login_log t,t_sys_user u where t.userid=u.user_id ");
		if(name!=null && !"".equals(name)){
			str.append(" and u.user_name like '%").append(name).append("%'");
		}
		if(type!=null && !"".equals(type)){
			str.append(" and t.logintype ='").append(type).append("'");
		}
		str.append(" order by t.logintime desc ");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
}
