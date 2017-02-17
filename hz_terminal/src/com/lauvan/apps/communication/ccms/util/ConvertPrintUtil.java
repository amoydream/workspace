package com.lauvan.apps.communication.ccms.util;

import com.lauvan.convertprint.client.ConvertPrintClient;

public class ConvertPrintUtil {
	public static String convert(String sourceFile) {
		return ConvertPrintClient.getInstance(CcmsUtil.CONV_LOCATION).convertToTIF(sourceFile);
	}

	public static void print(String sourceFile) {
		ConvertPrintClient.getInstance(CcmsUtil.CONV_LOCATION).print(sourceFile);
	}
}