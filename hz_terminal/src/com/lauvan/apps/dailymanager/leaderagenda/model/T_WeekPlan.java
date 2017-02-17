package com.lauvan.apps.dailymanager.leaderagenda.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_weekplan", pk = "id")
public class T_WeekPlan extends Model<T_WeekPlan> {
	private static final long	serialVersionUID	= 1L;
	public static T_WeekPlan	dao					= new T_WeekPlan();

	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String name, String syear, String sweek) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_weekplan t where t.year=").append(syear).append(" and t.weeknum=").append(sweek);
		if(name != null && !"".equals(name)) {
			str.append(" and t.name like '%").append(name).append("%'");
		}
		str.append(" order by id desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
}
