package com.lauvan.convertprint.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;

public class Config {
	public static final int		SM_SUCCESS					= 0;
	public static final int		SM_FAIL						= -1;
	public static final int		SM_OUTOF_MEMORY				= -2;
	public static final int		SM_PRINT_TIMEOUT			= -3;
	public static final int		SM_SYSTEM_ERROR				= -4;
	public static final int		SM_LINCESE_ERROR			= -5;
	public static final int		SM_PRODUCT_NOT_INSTALL		= -6;
	public static final int		SM_DISPATCH_NOT_FOUND		= -7;
	public static final int		SM_DISPATCH_CALL_FAIL		= -8;
	public static final int		SM_FOPEN_ERROR				= -9;
	public static final int		SM_UNKNOWN_ERROR			= -10;
	public static final int		SM_NOT_INIT					= -11;
	public static final int		SM_PRINT_NOT_INSTALL		= -12;
	public static final int		SM_FWRITE_ERROR				= -13;
	public static final int		SM_UNSUPPORTED_FILE_TYPE	= -14;
	public static final int		SM_EXPIRE_LINCESE			= -15;
	public static final int		SM_PRINTER_ACCESS_DENIED	= -16;

	private static final Logger	log							= Logger.getLogger(Config.class);
	private static Properties	prop						= null;

	private static Properties getProp() {
		if(prop == null) {
			String confgFile = System.getProperty("user.dir") + "/config.properties";
			prop = new Properties();
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(new File(confgFile));
				prop.load(fis);
			} catch(Exception e) {
				log.error(e);
			} finally {
				if(fis != null) {
					try {
						fis.close();
					} catch(IOException e) {
						log.error(e);
					}
				}
			}
		}

		return prop;
	}

	public static String get(String key) {
		return getProp().getProperty(key);
	}
}
