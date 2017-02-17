package com.lauvan.core.util;

import java.math.BigDecimal;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Sequence;
import com.lauvan.config.JFWebConfig;


public class AutoId {
	/** 获取下一个ID值 */
	/*public synchronized static BigDecimal nextval(Model<?> model) {
		
		T_Sys_Sequence t_Sequence = T_Sys_Sequence.dao.findById(model.getClass().getSimpleName());
		//如果在T_Sequence表找不到，即插入一条新记录
		if(t_Sequence==null||t_Sequence.equals("")){
			T_Sys_Sequence.dao.add(model.getClass().getSimpleName());
			return new BigDecimal(1);
		}
		
		
		BigDecimal curVal = t_Sequence.getBigDecimal("seq");
		curVal = curVal == null ? BigDecimal.valueOf(0) : curVal;
		BigDecimal nextval = curVal.add(BigDecimal.valueOf(1));
		t_Sequence.set("seq", nextval).update();
		return nextval;
	}*/
	
	/** 获取下一个ID值 */
	public synchronized static Number nextval(Model<?> model) {
		String dba = JFWebConfig.attrMap.get("dbaType");
		if("oracle".equals(dba)){
			T_Sys_Sequence t_Sequence = T_Sys_Sequence.dao.findById(model.getClass().getSimpleName());
			//如果在T_Sequence表找不到，即插入一条新记录
			if(t_Sequence==null||t_Sequence.equals("")){
				T_Sys_Sequence.dao.add(model.getClass().getSimpleName());
				return new BigDecimal(1);
			}
			
			
			BigDecimal curVal = t_Sequence.getBigDecimal("seq");
			curVal = curVal == null ? BigDecimal.valueOf(0) : curVal;
			BigDecimal nextval = curVal.add(BigDecimal.valueOf(1));
			t_Sequence.set("seq", nextval).update();
			return nextval;
		}else if("mysql".equals(dba)){
			String sql = "show table status where lower(Name) =lower('"+model.getClass().getSimpleName()+"')";
			Record r = Db.findFirst(sql);
			Integer next_seq = r.getNumber("Auto_increment").intValue();
			if(next_seq==null || next_seq==0){
				next_seq = 1;
			}
			return next_seq;
		}else{
			String sql = "SELECT IDENT_CURRENT('"+model.getClass().getSimpleName()+"')";
			Integer next = Db.queryInt(sql);
			if(next==null){
				sql = "select max(id) from "+model.getClass().getSimpleName();
				next = Db.queryInt(sql);
				if(next==null){
					next = 1;
				}else{
					next = next + 1;
				}
			}
			return next;
		}
	}
	
	
	/** 获取下一个ID值，用于表单数据表 */
	public synchronized static Number nextvalByFcode(String fcode) {
		String dba = JFWebConfig.attrMap.get("dbaType");
		if("oracle".equals(dba)){
			T_Sys_Sequence t_Sequence = T_Sys_Sequence.dao.findById(fcode);
			//如果在T_Sequence表找不到，即插入一条新记录
			if(t_Sequence==null||t_Sequence.equals("")){
				T_Sys_Sequence.dao.add(fcode);
				return new BigDecimal(1);
			}
			
			
			BigDecimal curVal = t_Sequence.getBigDecimal("seq");
			curVal = curVal == null ? BigDecimal.valueOf(0) : curVal;
			BigDecimal nextval = curVal.add(BigDecimal.valueOf(1));
			t_Sequence.set("seq", nextval).update();
			return nextval;
		}else if("mysql".equals(dba)){
			String sql = "show table status where lower(Name) =lower('"+fcode+"')";
			Record r = Db.findFirst(sql);
			Integer next_seq = r.getNumber("Auto_increment").intValue();
			if(next_seq==null || next_seq==0){
				next_seq = 1;
			}
			return next_seq;
		}else{
			String sql = "SELECT IDENT_CURRENT('"+fcode+"')";
			Integer next = Db.queryInt(sql);
			if(next==null){
				sql = "select max(id) from "+fcode;
				next = Db.queryInt(sql);
				if(next==null){
					next = 1;
				}else{
					next = next + 1;
				}
			}
			return next;
		}
	}
}
