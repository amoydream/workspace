package com.lauvan.apps.resource.knowlege.model;

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
 * 应急常识
 *
 */
@TableBind(name="t_bus_genekno", pk="knoid")
public class T_Bus_Genekno extends Model<T_Bus_Genekno>{

	
	private static final long serialVersionUID = 1L;

	public static T_Bus_Genekno dao = new T_Bus_Genekno();
	
	public boolean insert(T_Bus_Genekno kno){
		kno.set("knoid", AutoId.nextval(kno));
		kno.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return kno.save();
	}
	
	public boolean upd(T_Bus_Genekno kno){
		kno.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return kno.update();
	}
	
	public Page<Record> getPage(Integer pageSize, Integer pageNum, String title, String type){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select * ";
		StringBuffer sb = new StringBuffer(" from t_bus_genekno g , (select * from t_sys_parameter start with p_ACODE = 'GENEKNO' connect by prior id = sup_id) p where g.typecode = p.p_acode ");
		if(StringUtils.isNotBlank(type)){
			sb.append(" and g.typecode ='").append(type).append("' ");
		}
		if(StringUtils.isNotBlank(title)){
			sb.append(" and g.knotitle like '%").append(title).append("%' ");
		}
		sb.append(" order by g.knoid desc");
		return Db.paginate(pageNum, pageSize, select, sb.toString());
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_bus_genekno g where g.knoid in (" + ids + ")";
		Db.update(sql);
	}
	
	
	public String getfjidsByids(String ids){
		String sql = "select wm_concat(g.fjid) as fjids from t_bus_genekno g where g.knoid in (" + ids + ")";
		return  Db.queryStr(sql);
	}
	public T_Bus_Genekno getById(String id){
		String sql = "select g.* , a.name as fjname, a.m_size from t_bus_genekno g left join t_attachment a on g.fjid = a.id where g.knoid ="+id;
		return dao.findFirst(sql);
	}
	
}
