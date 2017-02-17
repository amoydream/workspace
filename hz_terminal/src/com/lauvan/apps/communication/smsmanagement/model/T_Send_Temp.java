package com.lauvan.apps.communication.smsmanagement.model;

import java.util.Date;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_send_temp", pk = "id")
public class T_Send_Temp extends Model<T_Send_Temp> {
	private static final long	serialVersionUID	= 1L;
	public static T_Send_Temp	dao					= new T_Send_Temp();

	public void insert(T_Send_Temp t) {
		t.set("id", AutoId.nextval(t));
		t.set("uptime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}

	public Page<Record> getPageList(Integer pageSize, Integer pageNumber, String swhere) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select s.* ";
		StringBuffer str = new StringBuffer();
		str.append("  from  t_send_temp s ");
		str.append("where 1=1 ");
		if(swhere != null && !"".equals(swhere)) {
			str.append(swhere);
		}
		str.append(" order by s.id desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}

	public boolean isDelete(String ids, String uid) {
		boolean flag = true;
		String sql = "select * from t_send_temp where id in (" + ids + ") and user_id<>" + uid;
		List<T_Send_Temp> list = dao.find(sql);
		if(list != null && list.size() > 0) {
			flag = false;
		}
		return flag;
	}

	public boolean deleteByIds(String ids) {
		String sql = "delete from t_send_temp where id in (" + ids + ")";
		return Db.update(sql) > 0;
	}
}
