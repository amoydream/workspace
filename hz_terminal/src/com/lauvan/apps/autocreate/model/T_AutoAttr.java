package com.lauvan.apps.autocreate.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_autoattr", pk = "id")
public class T_AutoAttr extends Model<T_AutoAttr> {
	private static final long	serialVersionUID	= 1L;
	public static T_AutoAttr	dao					= new T_AutoAttr();

	/**
	 * 根据表名获取表的字段属性
	 * */
	public List<Record> getListByCode(String tcode) {
		String sql = "select * from t_autoattr where tcode='" + tcode + "' order by id asc";
		return Db.find(sql);
	}

	/**
	 * 根据表名删除字段属性记录
	 * */

	public boolean deleteByTcode(String tcode) {
		String sql = "delete from t_autoattr where tcode='" + tcode + "'";
		return Db.update(sql) > 0;
	}

	public void insert(T_AutoAttr attr) {
		attr.set("id", AutoId.nextval(attr));
		attr.save();
	}
}
