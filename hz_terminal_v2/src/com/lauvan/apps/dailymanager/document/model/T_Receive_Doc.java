package com.lauvan.apps.dailymanager.document.model;
import java.math.BigDecimal;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
@TableBind(name="t_receive_doc",pk="id")
public class T_Receive_Doc extends Model<T_Receive_Doc> {
	private static final long serialVersionUID = 1L;
	public static T_Receive_Doc dao = new T_Receive_Doc();
	//接收公文
	public Page<Record> getrGridPage(Integer pageNum, Integer pageSize,
			String code,String name, LoginModel loginModel) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,u.user_name as sendername";
		StringBuffer str = new StringBuffer();
		str.append(" from t_receive_doc t,t_sys_user u where t.sender=u.user_id");
		if(code!=null && !"".equals(code)){
			str.append(" and t.code like '%").append(code).append("%'");
		}
		if(name!=null && !"".equals(name)){
			str.append(" and t.name like '%").append(name).append("%'");
		}
		if(!loginModel.getIsAdmin()){
			str.append(" and (','||t.receiver||',' like '%,").append(loginModel.getUserId()).append(",%'");
			T_Sys_Department dpm=T_Sys_Department.dao.findById(loginModel.getOrgId());
			BigDecimal p_did = dpm.getBigDecimal("d_pid");
			while(!p_did.equals(BigDecimal.valueOf(0))){
			str.append(" or ','||t.receiver_dept||',' like '%,").append(dpm.getBigDecimal("d_id")).append(",%'");
			dpm=T_Sys_Department.dao.findById(p_did);
			p_did = dpm.get("d_pid");
			}
			str.append(" or ','||t.receiver_dept||',' like '%,").append(dpm.getBigDecimal("d_id")).append(",%'");
			str.append(")");
		}
		str.append(" order by id desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
	//获取发送公文
	public Page<Record> getsGridPage(Integer pageNum, Integer pageSize,
			String code,String name, LoginModel loginModel) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,u.user_name as sendername";
		StringBuffer str = new StringBuffer();
		str.append(" from t_receive_doc t,t_sys_user u where t.sender=u.user_id");
		if(code!=null && !"".equals(code)){
			str.append(" and t.code like '%").append(code).append("%'");
		}
		if(name!=null && !"".equals(name)){
			str.append(" and t.name like '%").append(name).append("%'");
		}
		if(!loginModel.getIsAdmin()){
			str.append(" and t.sender =").append(loginModel.getUserId());
		}
		str.append(" order by t.sendtime desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
	public T_Receive_Doc getinfo(String id) {
		String sql="select d.*,u.user_name from t_receive_doc d,t_sys_user u where d.sender=u.user_id and d.id="+id;
		return T_Receive_Doc.dao.findFirst(sql);
	}
}
