package com.lauvan.apps.event.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_smssendrd",pk="smsid")
public class T_Bus_SmsSendRD extends Model<T_Bus_SmsSendRD> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_SmsSendRD dao = new T_Bus_SmsSendRD();
	
	public Page<Record> getPageByEventid(Integer pageSize,Integer pageNumber,String eventid){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select s.*,decode(s.sendstate,'V','发送中','T','成功','F','失败') as smsstate,e.ev_name"
					+",decode(s.callname,null,null,(select v.deptname from vw_address v where s.callno = v.telphone and rownum=1)) as deptname"
					+",case when (select  count(r.id) from t_bus_smsrevrd r where r.smsid=s.smsid and r.callno=s.callno)>0"
					+" then '有回执' else '无回执' end as isrev "
					+",decode(s.smsid,null,null,(select r.smsdata from t_bus_smsrevrd r where r.smsid=s.smsid and r.callno=s.callno))"
					+" as bak_rd ";
		StringBuffer  str = new StringBuffer();
		str.append("  from t_bus_smssendrd s ,t_bus_eventinfo e ");
		str.append(" where s.eventid=e.id and s.eventid=").append(eventid);
		str.append(" order by s.sendtime desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	public void insert(T_Bus_SmsSendRD t){
		t.set("id", AutoId.nextval(t));
		t.save();
	}
	
	//根据callno 获取callname
	public String getCallName(String callno){
		String sql = "select add_name from vw_address where telphone='"+callno+"'";
		Record r = Db.findFirst(sql);
		//String callname = Db.queryStr(sql);
		return r==null?"":r.getStr("add_name");
	}
	
	public T_Bus_SmsSendRD getBySmsId(String smsid,String mobile){
		String sql = "select * from t_bus_smssendrd where smsid='"+smsid+"' and callno='"+mobile+"'";
		return dao.findFirst(sql);
	}
	public void deleteBySmids(String smids){
		String sql ="delete from t_bus_smssendrd t where t.smsid in('" + smids.replaceAll(",", "','") + "')";
		Db.update(sql);
	}
}
