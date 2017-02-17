package com.lauvan.apps.plan.model;
/**
 * 预案处置行动清单model
 * */
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_preschaction",pk="actid")
public class T_Bus_PreschAction extends Model<T_Bus_PreschAction> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_PreschAction dao = new T_Bus_PreschAction();
	
	public List<Record> getListByPresch(String preid,String phaseid){
		String sql = "select a.*,'p_'||a.actphase as pid from t_bus_preschaction a"
					+" where a.preschid="+preid;
		if(phaseid!=null && !"".equals(phaseid)){
			sql = sql + " and a.actphase="+phaseid;
		}
		sql = sql + " order by a.actorder asc";
		return Db.find(sql);
	}
	
	public void insert(T_Bus_PreschAction a){
		a.set("actid", AutoId.nextval(a));
		a.save();
	}
	
	public void deleteByPIds(String pids){
		String sql = " select wmsys.wm_concat(p.actid) from t_bus_preschaction p where p.actphase in ("+pids+")";
		String aids = Db.queryStr(sql);
		if(aids!=null && !"".equals(aids)){
			//删除行动下的所有执行部门
			T_Bus_PreschActionDept.dao.deleteByPIds(aids);
			sql = "delete from t_bus_preschaction where actid in ("+aids+")";
			Db.update(sql);
		}
	}
	
	public boolean deleteByIds(String ids){
		//删除行动下的所有执行部门
		T_Bus_PreschActionDept.dao.deleteByPIds(ids);
		String sql = "delete from t_bus_preschaction where actid in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public List<Record> getAllListByPresch(String preid){
		String sql = "select a.* from t_bus_preschaction a"
					+" where a.preschid="+preid;
		sql = sql + " order by a.actorder asc";
		return Db.find(sql);
	}
	public void deleteBYprechid(String preshid){
		String sql = "delete from t_bus_preschaction where preschid in ("+preshid+")";
		Db.update(sql);
	}

	public void impByIds(String pid, String mid,Map<String,Object> map,Map<String,Object> map2) {
		String sql="select * from t_bus_preschaction where preschid="+mid;
		List<T_Bus_PreschAction> list=T_Bus_PreschAction.dao.find(sql);
		if(!list.isEmpty()){
			for(T_Bus_PreschAction r:list){
				Number newid=AutoId.nextval(r);
				map2.put(r.get("actid").toString(), newid);
				r.set("actid", newid).set("preschid", pid);
				r.save();
			}
			sql="select * from t_bus_preschaction where preschid="+pid;
			List<T_Bus_PreschAction> list2=T_Bus_PreschAction.dao.find(sql);
			for(T_Bus_PreschAction r2:list2){
				if(r2.get("actphase")!=null&&!r2.get("actphase").equals("")&&r2.getBigDecimal("actphase")!=BigDecimal.valueOf(0)){
					if(map.get(r2.get("actphase").toString())!=null&&!map.get(r2.get("actphase").toString()).equals("")){
					r2.set("actphase",map.get(r2.get("actphase").toString()));
				    r2.update();
					}
				}
			}
		}
	}
}
