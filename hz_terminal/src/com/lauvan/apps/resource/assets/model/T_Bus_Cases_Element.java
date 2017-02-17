package com.lauvan.apps.resource.assets.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_cases_element", pk = "ele_id")
public class T_Bus_Cases_Element extends Model<T_Bus_Cases_Element> {

	private static final long				serialVersionUID	= 5591215954074359182L;

	public static final T_Bus_Cases_Element	dao					= new T_Bus_Cases_Element();

	public boolean insert(T_Bus_Cases_Element p) {
		p.set("ele_id", AutoId.nextval(p));
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.save();
	}

	public boolean upd(T_Bus_Cases_Element p) {
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.update();
	}

	public boolean deleteByIds(String ids) {
		String sql = "delete from t_bus_cases_element where ele_id in (" + ids + ")";
		return Db.update(sql) > 0;
	}

	public T_Bus_Cases_Element getById(Integer id) {
		String sql = "select e.* , a.name as fjname , a.m_size from t_bus_cases_element e left join t_attachment a on e.fjid = a.id where e.ele_id =" + id;
		return dao.findFirst(sql);
	}

	//根据所属案例id删除要素记录
	public void deleteByCasesIds(String casesids) {
		String sql = "delete from t_bus_cases_element c where c.casesid in (" + casesids + ")";
		Db.update(sql);
	}
}
