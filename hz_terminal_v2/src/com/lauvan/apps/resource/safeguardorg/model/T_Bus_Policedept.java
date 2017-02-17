package com.lauvan.apps.resource.safeguardorg.model;

import java.util.Date;
import java.util.List;

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
 * 公安机关基本数据表
 *
 */
@TableBind(name="t_bus_policedept", pk="deptid")
public class T_Bus_Policedept extends Model<T_Bus_Policedept>{
	private static final long serialVersionUID = 1L;

	public static T_Bus_Policedept dao = new T_Bus_Policedept();
	
	public boolean insert(T_Bus_Policedept p){
		p.set("deptid", AutoId.nextval(p));
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.save();
	}
	
	public boolean upd(T_Bus_Policedept p){
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.update();
	}
	
	public Page<Record> getPage(Integer pageSize, Integer pageNum, String deptname, String pid){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select p.* ";
		StringBuffer sb = new StringBuffer(" from t_bus_policedept p where 1=1 ");
		if(StringUtils.isNotBlank(deptname)){
			sb.append(" and p.deptname like '%").append(deptname).append("%' ");
		}
		if(StringUtils.isNotBlank(pid)){
			sb.append(" and p.superdept_id =").append(pid);
		}
		return Db.paginate(pageNum, pageSize, select, sb.toString());
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_bus_policedept p where p.deptid in (" + ids + ")";
		Db.update(sql);
	}
	
	public String getfjidsByids(String ids){
		String sql = "select wm_concat(p.fjid) as fjids from t_bus_policedept p where p.deptid in (" + ids + ")";
		return Db.queryStr(sql);
	}
	
	public T_Bus_Policedept getById(String id){
		String sql = "select p.*, a.name as fjname , a.m_size from t_bus_policedept p left join t_attachment a on p.fjid = a.id where p.deptid = " +id;
		return dao.findFirst(sql);
	}
	
	public List<T_Bus_Policedept> getAllList(){
		String sql = "select * from t_bus_policedept ";
		return dao.find(sql);
	}
	
	//根据部门id查找下属所有机构id
	public String getChildIdsByDeptids(String deptids){
		String sql = "select wm_concat(p.deptid) from t_bus_policedept p start with p.deptid in (" 
			+ deptids + ") connect by prior p.deptid =p.superdept_id";
		return Db.queryStr(sql);
		
	}
}
