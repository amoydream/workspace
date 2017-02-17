package com.lauvan.apps.geographic.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name="t_bus_eventcmdpos", pk="id")
public class T_Bus_EventCmdpos extends Model<T_Bus_EventCmdpos>{

	private static final long serialVersionUID = 1L;
	
	public static final T_Bus_EventCmdpos dao = new T_Bus_EventCmdpos();
	
	
	//根据事件id获取
	public T_Bus_EventCmdpos getByEventid(String eventid){
		String sql = "select * from t_bus_eventcmdpos e where e.eventid = ?";
		return dao.findFirst(sql, eventid);
	}
	

}
