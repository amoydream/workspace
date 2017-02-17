package com.lauvan.apps.resource.assets.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

/**
 * 救援组织装备 
 *
 */

@TableBind(name="t_bus_team_equip", pk="teq_id")
public class T_Bus_Team_Equip extends Model<T_Bus_Team_Equip>{

	private static final long serialVersionUID = 1L;
	public static T_Bus_Team_Equip dao = new T_Bus_Team_Equip();
	
	public boolean insert(T_Bus_Team_Equip e){
		e.set("teq_id", AutoId.nextval(e));
		e.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return e.save();
	}
	
	public boolean upd(T_Bus_Team_Equip p){
		p.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return p.update();
	}
	
	public void delByIds(String ids){
		String sql = "delete from t_bus_team_equip where teq_id in (" +ids + ")";
		Db.update(sql);
	}
	
	//根据所属队伍id删除队伍装备记录
	public void deleteByTeamIds(String teamids){
			String sql = "delete from t_bus_team_equip c where c.teamid in (" + teamids +")";
			Db.update(sql);
	}
	
	public boolean  beNullByEqnIds(String ids){
		String sql = "update t_bus_team_equip set equipnameid = NULL where equipnameid in ("+ids+")";
		return Db.update(sql)>0;
	}
}
