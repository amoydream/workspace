package com.lauvan.apps.dailymanager.workhandover.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_dutyrecord_son", pk = "id")
public class T_DutyRecord_Son extends Model<T_DutyRecord_Son> {
	private static final long		serialVersionUID	= 1L;
	public static T_DutyRecord_Son	dao					= new T_DutyRecord_Son();
}
