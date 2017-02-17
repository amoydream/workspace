package com.lauvan.base.basemodel.model;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.IpAddr;
@TableBind(name="t_sys_operation_log",pk="id")
public class T_Sys_Operation_Log extends Model<T_Sys_Operation_Log> {
	private static final long serialVersionUID = 1L;
	public static T_Sys_Operation_Log dao = new T_Sys_Operation_Log();
	/**
	 * 插入操作记录
	 * */
	public void insert(T_Sys_Operation_Log t){
		t.set("id", AutoId.nextval(t));
		t.set("opt_time", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}
	/**
	 * 插入操作记录
	 * @param	success		是否操作成功标志
	 * @param	userid		当前操作人ID
	 * @param	maddress	访问路径
	 * @param	methodname	方法名称
	 * @param	model		实体model
	 * @param httpServletRequest 
	 * */
	public void insert(boolean success,String userid,String maddress,String methodname,Model<?> model, HttpServletRequest Request){
		T_Sys_Module module=T_Sys_Module.dao.getByAddress(maddress);
		T_Sys_Operation_Log log = new T_Sys_Operation_Log();
		log.set("id", AutoId.nextval(log));
		log.set("opt_time", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		log.set("opt_user", userid);
		log.set("status", success?"1":"0");
		log.set("opt_moudle", module.get("id"));
		log.set("login_ip", IpAddr.getIpAddr(Request));
		String opt_type = "0";
		StringBuffer content = new StringBuffer();
		if("add".equals(methodname)){
			opt_type = "1";
			content.append("新增：");
		}else if("update".equals(methodname)|| "edit".equals(methodname)){
			opt_type = "2";
			content.append("修改：");
		}else if("delete".equals(methodname)){
			opt_type = "3";
			content.append("删除：");
		}else{
			opt_type = "4";
		}
		log.set("opt_type", opt_type);
		if(model!=null){
			String str =  model.toJson();
			content.append(str);
		}
		log.set("content",content.toString());
		log.save();
	}
	public Page<Record> getGridPage(Integer pageNum,Integer pageSize,String name, String type, String status){
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,u.user_account,u.user_name,m.name mname";
		StringBuffer str = new StringBuffer();
		str.append(" from t_sys_operation_log t,t_sys_user u,t_sys_module m where t.opt_user=u.user_id and t.opt_moudle=m.id ");
		if(name!=null && !"".equals(name)){
			str.append(" and u.user_name like '%").append(name).append("%'");
		}
		if(type!=null && !"".equals(type)){
			str.append(" and t.opt_type ='").append(type).append("'");
		}
		if(status!=null && !"".equals(status)){
			str.append(" and t.status ='").append(status).append("'");
		}
		str.append(" order by t.id desc ");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
}
