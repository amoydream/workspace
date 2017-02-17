package com.lauvan.apps.resource.material.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_materialfirm", pk = "mf_id")
public class T_Bus_Materialfirm extends Model<T_Bus_Materialfirm>{

	private static final long serialVersionUID = 1L;
	
	public static final T_Bus_Materialfirm dao=new T_Bus_Materialfirm();
	
	public boolean insert(T_Bus_Materialfirm p){
		p.set("mf_id", AutoId.nextval(p));
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.save();
	}
	
	public boolean upd(T_Bus_Materialfirm p){
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.update();
	}
	
	public boolean  deleteByIds(String ids){
		String sql = "delete from t_bus_materialfirm where mf_id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public T_Bus_Materialfirm getById(Integer id){
		String sql = "select c.* , a.name as fjname , a.m_size from t_bus_materialfirm c left join t_attachment a on c.fjid = a.id where c.mf_id ="+id;
		return dao.findFirst(sql);
	}
	
	//根据机构ids返回对应的附件字符串
	public String getfjidsByIds(String ids){
			String sql = "select wm_concat(c.fjid) as fjids from t_bus_materialfirm c where c.mf_id in (" + ids + ")";
			return Db.queryStr(sql);
		}

}
