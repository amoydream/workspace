package com.lauvan.apps.resource.assets.model;

import java.math.BigDecimal;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_equipname", pk = "eqn_id")
public class T_Bus_Equipname extends Model<T_Bus_Equipname> {

	private static final long			serialVersionUID	= 5591215954074359182L;

	public static final T_Bus_Equipname	dao					= new T_Bus_Equipname();

	public boolean deleteByIds(String ids) {
		String sql = "delete from t_bus_equipname where eqn_id in (" + ids + ")";
		return Db.update(sql) > 0;
	}

	public T_Bus_Equipname getEquipnameByEquipnameid(BigDecimal eqn_id) {
		return dao.findFirst("select * from t_bus_Equipname where eqn_id=?", eqn_id);
	}

}
