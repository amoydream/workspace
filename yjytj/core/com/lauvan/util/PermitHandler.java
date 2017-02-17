package com.lauvan.util;

import java.math.BigDecimal;

import org.apache.commons.lang.StringUtils;

public class PermitHandler {

	public static boolean haspermit(Integer permitid, String limit) {
		
		if (StringUtils.isBlank(limit) || permitid==null) {
			return false;
		} else {
			if(limit.startsWith(permitid+",") || limit.indexOf(","+permitid)!=-1){
				return true;
			}else{
				return false;
			}
		}
	}
	
	public static boolean haspermit(Integer permitid, String xtlimit,Integer ptid, String limit) {
		
		if(StringUtils.isBlank(limit) || permitid==null)
			return false;
		
		if(limit.startsWith(ptid+",") || limit.indexOf(","+ptid)>-1){
			if(StringUtils.isBlank(xtlimit))
				return true;
			else{
				if(xtlimit.startsWith(permitid+",") || xtlimit.indexOf(","+permitid)>-1){
					return false;
				}
				else{
					return true;
				}
			}
		}else{
			return false;
		}
	}
	
	public static boolean haspermit2(Integer permitid, String limit) {
		
		if (limit == null || limit.length() == 0) {
			return false;
		} else {
			if (null == permitid) {
				return false;
			}
			if ((","+limit+",").indexOf("," + permitid + ",") != -1) {
				return true;
			} else {
				return false;
			}
		}
	}
}
