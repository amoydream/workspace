package com.lauvan.apps.event.model;

import java.util.Date;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_bus_eventappnews",pk="id")
public class T_Bus_EventAppNews extends Model<T_Bus_EventAppNews> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_EventAppNews dao = new T_Bus_EventAppNews();
	
	public List<Record> getListByEid(String eventid){
		String sql = "select * from t_bus_eventappnews where eventid="+eventid+" order by createtime desc";
		return Db.find(sql);
	}
	
	public void insert(T_Bus_EventAppNews t){
		t.set("id", AutoId.nextval(t));
		t.set("createtime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}
}
