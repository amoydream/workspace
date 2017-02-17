package com.lauvan.apps.event.model;
/**
 * 值班要情快报信息表
 * */
import java.util.Date;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_bus_eventdutyreport",pk="id")
public class T_Bus_EventDutyReport extends Model<T_Bus_EventDutyReport> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_EventDutyReport dao = new T_Bus_EventDutyReport();
	
	//插入
	public void insert(T_Bus_EventDutyReport t){
		t.set("id", AutoId.nextval(t));
		t.set("marktime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}
	//根据专报id获取快报
	public T_Bus_EventDutyReport getByERID(String erid){
		String sql = "select * from T_Bus_EventDutyReport where er_id="+erid;
		return dao.findFirst(sql);
	}
	
	public Page<Record> getPageList(Integer pageSize,Integer pageNumber,String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select e.* ";
		StringBuffer  str = new StringBuffer();
		str.append("  from  ");
		str.append("(select d.*,decode(d.eventid,null,null,(select to_char(wmsys.wm_concat(f.ev_name)) from t_bus_eventinfo f ");
		str.append("where ','||d.eventid||',' like '%,'||f.id||',%' )) as evname,u.user_name as username from ");
		str.append("  t_bus_eventdutyreport d,t_sys_user u where d.user_id=u.user_id ) e ");
		if(swhere!=null && !"".equals(swhere)){
			str.append(" where 1=1 ").append(swhere);
		}
		str.append(" order by e.marktime desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	//查询ids的状态
	public boolean isCreate(String ids,String uid){
		boolean flag = true;
		String sql = "select * from t_bus_eventdutyreport where id in ("+ids+") ";
		if(uid!=null && !"".equals(uid)){
			sql = sql +" and user_id<> "+uid;
		}
		T_Bus_EventDutyReport t = dao.findFirst(sql);
		if(t!=null){
			flag = false;
		}
		return flag;
	}
	
	public boolean  deleteByIDs(String ids){
		String sql = "delete from t_bus_eventdutyreport where id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public List<T_Bus_EventDutyReport> getListByIds(String ids){
		String sql = "select * from t_bus_eventdutyreport where id in ("+ids+")";
		return dao.find(sql);
	}
}
