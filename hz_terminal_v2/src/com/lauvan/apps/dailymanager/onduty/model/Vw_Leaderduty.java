package com.lauvan.apps.dailymanager.onduty.model;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
@TableBind(name="vw_leaderduty",pk="id")
public class Vw_Leaderduty extends Model<Vw_Leaderduty> {
	private static final long serialVersionUID = 1L;
	public static Vw_Leaderduty dao = new Vw_Leaderduty();
	public List<Record> getCalendarDayAll(String start,String end){
		StringBuffer sb = new StringBuffer();
		sb.append("select t.*,to_date(dutydate,'yyyy-MM-dd') as startdate,to_date(dutydate,'yyyy-MM-dd') as enddate from (select v.*,row_number() over(partition by substr(dutydate, 0, 10) order by dutydate desc) row_num");
		sb.append(" from vw_leaderduty v where 1=1");
		sb.append(" and dutydate<='").append(end).append("' and dutydate>='").append(start).append("' order by id desc");
		sb.append(") t where row_num<5");
		return Db.find(sb.toString());
	}
	public Page<Record> getGridPage(Integer pageNum, Integer pageSize,String dateStr, String name) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from vw_leaderduty t where t.dutydate='").append(dateStr).append("'");
		if(name!=null && !"".equals(name)){
			str.append(" and t.leadername like '%").append(name).append("%'");
		}
		str.append(" order by t.id desc ");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
}
