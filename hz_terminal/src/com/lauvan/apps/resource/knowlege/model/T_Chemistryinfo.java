package com.lauvan.apps.resource.knowlege.model;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_chemistryinfo", pk = "chemid")
public class T_Chemistryinfo extends Model<T_Chemistryinfo> {

	private static final long		serialVersionUID	= 1L;
	public static T_Chemistryinfo	dao					= new T_Chemistryinfo();

	public boolean insert(T_Chemistryinfo info) {
		info.set("chemid", AutoId.nextval(info));
		return info.save();
	}

	public void deleteByIds(String ids) {
		String sql = "delete from t_chemistryinfo info where info.chemid in (" + ids + ")";
		Db.update(sql);
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNum, String name, String val) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String select = "select info.* ";
		StringBuffer sb = new StringBuffer(" from t_chemistryinfo info where 1=1 ");
		if(StringUtils.isNotBlank(name) && StringUtils.isNotBlank(val)) {
			if("casno".equals(name)) {
				sb.append(" and info.casno like '%").append(val).append("%' ");
			} else if("chemname".equals(name)) {
				sb.append(" and info.chemname like '%").append(val).append("%' ");
			} else if("column1".equals(name)) {
				sb.append(" and info.column1 like '%").append(val).append("%' ");
			} else if("chemnameen".equals(name)) {
				sb.append(" and info.chemnameen like '%").append(val).append("%' ");
			} else {
				sb.append("and info.achemliasen like '%").append(val).append("%' ");
			}
		}
		sb.append(" order by info.chemid desc ");
		return Db.paginate(pageNum, pageSize, select, sb.toString());
	}

	public T_Chemistryinfo getById(String id) {
		String sql = "select c.*, u.user_name as username from t_chemistryinfo c left join t_sys_user u on c.recordman = u.user_id where c.chemid =" + id;
		return dao.findFirst(sql);
	}
}
