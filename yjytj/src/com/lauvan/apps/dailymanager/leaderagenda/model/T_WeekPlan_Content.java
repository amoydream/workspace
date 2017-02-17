package com.lauvan.apps.dailymanager.leaderagenda.model;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
@TableBind(name="t_weekplan_content",pk="id")
public class T_WeekPlan_Content extends Model<T_WeekPlan_Content> {
	private static final long serialVersionUID = 1L;
	public static T_WeekPlan_Content dao = new T_WeekPlan_Content();
	public List<Record> getlist(String id) {
		String sql="select * from t_weekplan_content where weekplanid='"+id+"' order by type asc";
		return Db.find(sql);
	}
	//获取日程安排id存在的日程详细记录
	public String getampm(String id) {
		String sql="select to_char(wmsys.wm_concat(type)) as list from t_weekplan_content where weekplanid="+id;
		return Db.findFirst(sql).getStr("list");
	}
}
