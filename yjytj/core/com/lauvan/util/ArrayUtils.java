package com.lauvan.util;

import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

public class ArrayUtils {
	/** 将数组转为字符串形式："1，2，3,...." */
	public static String ArrayToString(Object[] o) {
		if (o == null) {
			return null;
		}
		StringBuffer str = new StringBuffer();
		for (Object obj : o) {
			str.append(obj.toString());
			str.append(",");
		}
		str = str.deleteCharAt(str.length() - 1);
		return str.toString();
	}

	/** 去除数据重复元素 */
	public static String[] removeDuplicate(String[] s) {
		List<String> list = new LinkedList<String>();
		for (String st : s) {
			if (!list.contains(st)) {
				list.add(st);
			}
		}
		return list.toArray(new String[list.size()]);
	}
	
	public static Integer[] ArrayToInteger(String[] s){
		if(s==null)
			return null;
		Integer[] num=new Integer[s.length];
		for(int i=0;i<s.length;i++){
			if(s[i].matches("[0-9]+"))
				num[i]=Integer.parseInt(s[i]);
			else
				return null;
		}
		return num;
	}
	
	/**
	 * 将list转成字符串形式
	 * 
	 * @param    list    		如String,Integer,Boolean等基本数据类型对象
	 * @param	 seperatorStr	分隔字符串
	 * @return			
	 */
	public static String ListToString(List<Object> list,String seperatorStr){
		if(list==null || list.size()==0){
			return null;
		}
		seperatorStr=(StringUtils.isBlank(seperatorStr))?",":seperatorStr;
		StringBuffer str=new StringBuffer();
		for(Object o :list){
			str.append(o.toString());
			str.append(seperatorStr);
		}
		return str.substring(0,str.lastIndexOf(seperatorStr));
	}

	/** 数组不为 null 而且所有元素不为 "" 时返回 true */
	public static boolean notBlank(Object[] o) {
		if (o == null || o.length <= 0) {
			return false;
		} else if (o.length > 0) {
			for (Object temp : o) {
				if (!"".equals(temp)) {
					return true;
				}
			}
			return false;
		}
		return false;
	}
}
