package com.lauvan.base.basemodel.model;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_sys_dataservice",pk="id")
public class T_Sys_DataService extends Model<T_Sys_DataService> {
	private static final long serialVersionUID = 1L;
	public static T_Sys_DataService dao = new T_Sys_DataService();
	
	public boolean insert(T_Sys_DataService s){
		s.set("id", AutoId.nextval(s));
		return s.save();
	}
	
	public boolean deleteByIds(String ids){
		String sql = "delete from t_sys_dataservice where id in("+ids+")";
		return Db.update(sql)>0;
	}
	
	/**
	 * 根据部门ID获取跨部门业务关系
	 * */
	public Page<Record> getPage(Integer pageSize,Integer pageNumber,String deptid,String sqlWhere){
		String select="select s.*, t.deptname ";
		String sqlExceptSelect=" from T_Sys_DataService s left join (";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sqlExceptSelect = sqlExceptSelect + " select to_char(wmsys.wm_concat(d.d_name)) as deptname ";
		}else{
			sqlExceptSelect = sqlExceptSelect + " select group_concat(d.d_name separator ',')  as deptname ";
		}
		sqlExceptSelect = sqlExceptSelect +",r.service_id from T_Sys_DataRelation r ,t_sys_department d where r.other_dept=d.d_id "
						+"and r.dept_id="+deptid+" group by r.service_id) t " +" on s.id=t.service_id  where 1=1 ";
		
		if(StringUtils.isNotBlank(sqlWhere)){
			sqlExceptSelect = sqlExceptSelect + sqlWhere;
		}
		sqlExceptSelect+=" order by s.id desc";
		return Db.paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}
	
	//根据tablename获取业务ID
	public T_Sys_DataService getByTable(String table){
		String sql = "select * from T_Sys_DataService where servicetable='"+table+"'";
		return dao.findFirst(sql);
	}
	
	//查询所有业务信息
	public Page<Record> getPage(Integer pageSize,Integer pageNumber,String sqlWhere,String orderName, String sortOrder){
		String select="select s.*,t.name as modelname ";
		String sqlExceptSelect="from T_Sys_DataService s left join t_sys_module t on t.id=s.model_id where 1=1 ";
		if(sqlWhere!=null && !"".equals(sqlWhere)){
			sqlExceptSelect+=sqlWhere;
		}
		if(StringUtils.isNotBlank(orderName)){
			sqlExceptSelect+=" order by "+orderName;
			if(StringUtils.isNotBlank(sortOrder))
				sqlExceptSelect+=" "+sortOrder;
		}
		return Db.paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}
}
