package com.lauvan.apps.resource.assets.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_expertgroup_per", pk = "egp_id")
public class T_Bus_Expertgroup_Per extends Model<T_Bus_Expertgroup_Per>{

	private static final long serialVersionUID = 5591215954074359182L;
	
	public static final T_Bus_Expertgroup_Per dao=new T_Bus_Expertgroup_Per();
	
	public boolean  deleteByIds(String ids){
		String sql = "delete from t_bus_expertgroup_per where egp_id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	//根据所属专家组id删除记录
	public void deleteByExgroupIds(String exgroupids){
		String sql = "delete from t_bus_expertgroup_per c where c.exgroupid in (" + exgroupids +")";
		Db.update(sql);
	}
	
	public boolean  beNullByExpIds(String ids){
		String sql = "update t_bus_expertgroup_per set expertid = NULL where expertid in ("+ids+")";
		return Db.update(sql)>0;
	}
	

}
