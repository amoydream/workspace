package com.lauvan.apps.communication.mail.model;
import java.util.Date;
import java.util.HashMap;

import com.jfinal.plugin.activerecord.Db;
/***
 * 邮件发送列表
 * */
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_bus_mail_to",pk="id")
public class T_Bus_Mail_To extends Model<T_Bus_Mail_To> {
	private static final long	serialVersionUID	= 1L;
	public static T_Bus_Mail_To dao = new T_Bus_Mail_To();
	
	public Page<Record> getSendPage(Integer pageSize, Integer pageNumber, String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,e.ev_name ";
		StringBuffer str = new StringBuffer();
		str.append(" from  t_bus_mail_to t left join t_bus_eventinfo e on t.eventid=e.id where 1=1 ");
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by t.send_time desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString()); 
	}
	
	public void insert(T_Bus_Mail_To t){
		t.set("id", AutoId.nextval(t));
		String day = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		t.set("send_time", day);
		t.set("marktime", day);
		t.set("sender", JFWebConfig.attrMap.get("mailuser"));
		t.save();
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
				+" from t_bus_mail_to t where t.id="+id;
		return Db.findFirst(sql);
	}
	
	public boolean deleteByIds(String ids) {
		String sql = "delete from t_bus_mail_to where id in (" + ids + ")";
		return Db.update(sql) > 0;
	}
	
	//解除事件关联
	public boolean unrelaEventid(String mid) {
		String sql = "update T_Bus_Mail_To t set t.eventid = null  where t.id in('" + mid.replaceAll(",", "','") + "')";
		return Db.update(sql) > 0;
	}
	
	//根据id和 事件ID建立关联关系
	public boolean relaEventid(String mid, String eventid) {
		String sql = "update T_Bus_Mail_To t set t.eventid=" + eventid + " where t.id in('" + mid.replaceAll(",", "','") + "')";
		return Db.update(sql) > 0;
	}
}
