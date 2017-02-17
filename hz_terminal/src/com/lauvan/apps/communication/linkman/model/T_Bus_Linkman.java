package com.lauvan.apps.communication.linkman.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_linkman", pk = "id")
public class T_Bus_Linkman extends Model<T_Bus_Linkman> {
	private static final long	serialVersionUID	= 1L;
	public static T_Bus_Linkman	dao					= new T_Bus_Linkman();

	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String name, String tel, String deptname) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_linkman t where 1=1");
		if(name != null && !"".equals(name)) {
			str.append(" and t.name like '%").append(name).append("%'");
		}
		if(tel != null && !"".equals(tel)) {
			str.append(" and t.tel like '%").append(tel).append("%'");
		}
		if(deptname != null && !"".equals(deptname)) {
			str.append(" and t.dept='").append(deptname).append("'");
		}
		str.append(" order by t.id desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

	public List<Record> getdeptlist() {
		String sql="select * from (select min(id) as did,dept from t_bus_linkman group by dept) order by did asc";
		return Db.find(sql);
	}

	public List<Record> getlist() {
		String sql="select l.*,t1.did from t_bus_linkman l,( select * from (select min(id) as did,dept from t_bus_linkman group by dept) order by did asc) t1 where l.dept=t1.dept  or (l.dept is null and t1.dept is null)";
		return Db.find(sql);
	}

	public Page<Record> getQGridPage(Integer pageNum, Integer pageSize,
			String name, String tel, String ids, String llwid,String qid) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from (select qlm.*,qlm2.ordernum as ordernum from (select to_char(lm.id) as id,lm.name,lm.tel,lm.dept,lm.position,lm.remark from t_bus_linkman lm where 1=1 ");
		if(ids != null && !"".equals(ids)) {
			str.append(" and lm.id in(select regexp_substr(cid,'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+qid+") CONNECT BY REGEXP_SUBSTR(cid, '[^,]+', 1, LEVEL) IS NOT NULL)");
		}else{
			str.append(" and 1=2");
		}
		str.append(") qlm,( select REGEXP_SUBSTR (cid,'[^,]+',1,LEVEL) as id,rownum as ordernum FROM  (select * from t_bus_linkman_qun where id="+qid+")  CONNECT BY REGEXP_SUBSTR (cid,'[^,]+',1,LEVEL) IS NOT NULL) qlm2 where qlm.id=qlm2.id");
		if(llwid != null && !"".equals(llwid)){
			llwid=llwid.replaceAll(",", "','");
			if(llwid.indexOf("u_")!=-1){
			str.append(" union select 'u_'||u.user_id as id,u.user_name as name,b.bo_mobile as tel,u.d_name as dept,decode(b.bo_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with  p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 where ','||b.bo_position||',' like '%,'||a1.p_acode||',%' )) as position,null as remark,99999 as ordernum from t_bus_contactbook b right join (select tu.*,td.d_name from t_sys_user tu left join t_sys_department td on tu.dept_id=td.d_id) u on b.bo_userid=u.user_id where 'u_'||u.user_id in (select regexp_substr(to_char(llwid),'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+qid+") CONNECT BY REGEXP_SUBSTR(to_char(llwid), '[^,]+', 1, LEVEL) IS NOT NULL)");	
			}
			if(llwid.indexOf("d_")!=-1){
			str.append(" union select 'd_'||d.d_id as id,d.d_name as name,b.bo_mobile as tel,d.dept,null as position,null as remark,99999 as ordernum  from t_bus_contactbook b right join (select d1.*,d2.d_name as dept from t_sys_department d1 left join t_sys_department d2 on d1.d_pid=d2.d_id) d on b.bo_deptid=d.d_id where 'd_'||d.d_id in (select regexp_substr(to_char(llwid),'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+qid+") CONNECT BY REGEXP_SUBSTR(to_char(llwid), '[^,]+', 1, LEVEL) IS NOT NULL)");	
			}
			if(llwid.indexOf("ou_")!=-1){
			str.append(" union select 'ou_'||b.p_id as id,b.p_name as name,b.p_mobile as tel,b.dept,decode(b.p_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with  p_acode = 'RPOSITION' connect by prior id=sup_id) a1 where ','||b.p_position||',' like '%,'||a1.p_acode||',%' )) as position,null as remark,99999 as ordernum  from (select os.*,bo.or_name as dept from t_bus_organperson os left join t_bus_organ bo on os.p_orid=bo.or_id) b where 'ou_'||b.p_id in (select regexp_substr(to_char(llwid),'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+qid+") CONNECT BY REGEXP_SUBSTR(to_char(llwid), '[^,]+', 1, LEVEL) IS NOT NULL)");	
			}
			if(llwid.indexOf("od_")!=-1){
			str.append(" union select 'od_'||b.or_id as id,b.or_name as name,null as tel,b.dept,null as position,null as remark,99999 as ordernum from (select o1.*,o2.or_name as dept from t_bus_organ o1 left join t_bus_organ o2 on o1.or_pid=o2.or_id) b where 'od_'||b.or_id in (select regexp_substr(to_char(llwid),'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+qid+") CONNECT BY REGEXP_SUBSTR(to_char(llwid), '[^,]+', 1, LEVEL) IS NOT NULL)");	
			}
			
		}
		str.append(") t where 1=1");
		if(name != null && !"".equals(name)) {
			str.append(" and t.name like '%").append(name).append("%'");
		}
		if(tel != null && !"".equals(tel)) {
			str.append(" and t.tel like '%").append(tel).append("%'");
		}
		str.append(" order by t.ordernum asc,t.id asc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

	public List<Record> getlistinid(String ids) {
		String sql="select * from t_bus_linkman where id in("+ids+")";
		return Db.find(sql);
	}
	//此电话是否存在
	public T_Bus_Linkman findbytelnum(String tel){
		String sql="select * from t_bus_linkman where tel='"+tel+"'";
		return dao.findFirst(sql);
	}
	/**
	 * 根据类型和id 获取联系人信息
	 * */
	public Page<Record> getPageLink(Integer pageSize,Integer pageNum,  String did, String pid) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,t.name as smsname,t.tel as phonenum";
		StringBuffer str = new StringBuffer();
		if("dept".equals(pid)){
			//部门查询
			str.append(" from t_bus_linkman t ");
			str.append(" ,(select min(id) as did, dept from t_bus_linkman group by dept) d where t.dept=d.dept and d.did="+did);
		}else{
			T_Bus_Linkman_Qun qun = T_Bus_Linkman_Qun.dao.findById(did.substring(2));
			str.append(" from (select qlm.*,qlm2.ordernum as ordernum from (select to_char(lm.id) as id,lm.name,lm.tel,lm.dept,lm.position,lm.remark from t_bus_linkman lm where lm.id in (select regexp_substr(cid,'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+did.substring(2)+") CONNECT BY REGEXP_SUBSTR(cid, '[^,]+', 1, LEVEL) IS NOT NULL)");
			str.append(" ) qlm,( select REGEXP_SUBSTR (cid,'[^,]+',1,LEVEL) as id,rownum as ordernum FROM  (select * from t_bus_linkman_qun where id="+did.substring(2)+")  CONNECT BY REGEXP_SUBSTR (cid,'[^,]+',1,LEVEL) IS NOT NULL) qlm2 where qlm.id=qlm2.id");
			String llwid = qun.get("llwid")==null?"":qun.getStr("llwid");
			if(llwid != null && !"".equals(llwid)){
				llwid=llwid.replaceAll(",", "','");
				if(llwid.indexOf("u_")!=-1){
					str.append(" union select 'u_'||u.user_id as id,u.user_name as name,b.bo_mobile as tel,u.d_name as dept,decode(b.bo_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with  p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 where ','||b.bo_position||',' like '%,'||a1.p_acode||',%' )) as position,null as remark,99999 as ordernum from t_bus_contactbook b right join (select tu.*,td.d_name from t_sys_user tu left join t_sys_department td on tu.dept_id=td.d_id) u on b.bo_userid=u.user_id where 'u_'||u.user_id in (select regexp_substr(to_char(llwid),'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+did.substring(2)+") CONNECT BY REGEXP_SUBSTR(to_char(llwid), '[^,]+', 1, LEVEL) IS NOT NULL)");	
					}
					if(llwid.indexOf("d_")!=-1){
					str.append(" union select 'd_'||d.d_id as id,d.d_name as name,b.bo_mobile as tel,d.dept,null as position,null as remark,99999 as ordernum  from t_bus_contactbook b right join (select d1.*,d2.d_name as dept from t_sys_department d1 left join t_sys_department d2 on d1.d_pid=d2.d_id) d on b.bo_deptid=d.d_id where 'd_'||d.d_id in (select regexp_substr(to_char(llwid),'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+did.substring(2)+") CONNECT BY REGEXP_SUBSTR(to_char(llwid), '[^,]+', 1, LEVEL) IS NOT NULL)");	
					}
					if(llwid.indexOf("ou_")!=-1){
					str.append(" union select 'ou_'||b.p_id as id,b.p_name as name,b.p_mobile as tel,b.dept,decode(b.p_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with  p_acode = 'RPOSITION' connect by prior id=sup_id) a1 where ','||b.p_position||',' like '%,'||a1.p_acode||',%' )) as position,null as remark,99999 as ordernum  from (select os.*,bo.or_name as dept from t_bus_organperson os left join t_bus_organ bo on os.p_orid=bo.or_id) b where 'ou_'||b.p_id in (select regexp_substr(to_char(llwid),'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+did.substring(2)+") CONNECT BY REGEXP_SUBSTR(to_char(llwid), '[^,]+', 1, LEVEL) IS NOT NULL)");	
					}
					if(llwid.indexOf("od_")!=-1){
					str.append(" union select 'od_'||b.or_id as id,b.or_name as name,null as tel,b.dept,null as position,null as remark,99999 as ordernum from (select o1.*,o2.or_name as dept from t_bus_organ o1 left join t_bus_organ o2 on o1.or_pid=o2.or_id) b where 'od_'||b.or_id in (select regexp_substr(to_char(llwid),'[^,]+',1,LEVEL) from (select * from t_bus_linkman_qun where id = "+did.substring(2)+") CONNECT BY REGEXP_SUBSTR(to_char(llwid), '[^,]+', 1, LEVEL) IS NOT NULL)");	
					}
				
			}
			str.append(")t");
		}
		
		str.append(" order by t.ordernum asc,t.id asc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
}
