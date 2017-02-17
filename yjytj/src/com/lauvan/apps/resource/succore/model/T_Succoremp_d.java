package com.lauvan.apps.resource.succore.model;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name="t_succoremp_d", pk="persid")
public class T_Succoremp_d extends Model<T_Succoremp_d>{

	private static final long serialVersionUID = 1L;

	public static T_Succoremp_d dao = new T_Succoremp_d();
	
	public boolean insert(T_Succoremp_d d){
		d.set("persid", AutoId.nextval(d));
		return d.save();
	}
	public Page<Record> getPage(Integer pageSize, Integer pageNum, String personid){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select d.* ";
		StringBuffer sb = new StringBuffer(" from t_succoremp_d d where 1=1 ");
		if(StringUtils.isNotBlank(personid)){
			sb.append(" and d.personid=").append(personid);
		}
		sb.append(" order by d.starttime");
		return Db.paginate(pageNum, pageSize, select, sb.toString());
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_succoremp_d where persid in ("+ ids + ")";
		Db.update(sql);
	}
	
	public T_Succoremp_d getByIds(String id){
		String sql = "select * from t_succoremp_d d left join t_sys_user u on d.recid = u.user_id where d.persid ="+id;
		return dao.findFirst(sql);
	}
	
	/**
	 * 根据志愿者ID删除有关简历信息
	 * @param personids
	 */
	public void deleteByPersonid(String personids){
		String sql = "delete from t_succoremp_d d where d.personid in("+personids+")";
		Db.update(sql);
	}
}
