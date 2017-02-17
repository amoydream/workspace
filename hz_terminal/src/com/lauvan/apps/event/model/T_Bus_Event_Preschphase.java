package com.lauvan.apps.event.model;

/**
 * 预案实例流程表
 * */
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.plan.model.T_Bus_PreschPhase;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_bus_event_preschphase", pk = "evphaseid")
public class T_Bus_Event_Preschphase extends Model<T_Bus_Event_Preschphase> {
	private static final long				serialVersionUID	= 1L;
	public static T_Bus_Event_Preschphase	dao					= new T_Bus_Event_Preschphase();

	public boolean insert(String eventid, String planid, String instid) {
		boolean flag = false;
		//根据planid 查询预案的所有流程列表
		List<Record> list = T_Bus_PreschPhase.dao.getAllListByPresch(planid);
		if(list != null && list.size() > 0) {
			for(Record r : list) {
				String phaseid = r.get("phaseid").toString();
				String phasename = r.getStr("phasename");
				String fatherid = r.get("fatherid") == null ? "0" : r.get("fatherid").toString();
				String phasedetail = r.getStr("phasedetail");
				String note = r.getStr("note");
				String phaseorder = r.get("phaseorder").toString();
				T_Bus_Event_Preschphase t = new T_Bus_Event_Preschphase();
				t.set("evphaseid", AutoId.nextval(t));
				t.set("eventid", eventid);
				t.set("preschid", planid);
				t.set("phaseid", phaseid);
				t.set("phasename", phasename);
				t.set("fatherid", fatherid);
				t.set("phasedetail", phasedetail);
				t.set("note", note);
				t.set("phaseorder", phaseorder);
				t.set("instid", instid);
				t.save();
			}
			flag = true;
		}
		return flag;
	}

	//根据实例id删除流程
	public void deleteByInst(String inst) {
		String sql = "delete from t_bus_event_preschphase where instid=" + inst;
		Db.update(sql);
	}
}
