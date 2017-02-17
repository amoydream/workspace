
package com.lauvan.convertprint.client;

import java.net.MalformedURLException;

public final class ConvertPrintClient {
	private static ConvertPrintClient	instance			= null;
	private static ConvertPrintService	convertPrintService	= null;

	private ConvertPrintClient(String wsdlLocation) {
		try {
			ConvertPrintService_Service service = new ConvertPrintService_Service(wsdlLocation);
			convertPrintService = service.getConvertPrintServiceImplPort();
		} catch(MalformedURLException e) {
			e.printStackTrace();
		}
	}

	public synchronized static ConvertPrintClient getInstance(String wsdlLocation) {
		if(instance == null) {
			instance = new ConvertPrintClient(wsdlLocation);
		}

		return instance;
	}

	public String convert(String sourceFile, String fileType) {
		return convertPrintService.convert(sourceFile, fileType);
	}

	public String convertToTIF(String sourceFile) {
		return convertPrintService.convert(sourceFile, "TIF");
	}

	public String convertToPDF(String sourceFile) {
		return convertPrintService.convert(sourceFile, "PDF");
	}

	public void print(String sourceFile) {
		convertPrintService.print(sourceFile);
	}

	public static void main(String args[]) throws Exception {
		//args = new String[]{"http://localhost:7991/convprinsevr?wsdl", "convert", "D:\\t.pdf"};
		if(args.length < 3) {
			System.err.println("参数: wsdl地址 convert|print 文件绝对路径 [文件格式]");
		} else {
			ConvertPrintClient cp = getInstance(args[0]);
			String action = args[1];
			String sourceFile = args[2];
			if("convert".equals(action)) {
				System.out.println("Invoking convert...");
				String fileType = null;
				if(args.length > 3) {
					fileType = args[3];
				}
				String _convert__return = cp.convert(sourceFile, fileType);
				System.out.println("convert.result=" + _convert__return);
			} else if("print".equals(action)) {
				System.out.println("Invoking print...");
				cp.print(sourceFile);
			}
		}

		System.exit(0);
	}
}
