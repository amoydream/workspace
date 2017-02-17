package com.lauvan.apps.resource.safeguardorg.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
/**
 * 医疗机构
 *
 */
@TableBind(name="t_bus_healthdept", pk="deptid")
public class T_Bus_Healthdept extends Model<T_Bus_Healthdept>{

	private static final long serialVersionUID = 1L;

	public static T_Bus_Healthdept dao = new T_Bus_Healthdept();
	
	public boolean insert(T_Bus_Healthdept hd){
		hd.set("deptid", AutoId.nextval(hd));
		hd.set("updatetime",DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return hd.save();
	}
	
	public boolean upd(T_Bus_Healthdept hd){
		hd.set("updatetime",DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return hd.update();
	}
	
	public Page<Record> getPage(Integer pageSize, Integer pageNum, 
			String deptname, String levelcode, String classcode, String gradecode){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select h.*";
		StringBuffer sb = new StringBuffer("  from t_bus_healthdept h where 1=1 ");
		//String select = "select h.*, p1.p_name as levelcodename, p2.p_name as classcodename, p3.p_name as gradecodename ";
		//StringBuffer sb = new StringBuffer("  from t_bus_healthdept h left join(select * from  t_sys_parameter WHERE SUP_ID = 571)p1 on h.levelcode = p1.p_acode");
	   // sb.append(" left join (select * from  t_sys_parameter WHERE SUP_ID = 578) p2 on h.classcode = p2.p_acode left join"); 
	    //sb.append(" (select * from  t_sys_parameter WHERE SUP_ID = 627) p3 on h.deptgradecode = p3.p_acode where 1=1");
	    if(StringUtils.isNotBlank(deptname)){
	    	sb.append(" and h.deptname like '%").append(deptname).append("%' ");
	    }
	    if(StringUtils.isNotBlank(levelcode)){
	    	sb.append(" and h.levelcode =").append(levelcode);
	    }
	    if(StringUtils.isNotBlank(classcode)){
	    	sb.append(" and h.classcode =").append(classcode);
	    }
	    if(StringUtils.isNotBlank(gradecode)){
	    	sb.append("and h.deptgradecode =").append(gradecode);
	    }
	    sb.append(" order by h.deptid desc");
		return Db.paginate(pageNum, pageSize, select, sb.toString());
	}
	
	public T_Bus_Healthdept getById(String id){
		String sql = "select h.* , a.name as fjname , a.m_size from t_bus_healthdept h left join t_attachment a on h.fjid = a.id where h.deptid ="+id;
		return dao.findFirst(sql);
	}
	
	//根据id获取附件字符串
	public String getfjidsByids(String ids){
		String sql = "select wm_concat(h.fjid) as fjids from t_bus_healthdept h where h.deptid in("+ids + ")";
		return Db.queryStr(sql);
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_bus_healthdept h where h.deptid in (" + ids + ")";
		Db.update(sql);
	}
}
