package com.lauvan.apps.dailymanager.onduty.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_leaderduty", pk = "id")
public class T_LeaderDuty extends Model<T_LeaderDuty> {
	private static final long	serialVersionUID	= 1L;
	public static T_LeaderDuty	dao					= new T_LeaderDuty();

	public List<Record> getdutylist(String startdate, String enddate) {
		String sql = "select * from t_leaderduty where dutydate<='" + enddate + "' and dutydate>='" + startdate + "' and dutydate is not null order by dutydate asc";
		return Db.find(sql);
	}

	public String getnamestr(String startdate, String enddate) {
		String sql = "select to_char(wmsys.wm_concat(distinct(leadername))) as namelist from t_leaderduty where dutydate<='" + enddate + "' and dutydate>='" + startdate + "' and dutydate is not null order by dutydate asc";
		return Db.findFirst(sql).getStr("namelist");
	}
}
