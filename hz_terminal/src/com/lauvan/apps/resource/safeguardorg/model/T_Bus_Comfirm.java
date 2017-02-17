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
 * 通讯保障机构
 *
 */
@TableBind(name = "t_bus_comfirm", pk = "firmid")
public class T_Bus_Comfirm extends Model<T_Bus_Comfirm> {

	private static final long	serialVersionUID	= 1L;

	public static T_Bus_Comfirm	dao					= new T_Bus_Comfirm();

	public boolean insert(T_Bus_Comfirm comfirm) {
		comfirm.set("firmid", AutoId.nextval(comfirm));
		comfirm.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return comfirm.save();
	}

	public boolean upd(T_Bus_Comfirm comfirm) {
		comfirm.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return comfirm.update();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNumber, String firmname, String levelcode, String classcode) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select c.* ";
		StringBuffer sb = new StringBuffer(" from t_bus_comfirm c where 1=1 ");
		//String sql = "select c.*, p1.p_name as levelcodename, p2.p_name as classcodename ";
		//StringBuffer sb = new StringBuffer(" from t_bus_comfirm c left join (select * from t_sys_parameter where sup_id = 571) p1 on c.levelcode = p1.p_acode ");
		//sb.append(" left join (select * from t_sys_parameter where sup_id = 578) p2 on c.classcode = p2.p_acode where 1=1 ");
		if(StringUtils.isNotBlank(firmname)) {
			sb.append(" and c.firmname like '%").append(firmname).append("%' ");
		}
		if(StringUtils.isNotBlank(levelcode)) {
			sb.append(" and c.levelcode='").append(levelcode).append("' ");
		}
		if(StringUtils.isNotBlank(classcode)) {
			sb.append(" and c.classcode='").append(classcode).append("' ");
		}
		sb.append(" order by c.firmid desc ");
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}

	public T_Bus_Comfirm getById(String id) {
		String sql = "select c.* , a.url, a.name as fjname, a.m_size from t_bus_comfirm c left join t_attachment a on c.fjid = a.id where c.firmid = " + id;
		return dao.findFirst(sql);
	}

	public void deleteByIds(String ids) {
		String sql = "delete from t_bus_comfirm where firmid in (" + ids + ")";
		Db.update(sql);
	}

	public String getfjidsByIds(String ids) {
		String sql = "select wm_concat(c.fjid) as fjids from t_bus_comfirm c where c.firmid in (" + ids + ")";
		return Db.queryStr(sql);
	}
}
