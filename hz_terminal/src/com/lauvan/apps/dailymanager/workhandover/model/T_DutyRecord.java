package com.lauvan.apps.dailymanager.workhandover.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_dutyrecord", pk = "dutyrecord_id")
public class T_DutyRecord extends Model<T_DutyRecord> {
	private static final long	serialVersionUID	= 1L;
	public static T_DutyRecord	dao					= new T_DutyRecord();
}
