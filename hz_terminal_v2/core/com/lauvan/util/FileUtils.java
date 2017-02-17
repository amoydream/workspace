package com.lauvan.util;
/**
 * 文件工具类
 */
import java.text.DecimalFormat;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;

public class FileUtils {
	/** 转换文件大小 */
	public static String getFileSize(long fileLength) {
		DecimalFormat df = new DecimalFormat("#.00");
		String fileSizeString = "";
		if (fileLength < 1024) {
			fileSizeString = df.format((double) fileLength) + "B";
		} else if (fileLength < 1048576) {
			fileSizeString = df.format((double) fileLength / 1024) + "K";
		} else if (fileLength < 1073741824) {
			fileSizeString = df.format((double) fileLength / 1048576) + "M";
		} else {
			fileSizeString = df.format((double) fileLength / 1073741824) + "G";
		}
		return fileSizeString;
	}
	/**复制文件到指定路径*/
	public static boolean copyFile(File file,String filepath,String filename){
		boolean flag = false;
		File pfile = new File(filepath);
		if(!pfile.exists()){
			pfile.mkdirs();
		}
		File newfile = new File(filepath+"\\"+filename);
		try {
			newfile.createNewFile();
			FileInputStream fi = new FileInputStream(file);
			FileOutputStream fo = new FileOutputStream(newfile);
			FileChannel in = fi.getChannel();
			FileChannel out = fo.getChannel();
			in.transferTo(0, in.size(), out);
			fi.close();
			in.close();
			fo.close();
			out.close();
			flag = true;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return flag;
	}
}
