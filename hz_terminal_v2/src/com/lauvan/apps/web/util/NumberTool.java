package com.lauvan.apps.web.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NumberTool {
	/**
	 * 判断是否正整数
	 */
	public static boolean isPositiveInt(String str){
		if(str==null)return false;
		String rex = "^[1-9]\\d*$";
		Pattern p = Pattern.compile(rex);
		Matcher m = p.matcher(str);
		return m.find();
	}
	
	/**
	 * 判断是否负整数
	 */
	public static boolean isNegtiveInt(String str){
		if(str==null)return false;
		String rex="^-[1-9]\\d*$";
		Pattern p=Pattern.compile(rex);
		Matcher m=p.matcher(str);
		return m.find();
	}
	
	/**
	 * 判断是否整数
	 */
	public static boolean isInt(String str){
		if(str==null)return false;
		String rex="^-?[1-9]\\d*|0$";
		Pattern p=Pattern.compile(rex);
		Matcher m=p.matcher(str);
		return m.find();
	}
	
	/**
	 * 字符串转成正整数
	 * 
	 */

	public static int toPositiveInt(String str,int defaultValue){
		return isPositiveInt(str)?Integer.parseInt(str):(defaultValue>0?defaultValue:Math.abs(defaultValue));
	}
}
