package com.lauvan.util;

import java.io.File;
import java.io.FileOutputStream;

public class FileUtil {

	public static void create(String s,String path) {
		File file = new File(path+"/g.json");
		FileOutputStream oStream = null;
		try {
			oStream = new FileOutputStream(file);
			if (!file.exists()) {
				file.createNewFile();
			}
			oStream.write(s.getBytes());
			oStream.flush();
			oStream.close();
		} catch (Exception e) {
		}
	}
}
