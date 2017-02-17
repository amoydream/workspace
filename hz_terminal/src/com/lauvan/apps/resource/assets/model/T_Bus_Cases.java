package com.lauvan.apps.resource.assets.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_cases", pk = "cas_id")
public class T_Bus_Cases extends Model<T_Bus_Cases> {

	private static final long		serialVersionUID	= 5591215954074359182L;

	public static final T_Bus_Cases	dao					= new T_Bus_Cases();

	public Page<Record> getPage(Integer pageSize, Integer pageNum, String title, String typeCode, String eventLevelCode) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String select = "select ca.*,params.id p_id,params.p_name,dept.d_name,params2.p_name eventlevelname ";
		StringBuffer sql = new StringBuffer(" from T_BUS_CASES ca " + " left join (select p2.* from t_sys_parameter p1,t_sys_parameter p2 where p1.id=p2.sup_id and p1.p_acode='" + (typeCode.isEmpty() ? "" : typeCode) + "') params on ca.type=params.p_acode left join  t_sys_department dept on ca.sourcedept=dept.d_id" + " left join (select a.* from t_sys_parameter a  Start With a.p_acode='" + (eventLevelCode.isEmpty() ? "" : eventLevelCode) + "' Connect By  Prior a.id = a.sup_id ) params2 on params2.p_acode=ca.eventlevelcode where 1=1");
		if(title != null && !"".equals(title)) {
			sql.append("and title like '%").append(title).append("%' ");
		}
		sql.append(" order by cas_id desc");
		return Db.paginate(pageNum, pageSize, select, sql.toString());
	}

	public boolean insert(T_Bus_Cases p) {
		p.set("cas_id", AutoId.nextval(p));
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.save();
	}

	public boolean upd(T_Bus_Cases p) {
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.update();
	}

	public boolean deleteByIds(String ids) {
		String sql = "delete from t_bus_cases where cas_id in (" + ids + ")";
		return Db.update(sql) > 0;
	}

	public T_Bus_Cases getById(Integer id) {
		String sql = "select c.* , a.name as fjname , a.m_size from t_bus_cases c left join t_attachment a on c.fjid = a.id where c.cas_id =" + id;
		return dao.findFirst(sql);
	}

	//根据案例ids返回对应的附件字符串
	public String getfjidsByIds(String ids) {
		String sql = "select wm_concat(c.fjid) as fjids from t_bus_cases c where c.cas_id in (" + ids + ")";
		return Db.queryStr(sql);
	}

}
