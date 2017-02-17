package com.lauvan.apps.geographic.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_bus_mapconfig", pk = "id")
public class T_Bus_MapConfig extends Model<T_Bus_MapConfig> {

	private static final long			serialVersionUID	= 1L;

	public static final T_Bus_MapConfig	dao					= new T_Bus_MapConfig();

	public boolean update(T_Bus_MapConfig c) {
		T_Bus_MapConfig record = getData();
		if(record != null) {
			if(c.getStr("onlinemap").equals("1")) {
				c.set("apiurl", "");
				c.set("gisurl", "");
			}
			c.set("id", record.get("id"));

			return c.update();
		} else {
			c.set("id", AutoId.nextval(c));
			return c.save();
		}

	}

	public T_Bus_MapConfig getData() {
		String sql = "select * from t_bus_mapconfig";
		return dao.findFirst(sql);
	}
}
