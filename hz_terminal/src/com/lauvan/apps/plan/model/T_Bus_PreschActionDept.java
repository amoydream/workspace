package com.lauvan.apps.plan.model;
/**
 * 预案处置执行部门model
 * */
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_preschactiondept",pk="id")
public class T_Bus_PreschActionDept extends Model<T_Bus_PreschActionDept> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_PreschActionDept dao = new T_Bus_PreschActionDept();
	
	public void insert(T_Bus_PreschActionDept a){
		a.set("id", AutoId.nextval(a));
		a.save();
	}
	
	public boolean deleteByIds(String ids){
		String sql= "delete from t_bus_preschactiondept where id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public boolean deleteByPIds(String pids){
		String sql= "delete from t_bus_preschactiondept where actid in ("+pids+")";
		return Db.update(sql)>0;
	}
	public void deleteBYprechid(String preshid){
		String sql = "delete from t_bus_preschactiondept where preschid in ("+preshid+")";
		Db.update(sql);
	}

	public void impByIds(String pid, String mid,Map<String,Object> map) {
		String sql="select * from t_bus_preschactiondept where preschid="+mid;
		List<T_Bus_PreschActionDept> list=T_Bus_PreschActionDept.dao.find(sql);
		if(!list.isEmpty()){
			for(T_Bus_PreschActionDept r:list){
				r.set("id", AutoId.nextval(r)).set("preschid", pid);
				r.save();
			}
			sql="select * from t_bus_preschactiondept where preschid="+pid;
			List<T_Bus_PreschActionDept> list2=T_Bus_PreschActionDept.dao.find(sql);
			for(T_Bus_PreschActionDept r2:list2){
				if(r2.get("actid")!=null&&!r2.get("actid").equals("")&&r2.getBigDecimal("actid")!=BigDecimal.valueOf(0)){
					if(map.get(r2.get("actid").toString())!=null&&!map.get(r2.get("actid").toString()).equals("")){
					r2.set("actid",map.get(r2.get("actid").toString()));
				    r2.update();
					}
				}
			}
		}
	}
	
	//根据行动id查询对应负责部门
	public List<T_Bus_PreschActionDept> getListByActionId(String actid){
		String sql = "select * from t_bus_preschactiondept p where actid = ?";
		return dao.find(sql,actid);
	}
}
