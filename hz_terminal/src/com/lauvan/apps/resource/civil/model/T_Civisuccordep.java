package com.lauvan.apps.resource.civil.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

/**
 * 民间救援组织
 *
 */
@TableBind(name = "t_civisuccordep", pk = "deptid")
public class T_Civisuccordep extends Model<T_Civisuccordep> {

	private static final long		serialVersionUID	= 1L;
	public static T_Civisuccordep	dao					= new T_Civisuccordep();

	public boolean insert(T_Civisuccordep c) {
		c.set("deptid", AutoId.nextval(c));
		return c.save();
	}

	/**
	 * 返回列表记录
	 * @param pageSize
	 * @param pageNum
	 * @param name 名称
	 * @param type 类别
	 * @return
	 */
	public Page<Record> getPage(Integer pageSize, Integer pageNum, String name) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String select = "select * ";
		StringBuffer sql = new StringBuffer(" from t_civisuccordep where 1=1 ");
		if(name != null && !"".equals(name)) {
			sql.append("and deptname like '%").append(name).append("%' ");
		}
		sql.append(" order by deptid desc");
		return Db.paginate(pageNum, pageSize, select, sql.toString());

	}

	public T_Civisuccordep getById(String id) {
		if(id.matches("[0-9]+")) {
			String sql = "select c.* , a.url,u.user_name as username from t_civisuccordep c left join t_attachment a on c.photo = a.id " + "left join t_sys_user u on c.recid =  u.user_id where c.deptid = " + id;
			return dao.findFirst(sql);
		} else {
			return null;
		}

	}

	public void delByIds(String ids) {
		String sql = "delete from t_civisuccordep c where c.deptid in (" + ids + ")";
		Db.update(sql);
	}

	//根据id获取附件对应记录
	public String getfjidsByids(String ids) {
		String sql = "select wm_concat(c.photo) as photos from t_civisuccordep c where c.deptid in (" + ids + ")";
		return Db.queryStr(sql);
	}
}
