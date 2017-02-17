package com.lauvan.apps.dailymanager.eventtj.model;
/**
 * 归档目录类
 * */
import java.util.Date;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_bus_archive",pk="id")
public class T_Bus_Archive extends Model<T_Bus_Archive> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_Archive dao = new T_Bus_Archive();
	
	public List<Record> getTreeList(String time){
		String sql = "select * from t_bus_archive where archivetime='"+time+"' order by marktime desc";
		List<Record> list = Db.find(sql);
		return list;
	}
	
	public List<Record> getListBySupcode(String supcode){
		String sql = "select * from t_bus_archive where 1=1 ";
		if(supcode!=null && !"".equals(supcode)){
			sql = sql + " and supcode='"+supcode+"'";
		}
		sql = sql +" order by marktime desc";
		return Db.find(sql);
	}
	
	public List<Record> getTimeList(String supcode){
		String sql = "select archivetime from t_bus_archive where 1=1 ";
		if(supcode!=null && !"".equals(supcode)){
			sql = sql + " and supcode='"+supcode+"'";
		}
		sql = sql +" group by archivetime order by archivetime desc";
		return Db.find(sql);
	}
	
	public void insert(T_Bus_Archive t){
		t.set("id", AutoId.nextval(t));
		t.set("marktime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}
	
	public T_Bus_Archive getByName(String name){
		String sql = "select * from t_bus_archive where archivename='"+name+"'";
		return dao.findFirst(sql);
	}
}
