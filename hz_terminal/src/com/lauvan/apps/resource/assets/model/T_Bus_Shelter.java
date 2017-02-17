package com.lauvan.apps.resource.assets.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_shelter", pk = "she_id")
public class T_Bus_Shelter extends Model<T_Bus_Shelter> {

	private static final long			serialVersionUID	= 5591215954074359182L;

	public static final T_Bus_Shelter	dao					= new T_Bus_Shelter();

	public boolean deleteByIds(String ids) {
		String sql = "delete from t_bus_shelter where she_id in (" + ids + ")";
		return Db.update(sql) > 0;
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNum, String name, String paramsCode) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String select = "select she.*,params.id p_id,params.p_name,dept.d_name ";
		StringBuffer sql = new StringBuffer(" from T_BUS_SHELTER she left join (select p2.* from t_sys_parameter p1,t_sys_parameter p2 where p1.id=p2.sup_id and p1.p_acode='" + (paramsCode.isEmpty() ? "" : paramsCode) + "') params on she.type=params.p_acode left join  t_sys_department dept on she.organid=dept.d_id where 1=1");
		if(name != null && !"".equals(name)) {
			sql.append("and name like '%").append(name).append("%' ");
		}
		sql.append(" order by she_id desc");
		return Db.paginate(pageNum, pageSize, select, sql.toString());
	}
}
