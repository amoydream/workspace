package com.lauvan.apps.resource.safeguardorg.model;

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
 * 募捐机构
 *
 */
@TableBind(name="t_bus_colldept", pk="deptid")
public class T_Bus_CollDept extends Model<T_Bus_CollDept>{

	private static final long serialVersionUID = 1L;

	public static T_Bus_CollDept dao = new T_Bus_CollDept();
	
	public boolean insert(T_Bus_CollDept colldept){
		colldept.set("deptid", AutoId.nextval(colldept));
		colldept.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return colldept.save();
	}
	
	public boolean upd(T_Bus_CollDept colldept){
		colldept.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return colldept.update();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNumber,
			String colldeptname, String depttype) {
		pageNumber = pageNumber == null || pageNumber<1?1:pageNumber;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String sql = "select c.* ";
		StringBuffer sb = new StringBuffer(" from t_bus_colldept c where 1=1");
		if(StringUtils.isNotBlank(colldeptname)){
			sb.append(" and c.deptname like '%").append(colldeptname).append("%'");
		}
		if(StringUtils.isNotBlank(depttype)){
			sb.append(" and c.depttypecode ='").append(depttype).append("'");
		}
		sb.append(" order by c.updatetime desc");
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}
	
	public T_Bus_CollDept getById(String id){
		String sql = "select c.*, a.url, a.name as fjname ,a.m_size from t_bus_colldept c left join t_attachment a on c.fjid = a.id where c.deptid ="+id;
		return dao.findFirst(sql);
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_bus_colldept c where c.deptid in (" + ids + ")";
		Db.update(sql);
	}
	
	//根据机构ids返回对应的附件字符串
	public String getfjidsByIds(String ids){
		String sql = "select wm_concat(c.fjid) as fjids from t_bus_colldept c where c.deptid in (" + ids + ")";
		return Db.queryStr(sql);
	}
	
}
