package com.lauvan.apps.communication.mobileuser.model;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
@TableBind(name="s_bas_sendtask",pk="id")
public class S_Bas_SendTask extends Model<S_Bas_SendTask> {
	private static final long serialVersionUID = 1L;
	public static S_Bas_SendTask dao = new S_Bas_SendTask();
	
	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String userid,String sendtime) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,u.user_name as senduser";
		StringBuffer str = new StringBuffer();
		str.append(" from s_bas_sendtask t left join t_sys_user u on t.sender=u.user_id where eventid is null and arriver=").append(userid);
		if(StringUtils.isNotBlank(sendtime)){
			str.append(" and t.time like '%").append(sendtime).append("%'");
		}
		str.append(" order by t.id desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
    }
	
	/***
	 * 根据id获取列表
	 * */
	public List<Record> getLisByIds(String ids){
		String sql = "select s.*,u.realname  from s_bas_sendtask s ,T_MobileUser u where s.ARRIVER=u.ID and s.id in("+ids+") order by s.id asc";
		return Db.find(sql);
	}
	
	public Record getTaskInfo(String id){
		String sql = "select t.*,u.user_name as sname,mu.realname as aname from s_bas_sendtask t left join t_sys_user u on u.user_id=t.sender left join t_mobileuser "
				+ "mu on mu.id = t.arriver where t.id="+id;
		return Db.findFirst(sql);
	}
}
