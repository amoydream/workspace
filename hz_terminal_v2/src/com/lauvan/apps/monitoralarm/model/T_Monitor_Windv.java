package com.lauvan.apps.monitoralarm.model;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;


@TableBind(name="t_monitor_windv",pk="wv_id")
public class T_Monitor_Windv extends Model<T_Monitor_Windv>{

	private static final long serialVersionUID = 2889609901387608243L;
	
	public static final T_Monitor_Windv dao = new T_Monitor_Windv();
	
	public List<Record> getData(String sdate, String edate){
		StringBuffer sb = new StringBuffer("select *");
		sb.append(" from ( select  to_char(to_date(m.wv_time, 'yyyy-MM-dd hh24:mi:ss'), 'yyyy-MM-dd') as day ,m.*  from t_monitor_windv m) t where");
		if(StringUtils.isNotBlank(sdate)){
			sb.append(" substr(t.day,0,10)>='").append(sdate).append("'");
		}
		if(StringUtils.isNotBlank(edate)){
			sb.append(" and substr(t.day,0,10) <= '").append(edate).append("'");
		}
		sb.append(" order by wv_time");
		return Db.find(sb.toString());
	}

}
