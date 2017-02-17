package com.lauvan.apps.communication.mail.model;

import java.util.Date;
import java.util.HashMap;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.smsmanagement.model.T_Bus_Moblie_To;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name="t_bus_mail_fq",pk="id")
public class T_Bus_Mail_Fq extends Model<T_Bus_Mail_Fq> {
	private static final long	serialVersionUID	= 1L;
	public static T_Bus_Mail_Fq dao = new T_Bus_Mail_Fq();
	
	public boolean insert(T_Bus_Mail_Fq t) {
		String day = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		t.set("marktime", day);
		t.set("id", AutoId.nextval(t));
		return t.save();
	}
	
	public Page<Record> getDelPage(Integer pageSize, Integer pageNumber, String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,e.ev_name ";
		StringBuffer str = new StringBuffer();
		str.append(" from  t_bus_mail_fq t left join t_bus_eventinfo e on t.eventid=e.id where 1=1 ");
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by t.marktime desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString()); 
	}
	
	public boolean deleteByIds(String ids) {
		String sql = "delete from t_bus_mail_fq where id in (" + ids + ")";
		return Db.update(sql) > 0;
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
				+" from t_bus_mail_fq t where t.id="+id;
		return Db.findFirst(sql);
	}
}
