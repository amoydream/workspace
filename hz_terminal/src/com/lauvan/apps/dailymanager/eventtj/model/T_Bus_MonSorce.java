package com.lauvan.apps.dailymanager.eventtj.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name = "t_bus_monsorce", pk = "id")
public class T_Bus_MonSorce extends Model<T_Bus_MonSorce> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_MonSorce dao = new T_Bus_MonSorce();
	
	public T_Bus_MonSorce getMonSorce(String tjtime,String organname){
		if(tjtime==null || "".equals(tjtime)){
			return null;
		}
		String sql = "select * from T_Bus_MonSorce where organname ='"+organname+"' and montime='"+tjtime+"'";
		return dao.findFirst(sql);
	}
	//一年内的上一次累计得分
	public float getlastSorce(String year, String mon,String organname){
		if("01".equalsIgnoreCase(mon)){
			return 0;
		}
		String sql = "select sum(bydf) as ljdf from T_Bus_MonSorce where   organname ='"+organname+"' and montime<'"+year+"-"+mon+"' and montime>='"+year+"-01'";
		Record r = Db.findFirst(sql);
		if(r!=null && r.get("ljdf")!=null){
			if(r.getNumber("ljdf").floatValue()>0){
				return r.getNumber("ljdf").floatValue();
			}else{
				return 0;
			}
		}else{
			return 0;
		}
		
	}
	
	public void insert(T_Bus_MonSorce t){
		t.set("id", AutoId.nextval(t));
		t.save();
	}
}
