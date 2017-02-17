package com.lauvan.apps.communication.mobileuser.model;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "s_bas_sendtask", pk = "id")
public class S_Bas_SendTask extends Model<S_Bas_SendTask> {
	private static final long		serialVersionUID	= 1L;
	public static S_Bas_SendTask	dao					= new S_Bas_SendTask();

	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String userid, String sendtime) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,u.user_name as senduser";
		StringBuffer str = new StringBuffer();
		str.append(" from s_bas_sendtask t,t_sys_user u where t.SENDER=u.USER_ID and ARRIVER=").append(userid);
		if(StringUtils.isNotBlank(sendtime)) {
			str.append(" and t.TIME like '%").append(sendtime).append("%'");
		}
		str.append(" order by t.id desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

}
