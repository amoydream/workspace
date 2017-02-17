package com.lauvan.apps.communication.mail.model;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_bus_mail_rece",pk="id")
public class T_Bus_Mail_Rece extends Model<T_Bus_Mail_Rece> {
	private static final long	serialVersionUID	= 1L;
	public static T_Bus_Mail_Rece dao = new T_Bus_Mail_Rece();
	
	public void insert(T_Bus_Mail_Rece t){
		t.set("id", AutoId.nextval(t));
		t.set("marktime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}
	
	//查询最大序号
	public Integer getMaxSeq(){
		String sql = "select max(t.emseq)  from t_bus_mail_rece t";
		Number max = Db.queryNumber(sql);
		if(max!=null){
			return max.intValue();
		}else{
			return 0;
		}
	}
	
	public Page<Record> getRecePage(Integer pageSize, Integer pageNumber, String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,e.ev_name ";
		StringBuffer str = new StringBuffer();
		str.append(" from  t_bus_mail_rece t left join t_bus_eventinfo e on t.eventid=e.id where 1=1 ");
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by t.send_time desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString()); 
	}
	
	public Record getById(String id){
		HashMap<String, String>	attrMap		= JFWebConfig.attrMap;
		String mailuser =  attrMap.get("mailuser");
		String replaceaddto = "t.address_to";
		String replaceaddcc = "t.address_cc";
		String replacesender = "t.sender";
		if(mailuser!=null && !"".equals(mailuser)){
			mailuser = mailuser.substring(0,mailuser.indexOf("@"));
			replaceaddto = "replace(t.address_to,'"+mailuser+"<','我<')";
			replaceaddcc = "replace(t.address_cc,'"+mailuser+"<','我<')";
			replacesender = "replace(t.sender,'"+mailuser+"<','我<')";
		}
		String sql = "select t.*,replace(replace("+replaceaddto+",'<','＜'),'>','＞') as address_toname"
					+",replace(replace("+replaceaddcc+",'<','＜'),'>','＞') as address_ccname"
					+",replace(replace("+replacesender+",'<','＜'),'>','＞') as sendername"
					+" from t_bus_mail_rece t where t.id="+id;
		//String sql = "select t.* from t_bus_mail_rece t where t.id="+id;
		return Db.findFirst(sql);
	}
	
	//解除事件关联
	public boolean unrelaEventid(String mid) {
		String sql = "update T_Bus_Mail_Rece t set t.eventid = null  where t.id in('" + mid.replaceAll(",", "','") + "')";
		return Db.update(sql) > 0;
	}
	
	//根据id和 事件ID建立关联关系
	public boolean relaEventid(String mid, String eventid) {
		String sql = "update T_Bus_Mail_Rece t set t.eventid=" + eventid + " where t.id in('" + mid.replaceAll(",", "','") + "')";
		return Db.update(sql) > 0;
	}
}
