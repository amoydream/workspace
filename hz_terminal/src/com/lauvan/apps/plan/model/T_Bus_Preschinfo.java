package com.lauvan.apps.plan.model;

import java.io.File;
import java.util.Date;
import java.util.List;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_bus_preschinfo",pk="id")
public class T_Bus_Preschinfo extends Model<T_Bus_Preschinfo> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_Preschinfo dao = new T_Bus_Preschinfo();
	
	public String insert(T_Bus_Preschinfo t){
		Number id = AutoId.nextval(t);
		Date now = new Date();
		t.set("id", id);
		t.set("preschid", DateTimeUtil.formatDate(now, "yyyyMMddHHmmss")+String.format("%06d", id.intValue()));
		t.set("marktime", DateTimeUtil.formatDate(now, DateTimeUtil.Y_M_D_HMS_FORMAT));
		//若有所属机构，发布机构，则保存对应名称
		/*t.set("preschdeptname", getOrganName(t.getStr("organid")));
		t.set("preschpubdept", getOrganName(t.getStr("organid_fb")));
		t.set("preschworkdept", getOrganName(t.getStr("organid_bz")));
		t.set("preschexamdept", getOrganName(t.getStr("organid_sp")));*/
		t.save();
		return id.toString();
	}
	
	/**
	 * 判断是否全是该用户创建的预案
	 * */
	public boolean isCreater(String ids,String user){
		boolean flag = true;
		String sql = "select * from t_bus_preschinfo where id in("+ids+") and user_id<>"+user;
		T_Bus_Preschinfo t = dao.findFirst(sql);
		if(t!=null){
			flag = false;
		}
		return flag;
	}
	/**
	 * 判断是否全是该用户部门创建的预案
	 * */
	public boolean isCreatDept(String ids,String dept){
		boolean flag = true;
		String sql = "select * from t_bus_preschinfo where id in("+ids+") and user_id not in(select user_id from t_sys_user where dept_id="+dept+")";
		T_Bus_Preschinfo t = dao.findFirst(sql);
		if(t!=null){
			flag = false;
		}
		return flag;
	}
	/**
	 * 根据ID删除预案
	 * */
	public boolean deleteByIds(String ids){
		//删除操作手册
		String str = "select * from t_bus_preschinfo where id in ("+ids+")";
		List<T_Bus_Preschinfo> list = dao.find(str);
		if(list!=null && !"".equals(list)){
			for(T_Bus_Preschinfo t : list){
				String url = t.getStr("preschdocpath"); 
				if(url!=null && !"".equals(url)){
					if(!url.startsWith("/")&&url.indexOf(":")!=1){
						url =  PathKit.getWebRootPath() +"/"+ url;
					}
					File file = new File(url);
					if(file.exists()){
						file.delete();
					}
				}
			}
		}
		String sql = "delete from t_bus_preschinfo where id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public Page<Record> getPageList(Integer pageSize,Integer pageNumber,String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select p.*";
		StringBuffer  str = new StringBuffer();
		str.append(" from t_bus_preschinfo p where 1=1 ");
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by p.preschtype asc ,p.marktime desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	/**
	 * 获取机构以及人员列表
	 * */
	public List<Record> getOrganList(String flag){
		String sql = "select decode(v.add_type,'0','d_','1','u_','2','od_','3','ou_')||v.dpid as add_pid,v.* from vw_address v where 1=1 ";
		if(flag==null || "".equals(flag)){
			sql = sql +" and v.add_type in ('0','2')";
		}
		List<Record> list = Db.find(sql);
		Record dept = new Record();
		dept.set("add_pid", "0");
		dept.set("add_name", "系统部门");
		dept.set("add_code", "d_0");
		list.add(dept);
		Record dept2 = new Record();
		dept2.set("add_pid", "0");
		dept2.set("add_name", "日常机构");
		dept2.set("add_code", "od_0");
		list.add(dept2);
		if("1".equals(flag)){
			Record user = new Record();
			user.set("add_pid", "0");
			user.set("add_name", "系统用户");
			user.set("add_code", "u_0");
			list.add(user);
			Record user2 = new Record();
			user2.set("add_pid", "0");
			user2.set("add_name", "日常机构人员");
			user2.set("add_code", "ou_0");
			list.add(user2);
		}
		return list;
	}
	/**
	 * 根据视图ID获取机构名称
	 * */
	public String getOrganName(String id){
		String name ="";
		if(id==null||"".equals(id)){
			return name;
		}
		if("d_0".equals(id)){
			name = "系统部门";
		}else if("od_0".equals(id)){
			name = "日常机构";
		}else if("u_0".equals(id)){
			name = "系统用户";
		}else if("ou_0".equals(id)){
			name = "日常机构人员";
		}else{
			String sql = "select add_name from vw_address where add_code='"+id+"'";
			name = Db.queryStr(sql);
			if(name==null){
				name = "";
			}
		}
		return name;
	}
	
	/**
	 * 查询预案
	 * */
	public Page<Record> getPageSearch(Integer pageSize,Integer pageNumber,String eptype,String eplevel,String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select p.*";
		StringBuffer  str = new StringBuffer();
		str.append(" from t_bus_preschinfo p where 1=1 ");
		StringBuffer str2 = new StringBuffer();
		boolean flag = false;
		str2.append(" and p.id in(select distinct i1.preschid from t_bus_planitem i1,t_bus_planitem i2 ")
		.append(" where i1.preschid=i2.preschid and i1.planitemcode='1010' and i2.planitemcode='8010'");
		if(eptype!=null && !"".equals(eptype)){
			flag = true;
			str2.append(" and i1.itemid='").append(eptype).append("'");
		}
		if(eplevel!=null && !"".equals(eplevel)){
			flag = true;
			str2.append(" and i2.itemid='").append(eplevel).append("'");
		}
		str2.append(")");
		if(flag){
			str.append(str2.toString());
		}
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by p.preschtype asc ,p.marktime desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}

	public void impByIds(String pid, String mid) {
		T_Bus_Preschinfo pinfo=T_Bus_Preschinfo.dao.findById(pid);
		T_Bus_Preschinfo model=T_Bus_Preschinfo.dao.findById(mid);
		if(pinfo.getStr("preschscale")==null||pinfo.getStr("preschscale").equals("")){
			pinfo.set("preschscale", model.getStr("preschscale"));
		}
		if(pinfo.getStr("incidenttypenote")==null||pinfo.getStr("incidenttypenote").equals("")){
			pinfo.set("incidenttypenote", model.getStr("incidenttypenote"));
		}
		if(pinfo.getStr("preschdetail")==null||pinfo.getStr("preschdetail").equals("")){
			pinfo.set("preschdetail", model.getStr("preschdetail"));
		}
		if(pinfo.getStr("note")==null||pinfo.getStr("note").equals("")){
			pinfo.set("note", model.getStr("note"));
		}
		pinfo.update();
	}
	
	/**
	 * 获取预案树
	 * */
	public List<Record> getTreeList(String type){
		String sql = "select 'p_'||t.id as tid,t.*,pt.id as pid from t_bus_preschinfo t"
					+",(select p.* from t_sys_parameter p start with p.id=745 connect by prior p.id=p.sup_id) pt"
					+" where t.preschtype=pt.p_acode ";
		if(type!=null && !"".equals(type)){
			sql = sql + " and t.type='"+type+"'";
		}
		return Db.find(sql);
	}
	public List<Record> getcountListbytype() {
		String sql="select * from (select a.*,connect_by_isleaf as lvl from t_sys_parameter a where  a.p_acode<>'ZDFHJBDM' and a.p_acode<>'YAFL' Start With a.p_acode='YAFL' Connect By  Prior a.id = a.sup_id) x left join (select count(p.id) as countnum,preschtype from t_bus_preschinfo p group by preschtype) y on x.p_acode=y.preschtype";
		return Db.find(sql);
	}

	public Record getcountbysb() {
		String sql="select '未审批' as p_name,count(*) as countnum from t_bus_preschinfo where type=0";
		return Db.findFirst(sql);
	}
	public Record getcountbysp() {
		String sql="select '审批' as p_name,count(*) as countnum from t_bus_preschinfo where type=0 and isverify='00S'";
		return Db.findFirst(sql);
	}
	public List<Record> getcountListbydept() {
		String sql="select decode(preschdeptname,null,'未分所属部门',preschdeptname) as p_name,count(*) as countnum from T_Bus_Preschinfo group by preschdeptname order by preschdeptname desc";
		return Db.find(sql);
	}

	public List<Record> getdept() {
		String sql="select * from (select distinct(decode(preschdeptname,null,'未分所属部门',preschdeptname))  as dept from t_bus_preschinfo) a order by a.dept asc";
		return Db.find(sql);
	}

	public List<Record> gethang() {
		String sql="select a.* from t_sys_parameter a where  a.p_acode<>'ZDFHJBDM' and a.p_acode<>'YAFL' Start With a.p_acode='YAFL' Connect By  Prior a.id = a.sup_id";
		return Db.find(sql);
	}

	public List<Record> getNumbydept(String dept) {
		String sql="select * from (select a.*,connect_by_isleaf as lvl from t_sys_parameter a where  a.p_acode<>'ZDFHJBDM' and a.p_acode<>'YAFL' Start With a.p_acode='YAFL' Connect By  Prior a.id = a.sup_id) x left join (select * from (select count(p1.id) as countnum,preschtype,preschdeptname from t_bus_preschinfo p1 group by preschtype,preschdeptname) p where p.preschdeptname='"+dept+"') y on x.p_acode=y.preschtype";
		if(dept.equals("未分所属部门")){
			sql="select * from (select a.*,connect_by_isleaf as lvl from t_sys_parameter a where  a.p_acode<>'ZDFHJBDM' and a.p_acode<>'YAFL' Start With a.p_acode='YAFL' Connect By  Prior a.id = a.sup_id) x left join (select * from (select count(p1.id) as countnum,preschtype,preschdeptname from t_bus_preschinfo p1 group by preschtype,preschdeptname) p where p.preschdeptname is null) y on x.p_acode=y.preschtype";
		}
		return Db.find(sql);
	}

	public List<Record> gethangwithout0() {
		String sql="select * from (select a.*,connect_by_isleaf as lvl from t_sys_parameter a where  a.p_acode<>'ZDFHJBDM' and a.p_acode<>'YAFL' Start With a.p_acode='YAFL' Connect By  Prior a.id = a.sup_id) x where x.lvl<>0";
		return Db.find(sql);
	}

	public List<Record> getNumbytype(String str) {
		String sql="select k.*,decode(k.preschdeptname,null,'未分所属部门',k.preschdeptname) as dept from (select *   from "
				+" (select a.*, connect_by_isleaf as lvl from t_sys_parameter a where a.p_acode <> 'ZDFHJBDM' and a.p_acode <> 'YAFL' Start With a.p_acode = 'YAFL' Connect By Prior a.id = a.sup_id) x"
		+" left join (select count(p1.id) as countnum, preschtype, preschdeptname from t_bus_preschinfo p1 group by preschtype, preschdeptname) y on x.p_acode = y.preschtype) k where p_acode='"+str+"' order by preschdeptname asc";
		return Db.find(sql);
	}
}
