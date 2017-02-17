package com.lauvan.base.main.model;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_DataRelation;
import com.lauvan.config.JFWebConfig;

public class Paginate extends Record {
	private static final long serialVersionUID = 1L;
	public static final Paginate dao=new Paginate();
	
	public Page<Record> getPage(String tableName,Integer pageSize,Integer pageNumber,String sqlWhere,String orderName, String sortOrder){
		String select="select * ";
		String sqlExceptSelect="from "+tableName+" where "+(StringUtils.isNotBlank(sqlWhere)?sqlWhere:"1=1");
		if(StringUtils.isNotBlank(orderName)){
			sqlExceptSelect+=" order by "+orderName;
			if(StringUtils.isNotBlank(sortOrder))
				sqlExceptSelect+=" "+sortOrder;
		}
		return Db.paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}
	
	public Page<Record> getPage(Integer pageSize,Integer pageNumber,String sql,String orderName, String sortOrder){
		String select="select * ";
		String sqlExceptSelect = "from "+(StringUtils.isNotBlank(sql)?sql:"1=1");
		if(StringUtils.isNotBlank(orderName)){
			sqlExceptSelect+=" order by "+orderName;
			if(StringUtils.isNotBlank(sortOrder))
				sqlExceptSelect+=" "+sortOrder;
		}
		return Db.paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}
	
	
	public Page<Record> getPage(String tableName,String tszd,Integer pageSize,Integer pageNumber,String sqlWhere,String orderName, String sortOrder){
		String select="select t.* ,t."+tszd+" ";
		String sqlExceptSelect="from "+tableName+" t where "+(StringUtils.isNotBlank(sqlWhere)?sqlWhere:"1=1");
		if(StringUtils.isNotBlank(orderName)){
			sqlExceptSelect+=" order by "+orderName;
			if(StringUtils.isNotBlank(sortOrder))
				sqlExceptSelect+=" "+sortOrder;
		}
		return Db.paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}
	
	public List<Record> getList(String tableName,String sqlWhere){
		String exeSQL="select * from "+tableName+" where "+sqlWhere;
		try{
			List<Record> list=Db.find(exeSQL);
			return list;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public List<Record> getList(String tableName,String select,String sqlWhere){
		String exeSQL="select "+select+" from "+tableName+" where "+sqlWhere;
		try{
			List<Record> list=Db.find(exeSQL);
			return list;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public List<Record> getList(String select,String sql,String orderName,String sortOrder){
		String exeSQL="select "+select+" from "+sql;
		if(StringUtils.isNotBlank(orderName)){
			exeSQL+=" order by "+orderName;
			if(StringUtils.isNotBlank(sortOrder))
				exeSQL+=" "+sortOrder;
		}
		try{
			List<Record> list=Db.find(exeSQL);
			return list;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
	}
	
	/**
	 * 根据数据权限查询业务表
	 * @param 	pageSize	页面大小
	 * @param	pageNumber	页码
	 * @param	service		业务表名或业务视图名
	 * @param	dept		当前操作者部门ID
	 * @param	sqlWhere	自定义过滤条件
	 * @param 	orderName	排序字段名称
	 * @param	sortOrder	排序方式
	 * */
	public Page<Record> getServicePage(Integer pageSize,Integer pageNumber,String service,String dept,String sqlWhere,String orderName,String sortOrder){
		//根据业务名称，当前部门ID，获取跨部门ID
		//T_Sys_DataService ser = T_Sys_DataService.dao.getByTable(service);
		String otherDept = T_Sys_DataRelation.dao.getOtherDept(service, dept);
		//每个业务表都有一个操作员字段user_id
		StringBuffer str = new StringBuffer();
		str.append(" from ").append(service).append(" s ,t_sys_user u where s.user_id=u.user_id ");
		
		//当前部门及当前部门以下的id值
		String dsql = "select ";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			dsql = "select  to_char(wmsys.wm_concat(a.d_id)) from t_sys_department a Start With a.d_id ="+dept+" Connect By  Prior a.d_id = a.d_pid";
		}else{
			dsql = "select group_concat(a.d_id separator ',') FROM t_sys_department WHERE FIND_IN_SET(d_id, getChildLst("+dept+")) ";
		}
		String dids = Db.queryStr(dsql);
		
		if(otherDept!=null && !"".equals(otherDept)){
			//查询当前部门及下级的所有数据，以及跨部门数据
			str.append(" and u.dept_id in (").append(otherDept+","+dids).append(")");
		}else{
			//若为空，则直接按业务表名称查询,可查询当前部门及其下级的所有业务数据
			str.append(" and u.dept_id in (").append(dids).append(")");
		}
		String sql="select s.* ";

		//过滤条件。。。。
		if(sqlWhere !=null && !"".equals(sqlWhere)){
			str.append(sqlWhere);
		}
		if(StringUtils.isNotBlank(orderName)){
			str.append(" order by "+orderName);
			if(StringUtils.isNotBlank(sortOrder))
				str.append(" "+sortOrder);
		}
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	/**
	 * 根据数据权限查询业务表
	 * @param	service		业务表名或业务视图名
	 * @param	dept		当前操作者部门ID
	 * @param	sqlWhere	自定义过滤条件
	 * @param 	orderName	排序字段名称
	 * @param	sortOrder	排序方式
	 * */
	public List<Record> getServiceList(String service,String dept,String sqlWhere,String orderName,String sortOrder){
		//根据业务名称，当前部门ID，获取跨部门ID
		String otherDept = T_Sys_DataRelation.dao.getOtherDept(service, dept);
		//每个业务表都有一个操作员字段user_id
		StringBuffer str = new StringBuffer();
		str.append("select s.*  from ").append(service).append(" s ,t_sys_user u where s.user_id=u.user_id ");
		
		//当前部门及当前部门以下的id值
		String dsql = "select ";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			dsql = "select  to_char(wmsys.wm_concat(a.d_id)) from t_sys_department a Start With a.d_id ="+dept+" Connect By  Prior a.d_id = a.d_pid";
		}else{
			dsql = "select group_concat(a.d_id separator ',') FROM t_sys_department WHERE FIND_IN_SET(d_id, getChildLst("+dept+")) ";
		}
		String dids = Db.queryStr(dsql);
		
		if(otherDept!=null && !"".equals(otherDept)){
			//查询当前部门及下级的所有数据，以及跨部门数据
			str.append(" and u.dept_id in (").append(otherDept+","+dids).append(")");
		}else{
			//若为空，则直接按业务表名称查询,可查询当前部门及其下级的所有业务数据
			str.append(" and u.dept_id in (").append(dids).append(")");
		}

		//过滤条件。。。。
		if(sqlWhere !=null && !"".equals(sqlWhere)){
			str.append(sqlWhere);
		}
		if(StringUtils.isNotBlank(orderName)){
			str.append(" order by "+orderName);
			if(StringUtils.isNotBlank(sortOrder))
				str.append(" "+sortOrder);
		}
		return Db.find(str.toString());
	}
}
