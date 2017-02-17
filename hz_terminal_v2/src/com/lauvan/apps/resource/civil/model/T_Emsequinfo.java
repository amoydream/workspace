package com.lauvan.apps.resource.civil.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

/**
 * 救援组织装备 
 *
 */

@TableBind(name="t_emsequinfo", pk="equid")
public class T_Emsequinfo extends Model<T_Emsequinfo>{

	private static final long serialVersionUID = 1L;
	public static T_Emsequinfo dao = new T_Emsequinfo();
	
	public boolean insert(T_Emsequinfo e){
		e.set("equid", AutoId.nextval(e));
		return e.save();
	}
	
	
	public Record getById(String id){
		String sql = "select eq.*, a.url from t_emsequinfo eq left join t_attachment a on eq.equphoto = a.id where eq.equid="+id;
		return Db.findFirst(sql);
	}

	public void delByIds(String ids){
		String sql = "delete from t_emsequinfo where equid in (" +ids + ")";
		Db.update(sql);
	}
	
	//根据id获取附件对应记录
	public String getfjidsByids(String ids){
		String sql = "select wm_concat(eq.equphoto) as fjids from t_emsequinfo eq where eq.equid in (" + ids + ")";
		return Db.queryStr(sql);
	}
	//根据民间救援组织ID获取救援设备id字符串
	public String getIdStrByCivids(String cids){
		String sql = "select wm_concat(eq.equid) from t_emsequinfo eq where eq.equteamno in ("+cids+")";
		return Db.queryStr(sql);
	}
}
