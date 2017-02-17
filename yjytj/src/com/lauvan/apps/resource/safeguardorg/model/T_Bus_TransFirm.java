package com.lauvan.apps.resource.safeguardorg.model;

import java.util.Date;
import java.util.List;

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
 * 
 *运输企业
 */
@TableBind(name="t_bus_transfirm", pk="firmid")
public class T_Bus_TransFirm extends Model<T_Bus_TransFirm>{
	
	private static final long serialVersionUID = 1L;
	public static T_Bus_TransFirm dao = new T_Bus_TransFirm();

	public boolean insert(T_Bus_TransFirm firm){
		firm.set("firmid", AutoId.nextval(firm));
		firm.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return firm.save();
	}
	
	public boolean upd(T_Bus_TransFirm firm){
		firm.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return firm.update();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNumber,
			String firmname, String levelcode, String classcode) {
		pageNumber = pageNumber == null || pageNumber<1?1:pageNumber;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String sql = "select t.* ";
		StringBuffer sb = new StringBuffer(" from t_bus_transfirm t where 1=1 ");
		//String sql = "select t.*, p1.p_name as levelcodename, p2.p_name as classcodename ";
		//StringBuffer sb = new StringBuffer(" from t_bus_transfirm t left join (select * from t_sys_parameter where sup_id = 571) p1 on t.levelcode = p1.p_acode ");
		//sb.append(" left join (select * from t_sys_parameter where sup_id = 578) p2 on t.classcode = p2.p_acode where 1=1 ");
		if(StringUtils.isNotBlank(firmname)){
			sb.append(" and t.firmname like '%").append(firmname).append("%' ");
		}
		if(StringUtils.isNotBlank(levelcode)){
			sb.append(" and t.levelcode='").append(levelcode).append("' ");
		}
		if(StringUtils.isNotBlank(classcode)){
			sb.append(" and t.classcode='").append(classcode).append("' ");
		}
		sb.append(" order by t.firmid desc ");
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}
	
	public T_Bus_TransFirm getById(String id){
		String sql = "select t.*, a.url, a.name as fjname, a.m_size from t_bus_transfirm t left join t_attachment a on t.fjid = a.id where t.firmid =" +id;
		return dao.findFirst(sql);
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_bus_transfirm where firmid in (" + ids + ")";
		Db.update(sql);
	}
	
	public String getfjidsByIds(String ids){
		String sql = "select wm_concat(t.fjid) as fjids from t_bus_comfirm t where t.firmid in (" + ids + ")";
		return Db.queryStr(sql);
	}
	
	
	//根据运输企业id查找列表
	public List<T_Bus_TransFirm> getListByIds(String ids){
		String sql = "select * from t_bus_transfirm t where t.firmid in (" + ids + ")";
		return dao.find(sql);
	}
}
