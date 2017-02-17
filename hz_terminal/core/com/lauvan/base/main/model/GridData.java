package com.lauvan.base.main.model;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class GridData extends Record{
	private static final long serialVersionUID = 1L;
	public static final GridData dao = new GridData();
	
	public List<Record> treeList(String tableName,String pid,String sqlselect,String sqlWhere,String orderName, String sortOrder){
		String sql = "select t.* ";
		if(pid!=null && !"".equals(pid)){
			sql = sql +",case when (select count(*) from "+tableName+" where "+pid+"=t.id) >0"+" then 'closed' else 'open'  end as state ";
		}
		if(sqlselect !=null && !"".equals(sqlselect)){
			sql = sql + sqlselect;
		}
		String sqlExceptSelect=" from "+tableName+" t where "+(StringUtils.isNotBlank(sqlWhere)?sqlWhere:"1=1");
		if(StringUtils.isNotBlank(orderName)){
			sqlExceptSelect+=" order by "+orderName;
			if(StringUtils.isNotBlank(sortOrder))
				sqlExceptSelect+=" "+sortOrder;
		}
		return Db.find(sql+sqlExceptSelect);
	}
}
