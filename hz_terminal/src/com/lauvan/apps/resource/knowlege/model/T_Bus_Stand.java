package com.lauvan.apps.resource.knowlege.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

/**
 *
 *标准及技术规范
 */
@TableBind(name = "t_bus_stand", pk = "standid")
public class T_Bus_Stand extends Model<T_Bus_Stand> {

	private static final long	serialVersionUID	= 1L;

	public static T_Bus_Stand	dao					= new T_Bus_Stand();

	public boolean insert(T_Bus_Stand s) {
		s.set("standid", AutoId.nextval(s));
		s.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return s.save();
	}

	public boolean upd(T_Bus_Stand s) {
		s.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return s.update();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNum, String standname, String type) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String select = "select * ";
		StringBuffer sb = new StringBuffer(" from t_bus_stand s where 1=1 ");
		if(StringUtils.isNotBlank(type)) {
			sb.append(" and s.standtypecode ='").append(type).append("' ");
		}
		if(StringUtils.isNotBlank(standname)) {
			sb.append(" and s.standname like '%").append(standname).append("%' ");
		}
		sb.append(" order by s.standid desc");
		return Db.paginate(pageNum, pageSize, select, sb.toString());
	}

	public String getfjidsByids(String ids) {
		String sql = "select wm_concat(s.fjid) as fjids from t_bus_stand s where s.standid in (" + ids + ")";
		return Db.queryStr(sql);
	}

	public void deleteByIds(String ids) {
		String sql = "delete from t_bus_stand where standid in (" + ids + ")";
		Db.update(sql);
	}

	public T_Bus_Stand getById(String id) {
		String sql = "select s.* , a.name as fjname , a.m_size from t_bus_stand s left join t_attachment a on s.fjid = a.id where s.standid =" + id;
		return dao.findFirst(sql);
	}
}
