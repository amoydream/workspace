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
 * 运输工具型号
 *
 */
@TableBind(name="t_bus_transtype", pk="transtypeid")
public class T_Bus_TransType extends Model<T_Bus_TransType>{

	private static final long serialVersionUID = 1L;
	
	public static T_Bus_TransType dao = new T_Bus_TransType();
	
	public boolean insert(T_Bus_TransType type){
		type.set("transtypeid", AutoId.nextval(type));
		type.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return type.save();
	}
	
	public boolean upd(T_Bus_TransType type){
		type.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return type.update();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNumber,
			String transtype, String transwaycode) {
		pageNumber = pageNumber == null || pageNumber<1?1:pageNumber;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String sql = "select t.*, p1.p_name transwayname ";
		StringBuffer sb = new StringBuffer(" from t_bus_transtype t left join (select t1.* from t_sys_parameter t1, ");
		sb.append("t_sys_parameter t2 where t1.sup_id = t2.id and t2.p_acode = 'YSFS') p1 on t.transwaycode = p1.p_acode where 1=1 ");
		if(StringUtils.isNotBlank(transtype)){
			sb.append(" and t.transtype like '%").append(transtype).append("%' ");
		}
		if(StringUtils.isNotBlank(transwaycode)){
			sb.append(" and t.transwaycode ='").append(transwaycode).append("' ");
		}
		sb.append(" order by t.transtypeid desc");
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_bus_transtype where transtypeid in (" + ids + ")";
		Db.update(sql);
	}
	
	public List<T_Bus_TransType> getListByIds(String ids){
		String sql = "select * from t_bus_transtype t where t.transtypeid in (" + ids +")";
		return dao.find(sql);
	}

}
