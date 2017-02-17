package com.lauvan.util;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

public class IpAddr {
	private static final Pattern	IPV4_PATTERN				= Pattern.compile("^(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)(\\.(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)){3}$");

	private static final Pattern	IPV6_STD_PATTERN			= Pattern.compile("^(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$");

	private static final Pattern	IPV6_HEX_COMPRESSED_PATTERN	= Pattern.compile("^((?:[0-9A-Fa-f]{1,4}(?::[0-9A-Fa-f]{1,4})*)?)::((?:[0-9A-Fa-f]{1,4}(?::[0-9A-Fa-f]{1,4})*)?)$");

	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	public static boolean isIPv4Addr(final String ipAddr) {
		return IPV4_PATTERN.matcher(ipAddr).matches();
	}

	public static boolean isIPv6Addr(final String ipAddr) {
		return isIPv6StdAddr(ipAddr) || isIPv6HexCompressedAddr(ipAddr);
	}

	public static boolean isIPv6StdAddr(final String ipAddr) {
		return IPV6_STD_PATTERN.matcher(ipAddr).matches();
	}

	public static boolean isIPv6HexCompressedAddr(final String ipAddr) {
		return IPV6_HEX_COMPRESSED_PATTERN.matcher(ipAddr).matches();
	}

	public static boolean check(final String ipAddr) {
		return isIPv4Addr(ipAddr) || isIPv6Addr(ipAddr) || isIPv6StdAddr(ipAddr) || isIPv6HexCompressedAddr(ipAddr);
	}
}
