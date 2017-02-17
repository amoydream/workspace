package com.lauvan.apps.event.model;

import java.util.Date;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_eventreport", pk = "id")
public class T_Bus_EventReport extends Model<T_Bus_EventReport> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_EventReport	dao					= new T_Bus_EventReport();

	public List<Record> getListByEventId(String eid) {
		String sql = "select t.* from t_bus_eventreport t where t.eventid=" + eid + " order by t.marktime desc";
		return Db.find(sql);
	}

	public void insert(T_Bus_EventReport t) {
		t.set("id", AutoId.nextval(t));
		t.set("marktime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}

	//查询ids的状态
	public boolean isStatus(String ids, String uid) {
		boolean flag = true;
		String sql = "select * from t_bus_eventreport where id in (" + ids + ") ";
		if(uid != null && !"".equals(uid)) {
			sql = sql + " and user_id<> " + uid;
		}
		T_Bus_EventReport t = dao.findFirst(sql);
		if(t != null) {
			flag = false;
		}
		return flag;
	}

	public boolean deleteByIDS(String ids) {
		String sql = "delete from t_bus_eventreport where id in(" + ids + ")";
		return Db.update(sql) > 0;
	}
}
