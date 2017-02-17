package com.lauvan.apps.plan.model;
/**
 * 预案要素表
 * */

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.workcontact.model.T_Bus_EmergencyContact;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_planitem",pk="id")
public class T_Bus_PlanItem extends Model<T_Bus_PlanItem> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_PlanItem dao = new T_Bus_PlanItem();
	
	public void insert(T_Bus_PlanItem t){
		t.set("id", AutoId.nextval(t));
		t.save();
	}
	/**
	 * 根据id删除要素
	 * */
	public boolean deleteByIds(String ids){
		String sql = "delete from t_bus_planitem where id in ("+ids+")";
		return Db.update(sql)>0;
	}
	/**
	 * 根据itemid,要素类型，预案id删除要素
	 * */
	public boolean deleteByCode(String ids,String code,String pid){
		String sql = "delete from t_bus_planitem where preschid="+pid
					+" and planitemcode='"+code+"'"
					+" and itemid not in ('"+ids.replaceAll(",", "','")+"')";
		return Db.update(sql)>0;
	}
	/**
	 * 根据预案ID，和要素类型，获取要素列表
	 * */
	public List<Record> getListByIdCode(String id,String code){
		String sql = "select t.* from t_bus_planitem t ";
		String sql2="";
		if("3020".equals(code)){
			//应急物资
			sql2 = sql2 + ",T_Bus_Materialname m where t.itemid = m.mn_id ";
		}
		if("2080".equals(code)){
			//应急专家
			sql2 = sql2 + ",T_Bus_Expert x where t.itemid = x.ex_id ";
		}
		if("3010".equals(code)){
			//应急队伍
			sql2 = sql2 + ",T_Bus_Team x where t.itemid = x.tea_id ";
		}
		if("3030".equals(code)){
			//应急装备
			sql2 = sql2 + ",T_Bus_Equipname x where t.itemid = x.eqn_id ";
		}
		if("".equals(sql2)){
			sql = sql +" where 1=1 ";
		}else{
			sql = sql + sql2;
		}
		sql = sql + " and t.preschid="+id;
		if(code!=null && !"".equals(code)){
			sql = sql + " and t.planitemcode='"+code+"'";
		}
		sql = sql + "order by t.itemid desc ";
		return Db.find(sql);
	}
	/**
	 * 根据预案ID，要素类型，要素父级，获取要素列表
	 * */
	public Page<Record> getPageByIdCode(Integer pageSize,Integer pageNumber,String preschid,String pid,String code,String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select p.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_planitem p where p.preschid=").append(preschid);
		if(pid!=null && !"".equals(pid)){
			str.append(" and p.pid=").append(pid);
		}
		if(code!=null && !"".equals(code)){
			str.append(" and p.planitemcode='").append(code).append("' ");
		}
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by p.id desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	/**
	 * 根据预案ID，要素类型，要素父级，获取资源列表
	 * */
	public Page<Record> getPageByIdResCode(Integer pageSize,Integer pageNumber,String preschid,String pid,String code,String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select p.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_planitem p ");
		if("3020".equals(code)){
			//应急物资
			sql = sql +",m.typeclass as tcode";
			str.append(",T_Bus_Materialname m where p.itemid = m.mn_id ");
		}
		if("2080".equals(code)){
			//应急专家
			sql = sql +",x.remark";
			str.append(",T_Bus_Expert x where p.itemid = x.ex_id ");
		}
		if("3010".equals(code)){
			//应急队伍
			sql = sql +",x.teamjob";
			str.append(",T_Bus_Team x where p.itemid = x.tea_id ");
		}
		if("3030".equals(code)){
			//应急装备
			sql = sql +",x.remark";
			str.append(",T_Bus_Equipname x where p.itemid = x.eqn_id ");
		}
		if("".equals(code)){
			str.append(" where 1=1 ");
		}
		str.append(" and p.preschid=").append(preschid);
		if(pid!=null && !"".equals(pid)){
			str.append(" and p.pid=").append(pid);
		}
		if(code!=null && !"".equals(code)){
			str.append(" and p.planitemcode='").append(code).append("' ");
		}
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by p.id desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	public List<Record> getListByIdResCode(String preschid, String pid,
			String code) {
		String sql = "select p.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_planitem p ");
		if("3020".equals(code)){
			//应急物资
			sql = sql +",m.typeclass as tcode";
			str.append(",T_Bus_Materialname m where p.itemid = m.mn_id ");
		}
		if("2080".equals(code)){
			//应急专家
			sql = sql +",x.remark";
			str.append(",T_Bus_Expert x where p.itemid = x.ex_id ");
		}
		if("3010".equals(code)){
			//应急队伍
			sql = sql +",x.teamjob";
			str.append(",T_Bus_Team x where p.itemid = x.tea_id ");
		}
		if("3030".equals(code)){
			//应急装备
			sql = sql +",x.remark";
			str.append(",T_Bus_Equipname x where p.itemid = x.eqn_id ");
		}
		if("".equals(code)){
			str.append(" where 1=1 ");
		}
		str.append(" and p.preschid=").append(preschid);
		if(pid!=null && !"".equals(pid)){
			str.append(" and p.pid=").append(pid);
		}
		if(code!=null && !"".equals(code)){
			str.append(" and p.planitemcode='").append(code).append("' ");
		}
		str.append(" order by p.id desc ");
		return Db.find(sql+str.toString());
	}
	/**
	 * 根据资源类型，获取资源信息列表
	 * */
	public Page<Record> getPageByRecid(Integer pageSize,Integer pageNumber,String code,String rescid,String preschid,String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select e.*";
		StringBuffer  str = new StringBuffer();
		str.append("  from ");
		if("3020".equals(code)){
			//应急物资
			str.append("(select m.mn_id as id, m.mn_name as name,m.type,m.typeclass as tcode,m.sizeclass as scode")
			.append(",m.measureunit as ucode,m.remark as remark,decode(i.id,null,0, 1) as checked from  T_Bus_Materialname m")
			.append(" left join t_bus_planitem i on i.itemid=m.mn_id and i.planitemcode='3020' and i.preschid="+preschid+" ) e");
		}
		if("2080".equals(code)){
			//应急专家
			str.append("(select x.ex_id as id,x.typeid as type ")
			.append(",x.*,decode(i.id,null,0, 1) as checked from  T_Bus_Expert x")
			.append(" left join t_bus_planitem i on i.itemid=x.ex_id and i.planitemcode='2080' and i.preschid="+preschid+" ) e");
		}
		if("3010".equals(code)){
			//应急队伍
			str.append("(select t.tea_id as id ")
			.append(",t.*,decode(i.id,null,0, 1) as checked from  T_Bus_Team t ")
			.append(" left join t_bus_planitem i on i.itemid=t.tea_id and i.planitemcode='3010' and i.preschid="+preschid+" ) e");
		}
		if("3030".equals(code)){
			//应急装备
			str.append("(select eq.eqn_id as id,eq.eqn_name as name,eq.type,eq.typeclass as tcode,eq.sizeclass as scode")
			.append(",eq.measureunit as ucode,eq.remark as remark,decode(i.id,null,0, 1) as checked from  T_Bus_Equipname eq ")
			.append(" left join t_bus_planitem i on i.itemid=eq.eqn_id and i.planitemcode='3030' and i.preschid="+preschid+" ) e");
		}
		str.append(" where 1=1 ");
		if(rescid!=null && !"".equals(rescid)){
			str.append(" and e.type=");
			if("3010".equals(code)){
				str.append("'").append(rescid).append("' ");
			}else{
				str.append(rescid);
			}
		}
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by e.id desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	/**
	 * 根据资源类型，获取资源信息列表
	 * */
	public List<Record> getListByRecid(String code,String rescid){
		String sql = "select e.*";
		StringBuffer  str = new StringBuffer();
		str.append("  from ");
		if("3020".equals(code)){
			//应急物资
			str.append("(select m.mn_id as id, m.mn_name as name,m.type,m.typeclass as tcode,m.sizeclass as scode")
			.append(",m.measureunit as ucode,m.remark as remark from  T_Bus_Materialname m) e");
		}
		if("2080".equals(code)){
			//应急专家
			str.append("(select x.ex_id as id,x.typeid as type ")
			.append(",x.* from  T_Bus_Expert x) e");
		}
		if("3010".equals(code)){
			//应急队伍
			str.append("(select t.tea_id as id ")
			.append(",t.* from  T_Bus_Team t) e");
		}
		if("3030".equals(code)){
			//应急装备
			str.append("(select eq.eqn_id as id,eq.eqn_name as name,eq.type,eq.typeclass as tcode,eq.sizeclass as scode")
			.append(",eq.measureunit as ucode,eq.remark as remark from  T_Bus_Equipname eq )e");
		}
		str.append(" where 1=1 ");
		if(rescid!=null && !"".equals(rescid)){
			str.append(" and e.id in (").append(rescid).append(")");
		}
		str.append(" order by Instr('"+rescid+"',e.id) ");
		return Db.find(sql+str.toString());
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
			str.append("( select 'd_'||d.d_id as id,b.bo_worknumber as worknum,b.bo_homenumber as homenum,b.bo_deptid as deptid")
			.append(",b.bo_mobile as phonenum,b.bo_address as address,b.bo_fax as faxnum,d.d_name as smsname,d.orderid as orderid ")
			.append(" from t_bus_contactbook b right join t_sys_department d on b.bo_deptid=d.d_id ")
			.append(" where d.d_pid=").append(smsid.substring(2)).append(") e");
		}
		else if(smsid.startsWith("u_")){
			//内部人员
			str.append("( select 'u_'||u.user_id as id,b.bo_worknumber as worknum,b.bo_homenumber as homenum,u.dept_id as deptid")
			.append(",b.bo_mobile as phonenum,b.bo_address as address,b.bo_fax as faxnum,u.user_name as smsname,u.orderid as orderid ")
			.append(",decode(b.bo_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
			.append(" p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 where ','||b.bo_position||',' like '%,'||a1.p_acode||',%' )) as position")
			.append(" from t_bus_contactbook b right join t_sys_user u on b.bo_userid=u.user_id ")
			.append(" where u.dept_id=").append(smsid.substring(2)).append(") e");
		}
		else if(smsid.startsWith("od_")){
			//日常组织机构
			str.append("(SELECT 'od_'||b.or_id as id,b.or_name as smsname,b.or_address as address,b.or_fax as faxnum,b.or_pid as deptid")
			.append(",b.or_worknumber as worknum,b.or_email as email,b.or_pid as pid,b.or_sort as orderid FROM T_BUS_ORGAN b ")
			.append(" where b.or_pid=").append(smsid.substring(3)).append(" ) e");
		}
		else if(smsid.startsWith("ou_")){
			//日常机构人员
			str.append("(SELECT 'ou_'||b.p_id as id,b.p_name as smsname,b.p_address as address,b.p_email as email")
			.append(",b.p_fax as faxnum,b.p_homenumber as homenum,b.p_mobile as phonenum,") 
			.append("decode(b.p_position,null,null,(select to_char(wmsys.wm_concat(a1.p_name)) from (select * from t_sys_parameter start with ")
			.append(" p_acode = 'RPOSITION' connect by prior id=sup_id) a1 where ','||b.p_position||',' like '%,'||a1.p_acode||',%' ))")
			.append("  as position,b.p_worknumber as worknum")
			.append(",b.p_orid as deptid,b.p_sort as orderid  FROM t_bus_organperson b where b.p_orid=").append(smsid.substring(3)).append(" ) e");
		}else {
			//群组人员
			T_Bus_EmergencyContact c = T_Bus_EmergencyContact.dao.findById(smsid.substring(2));
			if(c!=null){
				String uid = c.getStr("e_bookid");
				StringBuffer str2 = new StringBuffer();
				//if(uid!=null && !"".equals(uid)){
					str2.append(" select 'u_'||u.user_id as id, u.user_name as smsname,b.bo_address  as address, b.bo_email as email, b.bo_fax as faxnum")
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
					str2.append("SELECT 'ou_'||b.p_id  as id,b.p_name as smsname,b.p_address as address,b.p_email as email,b.p_fax as faxnum")
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
	
	//根据id获取已勾选机构/人员
	public List<Record> getOrgList(String id){
		String sql = "select v.add_code as id,v.add_name as smsname,v.* from vw_address v where 1=1 ";
		if(id!=null && !"".equals(id)){
			sql = sql + " and v.add_code in ('"+id.replaceAll(",", "','")+"')";
		}
		return Db.find(sql);
	}
	
	//获取要素树
	public List<Record> getTreeData(String pid,String preschid){
		String sql = "select p.*,case when (select count(a.id) from t_bus_planitem a where a.pid=p.id)>0"
					+" then 1 else 0 end as isleaf from t_bus_planitem p where p.preschid="+preschid
					+" start with p.pid="+pid
					+" connect by prior p.id =p.pid order by p.id asc";
		return Db.find(sql);
	}
		public void deleteBYprechid(String preshid){
			String sql = "delete from t_bus_planitem where preschid in ("+preshid+")";
			Db.update(sql);
		}
		public void impByIds(String pid, String mid) {
			Map<String,Object> map=new HashMap<String,Object>();
			String sql="select * from t_bus_planitem where preschid="+mid;
			List<T_Bus_PlanItem> list=T_Bus_PlanItem.dao.find(sql);
			if(!list.isEmpty()){
				for(T_Bus_PlanItem r:list){
					Number newid=AutoId.nextval(r);
					map.put(r.get("id").toString(), newid);
					r.set("id",newid).set("preschid", pid);
					r.save();
				}
				sql="select * from t_bus_planitem where preschid="+pid;
				List<T_Bus_PlanItem> list2=T_Bus_PlanItem.dao.find(sql);
				for(T_Bus_PlanItem r2:list2){
					if(r2.get("pid")!=null&&!r2.get("pid").equals("")&&r2.getBigDecimal("pid")!=BigDecimal.valueOf(0)){
					if(map.get(r2.get("pid").toString())!=null&&!map.get(r2.get("pid").toString()).equals("")){
					r2.set("pid",map.get(r2.get("pid").toString()));
					r2.update();
					}
					}
				}
			}
		}
		
	//根据预案，以及事件级别查询预案级别
	public List<Record> getEPlevel(String preschid,String elevel){
		String sql = "select p.*,decode(p.itemid,'"+elevel+"',1,0) as ischecked,substr(p.itemname,1,instr(p.itemname,'级')) as name"
					+" from t_bus_planitem p where p.planitemcode='8010' and p.preschid="+preschid+" order by p.itemid asc";
		return Db.find(sql);
	}
	
	/**
	 * 根据预案ID，和要素类型，获取要素列表
	 * */
	public List<Record> getListByIdCode2(String id,String code){
		String sql = "select t.planitemcode, t2.* from t_bus_planitem t ";
		String sql2="";
		if("3020".equals(code)){
			//应急物资
			sql2 = sql2 + ",(select * from T_Bus_Materialname m left join (select materialid,LONGITUDE,LATITUDE from t_bus_store, t_bus_repertory where repertoryid = rep_id) " +
					"s on m.mn_id = s.materialid) t2 where t.itemid = t2.mn_id ";
		}
		if("2080".equals(code)){
			//应急专家
			sql2 = sql2 + ",(select t3.* ,t4.p_name as typename from T_Bus_Expert t3 left join ( select * from t_sys_parameter start with p_acode = 'YJZJ' connect by prior id =  sup_id) t4 " +
					" on t3.typeid = t4.id) t2 where t.itemid = t2.ex_id ";
		}
		if("3010".equals(code)){
			//应急队伍
			sql2 = sql2 + ",T_Bus_Team t2 where t.itemid = t2.tea_id ";
		}
		if("3030".equals(code)){
			//应急装备
			sql2 = sql2 + ",(select eqn_id,longitude, latitude, eqn_name from T_Bus_Equipname, t_bus_equipstore where eqn_id = equipnameid) t2 where t.itemid = t2.eqn_id ";
		}
		if("".equals(sql2)){
			sql = sql +" where 1=1 ";
		}else{
			sql = sql + sql2;
		}
		sql = sql + " and t.preschid="+id;
		if(code!=null && !"".equals(code)){
			sql = sql + " and t.planitemcode='"+code+"'";
		}
		sql = sql + "order by t.id desc ";
		return Db.find(sql);
	}
	

}
