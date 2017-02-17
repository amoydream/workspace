package com.lauvan.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.io.IOUtils;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.log4j.Logger;

public class FTPUtil {
	private static final Logger	log					= Logger.getLogger(FTPUtil.class);
	private static String		local_vocrecd_dir	= null;
	private static String		local_faxrecd_dir	= null;
	private static String		remote_vocrecd_dir	= null;
	private static String		remote_faxrecv_dir	= null;
	private static String		remote_faxsend_dir	= null;
	private static String		ftp_server_host		= null;
	private static String		ftp_server_uname	= null;
	private static String		ftp_server_pwd		= null;
	private static FTPClient	ftp_client			= null;

	static {
		try {
			local_vocrecd_dir = SiteUrl.readUrl("local_vocrecd_dir");
			local_faxrecd_dir = SiteUrl.readUrl("local_faxrecd_dir");
			remote_vocrecd_dir = SiteUrl.readUrl("remote_vocrecd_dir");
			remote_faxrecv_dir = SiteUrl.readUrl("remote_faxrecv_dir");
			remote_faxsend_dir = SiteUrl.readUrl("remote_faxsend_dir");
			ftp_server_host = SiteUrl.readUrl("ftp_server_host");
			ftp_server_uname = SiteUrl.readUrl("ftp_server_uname");
			ftp_server_pwd = SiteUrl.readUrl("ftp_server_pwd");
		} catch(Exception e) {
			Messenger.send("CCMS备份:" + e);
			log.error(e);
		}
	}

	public static void upload_vocrecd(String dname, String filename) {
		String localDir = local_vocrecd_dir + "\\" + dname;
		String remoteDir = mkRemoteDir(remote_vocrecd_dir + "/" + dname);
		ftp_upload(localDir, remoteDir, filename);
	}

	public static void upload_faxrecv(String filename) {
		String remoteDir = mkRemoteDir(remote_faxrecv_dir);
		ftp_upload(local_faxrecd_dir, remoteDir, filename);
	}

	public static void upload_faxsend(String filename) {
		String remoteDir = mkRemoteDir(remote_faxsend_dir);
		ftp_upload(local_faxrecd_dir, remoteDir, filename);
	}

	public static synchronized void ftp_upload(String localDir, String remoteDir, String filename) {
		FileInputStream fis = null;
		try {
			File localFile = new File(localDir + "\\" + filename);
			fis = new FileInputStream(localFile);
			if(ftp_client == null) {
				ftp_connect();
			}
			ftp_client.sendCommand("lcd " + localDir);
			ftp_client.changeWorkingDirectory(remoteDir);
			ftp_client.storeFile(filename, fis);
			if(ftp_client.list(remoteDir + "/" + filename) > 0) {
				log.info(filename + " 已上传到FTP: " + ftp_server_host);
			} else {
				Messenger.send("CCMS备份:" + filename + "上传失败");
			}
		} catch(IOException e) {
			Messenger.send("CCMS备份:" + e);
			log.error(e);
		} finally {
			IOUtils.closeQuietly(fis);
			try {
				ftp_client.disconnect();
				ftp_client = null;
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

	public static synchronized String mkRemoteDir(String remote_dir) {
		if(ftp_client == null) {
			ftp_connect();
		}
		try {
			String[] dirs = remote_dir.split("/");
			ftp_client.changeWorkingDirectory("/");
			for(int i = 0; i < dirs.length; i++) {
				String dir = dirs[i];
				ftp_client.makeDirectory(dir);
				ftp_client.changeWorkingDirectory(dir);
			}
		} catch(IOException e) {
			Messenger.send("CCMS备份:" + e);
			log.error(e);
		}

		return remote_dir;
	}

	private static synchronized void ftp_connect() {
		try {
			ftp_client = new FTPClient();
			ftp_client.connect(ftp_server_host);
			ftp_client.login(ftp_server_uname, ftp_server_pwd);
			ftp_client.setBufferSize(1024);
			ftp_client.setControlEncoding("GBK");
			ftp_client.setFileType(FTP.BINARY_FILE_TYPE);
			if(ftp_client.isConnected() && ftp_client.isAvailable()) {
				log.info("已连接到FTP: " + ftp_server_host);
			} else {
				log.info("FTP: " + ftp_server_host + " 未连接");
			}
		} catch(Exception e) {
			Messenger.send("FTP服务连接失败, 请检查FTP服务是否正常");
			ftp_client = null;
			log.error(e);
		}
	}

	public static void main(String[] args) {
		upload_vocrecd("00010", "10620.wav");
		upload_faxrecv("20160908_173938276.TIF");
		upload_faxsend("20160908_173938276.TIF");
	}
}
