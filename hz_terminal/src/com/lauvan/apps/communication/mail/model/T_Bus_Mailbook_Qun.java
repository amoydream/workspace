package com.lauvan.apps.communication.mail.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_mailbook_qun", pk = "id")
public class T_Bus_Mailbook_Qun extends Model<T_Bus_Mailbook_Qun> {
	private static final long	serialVersionUID	= 1L;
	public static T_Bus_Mailbook_Qun	dao					= new T_Bus_Mailbook_Qun();

	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String name) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_mailbook_qun t where 1=1");
		if(name != null && !"".equals(name)) {
			str.append(" and t.name like '%").append(name).append("%'");
		}
		str.append(" order by t.id desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

	public List<Record> getqunlist() {
		String sql="select * from t_bus_mailbook_qun";
		return Db.find(sql);
	}

	public List<Record> getlist() {
		String sql="select * from t_bus_mailbook order by name asc";
		return Db.find(sql);
	}

	public void deletequn(String id) {
		String sql="delete t_bus_mailbook_qun where id in (select id from t_bus_mailbook_qun start with id="+id+" connect by prior id=pid)";
		Db.update(sql);
	}
}
