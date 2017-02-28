package com.lauvan.convertprint.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.jws.WebService;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.event.PrintJobAdapter;
import javax.print.event.PrintJobEvent;
import javax.xml.ws.Endpoint;

import org.apache.log4j.Logger;

@WebService(
	endpointInterface = "com.lauvan.convertprint.service.ConvertPrintService",
	serviceName = "ConvertPrintService")
public class ConvertPrintServiceImpl implements ConvertPrintService {
	public static final Logger				log				= Logger.getLogger(ConvertPrintService.class);
	private static boolean					waitFor			= true;
	private static int						result;
	private static String					destFile		= null;
	private static DocFlavor				docFlavor		= DocFlavor.INPUT_STREAM.AUTOSENSE;
	private static PrintRequestAttributeSet	attributeSet	= new HashPrintRequestAttributeSet();
	private static PrintService				printService	= null;

	static {
		PrintService[] psList = PrintServiceLookup.lookupPrintServices(docFlavor, attributeSet);
		for(int i = 0; i < psList.length; i++) {
			PrintService _ps = psList[i];
			if(_ps.getName().equals(Config.get("printservice"))) {
				printService = _ps;
				break;
			}
		}
	}

	@Override
	public synchronized String convert(String sourceFile, String fileType) {
		if(sourceFile == null || !new File(sourceFile).exists()) {
			log.error(sourceFile + "不存在");
			return null;
		} else if(!new File(sourceFile).isFile()) {
			log.error(sourceFile + "不是一个文件");
			return null;
		} else {
			if(fileType == null) {
				fileType = "TIF";
			}
			if(sourceFile.toLowerCase().endsWith("." + fileType.toLowerCase())) {
				return sourceFile;
			}

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			destFile = Config.get("destfolder") + "\\" + sdf.format(new Date()) + "." + fileType;
		}

		try {
			String[] cmdargs = {Config.get("smartprinter"), sourceFile, destFile};
			Process p = Runtime.getRuntime().exec(cmdargs);
			log.info(sourceFile + " 开始转换...");
			new Thread(new ProcessInfo(p.getInputStream())).start();
			p.waitFor();
			new Thread(new Runnable() {
				@Override
				public void run() {
					while(waitFor) {
						try {
							Thread.sleep(100);
						} catch(Exception e) {
							log.error(e);
						}
					}
				}
			}).start();
		} catch(Exception e) {
			log.error(e);
		} finally {
			if(result == Config.SM_SUCCESS) {
				log.info("转换完成: " + destFile);
			} else {
				log.error(Config.get("code" + result));
				destFile = null;
			}
		}

		return destFile;
	}

	@Override
	public synchronized void print(String sourceFile) {
		if(printService == null) {
			log.info("未找到打印机: " + Config.get("printservice"));
		} else {
			DocPrintJob printJob = printService.createPrintJob();
			if(sourceFile == null || !new File(sourceFile).exists()) {
				log.error(sourceFile + "不存在");
				return;
			} else if(!new File(sourceFile).isFile()) {
				log.error(sourceFile + "不是一个文件");
				return;
			}
			String _sourceFile = sourceFile;
			String fileType = sourceFile.substring(sourceFile.lastIndexOf(".") + 1).toLowerCase();
			if(!"gif,jpg,png,pdf,pcl".contains(fileType)) {
				_sourceFile = convert(sourceFile, "PDF");
			}
			try {
				FileInputStream fis = new FileInputStream(_sourceFile);
				Doc doc = new SimpleDoc(fis, docFlavor, null);
				log.info(_sourceFile + " 开始打印...");
				printJob.addPrintJobListener(new PrintJobAdapter() {
					@Override
					public void printDataTransferCompleted(PrintJobEvent e) {
						log.info("打印数据传输完毕");
					}

					@Override
					public void printJobCanceled(PrintJobEvent e) {
						log.info("打印任务已取消");
					}

					@Override
					public void printJobFailed(PrintJobEvent e) {
						log.info("打印失败");
					}

					@Override
					public void printJobCompleted(PrintJobEvent e) {
						log.info("打印完成");
					}
				});
				printJob.print(doc, attributeSet);
				fis.close();
			} catch(Exception e) {
				log.error(e);
			}
		}
	}

	static class ProcessInfo implements Runnable {
		InputStream in;

		public ProcessInfo(InputStream in) {
			this.in = in;
		}

		@Override
		public void run() {
			BufferedReader br = null;
			try {
				br = new BufferedReader(new InputStreamReader(in, "GB2312"));
				String code = null;
				while((code = br.readLine()) != null) {
					if("0".equals(code) || code.startsWith("-")) {
						result = Integer.parseInt(code.trim());
						break;
					}
				}
				if(code == null) {
					result = Config.SM_UNKNOWN_ERROR;
				}
				waitFor = false;
			} catch(Exception e) {
				log.error(e);
			} finally {
				if(br != null) {
					try {
						br.close();
					} catch(IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	public static void main(String[] args) {
		try {
			String serviceLocation = Config.get("servicelocation");
			ConvertPrintServiceImpl convertPrintService = new ConvertPrintServiceImpl();
			Endpoint.publish(serviceLocation, convertPrintService);
			log.info("文档转换打印服务已启动");
			log.info(serviceLocation);
		} catch(Exception e) {
			log.error(e);
		}
	}
}
