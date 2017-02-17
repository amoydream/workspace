package com.lauvan.apps.event.model;

/**
 * 事件预案关联实例（启动预案）
 * */
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_bus_presch_instance", pk = "id")
public class T_Bus_Presch_Instance extends Model<T_Bus_Presch_Instance> {
	private static final long			serialVersionUID	= 1L;
	public static T_Bus_Presch_Instance	dao					= new T_Bus_Presch_Instance();

	/**
	 * 根据事件ID查询已启动的预案列表
	 * */
	public Page<Record> getPageByEventid(Integer pageSize, Integer pageNumber, String eventid) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select p.*,t.preschname as planname";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_presch_instance p,t_bus_preschinfo t where p.plan_id=t.id ");
		str.append(" and p.event_id=").append(eventid);
		str.append(" order by p.start_time asc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}

	public String insert(T_Bus_Presch_Instance t) {
		String id = AutoId.nextval(t).toString();
		t.set("id", id);
		t.save();
		return id;
	}

	public List<Record> getACTList(String instid) {
		String sql = "select x.* from(" + "select p.*,t.actname,t.actid,t.actcode,t.actcont,t.actdetail,decode(t.istempact,'Y','临时行动','N','来自预案','') as istempact" + ",decode(t.actstatus,'U','未执行','E','正在执行','D','执行完成','F','执行失败','') as actstatus from " + "(select p1.phaseorder,p1.fatherid,p1.eventid,p1.preschid,p1.phaseid,p1.instid,p1.phasename as phasename1,'' as phasename2 from t_bus_event_preschphase p1 " + "where p1.fatherid=0 and p1.instid=" + instid + " union select p2.phaseorder,p2.fatherid,p2.eventid,p2.preschid,p2.phaseid,p2.instid,'' as phasename1" + ",p2.phasename as phasename2 from t_bus_event_preschphase p2 where p2.fatherid<>0  and p2.instid=" + instid + ")p left join t_bus_event_preschaction t on p.phaseid=t.actphase and t.instid=p.instid " + " ) x start with x.fatherid=0 connect by prior x.phaseid=x.fatherid";
		return Db.find(sql);
	}

	public boolean isPlanInst(String planid, String eventid) {
		boolean flag = false;
		String sql = "select * from t_bus_presch_instance where plan_id=" + planid + " and event_id=" + eventid;
		List<Record> list = Db.find(sql);
		if(list != null && list.size() > 0) {
			flag = true;
		}
		return flag;
	}
}
