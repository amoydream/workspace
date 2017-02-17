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
 *运输工具 
 *
 */
@TableBind(name="t_bus_transtool", pk="toolid")
public class T_Bus_TransTool extends Model<T_Bus_TransTool>{

	private static final long serialVersionUID = 1L;

	public static T_Bus_TransTool dao = new T_Bus_TransTool(); 
	
	public boolean insert(T_Bus_TransTool tool){
		tool.set("toolid", AutoId.nextval(tool));
		tool.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return tool.save();
	}
	
	public boolean upd(T_Bus_TransTool tool){
		tool.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return tool.update();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNumber,
			String toolname, String firmname, String transtypeid) {
		pageNumber = pageNumber == null || pageNumber<1?1:pageNumber;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String sql = "select t.*, t2.transtype, f.firmname";
		StringBuffer sb = new StringBuffer(" from t_bus_transtool t ,t_bus_transfirm f , t_bus_transtype t2 ");
		sb.append(" where t.transtypeid = t2.transtypeid and t.firmid = f.firmid ");
		if(StringUtils.isNotBlank(toolname)){
			sb.append(" and t.toolname like '%").append(toolname).append("%' ");
		}
		if(StringUtils.isNotBlank(firmname)){
			sb.append(" and f.firmname like '%").append(firmname).append("%' ");
		}
		if(StringUtils.isNotBlank(transtypeid)){
			sb.append(" and t2.transtype like '%").append(transtypeid).append("%'");
		}
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}

	public void deleteByIds(String ids) {
		String sql = "delete from t_bus_transtool where toolid in (" + ids + ")";
		Db.update(sql);
		
	}

	public T_Bus_TransTool getById(String id) {
		String sql = "select t.*, t2.transtype,f.firmname from t_bus_transtool t ,t_bus_transfirm f , t_bus_transtype t2 " +
				"where t.transtypeid = t2.transtypeid and t.firmid = f.firmid and t.toolid ="+id;
		return dao.findFirst(sql);
	}
	
	//根据运输工具类型查找是否存在运输工具
	public boolean isExistBytranstype(Integer transtype){
		String sql = "select count(1) from t_bus_transtool t where t.transtypeid =" + transtype;
		return Db.queryBigDecimal(sql).intValue()>0?true:false;
	}
	
	//根据运输企业查找是否存在运输工具
	public boolean isExistByFirmname(Integer firmid){
		String sql ="select count(1) from t_bus_transtool t where t.firmid =" + firmid;
		return Db.queryBigDecimal(sql).intValue()>0?true:false;
	}
	
}
