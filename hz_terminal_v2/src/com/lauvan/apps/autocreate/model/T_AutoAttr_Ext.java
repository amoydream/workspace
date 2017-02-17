package com.lauvan.apps.autocreate.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_autoattr_ext",pk="id")
public class T_AutoAttr_Ext extends Model<T_AutoAttr_Ext> {
	private static final long serialVersionUID = 1L;
	public static T_AutoAttr_Ext dao = new T_AutoAttr_Ext();
	
	public void insert(T_AutoAttr_Ext e){
		e.set("id", AutoId.nextval(e));
		e.save();
	}
	/**
	 * 根据视图id删除控件记录
	 * */
	public void deleteByView(String id){
		String sql = "delete from t_autoattr_ext where viewid="+id;
		Db.update(sql);
	}
	
	/**
	 * 根据视图ID获取控件记录
	 * */
	public List<Record> getExtList(String id){
		String sql = "select * from  t_autoattr_ext where viewid="+id;
		return Db.find(sql);
	}
}
