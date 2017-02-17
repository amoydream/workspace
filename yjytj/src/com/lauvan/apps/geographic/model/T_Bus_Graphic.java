package com.lauvan.apps.geographic.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;


@TableBind(name="t_bus_graphic", pk="g_id")
public class T_Bus_Graphic extends Model<T_Bus_Graphic> {


	private static final long serialVersionUID = 1L;

	public static final T_Bus_Graphic dao=new T_Bus_Graphic();
	
	public T_Bus_Graphic getByEventId(int eventId){
		String sql="select * from t_bus_graphic where eventid=?";
		T_Bus_Graphic record=dao.findFirst(sql, eventId);
		return record;
	}
}
