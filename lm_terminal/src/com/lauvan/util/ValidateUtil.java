package com.lauvan.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

public class ValidateUtil {
	/**
	 * 正则表达式：验证用户名
	 */
	public static final String REGEX_USERNAME = "/^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i";

	/**
	 * 正则表达式：验证密码
	 */
	public static final String REGEX_PASSWORD = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";

	/**
	 * 正则表达式：验证手机号
	 */
	public static final String REGEX_MOBILE = "^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";

	/**
	 * 正则表达式：验证邮箱
	 */
	public static final String REGEX_EMAIL = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";

	/**
	 * 正则表达式：验证汉字
	 */
	public static final String REGEX_CHINESE = "^[\u4e00-\u9fa5],{0,}$";

	/**
	 * 正则表达式：验证身份证
	 */
	public static final String REGEX_ID_CARD = "(^\\d{18}$)|(^\\d{15}$)";

	/**
	 * 正则表达式：验证URL
	 */
	public static final String REGEX_URL = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";

	/**
	 * 正则表达式：验证IP地址
	 */
	public static final String REGEX_IP_ADDR = "(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)";

	/**
	 * 校验用户名 （字母开头，允许6-16字节，允许字母数字下划线）
	 * 
	 * @param username
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isUsername(String username) {
		return Pattern.matches(REGEX_USERNAME, username);
	}

	/**
	 * 校验密码 (必须是字母和数字组合,允许6-20字节)
	 * 
	 * @param password
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isPassword(String password) {
		return Pattern.matches(REGEX_PASSWORD, password);
	}

	/**
	 * 校验手机号
	 * 
	 * @param mobile
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isMobile(String mobile) {
		return Pattern.matches(REGEX_MOBILE, mobile);
	}

	/**
	 * 校验邮箱
	 * 
	 * @param email
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isEmail(String email) {
		return Pattern.matches(REGEX_EMAIL, email);
	}

	/**
	 * 校验汉字
	 * 
	 * @param chinese
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isChinese(String chinese) {
		return Pattern.matches(REGEX_CHINESE, chinese);
	}

	/**
	 * 校验身份证
	 * 
	 * @param idCard
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isIDCard(String idCard) {
		return Pattern.matches(REGEX_ID_CARD, idCard);
	}

	/**
	 * 校验URL
	 * 
	 * @param url
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isUrl(String url) {
		return Pattern.matches(REGEX_URL, url);
	}

	/**
	 * 校验IP地址
	 * 
	 * @param ipAddr
	 * @return
	 */
	public static boolean isIPAddr(String ipAddr) {
		return Pattern.matches(REGEX_IP_ADDR, ipAddr);
	}
	/**
	 * 判断是否为空值包括空格
	 * @param str
	 * @return 返回true为空
	 */
	public static boolean isEmpty(String str) {
		return (str!=null && str.trim().length()>0) ? false : true;
	}
	
