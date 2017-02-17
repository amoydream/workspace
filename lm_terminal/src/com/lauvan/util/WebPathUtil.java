package com.lauvan.util;

import java.io.File;
import java.io.IOException;

import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

/**
 * 网页文件路径工具
 * @author zhikai.chen
 * @since 2014-4-28
 */
public class WebPathUtil {
	
	/**
	 * 根据资源路径找到对应的目录或者文件
	 * @param resourcePath 资源路径
	 * @return 对应的目录或者文件
	 */
	public static File getResourceFile(String resourcePath) throws IOException{
		ResourceLoader resourceLoader = new DefaultResourceLoader();
		Resource resource = resourceLoader.getResource(resourcePath);
		return resource.getFile();
	}

}
