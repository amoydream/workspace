package com.lauvan.convertprinter;

import javax.xml.ws.Endpoint;

import org.apache.log4j.Logger;

public class ConvertPrintService {
	private static final Logger log = Logger.getLogger(ConvertPrintService.class);

	public static void main(String[] args) {
		try {
			String serviceUrl = Config.getProp().getProperty("convertprinter.serviceUrl");
			ConvertPrinterImpl convertor = new ConvertPrinterImpl();
			Endpoint.publish(serviceUrl, convertor);
			log.info("文档转换打印服务已启动");
		} catch(Exception e) {
			log.error(e);
		}
	}
}