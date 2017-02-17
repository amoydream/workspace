package com.lauvan.apps.massms.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_moblie_mas", pk = "id")
public class T_Bus_Moblie_Mas extends Model<T_Bus_Moblie_Mas> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_Moblie_Mas	dao					= new T_Bus_Moblie_Mas();

	public long getMaxsn() {
		String sql = "select max(sn_id)+1 maxsn from t_bus_moblie_mas";
		Number max = Db.queryNumber(sql);
		if(max == null) {
			return 1;
		}
		return max.longValue();
	}

	public T_Bus_Moblie_Mas getbysntel(String smid, String mobile) {
		String sql = "select * from t_bus_moblie_mas where sn_id=" + smid + " and mobile='" + mobile + "'";
		return dao.findFirst(sql);
	}

}
