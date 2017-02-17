package com.lauvan.apps.attachment.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_template", pk = "id")
public class T_Template extends Model<T_Template> {
	private static final long	serialVersionUID	= 1L;
	public static T_Template	dao					= new T_Template();

	public Page<Record> getPage(Integer pageSize, Integer pageNum, String name, String type) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.* ";
		StringBuffer str = new StringBuffer();
		str.append(" from t_template t where 1=1 ");
		if(name != null && !"".equals(name)) {
			str.append(" and t.name like '%").append(name).append("%'");
		}
		if(type != null && !"".equals(type)) {
			str.append(" and t.m_type  = '").append(type).append("'");
		}
		str.append(" order by t.id desc ");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

	public List<T_Template> getListByIds(String ids) {
		String sql = "select * from t_template where id in (" + ids + ")";
		return dao.find(sql);
	}

	public String insert(T_Template t, String path, String ext) {
		Number id = AutoId.nextval(t);
		t.set("id", id);
		t.set("url", path + "/" + id + ext);
		t.save();
		return id.toString();
	}

	public boolean deleteByIDS(String ids) {
		String sql = "delete from t_template where id in (" + ids + ")";
		return Db.update(sql) > 0;
	}
}
