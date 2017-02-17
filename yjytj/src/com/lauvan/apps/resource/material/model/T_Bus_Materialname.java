package com.lauvan.apps.resource.material.model;

import java.math.BigDecimal;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_materialname", pk = "mn_id")
public class T_Bus_Materialname extends Model<T_Bus_Materialname>{

	private static final long serialVersionUID = 5591215954074359182L;
	
	public static final T_Bus_Materialname dao=new T_Bus_Materialname();
	
	public boolean  deleteByIds(String ids){
		String sql = "delete from t_bus_materialname where mn_id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public T_Bus_Materialname getMaterialByMaterialid(BigDecimal manameid) {
		return dao.findFirst(
				"select * from t_bus_Materialname where mn_id=?", manameid);
	}

}
