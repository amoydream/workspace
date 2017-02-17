package com.lauvan.apps.event.model;

/**
 * 预案实例行动表
 * **/
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.plan.model.T_Bus_PreschAction;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_bus_event_preschaction", pk = "evactid")
public class T_Bus_Event_PreschAction extends Model<T_Bus_Event_PreschAction> {
	private static final long				serialVersionUID	= 1L;
	public static T_Bus_Event_PreschAction	dao					= new T_Bus_Event_PreschAction();

	public void insert(String planid, String eventid, String instid) {
		List<Record> list = T_Bus_PreschAction.dao.getAllListByPresch(planid);
		if(list != null && list.size() > 0) {
			for(Record r : list) {
				String actid = r.get("actid").toString();
				String actphase = r.get("actphase").toString();
				String actname = r.getStr("actname");
				String actcode = r.getStr("actcode");
				String actcont = r.getStr("actcont");
				String note = r.getStr("note");
				String actorder = r.get("actorder").toString();
				T_Bus_Event_PreschAction a = new T_Bus_Event_PreschAction();
				a.set("evactid", AutoId.nextval(a));
				a.set("eventid", eventid);
				a.set("preschid", planid);
				a.set("instid", instid);
				a.set("actid", actid);
				a.set("actphase", actphase);
				a.set("actname", actname);
				a.set("actcode", actcode);
				a.set("actorder", actorder);
				a.set("actcont", actcont);
				a.set("note", note);
				a.set("istempact", "N");
				a.set("actstatus", "U");
				a.save();
			}
		}
	}

	//根据实例id删除行动
	public void deleteByInst(String inst) {
		String sql = "delete from t_bus_event_preschaction where instid=" + inst;
		Db.update(sql);
	}
}
