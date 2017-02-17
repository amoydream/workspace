package com.lauvan.apps.resource.assets.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

/**
 * 专家组
 *
 */
@TableBind(name="t_bus_expertgroup", pk="eg_id")
public class  T_Bus_Expertgroup extends Model<T_Bus_Expertgroup>{

	private static final long serialVersionUID = 1L;
	public static T_Bus_Expertgroup dao = new T_Bus_Expertgroup();

	
	public boolean insert(T_Bus_Expertgroup t){
		t.set("eg_id", AutoId.nextval(t));
		t.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return t.save();
	}
	
	public boolean upd(T_Bus_Expertgroup t){
		t.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return t.update();
	}
	/**
	 * 返回列表记录
	 * @param pageSize
	 * @param pageNum
	 * @param name 名称 
	 * @param type 类别
	 * @return
	 */
	public Page<Record> getPage(Integer pageSize, Integer pageNum, String name){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select * ";
		StringBuffer sql = new StringBuffer(" from t_bus_expertgroup where 1=1 ");
		if(name != null && !"".equals(name)){
			sql.append("and eg_name like '%").append(name).append("%' ");
		}
		sql.append(" order by eg_id desc");
		return Db.paginate(pageNum, pageSize, select, sql.toString());
		
	}
	
	public T_Bus_Expertgroup getById(Integer id){
		String sql = "select c.* , a.name as fjname , a.m_size from t_bus_expertgroup c left join t_attachment a on c.fjid = a.id where c.eg_id ="+id;
		return dao.findFirst(sql);
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_bus_expertgroup c where c.eg_id in (" + ids + ")";
		Db.update(sql);
	}
	
	//根据队伍ids返回对应的附件字符串
    public String getfjidsByIds(String ids){
		String sql = "select wm_concat(c.fjid) as fjids from t_bus_expertgroup c where c.eg_id in (" + ids + ")";
		return Db.queryStr(sql);
	}
	
}	
