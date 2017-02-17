package com.lauvan.apps.plan.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_preschlaw",pk="id")
public class T_Bus_PreschLaw extends Model<T_Bus_PreschLaw> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_PreschLaw dao = new T_Bus_PreschLaw();
	
	public void insert(String ids,String preshid){
		//根据ids查询法律法规
		String sql = "select * from T_Bus_LawRegulation where lr_id in ("+ids+")";
		List<Record> list = Db.find(sql);
		if(list!=null && list.size()>0){
			for(Record r : list){
				T_Bus_PreschLaw f = new T_Bus_PreschLaw();
				f.set("id", AutoId.nextval(f));
				f.set("preschid", preshid);
				f.set("lawid", r.get("lr_id"));
				f.set("lawtitle", r.getStr("lr_title"));
				f.save();
			}
		}
		
	}
	
	public void updateLaw(String lawid,String preshid){
		//删除原数据
		String sql = "delete from t_bus_preschlaw where preschid="+preshid;
		Db.update(sql);
		//插入新数据
		if(lawid!=null && !"".equals(lawid)){
			sql = "select * from T_Bus_LawRegulation where lr_id in ("+lawid+")";
			List<Record> list = Db.find(sql);
			if(list!=null && list.size()>0){
				for(Record r : list){
					T_Bus_PreschLaw f = new T_Bus_PreschLaw();
					f.set("id", AutoId.nextval(f));
					f.set("lawtitle", r.getStr("lr_title"));
					f.set("preschid", preshid);
					f.set("lawid", r.get("lr_id"));
					f.save();
				}
			}
		}
	}
	
	//根据预案ID删除法律关系
	public void deleteBYprechid(String preshid){
		String sql = "delete from t_bus_preschlaw where preschid in ("+preshid+")";
		Db.update(sql);
	}
	
	public Page<Record> getLaws(Integer pageSize,Integer pageNumber,String swhere,String pid){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		StringBuffer  str = new StringBuffer();
		String sql = "select t.*";
		str.append(" from T_Bus_LawRegulation t ");
		if(pid!=null && !"".equals(pid)){
			sql = sql + ",decode(l.lawid,null,0,1) as checked";
			str.append(" left join t_bus_preschlaw l on t.lr_id=l.lawid ");
			str.append(" and l.preschid="+pid);
		}
		str.append("  where 1=1");
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by t.lr_publishdate desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	public List<Record> getLawsByPid(String pid){
		String sql = "select t.* from t_bus_preschlaw l,T_Bus_LawRegulation t where l.lawid=t.lr_id and l.preschid="+pid;
		return Db.find(sql);
	}

	public void impByIds(String pid, String mid) {
		String sql="select * from t_bus_preschlaw where preschid="+mid;
		List<T_Bus_PreschLaw> list=T_Bus_PreschLaw.dao.find(sql);
		if(!list.isEmpty()){
			for(T_Bus_PreschLaw r:list){
				r.set("id", AutoId.nextval(r)).set("preschid", pid);
				r.save();
			}
		}
	}
}
