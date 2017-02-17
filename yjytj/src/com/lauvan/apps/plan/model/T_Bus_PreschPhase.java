package com.lauvan.apps.plan.model;
/**
 * 预案处置阶段model
 * */
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_preschphase",pk="phaseid")
public class T_Bus_PreschPhase extends Model<T_Bus_PreschPhase> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_PreschPhase dao = new T_Bus_PreschPhase();
	
	public void insert(T_Bus_PreschPhase a){
		a.set("phaseid", AutoId.nextval(a));
		a.save();
	}
	
	public boolean deleteByIds(String ids,String preschid,String cflag){
		String cids = ids;
		String sql = "";
		if(!"1".equals(cflag)){
			sql = "select wmsys.wm_concat(p.phaseid) from t_bus_preschphase p where p.preschid="+preschid+" and p.fatherid in ("+ids+")";
			cids = Db.queryStr(sql);
		}
		if(cids!=null && !"".equals(cids)){
			//删除流程下的所有行动
			T_Bus_PreschAction.dao.deleteByPIds(cids);
			//删除流程
			if(!"1".equals(cflag)){
				sql = "delete from t_bus_preschphase where phaseid in ("+cids+")";
				Db.update(sql);
			}
		}
		sql = "delete from t_bus_preschphase where phaseid in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public List<Record> getListByPresch(String preid,String flag){
		String sql = "select p.*,'p_'||p.fatherid as pid from t_bus_preschphase p "
					+" where p.preschid= "+preid;
		if("root".equals(flag)){
			sql = sql +" and p.fatherid=0";
		}
		sql = sql + " order by p.phaseorder asc";
		return Db.find(sql);
	}
	
	public Page<Record> getPageByPresch(Integer pageSize,Integer pageNumber,String preschid,String pid,String flag){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select p.*";
		StringBuffer str = new StringBuffer();
		str.append(" from ");
		if(pid.startsWith("p_")){
			pid = pid.substring(2);
		}
		if("3".equals(flag)){
			//执行部门
			str.append("(select '3' as processtype,t.actdeptname as processname,null as seq,t.actid as pid,t.*  ")
			.append(",t.note as pcontent from t_bus_preschactiondept t where t.actid=").append(pid)
			.append(" and t.preschid=").append(preschid).append(") p");
		}else if("2".equals(flag)){
			//行动
			str.append("(select '2' as processtype,t.actname as processname,t.actorder as seq,t.actphase as pid,t.actid as id,t.*  ")
			.append(",t.actcont as pcontent from t_bus_preschaction t where t.actphase=").append(pid)
			.append(" and t.preschid=").append(preschid).append(") p");
		}else{
			//阶段/流程
			str.append("(select decode(t.fatherid,0,'0','1') as processtype,t.phasename as processname,t.phaseorder as seq,t.fatherid as pid,t.phaseid as id")
			.append(",t.*,t.phasedetail as pcontent from  t_bus_preschphase t where t.fatherid=").append(pid)
			.append(" and t.preschid=").append(preschid).append(") p");
		}
		str.append(" order by p.seq asc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	public List<Record> getTreeListByPresch(String preid,String pid){
		String sql = "select p.*,case when (select count(a.id) from vw_preschpahse a where a.pid=p.id)>0"
					+" then 1 else 0 end as isleaf  from vw_preschpahse p where p.preschid="+preid
					+"  start with p.pid='"+pid+"' connect by prior p.id =p.pid order by p.seq asc";
		return Db.find(sql);
	}
	
	/**
	 * 查询阶段流程列表
	 * */
	public List<Record> getPhaseList(String pid,String preschid){
		String sql = "";
		if("0".equals(pid)){
			sql = "select p.phaseid,p.phasename from t_bus_preschphase p  where p.preschid="+preschid+" and p.fatherid=0 order by p.phaseorder asc";
		}else{
			sql = "select p.phaseid,p1.phasename||'【'||p.phasename||'】' as phasename from t_bus_preschphase p,t_bus_preschphase p1"
				+"  where p.fatherid=p1.phaseid and p.preschid="+preschid+" and p.fatherid<>0 order by p.phaseorder asc";
		}
		return Db.find(sql);
	}
	
	/**
	 * 向上检索查询阶段流程树
	 * */
	public List<Record> getPhaseTree(String pid){
		String sql = "select p.* from t_bus_preschphase p start with p.fatherid="+pid+" connect by prior p.fatherid =p.phaseid";
		return Db.find(sql);
	}
	
	public List<Record> getAllListByPresch(String preid){
		String sql = "select p.* from t_bus_preschphase p "
					+" where p.preschid= "+preid;
		sql = sql + " order by p.phaseorder asc";
		return Db.find(sql);
	}
	public void deleteBYprechid(String preshid){
		String sql = "delete from t_bus_preschphase where preschid in ("+preshid+")";
		Db.update(sql);
	}

	public void impByIds(String pid, String mid,Map<String,Object> map) {
		String sql="select * from t_bus_preschphase where preschid="+mid;
		List<T_Bus_PreschPhase> list=T_Bus_PreschPhase.dao.find(sql);
		if(!list.isEmpty()){
			for(T_Bus_PreschPhase r:list){
				Number newid=AutoId.nextval(r);
				map.put(r.get("phaseid").toString(), newid);
				r.set("phaseid", newid).set("preschid", pid);
				r.save();
			}
			sql="select * from t_bus_preschphase where preschid="+pid;
			List<T_Bus_PreschPhase> list2=T_Bus_PreschPhase.dao.find(sql);
			for(T_Bus_PreschPhase r2:list2){
				if(r2.get("fatherid")!=null&&!r2.get("fatherid").equals("")&&r2.getBigDecimal("fatherid")!=BigDecimal.valueOf(0)){
					if(map.get(r2.get("fatherid").toString())!=null&&!map.get(r2.get("fatherid").toString()).equals("")){
					r2.set("fatherid",map.get(r2.get("fatherid").toString()));
				    r2.update();
					}
				}
			}
		}
	}
}
