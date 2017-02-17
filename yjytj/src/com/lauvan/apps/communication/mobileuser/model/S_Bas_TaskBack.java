package com.lauvan.apps.communication.mobileuser.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;

/**
 * @author Bob
 * 任务反馈
 */
@TableBind(name="s_bas_taskback",pk="id")
public class S_Bas_TaskBack extends Model<S_Bas_TaskBack> {
	private static final long serialVersionUID = 1L;
	public static final S_Bas_TaskBack dao = new S_Bas_TaskBack();
	public List<Record> getListByTask(String tid){
		String sql = "select * from s_bas_taskback where taskid="+tid+" order by backtime desc";
		return Db.find(sql);
	}
	
	public List<Record> getListByEventid(String eventid){
		String sql = "select * from s_bas_taskback  where eventid="+eventid+" order by backtime desc ";
		return Db.find(sql);
	}
}
