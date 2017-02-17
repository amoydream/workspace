package com.lauvan.configure;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

import com.lauvan.util.WebPathUtil;

/**
 * 加载自定义系统变量
 * @author zhikai.chen
 * @since 2015年10月28日 上午11:51:39
 */
//@Component 
public class SystemSet {
	
	/** 录音文件路径  */
	public static String VOICE_PATH;
	
	/**
	 * 初始化
	 */
	//@PostConstruct
	public void init() throws Exception {
		System.out.println("Loading the system configuration...");
		InputStream in = new BufferedInputStream(new FileInputStream(
				WebPathUtil.getResourceFile("system.properties")));
		Properties p = new Properties();
		p.load(in);
		VOICE_PATH=p.getProperty("VOICE_PATH");
	}
	
	/**
	 * 正常结束程序
	 */
	//@PreDestroy
	public void destory(){
		System.out.println("Closing system...");
	}
	
}
