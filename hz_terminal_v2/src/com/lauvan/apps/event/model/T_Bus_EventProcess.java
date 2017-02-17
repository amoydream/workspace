package com.lauvan.apps.event.model;

import java.util.Date;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.workcontact.model.T_Bus_EmergencyContact;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_bus_eventprocess",pk="id")
public class T_Bus_EventProcess extends Model<T_Bus_EventProcess> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_EventProcess dao = new T_Bus_EventProcess();
	
	public Page<Record> getPageByEventid(Integer pageSize,Integer pageNumber,String eventid){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select *";
		StringBuffer  str = new StringBuffer();
		str.append("  from t_bus_eventprocess e where 1=1 and e.eventid=").append(eventid);
		str.append(" and e.ep_instflag is null ");
		str.append(" order by e.marktime desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	public void insert(T_Bus_EventProcess t){
		t.set("id", AutoId.nextval(t));
		t.set("marktime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}
	
	//插入反馈信息
	public void insert(T_Bus_EventProcess t,String content,String user,String organ,String userid){
		t.set("id", AutoId.nextval(t));
		String date = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		t.set("marktime", date);
		t.set("ep_user", user);
		t.set("ep_date", date);
		t.set("ep_content", content);
		t.set("ep_organ", organ);
		t.set("ep_type", "0002");//反馈类型
		t.set("ep_reporter", user);
		t.set("ep_reportdate", date);
		t.set("user_id", userid);
		t.save();
	}
	//根据类型获取通讯簿信息
	public Page<Record> getPageBySmsid(Integer pageSize,Integer pageNumber,String smsid){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select e.*";
		StringBuffer  str = new StringBuffer();
		str.append("  from ");
		if("hy_organ".equals(smsid)){
			smsid="d_0";
		}
		if("hy_user".equals(smsid)){
			smsid="u_0";
		}
		if("yj_organ".equals(smsid)){
			smsid="od_0";
		}
		if("yj_user".equals(smsid)){
			smsid="ou_0";
		}
		if(smsid.startsWith("d_")){
			//组织机构
			str.append("( select d.d_id as id,b.bo_worknumber as worknum,b.bo_homenumber as homenum,b.bo_deptid as deptid")
			.append(",b.bo_mobile as phonenum,b.bo_address as address,b.bo_fax as faxnum,d.d_name as smsname,d.orderid as orderid ")
			.append(" from t_bus_contactbook b right join t_sys_department d on b.bo_deptid=d.d_id ")
			.append(" where d.d_pid=").append(smsid.substring(2)).append(") e");
		}
		else if(smsid.startsWith("u_")){
			//内部人员
			str.append("( select u.user_id as id,b.bo_worknumber as worknum,b.bo_homenumber as homenum,u.dept_id as deptid")
			.append(",b.bo_mobile as phonenum,b.bo_address as address,b.bo_fax as faxnum,u.user_name as smsname,u.orderid as orderid ")
			.append(",decode(b.bo_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
			.append(" p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 where ','||b.bo_position||',' like '%,'||a1.p_acode||',%' )) as position")
			.append(" from t_bus_contactbook b right join t_sys_user u on b.bo_userid=u.user_id ")
			.append(" where u.dept_id=").append(smsid.substring(2)).append(") e");
		}
		else if(smsid.startsWith("od_")){
			//日常组织机构
			str.append("(SELECT b.or_id as id,b.or_name as smsname,b.or_address as address,b.or_fax as faxnum,b.or_pid as deptid")
			.append(",b.or_worknumber as worknum,b.or_email as email,b.or_pid as pid,b.or_sort as orderid FROM T_BUS_ORGAN b ")
			.append(" where b.or_pid=").append(smsid.substring(3)).append(" ) e");
		}
		else if(smsid.startsWith("ou_")){
			//日常机构人员
			str.append("(SELECT b.p_id as id,b.p_name as smsname,b.p_address as address,b.p_email as email")
			.append(",b.p_fax as faxnum,b.p_homenumber as homenum,b.p_mobile as phonenum,b.p_worknumber as worknum,")
			.append("decode(b.p_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
			.append(" p_acode = 'RPOSITION' connect by prior id=sup_id) a1 where ','||b.p_position||',' like '%,'||a1.p_acode||',%' )) as position")
			.append(",b.p_orid as deptid,b.p_sort as orderid  FROM t_bus_organperson b where b.p_orid=").append(smsid.substring(3)).append(" ) e");
		}else {
			//群组人员
			T_Bus_EmergencyContact c = T_Bus_EmergencyContact.dao.findById(smsid.substring(2));
			if(c!=null){
				String uid = c.getStr("e_bookid");
				StringBuffer str2 = new StringBuffer();
				//if(uid!=null && !"".equals(uid)){
					str2.append(" select u.user_id as id, u.user_name as smsname,b.bo_address  as address, b.bo_email as email, b.bo_fax as faxnum")
					.append(",b.bo_homenumber as homenum,b.bo_mobile as phonenum,b.bo_worknumber as worknum,u.dept_id  as deptid ")
					.append(",decode(b.bo_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
					.append(" p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 where ','||b.bo_position||',' like '%,'||a1.p_acode||',%' )) as position")
					.append(",u.orderid as orderid from t_bus_contactbook b right join t_sys_user u on b.bo_userid=u.user_id ")
					.append(" where u.user_id in (").append(uid).append(")");
				//}
				String ouid = c.getStr("e_personid");
				//if(ouid!=null && !"".equals(ouid)){
					if(str2.length()>0){
						str2.append(" union ");
					}
					str2.append("SELECT b.p_id  as id,b.p_name as smsname,b.p_address as address,b.p_email as email,b.p_fax as faxnum")
					.append(",b.p_homenumber as homenum,b.p_mobile as phonenum,b.p_worknumber as worknum,b.p_orid  as deptid,")
					.append("decode(b.p_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
					.append(" p_acode = 'RPOSITION' connect by prior id=sup_id) a1 where ','||b.p_position||',' like '%,'||a1.p_acode||',%' )) as position")
					.append(",1000+b.p_sort as orderid FROM t_bus_organperson b where b.p_id in (").append(ouid).append(") ");
				//}
				str.append("(").append(str2).append(") e ");
			}
		}
		str.append(" order by e.orderid asc, e.id asc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	public List<Record> getListByEid(String eid){
		String sql = "select p.*,substr(p.ep_date,1,10) as ep_day,substr(p.ep_date,12) as ep_time"
					+",decode(p.ep_type,null,null,(select p1.p_name from t_sys_parameter p1,t_sys_parameter p2 where p1.sup_id=p2.id "
					+"and p2.p_acode='EVPY' and p1.p_acode=p.ep_type)) as eptname"
					+" from t_bus_eventprocess p where p.eventid="+eid;
		return Db.find(sql);
	}
	
	//获取事件回顾的过程信息
	public List<Record> getListByEid_HG(String eid, String trainflag){
		String sql = " select h.* from ("
					+"select to_char(p.id) as id,p.ep_user,p.ep_date,p.ep_content,"
					+"substr(p.ep_date, 1, 10) as ep_day,substr(p.ep_date, 12) as ep_time,"
					+"decode(p.ep_type,null, null,(select p1.p_name from t_sys_parameter p1, t_sys_parameter p2"
					+" where p1.sup_id = p2.id and p2.p_acode = 'EVPY' and p1.p_acode = p.ep_type)) as eptname"
					+",null as backtype,null as smsid,null as callname from t_bus_eventprocess p  where p.eventid = "+eid;
		if("train".equals(trainflag)){
			 sql += " and p.ep_instflag = '" + trainflag + "' ";
		}
		sql+=" union "
		+"select s.id,s.senduser as ep_user,s.sendtime as ep_date,s.smsdata as ep_content, substr(s.sendtime, 1, 10) as ep_day,"
		+"substr(s.sendtime, 12) as ep_time,'短信' as eptname, '1' as backtype,s.smsid,s.callname from ("
		+"select wmsys.wm_concat(t.id) as id,t.sendtime,t.smsdata,t.senduser,t.smsid,wmsys.wm_concat(t.callname) as callname"
		+" from t_bus_smssendrd t  where t.eventid="+eid
		+" and t.sendstate='T' group by (t.smsid,t.sendtime,t.smsdata,t.senduser)) s"
		+") h order by h.ep_date asc";
		return Db.find(sql);
	}
	
	public Record getFaxUserRecord(String id){
		String sql = "select v.* from vw_address v where v.add_code ='"+id+"'";
		return Db.findFirst(sql);
	}
	
	//根据类型获取传真信息
	public Page<Record> getPageByfaxList(Integer pageSize,Integer pageNumber,String smsid,String faxno){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select e.*";
		StringBuffer  str = new StringBuffer();
		str.append("  from ");
		if("hy_organ".equals(smsid)){
			smsid="d_0";
		}
		if("hy_user".equals(smsid)){
			smsid="u_0";
		}
		if("yj_organ".equals(smsid)){
			smsid="od_0";
		}
		if("yj_user".equals(smsid)){
			smsid="ou_0";
		}
		if(smsid.startsWith("d_")){
			//组织机构
			str.append("( select d.d_id as id,b.bo_worknumber as worknum,b.bo_homenumber as homenum,b.bo_deptid as deptid")
			.append(",b.bo_mobile as phonenum,b.bo_address as address,b.bo_fax as fax,d.d_name as add_name,d.orderid as orderid ")
			.append(" from t_bus_contactbook b right join t_sys_department d on b.bo_deptid=d.d_id ")
			.append(" where d.d_pid=").append(smsid.substring(2));
			if(faxno!=null && !"".equals(faxno)){
				str.append(" and b.bo_fax not in ('").append(faxno).append("') ");
			}
			str.append(") e");
		}
		else if(smsid.startsWith("u_")){
			//内部人员
			str.append("( select u.user_id as id,b.bo_worknumber as worknum,b.bo_homenumber as homenum,u.dept_id as deptid")
			.append(",b.bo_mobile as phonenum,b.bo_address as address,b.bo_fax as fax,u.user_name as add_name,u.orderid as orderid ")
			//.append(",decode(b.bo_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
			//.append(" p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 where ','||b.bo_position||',' like '%,'||a1.p_acode||',%' )) as position")
			.append(" from t_bus_contactbook b right join t_sys_user u on b.bo_userid=u.user_id ")
			.append(" where u.dept_id=").append(smsid.substring(2));
			if(faxno!=null && !"".equals(faxno)){
				str.append(" and b.bo_fax not in ('").append(faxno).append("') ");
			}
			str.append(") e");
		}
		else if(smsid.startsWith("od_")){
			//日常组织机构
			str.append("(SELECT b.or_id as id,b.or_name as add_name,b.or_address as address,b.or_fax as fax,b.or_pid as deptid")
			.append(",b.or_worknumber as worknum,b.or_email as email,b.or_pid as pid,b.or_sort as orderid FROM T_BUS_ORGAN b ")
			.append(" where b.or_pid=").append(smsid.substring(3));
			if(faxno!=null && !"".equals(faxno)){
				str.append(" and b.or_fax not in ('").append(faxno).append("') ");
			}
			str.append(" ) e");
		}
		else if(smsid.startsWith("ou_")){
			//日常机构人员
			str.append("(SELECT b.p_id as id,b.p_name as add_name,b.p_address as address,b.p_email as email")
			.append(",b.p_fax as fax,b.p_homenumber as homenum,b.p_mobile as phonenum,b.p_worknumber as worknum")
			//.append(",decode(b.p_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
			//.append(" p_acode = 'RPOSITION' connect by prior id=sup_id) a1 where ','||b.p_position||',' like '%,'||a1.p_acode||',%' )) as position")
			.append(",b.p_orid as deptid,b.p_sort as orderid  FROM t_bus_organperson b where b.p_orid=").append(smsid.substring(3));
			if(faxno!=null && !"".equals(faxno)){
				str.append(" and b.p_fax not in ('").append(faxno).append("') ");
			}
			str.append(" ) e");
		}else {
			//群组人员
			T_Bus_EmergencyContact c = T_Bus_EmergencyContact.dao.findById(smsid.substring(2));
			if(c!=null){
				String uid = c.getStr("e_bookid");
				StringBuffer str2 = new StringBuffer();
					str2.append(" select u.user_id as id, u.user_name as add_name,b.bo_address  as address, b.bo_email as email, b.bo_fax as fax")
					.append(",b.bo_homenumber as homenum,b.bo_mobile as phonenum,b.bo_worknumber as worknum,u.dept_id  as deptid ")
					//.append(",decode(b.bo_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
					//.append(" p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 where ','||b.bo_position||',' like '%,'||a1.p_acode||',%' )) as position")
					.append(",u.orderid as orderid from t_bus_contactbook b right join t_sys_user u on b.bo_userid=u.user_id ")
					.append(" where u.user_id in (").append(uid).append(")");
					if(faxno!=null && !"".equals(faxno)){
						str2.append(" and b.bo_fax not in ('").append(faxno).append("') ");
					}
				String ouid = c.getStr("e_personid");
					if(str2.length()>0){
						str2.append(" union ");
					}
					str2.append("SELECT b.p_id  as id,b.p_name as add_name,b.p_address as address,b.p_email as email,b.p_fax as fax")
					.append(",b.p_homenumber as homenum,b.p_mobile as phonenum,b.p_worknumber as worknum,b.p_orid  as deptid")
					//.append(",decode(b.p_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
					//.append(" p_acode = 'RPOSITION' connect by prior id=sup_id) a1 where ','||b.p_position||',' like '%,'||a1.p_acode||',%' )) as position")
					.append(",1000+b.p_sort as orderid FROM t_bus_organperson b where b.p_id in (").append(ouid).append(") ");
					if(faxno!=null && !"".equals(faxno)){
						str2.append(" and b.p_fax not in ('").append(faxno).append("') ");
					}
				str.append("(").append(str2).append(") e ");
			}
		}
		str.append(" order by e.orderid asc, e.id asc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	public Page<Record> getFaxListByEid(Integer pageSize,Integer pageNumber,String eventid){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select f.*,t.fax_task_id"
					+",decode(f.fax_number,null,null,(select v.add_name from vw_address v where v.fax=f.fax_number and rownum=1)) as faxname";
		StringBuffer  str = new StringBuffer();
		str.append("  from t_fax_record f left join t_bus_fax_task t  on  ','||t.callid||',' like '%,'||f.callid||',%' and t.callid is not null ");
		str.append(" where f.eventid=").append(eventid);
		str.append(" order by f.faxtime desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	//根据类型获取通讯簿信息
			public Page<Record> getPageByllwid(Integer pageSize, Integer pageNumber, String smsid) {
				pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
				pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
				String sql = "select e.*";
				StringBuffer str = new StringBuffer();
				str.append("  from ");
				if("hy_organ".equals(smsid)) {
					smsid = "d_0";
				}
				if("hy_user".equals(smsid)) {
					smsid = "u_0";
				}
				if("yj_organ".equals(smsid)) {
					smsid = "od_0";
				}
				if("yj_user".equals(smsid)) {
					smsid = "ou_0";
				}
				if(smsid.startsWith("d_")) {
					//组织机构
					str.append("( select 'd_'||d.d_id as id,b.bo_worknumber as worknum,b.bo_homenumber as homenum,b.bo_deptid as deptid").append(",b.bo_mobile as phonenum,b.bo_address as address,b.bo_fax as faxnum,d.d_name as smsname,d.orderid as orderid ").append(" from t_bus_contactbook b right join t_sys_department d on b.bo_deptid=d.d_id ").append(" where d.d_pid=").append(smsid.substring(2)).append(") e");
				} else if(smsid.startsWith("u_")) {
					//内部人员
					str.append("( select 'u_'||u.user_id as id,b.bo_worknumber as worknum,b.bo_homenumber as homenum,u.dept_id as deptid").append(",b.bo_mobile as phonenum,b.bo_address as address,b.bo_fax as faxnum,u.user_name as smsname,u.orderid as orderid ").append(",decode(b.bo_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ").append(" p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 where ','||b.bo_position||',' like '%,'||a1.p_acode||',%' )) as position").append(" from t_bus_contactbook b right join t_sys_user u on b.bo_userid=u.user_id ").append(" where u.dept_id=").append(smsid.substring(2)).append(") e");
				} else if(smsid.startsWith("od_")) {
					//日常组织机构
					str.append("(SELECT 'od_'||b.or_id as id,b.or_name as smsname,b.or_address as address,b.or_fax as faxnum,b.or_pid as deptid").append(",b.or_worknumber as worknum,b.or_email as email,b.or_pid as pid,b.or_sort as orderid FROM T_BUS_ORGAN b ").append(" where b.or_pid=").append(smsid.substring(3)).append(" ) e");
				} else if(smsid.startsWith("ou_")) {
					//日常机构人员
					str.append("(SELECT 'ou_'||b.p_id as id,b.p_name as smsname,b.p_address as address,b.p_email as email").append(",b.p_fax as faxnum,b.p_homenumber as homenum,b.p_mobile as phonenum,b.p_worknumber as worknum,").append("decode(b.p_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ").append(" p_acode = 'RPOSITION' connect by prior id=sup_id) a1 where ','||b.p_position||',' like '%,'||a1.p_acode||',%' )) as position").append(",b.p_orid as deptid,b.p_sort as orderid  FROM t_bus_organperson b where b.p_orid=").append(smsid.substring(3)).append(" ) e");
				}
				str.append(" order by e.orderid asc, e.id asc ");
				return Db.paginate(pageNumber, pageSize, sql, str.toString());
			}
}
