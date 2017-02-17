package com.lauvan.apps.resource.material.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_store", pk = "sto_id")
public class T_Bus_Store extends Model<T_Bus_Store> {

	private static final long		serialVersionUID	= 5591215954074359182L;

	public static final T_Bus_Store	dao					= new T_Bus_Store();

	public boolean deleteByIds(String ids) {
		String sql = "delete from t_bus_store where sto_id in (" + ids + ")";
		return Db.update(sql) > 0;
	}

	public boolean beNullByMaIds(String ids) {
		String sql = "update t_bus_store set materialid = NULL where materialid in (" + ids + ")";
		return Db.update(sql) > 0;
	}

	public boolean beNullByReIds(String ids) {
		String sql = "update t_bus_store set repertoryid = NULL where repertoryid in (" + ids + ")";
		return Db.update(sql) > 0;
	}
	public List<Record> getListbymatid(Integer itemid) {
	String 	sql="select * from t_bus_store u left join t_bus_repertory b on b.rep_id = u.repertoryid left join t_bus_materialname m on u.materialid= m.mn_id left join t_sys_parameter p on m.type= p.id where u.materialid="+itemid;
	return Db.find(sql);
	}
	public Page<Record> getPagebymatid(Integer pageNum, Integer pageSize,Integer itemid) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		// TODO Auto-generated method stub
		String sql = "select *";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_store u left join t_bus_repertory b on b.rep_id = u.repertoryid left join t_bus_materialname m on u.materialid= m.mn_id left join t_sys_parameter p on m.type= p.id where u.materialid=").append(itemid);
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
}
