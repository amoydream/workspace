package com.lauvan.apps.resource.succore.model;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_succoremp", pk = "personid")
public class T_Succoremp extends Model<T_Succoremp> {

	private static final long	serialVersionUID	= 1L;
	public static T_Succoremp	dao					= new T_Succoremp();

	public boolean insert(T_Succoremp s) {
		s.set("personid", AutoId.nextval(s));
		return s.save();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNum, String name, String type) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String select = "select s.* ";
		StringBuffer sb = new StringBuffer(" from t_succoremp s where 1=1 ");
		if(StringUtils.isNotBlank(name)) {
			sb.append(" and s.personname like '%").append(name).append("%' ");
		}
		if(StringUtils.isNotBlank(type)) {
			sb.append(" and s.personsortid = '").append(type).append("'");
		}
		sb.append(" order by s.personid desc");
		return Db.paginate(pageNum, pageSize, select, sb.toString());
	}

	public String getOpidsByIds(String ids) {
		String sql = "select wm_concat(s.opid) from t_succoremp s where s.personid in (" + ids + ")";
		return Db.queryStr(sql);
	}

	public void deleteByIds(String ids) {
		String sql = "delete from t_succoremp s where s.personid in (" + ids + ")";
		Db.update(sql);
	}

	public T_Succoremp getById(String personid) {
		String sql = "select s.* , u.user_name as username from t_succoremp s left join t_sys_user u on s.recid = u.user_id where s.personid =" + personid;
		return dao.findFirst(sql);

	}
}