	/**
	 * 判断是否为空值且大于零
	 * @param str
	 * @return 返回true为空
	 */
	public static boolean isEmpty(Integer str) {
        if (str!=null && str>0) {
			return false;
		}else {
			return true;
		}
    }
	/**
	 * 判断list集合是否为空
	 * @param list
	 * @return 返回false为空
	 */
	@SuppressWarnings("rawtypes")
	public static boolean isEmpty(List list) {
		if (list!=null && list.size()>0) {
			return true;
		}else {
			return false;
		}
	}
	/**
	 * 判断数组是否为空
	 * @param obj Object
	 * @return 返回false为空
	 */
	public static boolean isEmpty(Object[] obj) {
		if (obj!=null && obj.length>0) {
			return true;
		}else {
			return false;
		}
	}
	/**
	 * 转换成(yyyy-MM-dd HH:mm:ss)
	 * @param d
	 * @return
	 * @throws Exception
	 */
	public static String parseDateToStringss(Date d) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(d);
	}
	/**
	 * 转换成(yyyy-MM-dd)
	 * @param d
	 * @return
	 * @throws Exception
	 */
	public static String parseDateToString(Date d){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(d);
	}
	/**
	 * 转换成(yyyy-MM-dd)
	 * @param ds
	 * @return
	 * @throws Exception
	 */
	public static Date parseDate(String ds) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = null;
		if (ds.indexOf("/")>0) {
			try {
				d = sdf.parse(ds.replace("/", "-"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else {
			try {
				d = sdf.parse(ds);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return d;
	}
	
	/**
	 * 转换成(yyyy-MM-dd HH:mm:ss)
	 * @param ds
	 * @return
	 * @throws Exception
	 */
	public static Date parseTimeStamp(String ds) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d = null;
		if (ds.indexOf("/")>0) {
			try {
				d = sdf.parse(ds.replace("/", "-"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else {
			try {
				d = sdf.parse(ds);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return d;
	}
	/**
	 * 加减日期
	 * @param d
	 * @param m
	 * @return
	 */
	public static Date dateAddOrSub(Date d,Integer m) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(d);
		calendar.add(Calendar.DAY_OF_YEAR, m);
		return parseDate(sdf.format(calendar.getTime()));
	}
	/**
     * 凌晨
     * @param date
     * @flag 0 返回yyyy-MM-dd 00:00:00日期<br>
     *       1 返回yyyy-MM-dd 23:59:59日期
     * @return
     */
    public static Date weeHours(Date date, int flag) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int minute = cal.get(Calendar.MINUTE);
        int second = cal.get(Calendar.SECOND);
        //时分秒（毫秒数）
        long millisecond = hour*60*60*1000 + minute*60*1000 + second*1000;
        //凌晨00:00:00
        cal.setTimeInMillis(cal.getTimeInMillis()-millisecond);
         
        if (flag == 0) {
            return cal.getTime();
        } else if (flag == 1) {
            //凌晨23:59:59
            cal.setTimeInMillis(cal.getTimeInMillis()+23*60*60*1000 + 59*60*1000 + 59*1000);
        }
        return cal.getTime();
    }
    public static String buildPath(String s) {
    	String ps = s.subSequence(0, s.length()-3).toString();
		int m = 5-ps.length();
		StringBuilder sb = new StringBuilder("");
		for (int i = 0; i < m; i++) {
			sb.append("0");
		}
		return sb.toString()+ps;
	}
	/**
	 * 计算地球上任意两点(经纬度)距离
	 * 
	 * @param long1
	 *            第一点经度
	 * @param lat1
	 *            第一点纬度
	 * @param long2
	 *            第二点经度
	 * @param lat2
	 *            第二点纬度
	 * @return 返回距离 单位：米
	 */
	public static double Distance(double long1, double lat1, double long2,
			double lat2) {
		double a, b, R;
		R = 6378137; // 地球半径
		lat1 = lat1 * Math.PI / 180.0;
		lat2 = lat2 * Math.PI / 180.0;
		a = lat1 - lat2;
		b = (long1 - long2) * Math.PI / 180.0;
		double d;
		double sa2, sb2;
		sa2 = Math.sin(a / 2.0);
		sb2 = Math.sin(b / 2.0);
		d = 2
				* R
				* Math.asin(Math.sqrt(sa2 * sa2 + Math.cos(lat1)
						* Math.cos(lat2) * sb2 * sb2));
		return d;
	}
	private static final double PI = 3.14159265;  
    private static final double EARTH_RADIUS = 6378137;  
    private static final double RAD = Math.PI / 180.0;
	/** 
     * 根据两点间经纬度坐标（double值），计算两点间距离，单位为米 
     * @param lng1 
     * @param lat1 
     * @param lng2 
     * @param lat2 
     * @return 
     */  
    public static double getDistance(double lng1, double lat1, double lng2, double lat2)  
    {  
       double radLat1 = lat1*RAD;  
       double radLat2 = lat2*RAD;  
       double a = radLat1 - radLat2;  
       double b = (lng1 - lng2)*RAD;  
       double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a/2),2) +  
        Math.cos(radLat1)*Math.cos(radLat2)*Math.pow(Math.sin(b/2),2)));  
       s = s * EARTH_RADIUS;  
       s = Math.round(s * 10000) / 10000;  
       return s;  
    }
    /**
     * 根据经纬度和半径计算经纬度范围
     * @param lat 纬度
     * @param lon 经度
     * @param raidus 半径
     * @return
     */
    public static double[] getAround(double lat,double lon,int raidus){  
        
        Double latitude = lat;  
        Double longitude = lon;  
          
        Double degree = (24901*1609)/360.0;  
        double raidusMile = raidus;  
          
        Double dpmLat = 1/degree;  
        Double radiusLat = dpmLat*raidusMile;  
        Double minLat = latitude - radiusLat;  
        Double maxLat = latitude + radiusLat;  
          
        Double mpdLng = degree*Math.cos(latitude * (PI/180));  
        Double dpmLng = 1 / mpdLng;  
        Double radiusLng = dpmLng*raidusMile;  
        Double minLng = longitude - radiusLng;  
        Double maxLng = longitude + radiusLng;  
        //System.out.println("["+minLat+","+minLng+","+maxLat+","+maxLng+"]");  
        return new double[]{maxLng,minLng,maxLat,minLat};  
    }  
    
	public static void main(String[] args) {
		Date d = parseDate("2015-07-02");
		System.out.println(d);
		
		System.out.println(dateAddOrSub(d, -2));
//		System.out.println(isUsername("111"));
		
//		System.out.println(Distance(114.47969, 23.110293, 114.511885, 23.090082));
//		System.out.println(getDistance(114.47969, 23.110293, 114.511885, 23.090082));
//		System.out.println(Arrays.toString(getAround(23.110293,114.47969, 5000)));
		
//		System.out.println(isEmpty(" "));
	}
}
