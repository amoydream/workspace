package com.lauvan.apps.event.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_fax_task", pk = "fax_task_id")
public class T_Bus_Fax_Task extends Model<T_Bus_Fax_Task> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_Fax_Task	dao					= new T_Bus_Fax_Task();

	public String insert(T_Bus_Fax_Task t) {
		String id = AutoId.nextval(t).toString();
		t.set("fax_task_id", id);
		t.set("create_time", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
		return id;
	}
}
