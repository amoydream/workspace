package com.lauvan.util;

import java.util.List;

import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;

public class StrappUtil {
	public static String translate(String obj1,String obj2){
		List<Record> plist = T_Sys_Parameter.dao.getParamByCode(obj2,true);
		if(plist!=null && plist.size()>0){
			for(Record p : plist){
				String pcode = p.getStr("p_acode");
				if(pcode!=null && pcode.equals(obj1)){
					obj1 = p.getStr("p_name");
				}
			}
		}
		return obj1;
	}
}
