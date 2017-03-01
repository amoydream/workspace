package com.lauvan.apps.communication.ccms.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.lauvan.apps.communication.ccms.model.T_Ccms_Setting;

public class CcmsUtil {
	public static String	TEL_NUMBER		= null;
	public static String	FAX_NUMBER		= null;
	public static String	MSEQ_SHPATH		= null;
	public static String	MFAX_SHPATH		= null;
	public static String	VOCR_SHPATH		= null;
	public static String	VOCR_URL		= null;
	public static String	FAXR_SHPATH		= null;
	public static String	FAXR_URL		= null;
	public static String	FAXS_SHPATH		= null;
	public static String	FAXS_URL		= null;
	public static String	CONV_LOCATION	= null;

	public static void init(T_Ccms_Setting setting) {
		TEL_NUMBER = setting.getStr("TEL_NUMBER");
		FAX_NUMBER = setting.getStr("FAX_NUMBER");
		MSEQ_SHPATH = setting.getStr("MSEQ_SHPATH");
		MFAX_SHPATH = setting.getStr("MFAX_SHPATH");
		VOCR_SHPATH = setting.getStr("VOCR_SHPATH");
		VOCR_URL = setting.getStr("VOCR_URL");
		FAXR_SHPATH = setting.getStr("FAXR_SHPATH");
		FAXR_URL = setting.getStr("FAXR_URL");
		FAXS_SHPATH = setting.getStr("FAXS_SHPATH");
		FAXS_URL = setting.getStr("FAXS_URL");
		CONV_LOCATION = setting.getStr("CONV_LOCATION");
	}

	public static String createFolder(String rootFolder, String deptName) {
		Calendar c = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MMdd");
		String[] yyyyMMdd = sdf.format(c.getTime()).split("-");
		rootFolder = rootFolder + "\\" + deptName + "\\" + yyyyMMdd[0] + "\\" + yyyyMMdd[1];
		File folder = new File(rootFolder);
		if(!folder.exists()) {
			folder.mkdirs();
		}

		return folder.getAbsolutePath();
	}

	public static String copyFile(String sourceFile, String targetFile) {
		if(new File(targetFile).isDirectory()) {
			Calendar c = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			targetFile += "\\" + sdf.format(c.getTime()) + ".tif";
		}
		FileInputStream fis = null;
		FileOutputStream fos = null;
		try {
			fis = new FileInputStream(new File(sourceFile));
			fos = new FileOutputStream(new File(targetFile));
			byte[] byteArr = new byte[1024];
			while(fis.read(byteArr) != -1) {
				fos.write(byteArr);
			}
			fos.flush();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fis.close();
				fos.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		return targetFile;
	}
}
