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
 * 民间救援组织 
 *
 */
@TableBind(name="t_bus_team", pk="tea_id")
public class  T_Bus_Team extends Model<T_Bus_Team>{

	private static final long serialVersionUID = 1L;
	public static T_Bus_Team dao = new T_Bus_Team();

	
	public boolean insert(T_Bus_Team t){
		t.set("tea_id", AutoId.nextval(t));
		t.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return t.save();
	}
	
	public boolean upd(T_Bus_Team t){
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
	public Page<Record> getPage(Integer pageSize, Integer pageNum, String name, Integer departid){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select * ";
		StringBuffer sql = new StringBuffer(" from t_bus_team where 1=1 ");
		if(name != null && !"".equals(name)){
			sql.append("and name like '%").append(name).append("%' ");
		}
		if(departid != null && departid !=0 ){
			sql.append(" and organid =").append(departid);
		}
		sql.append(" order by tea_id desc");
		return Db.paginate(pageNum, pageSize, select, sql.toString());
		
	}
	
	/**
	 * 返回列表记录
	 * @param pageSize
	 * @param pageNum
	 * @param name 名称 
	 * @param paramsCode 队伍类型参数值
	 * @return
	 */
	public Page<Record> getPage(Integer pageSize,Integer pageNum,String name,String paramsCode){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select team.*,params.id p_id,params.p_name,dept.d_name ";
		StringBuffer sql = new StringBuffer(" from t_bus_team team left join (select p2.* from t_sys_parameter p1,t_sys_parameter p2 where p1.id=p2.sup_id and p1.p_acode='"+(paramsCode.isEmpty()?"":paramsCode)+"') params on team.type=params.p_acode left join t_sys_department dept on team.organid=dept.d_id where 1=1");
		if(name != null && !"".equals(name)){
			sql.append("and name like '%").append(name).append("%' ");
		}
		sql.append(" order by tea_id desc");
		return Db.paginate(pageNum, pageSize, select, sql.toString());
	}
	
	public T_Bus_Team getById(Integer id){
		String sql = "select c.* , a.name as fjname , a.m_size from t_bus_team c left join t_attachment a on c.fjid = a.id where c.tea_id ="+id;
		return dao.findFirst(sql);
	}
	
	public void deleteByIds(String ids){
		String sql = "delete from t_bus_team c where c.tea_id in (" + ids + ")";
		Db.update(sql);
	}
	
	//根据队伍ids返回对应的附件字符串
    public String getfjidsByIds(String ids){
		String sql = "select wm_concat(c.fjid) as fjids from t_bus_team c where c.tea_id in (" + ids + ")";
		return Db.queryStr(sql);
	}
	
}	
