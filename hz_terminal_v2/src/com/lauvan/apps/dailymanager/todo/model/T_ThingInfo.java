package com.lauvan.apps.dailymanager.todo.model;
import java.math.BigDecimal;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
@TableBind(name="t_thinginfo",pk="id")
public class T_ThingInfo extends Model<T_ThingInfo> {
	private static final long serialVersionUID = 1L;
	public static T_ThingInfo dao = new T_ThingInfo();
	public Page<Record> getallGridPage(Integer pageNum, Integer pageSize,
			String code, String name, LoginModel loginModel, String type) {
			pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
			pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
			String sql = "select t.*,u.user_name";
			StringBuffer str = new StringBuffer();
			str.append(" from t_thinginfo t,t_sys_user u where t.recordman=u.user_id");
			if(code!=null && !"".equals(code)){
				str.append(" and t.code like '%").append(code).append("%'");
			}
			if(name!=null && !"".equals(name)){
				str.append(" and t.name like '%").append(name).append("%'");
			}
			if(!loginModel.getIsAdmin()){
				str.append(" and (','||t.receiver||',' like '%,").append(loginModel.getUserId()).append(",%'");
				if(type==null || "".equals(type)){
				str.append(" or ','||t.RECORDMAN||',' like '%,").append(loginModel.getUserId()).append(",%'");	
				}
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
			if(type!=null && !"".equals(type)){
				if(type.equals("0")){
					str.append(" and (t.THINGSTATUS=").append(type).append(" and ','||readed||',' not like '%").append(loginModel.getUserId()).append(",%')");	
				}else{
					str.append(" and (t.THINGSTATUS=").append(type).append(" or ','||readed||',' like '%").append(loginModel.getUserId()).append(",%')");
				}					
			}
			str.append(" order by t.id desc");
			return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
	//根据id获取事宜信息
	public T_ThingInfo getinfo(String id,String type) {
		String head="";
		String from="";
		String where="";
		if(type.equals("001")){
			head=",b.ev_name";
			from=",t_bus_eventinfo b";
			where=" and t.code=b.id";
		}
		String sql="select t.*,u.user_name"+head+" from t_thinginfo t,t_sys_user u"+from+" where t.recordman=u.user_id"+where+" and t.id="+id;
		return T_ThingInfo.dao.findFirst(sql);
	}
}
