package com.lauvan.meip.service.util;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.util.StringUtils;

public class Utils {
	public static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public static String arrToStr(Object[] arr) {
		return StringUtils.arrayToDelimitedString(arr, ",");
	}

	public static boolean isNumber(String str) {
		if(StringUtils.isEmpty(str)) {
			return false;
		}
		char[] cArr = str.toCharArray();
		for(char c : cArr) {
			if(!Character.isDigit(c)) {
				return false;
			}
		}

		return true;
	}

	public static String[] strToArr(String str) {
		return StringUtils.delimitedListToStringArray(str, ",");
	}

	public static String replaceSpecilAlhpa(String content) {
		if(content == null || content.trim().length() == 0) {
			return "";
		}
		String spec_char = "\\'";
		String retStr = "";
		for(int i = 0; i < content.length(); i++) {
			if(spec_char.indexOf(content.charAt(i)) >= 0) {
				retStr = retStr + "\\";
			}
			retStr = retStr + content.charAt(i);
		}
		return retStr;
	}

	public static boolean checkSmID(long smID) {
		return smID >= 0L && smID <= 99999999L;
	}

	public static String gb2Iso(String str) {
		if(str == null) {
			return "";
		}
		String temp = "";
		try {
			byte[] buf = str.trim().getBytes("GBK");
			temp = new String(buf, "iso8859-1");
		} catch(UnsupportedEncodingException e) {
			temp = str;
		}
		return temp;
	}

	public static String isDateTime(String str) {
		if(str == null) {
			return null;
		}
		if(str.length() != 19) {
			return null;
		}
		int temp = Integer.parseInt(str.substring(5, 7));
		if(12 < temp || temp < 1) {
			return null;
		}
		temp = Integer.parseInt(str.substring(8, 10));
		if(31 < temp || temp < 1) {
			return null;
		}
		temp = Integer.parseInt(str.substring(11, 13));
		if(23 < temp || temp < 0) {
			return null;
		}
		temp = Integer.parseInt(str.substring(14, 16));
		if(59 < temp || temp < 0) {
			return null;
		}
		temp = Integer.parseInt(str.substring(17, 19));
		if(59 < temp || temp < 0) {
			return null;
		}
		Date returnDate = null;
		DateFormat df = DateFormat.getDateInstance();
		try {
			returnDate = df.parse(str);
			return returnDate.toString();
		} catch(Exception localException) {
		}
		return null;
	}

	public static String binary2Hex(byte[] bys) {
		if(bys == null || bys.length < 1) {
			return null;
		}
		StringBuffer sb = new StringBuffer(100);

		for(int i = 0; i < bys.length; i++) {
			if(bys[i] >= 16) {
				sb.append(Integer.toHexString(bys[i]));
			} else if(bys[i] >= 0) {
				sb.append("0" + Integer.toHexString(bys[i]));
			} else {
				sb.append(Integer.toHexString(bys[i]).substring(6, 8));
			}
		}
		return sb.toString();
	}

	public static String iso2gbk(String str) {
		if(str == null) {
			return "";
		}
		String temp = "";
		try {
			byte[] buf = str.trim().getBytes("GBK");
			temp = new String(buf, "UTF8");
		} catch(UnsupportedEncodingException e) {
			temp = str;
		}
		return temp;
	}

	public static String nullConvert(String str) {
		if(str == null) {
			str = "";
		}
		return str;
	}
}