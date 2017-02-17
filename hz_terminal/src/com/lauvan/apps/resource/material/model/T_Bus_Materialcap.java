package com.lauvan.apps.resource.material.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_materialcap", pk = "cap_id")
public class T_Bus_Materialcap extends Model<T_Bus_Materialcap> {

	private static final long				serialVersionUID	= 1L;

	public static final T_Bus_Materialcap	dao					= new T_Bus_Materialcap();

	public boolean insert(T_Bus_Materialcap p) {
		p.set("cap_id", AutoId.nextval(p));
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.save();
	}

	public boolean upd(T_Bus_Materialcap p) {
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.update();
	}

	public boolean deleteByIds(String ids) {
		String sql = "delete from t_bus_materialcap where cap_id in (" + ids + ")";
		return Db.update(sql) > 0;
	}

	//根据所属生产企业id删除记录
	public void deleteByMafirmIds(String mafirmids) {
		String sql = "delete from t_bus_materialcap c where c.firmid in (" + mafirmids + ")";
		Db.update(sql);
	}

}
