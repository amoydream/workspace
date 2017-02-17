package com.lauvan.base.basemodel.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name="t_sys_Sequence",pk="name")
public class T_Sys_Sequence extends Model<T_Sys_Sequence> {
	
	private static final long serialVersionUID = 1L;
	public static final T_Sys_Sequence dao = new T_Sys_Sequence();
	
	/** 将新表插入T_Sequence表中作为此表主键序列 */
	public void add(String tableName){
		T_Sys_Sequence t_sequence = new T_Sys_Sequence();
		
		t_sequence.set("name", tableName);
		t_sequence.set("seq", 1);//每张表开始ID
		t_sequence.save();
	}
}
