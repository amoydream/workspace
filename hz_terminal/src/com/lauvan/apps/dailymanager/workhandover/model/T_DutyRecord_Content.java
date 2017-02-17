package com.lauvan.apps.dailymanager.workhandover.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_dutyrecord_content", pk = "id")
public class T_DutyRecord_Content extends Model<T_DutyRecord_Content> {
	private static final long			serialVersionUID	= 1L;
	public static T_DutyRecord_Content	dao					= new T_DutyRecord_Content();
}
