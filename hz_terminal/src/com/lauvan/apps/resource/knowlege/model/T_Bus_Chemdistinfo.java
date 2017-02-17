package com.lauvan.apps.resource.knowlege.model;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

/**
 *
 *应急处置
 */

@TableBind(name = "t_bus_chemdistinfo", pk = "id")
public class T_Bus_Chemdistinfo extends Model<T_Bus_Chemdistinfo> {
	private static final long			serialVersionUID	= 1L;

	public static T_Bus_Chemdistinfo	dao					= new T_Bus_Chemdistinfo();

	public boolean insert(T_Bus_Chemdistinfo info) {
		info.set("id", AutoId.nextval(info));
		return info.save();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNumber, String chemname) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String select = "select c.*, c2.chemname, c2.column1, c2.chemnameen, c2.achemliasen ";
		StringBuffer sb = new StringBuffer(" from t_bus_chemdistinfo c, t_chemistryinfo c2  where c.chemid = c2.chemid  ");
		if(StringUtils.isNotBlank(chemname)) {
			sb.append(" and c2.chemname like '%").append(chemname).append("%' ");
		}
		sb.append(" order by c.id desc");
		return Db.paginate(pageNumber, pageSize, select, sb.toString());
	}

	public void deleteByIds(String ids) {
		String sql = "delete from t_bus_chemdistinfo c where c.id in (" + ids + ")";
		Db.update(sql);
	}

	public T_Bus_Chemdistinfo getById(String id) {
		String sql = "select c.*, c2.chemname, c2.column1, c2.chemnameen, c2.achemliasen from t_bus_chemdistinfo c, t_chemistryinfo c2  where c.chemid = c2.chemid and c.id = " + id;
		return dao.findFirst(sql);
	}

	public void deleteByChemId(String chemids) {
		String sql = "delete from t_bus_chemdistinfo c where c.chemid in (" + chemids + ")";
		Db.update(sql);
	}
}
