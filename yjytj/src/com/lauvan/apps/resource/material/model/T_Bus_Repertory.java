package com.lauvan.apps.resource.material.model;

import java.math.BigDecimal;
import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_repertory", pk = "rep_id")
public class T_Bus_Repertory extends Model<T_Bus_Repertory>{

	private static final long serialVersionUID = 5591215954074359182L;
	
	public static final T_Bus_Repertory dao=new T_Bus_Repertory();
	
	public Page<Record> getPage(Integer pageSize,Integer pageNum,String name,String jbCode,String djCode){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select rep.*,jb.id p_id,jb.p_name jb_name,dj.id dj_id,dj.p_name dj_name,dept.d_name ";
		StringBuffer sql = new StringBuffer("from T_BUS_REPERTORY rep left join (select p2.* from t_sys_parameter p1,t_sys_parameter p2 where p1.id=p2.sup_id and p1.p_acode='"+(jbCode.isEmpty()?"":jbCode)+"') jb on rep.levelcode=jb.p_acode"
						+" left join (select p2.* from t_sys_parameter p1,t_sys_parameter p2 where p1.id=p2.sup_id and p1.p_acode='"+(djCode.isEmpty()?"":djCode)+"') dj on rep.deflevelcode=dj.p_acode"
						+" left join t_sys_department dept on rep.organid =dept.d_id where 1=1");
		if(name != null && !"".equals(name)){
			sql.append("and name like '%").append(name).append("%' ");
		}
		sql.append(" order by rep_id desc");
		return Db.paginate(pageNum, pageSize, select, sql.toString());
	}
	
	public boolean insert(T_Bus_Repertory p){
		p.set("rep_id", AutoId.nextval(p));
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.save();
	}
	
	public boolean upd(T_Bus_Repertory p){
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.update();
	}
	
	public boolean  deleteByIds(String ids){
		String sql = "delete from t_bus_repertory where rep_id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public T_Bus_Repertory getById(Integer id){
		String sql = "select r.* , a.name as fjname , a.m_size from t_bus_repertory r left join t_attachment a on r.fjid = a.id where r.rep_id ="+id;
		return dao.findFirst(sql);
	}
	
	public T_Bus_Repertory getRepertoryByRepid(BigDecimal rep_id) {
		return dao.findFirst(
				"select * from t_bus_repertory where rep_id=?", rep_id);
	}
	
	//根据仓库ids返回对应的附件字符串
	public String getfjidsByIds(String ids){
		String sql = "select wm_concat(c.fjid) as fjids from t_bus_repertory c where c.rep_id in (" + ids + ")";
		return Db.queryStr(sql);
	}
	
	

}
