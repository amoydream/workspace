package com.lauvan.apps.communication.ccms.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "T_CCMS_SETTING", pk = "ID")
public class T_Ccms_Setting extends Model<T_Ccms_Setting> {
	private static final long		serialVersionUID	= 1L;
	public static T_Ccms_Setting	dao					= new T_Ccms_Setting();
}