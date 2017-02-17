package com.lauvan.apps.event.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_smsrevrd",pk="id")
public class T_Bus_SmsRevRD extends Model<T_Bus_SmsRevRD> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_SmsRevRD dao = new T_Bus_SmsRevRD();
	
	public void insert(T_Bus_SmsRevRD t){
		t.set("id", AutoId.nextval(t));
		t.save();
	}
}
