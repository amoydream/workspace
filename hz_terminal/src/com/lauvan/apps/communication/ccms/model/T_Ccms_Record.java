package com.lauvan.apps.communication.ccms.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "T_CCMS_RECORD", pk = "CALLID")
public class T_Ccms_Record extends Model<T_Ccms_Record> {
	private static final long	serialVersionUID	= 1L;
	public static T_Ccms_Record	dao					= new T_Ccms_Record();
}