package com.lauvan.apps.resource.safeguardorg.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

/**
 * 募捐现存资金
 *
 */
@TableBind(name = "t_bus_collfund", pk = "fundid")
public class T_Bus_CollFund extends Model<T_Bus_CollFund> {

	private static final long		serialVersionUID	= 1L;
	public static T_Bus_CollFund	dao					= new T_Bus_CollFund();

	public boolean insert(T_Bus_CollFund fund) {
		fund.set("fundid", AutoId.nextval(fund));
		fund.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return fund.save();
	}

	public boolean upd(T_Bus_CollFund fund) {
		fund.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return fund.update();
	}

	public void deleteByIds(String ids) {
		String sql = "delete from t_bus_collfund c where c.fundid in (" + ids + ")";
		Db.update(sql);
	}

	//根据募捐机构id删除记录
	public void deleteByDeptIds(String deptids) {
		String sql = "delete from t_bus_collfund c where c.deptid in (" + deptids + ")";
		Db.update(sql);
	}

}
