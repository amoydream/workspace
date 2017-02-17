package com.lauvan.apps.event.model;
/**
 * 预案实例流程表
 * */
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.plan.model.T_Bus_PreschPhase;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_event_preschphase",pk="evphaseid")
public class T_Bus_Event_Preschphase extends Model<T_Bus_Event_Preschphase> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_Event_Preschphase dao = new T_Bus_Event_Preschphase();
	
	public boolean insert(String eventid,String planid,String instid){
		boolean flag = false;
		//根据planid 查询预案的所有流程列表
		List<Record> list = T_Bus_PreschPhase.dao.getAllListByPresch(planid);
		if(list!=null && list.size()>0){
			for(Record r : list){
				String phaseid = r.get("phaseid").toString();
				String phasename = r.getStr("phasename");
				String fatherid = r.get("fatherid")==null?"0":r.get("fatherid").toString();
				String phasedetail = r.getStr("phasedetail");
				String note = r.getStr("note");
				String phaseorder = r.get("phaseorder").toString();
				String jdflag = r.getStr("flag");
				T_Bus_Event_Preschphase t = new T_Bus_Event_Preschphase();
				t.set("evphaseid", AutoId.nextval(t));
				t.set("eventid",eventid);
				t.set("preschid",planid);
				t.set("phaseid",phaseid);
				t.set("phasename",phasename);
				t.set("fatherid",fatherid);
				t.set("phasedetail",phasedetail);
				t.set("note",note);
				t.set("phaseorder",phaseorder);
				t.set("instid",instid);
				t.set("flag",jdflag);
				t.save();
			}
			flag = true;
		}
		return flag;
	}
	
	//根据实例id删除流程
	public void deleteByInst(String inst){
		String sql = "delete from t_bus_event_preschphase where instid="+inst;
		Db.update(sql);
	}
	
	public List<T_Bus_Event_Preschphase> getByFatherId(String instid, String fid){
		String sql = "select * from t_bus_event_preschphase p where instid = ? and p.fatherid = ? order by p.phaseorder";
		return dao.find(sql, instid, fid);
	}
	
	public List<T_Bus_Event_Preschphase> getByPhaseId(String instid, String fid){
		String sql = "select * from t_bus_event_preschphase p where instid = ? and (p.fatherid = ? or p.phaseid = ? )order by p.phaseorder";
		return dao.find(sql, instid, fid, fid);
	}
	
	public Page<Record> getPageByPresch(Integer pageSize,Integer pageNumber,String instid,String pid,String flag){
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
			.append(",t.note as pcontent from t_bus_event_preschactiondept t where t.evactid=").append(pid)
			.append(" and t.instid=").append(instid).append(") p");
		}else if("2".equals(flag)){
			//行动
			str.append("(select '2' as processtype,t.actname as processname,t.actorder as seq,t.actphase as pid,t.evactid as id,t.*  ")
			.append(",t.actcont as pcontent from t_bus_event_preschaction t where t.actphase=").append(pid)
			.append(" and t.instid=").append(instid).append(") p");
		}else{
			//阶段/流程
			str.append("(select decode(t.fatherid,0,'0','1') as processtype,t.phasename as processname,t.phaseorder as seq,t.fatherid as pid,t.phaseid as id")
			.append(",t.*,t.phasedetail as pcontent from  t_bus_event_preschphase t where t.fatherid=").append(pid)
			.append(" and t.instid=").append(instid).append(") p");
		}
		str.append(" order by p.seq asc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	
	public List<Record> getListByInstid(String instid){
		String sql = "select p.*, 'p_' || p.fatherid as pid from t_bus_event_preschphase p where p.instid = ? order by phaseorder ";
		return Db.find(sql, instid);
	}
	
}
