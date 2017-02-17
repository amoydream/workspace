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
 *应急救援资金 
 *
 */
@TableBind(name="t_bus_emfund", pk="fundid")
public class T_Bus_EmFund extends Model<T_Bus_EmFund>{

	private static final long serialVersionUID = 1L;

	public static T_Bus_EmFund dao = new T_Bus_EmFund();
	
	public boolean insert(T_Bus_EmFund fund){
		fund.set("fundid", AutoId.nextval(fund));
		fund.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return fund.save();
	}
	
	public boolean upd(T_Bus_EmFund fund){
		fund.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return fund.update();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNumber,
			String fundname, String levelcode, String classcode) {
		pageNumber = pageNumber == null || pageNumber<1?1:pageNumber;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String sql = "select e.* ";
		StringBuffer sb = new StringBuffer(" from t_bus_emfund e where 1=1 ");
		if(StringUtils.isNotBlank(fundname)){
			sb.append(" and e.fundname like '%").append(fundname).append("%' ");
		}
		if(StringUtils.isNotBlank(levelcode)){
			sb.append(" and e.levelcode='").append(levelcode).append("' ");
		}
		if(StringUtils.isNotBlank(classcode)){
			sb.append(" and e.classcode = '").append(classcode).append("' ");
		}
		sb.append(" order by e.updatetime desc ");
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_bus_emfund where fundid in (" + ids + ")";
		Db.update(sql);
	}
}
