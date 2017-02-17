package com.lauvan.base.basemodel.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_sys_datarelation",pk="id")
public class T_Sys_DataRelation extends Model<T_Sys_DataRelation> {
	private static final long serialVersionUID = 1L;
	public static T_Sys_DataRelation dao = new T_Sys_DataRelation();
	
	public void insert(T_Sys_DataRelation t){
		t.set("id", AutoId.nextval(t));
		t.save();
	}
	
	//根据serviceID，主部门ID，查询有查询权限的跨部门
	public List<Record> getListByIDs(String serviceid,String deptid,List<Record> dlist,StringBuffer selids){
		String sql = "select ";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = sql +" to_char(wmsys.wm_concat(s.other_dept)) ";
		}else{
			sql = sql +" group_concat(s.other_dept separator ',') ";
		}
		sql = sql + " from t_sys_datarelation s where  s.service_id=" +serviceid+" and s.dept_id="+deptid;
		String str = Db.queryStr(sql);
		StringBuffer check = new StringBuffer();
		if(str!=null && !"".equals(str)){
			selids.append(str);
			for(Record r : dlist){
				String did = r.get("d_id").toString();
				String pdid = r.get("d_pid").toString();
				if((","+str+",").indexOf(","+did+",")>=0){
					//存在
					check.append(",").append(did);
					r.set("checked", true);
				}else if(check.length()>0 && (check+",").indexOf(","+pdid+",")>=0){
					check.append(",").append(pdid);
					r.set("checked", true);
				}
			}
		}
		return dlist;
	}
	//删除多余的部门
	public void deleteByIds(String deptid,String serviceid,String selid){
		String sql = "select other_dept from  t_sys_datarelation where dept_id="+deptid+" and service_id="+serviceid;
		String delsql = "delete from t_sys_datarelation d where d.dept_id="+deptid+" and d.service_id="+serviceid+" and d.other_dept in ("
					+ sql+") and d.other_dept not in ("+selid+")";
		Db.update(delsql);
	}
	
	//返回新增的部门ID
	public String getNewDept(String deptid,String serviceid,String selid){
		String temp = ","+selid+",";
		String sql = "select ";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = sql +" to_char(wmsys.wm_concat(s.other_dept)) ";
		}else{
			sql = sql +" group_concat(s.other_dept separator ',') ";
		}
		sql = sql + " from  t_sys_datarelation s where s.dept_id="+deptid+" and s.service_id="+serviceid;
		String str = Db.queryStr(sql);
		if(str!=null && !"".equals(str)){
			String[] st = str.split(",");
			for(String s : st){
				temp = temp.replaceAll(","+s+",", ","); 
			}
		}
		if(temp!=null && temp.length()>2 ){
			temp  =  temp.substring(1, temp.length()-1);
		}else{
			temp = "";
		}
		return temp;
	}
	
	//清空关联关系
	public boolean deleteBySerDept(String serviceid,String deptid){
		String sql = "delete from t_sys_datarelation s where s.dept_id="+deptid+" and s.service_id in("+serviceid+")";
		int count = Db.update(sql);
		return count>0?true:false;
	}
	//根据业务表名，以及主部门ID，获取跨部门ID
	public String getOtherDept(String service,String deptid){
		String sql = "select ";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = sql +" to_char(wmsys.wm_concat(s.other_dept)) ";
		}else{
			sql = sql +" group_concat(s.other_dept separator ',') ";
		}
		sql = sql + " from  t_sys_datarelation s,T_Sys_DataService ds where  s.dept_id="+deptid
				+" and s.service_id=ds.id and ds.servicetable='"+service+"'";
		return Db.queryStr(sql);
	}
}
