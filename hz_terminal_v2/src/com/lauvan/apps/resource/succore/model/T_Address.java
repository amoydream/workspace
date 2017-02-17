package com.lauvan.apps.resource.succore.model;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name="t_address", pk="add_code")
public class T_Address extends Model<T_Address>{

	private static final long serialVersionUID = 1L;

	public static T_Address dao = new T_Address();
	
	public boolean insert(T_Address a){
		a.set("add_code", AutoId.nextval(a));
		return a.save();
	}
	
	public Page<Record> getPage(Integer pageSize, Integer pageNum, String personid){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select =  "select a.*  ";
		StringBuffer sb = new StringBuffer(" from t_address a where 1=1 ");
		if(StringUtils.isNotBlank(personid)){
			sb.append(" and a.user_code =").append(personid);
		}
		sb.append(" order by a.DISTINCTION desc");
		return Db.paginate(pageNum, pageSize, select, sb.toString());
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_address a where a.add_code in ("+ids+")";
		Db.update(sql);
	}
	
	/**
	 * 根据志愿者id删除相关的通讯录信息
	 * @param personids
	 */
	public void deleteByPersonids(String personids){
		String sql = "delete from t_address where user_code in ("+personids+")";
		Db.update(sql);
	}
}
