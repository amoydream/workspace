package com.lauvan.apps.dailymanager.workhandover.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_work_handover", pk = "id")
public class T_Work_Handover extends Model<T_Work_Handover> {
	private static final long		serialVersionUID	= 1L;
	public static T_Work_Handover	dao					= new T_Work_Handover();

	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String givenname, String receivename, String useraccount, String type) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_work_handover t where 1=1 ");
		if(useraccount != null && !"".equals(useraccount)) {
			if(type.equals("g")) {
				str.append(" and t.giveuser='").append(useraccount).append("'");
			} else {
				str.append(" and t.receiveuser='").append(useraccount).append("'");
			}
		}
		if(givenname != null && !"".equals(givenname)) {
			str.append(" and t.givername like '%").append(givenname).append("%'");
		}
		if(receivename != null && !"".equals(receivename)) {
			str.append(" and t.receivename like '%").append(receivename).append("%'");
		}
		str.append(" order by t.dutydate desc ");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

	public List<Record> getlist(String id) {
		String sql = "select h.getduty,d.*,k.d_name from vw_dutyrecord d left join (select e.id,e.ev_name,m.d_name from t_bus_eventinfo e left join t_sys_department m on e.organid=m.d_id) k on k.id=d.eventid,t_work_handover h where  h.dutyid=d.pid and h.id='" + id + "'";
		return Db.find(sql);
	}

}
