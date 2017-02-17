package com.lauvan.apps.event.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.apps.plan.model.T_Bus_PreschActionDept;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_event_preschactiondept",pk="id")
public class T_Bus_Event_PreschActionDept extends Model<T_Bus_Event_PreschActionDept> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_Event_PreschActionDept dao = new T_Bus_Event_PreschActionDept();
	
	/**
	 * 根据预案复制执行部门
	 * */
	public void insert(String planid,String eventid,String instid,String actid,String evactid){
		List<T_Bus_PreschActionDept> list = T_Bus_PreschActionDept.dao.getListByActionId(actid);
		if(list!=null && list.size()>0){
			for(T_Bus_PreschActionDept d : list){
				T_Bus_Event_PreschActionDept ed = new T_Bus_Event_PreschActionDept();
				ed.set("id", AutoId.nextval(ed));
				ed.set("evactid", evactid);
				ed.set("actid", actid);
				ed.set("instid", instid);
				ed.set("eventid", eventid);
				
				ed.set("actdeptid", d.getStr("actdeptid"));
				ed.set("actdeptname", d.getStr("actdeptname"));
				ed.set("note", d.getStr("note"));
				ed.set("preschid", planid);
				ed.set("acteventtype", d.getStr("acteventtype"));
				ed.set("acteventclass", d.getStr("acteventclass"));
				
				ed.set("actphase", d.getStr("actphase"));
				ed.set("actlinkerman", d.getStr("actlinkerman"));
				ed.set("actlinkertel", d.getStr("actlinkertel"));
				ed.save();
			}
		}
	}
	
	//根据事件预案实例id查找列表
	public List<T_Bus_Event_PreschActionDept> getListByEVactid(String evactid){
		String sql = "select * from t_bus_event_preschactiondept p where p.evactid =?";
		return dao.find(sql, evactid);
	}
	
	//根据evactid删除数据
	public boolean delByEvactid(String evactid){
		String sql = "delete from t_bus_event_preschactiondept p where p.evactid in (?)";
		return Db.update(sql, evactid)>0;
	}
}
