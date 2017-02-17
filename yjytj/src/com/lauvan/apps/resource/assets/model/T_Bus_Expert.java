package com.lauvan.apps.resource.assets.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_expert", pk = "ex_id")
public class T_Bus_Expert extends Model<T_Bus_Expert>{

	private static final long serialVersionUID = 5591215954074359182L;
	
	public static final T_Bus_Expert dao=new T_Bus_Expert();
	
	public boolean  deleteByIds(String ids){
		String sql = "delete from t_bus_expert where ex_id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public Page<Record> getPage(Integer pageSize, Integer pageNum, String name){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select e.*,p.p_name,p.id p_id ";
		StringBuffer sql = new StringBuffer(" from t_bus_expert e left join t_sys_parameter p on e.typeid=p.id where 1=1  ");
		if(name != null && !"".equals(name)){
			sql.append("and name like '%").append(name).append("%' ");
		}
		sql.append(" order by ex_id desc");
		return Db.paginate(pageNum, pageSize, select, sql.toString());
	}
}
