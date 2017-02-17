package com.lauvan.apps.resource.assets.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
/**
 *应急队伍人员 
 *
 */
@TableBind(name="t_bus_team_person", pk="tpe_id")
public class T_Bus_Team_Person extends Model<T_Bus_Team_Person>{

	private static final long serialVersionUID = 1L;
	public static T_Bus_Team_Person dao = new T_Bus_Team_Person();
	
	//根据所属生产企业id删除记录
	public void deleteByTeamIds(String teamids){
		String sql = "delete from t_bus_team_person c where c.teamid in (" + teamids +")";
		Db.update(sql);
	}
	
	public boolean  deleteByIds(String ids){
		String sql = "delete from t_bus_team_person where tpe_id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
}
