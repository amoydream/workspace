package com.lauvan.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.Months;
import org.joda.time.Years;

/**
 * 时间工具类
 * @author zhikai.chen
 * @since 2015年10月28日 上午11:58:40
 */
public class DateUtil {
	
	public final static long ONEDAY=(24*3600*1000);
	
    private static final SimpleDateFormat FORMAT_DAY = new SimpleDateFormat("yyyy-MM-dd");
	
	private static final SimpleDateFormat FORMAT_MONTH = new SimpleDateFormat("yyyy-MM");
	
	public static final DateFormat TIMEFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 合法时间处理
	 * @param date 月日年
	 * @return 年月日
	 */
	public static String getDate(String date){
		String strs[]=date.split("-");
		return strs[0]+"-"+strs[1]+"-"+strs[2]+" 00:00:00";
	}
	
	/**
	 * 获取当前时间的年月部分
	 * @throws ParseException 
	 */
	public static String getDate_YM() throws ParseException{
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(FORMAT_MONTH.parse(FORMAT_MONTH.format(new Date())));
		String value=FORMAT_DAY.format(calendar.getTime());
		return value;
	}
	
	/**
	 * 把月日年，转为年月日
	 * @param day 月日年
	 * @return 年月日
	 */
	public static String getDate(Date day){
		return FORMAT_DAY.format(day);
	}

	/**
	 * 获取两个时间相差多少天、月、年
	 * @param end 结束时间
	 * @param begin 开始时间
	 * @param type DateCompareType 类型
	 * @return 对应类型相差的数目
	 */
	public static int compare(Date end, Date begin, DateCompareType type) {
		if(type==DateCompareType.Day){
			Days intervalDays=Days.daysBetween(new DateTime(begin),new DateTime(end));
			return intervalDays.getDays();
		}else if(type==DateCompareType.Month){
			Months intervalMonths=Months.monthsBetween(new DateTime(begin),new DateTime(end));
			return intervalMonths.getMonths();
		}else{
			Years intervalYears=Years.yearsBetween(new DateTime(begin),new DateTime(end));
			return intervalYears.getYears();
		}
	}
	
	/**
    * 按指定格式将日期字符串对象转换成日期对象，忽略无效转化
    * @param dateStr 日期字符串
    * @param pattern 日期格式
    * @return 日期对象
    */
	public static Date parse(String dateStr, String pattern) {
	   SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
	   
	   Date date = null;
	   
	   try {
         date = dateFormat.parse(dateStr);
      } catch(ParseException e) {
         e.printStackTrace();
      }
	   
	   return date;
	}

}
