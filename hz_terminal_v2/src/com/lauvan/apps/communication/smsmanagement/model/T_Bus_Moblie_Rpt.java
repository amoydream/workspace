package com.lauvan.apps.communication.smsmanagement.model;

import java.util.List;

/**
 * 短信发送报告（回执信息）model类
 * */
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_bus_moblie_rpt", pk = "repeatid")
public class T_Bus_Moblie_Rpt extends Model<T_Bus_Moblie_Rpt> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_Moblie_Rpt	dao					= new T_Bus_Moblie_Rpt();

	public void insert(T_Bus_Moblie_Rpt r) {
		r.set("repeatid", AutoId.nextval(r));
		r.save();
	}
	
	public List<T_Bus_Moblie_Rpt> getListBySmid(String smid){
		String sql = "select * from t_bus_moblie_rpt where sm_id="+smid+" order by rpt_time asc";
		return dao.find(sql);
	}
}
