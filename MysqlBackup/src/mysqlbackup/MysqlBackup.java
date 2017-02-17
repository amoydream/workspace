package mysqlbackup;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import org.apache.commons.io.IOUtils;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.log4j.Logger;

public class MysqlBackup {
	private static final Logger	log					= Logger.getLogger(MysqlBackup.class);
	private static Properties	prop				= null;
	private static String		local_dbbak_dir		= null;
	private static String		remote_dbbak_dir	= null;
	private static String		ftp_server_host		= null;
	private static String		ftp_server_uname	= null;
	private static String		ftp_server_pwd		= null;
	private static FTPClient	ftp_client			= null;
	private static String		mysqldump			= null;
	private static String		mysql_uname			= null;
	private static String		mysql_pwd			= null;
	private static Dir			db_bakdir			= null;
	private static String[]		dbnames				= null;
	private static Object		UPLOAD_LOCK			= "UPLOAD_LOCK";
	private static Object		ERROR_LOCK			= "ERROR_LOCK";

	static {
		String confgFile = System.getProperty("user.dir") + "/config.properties";
		prop = new Properties();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(new File(confgFile));
			prop.load(fis);
			local_dbbak_dir = get("local_dbbak_dir");
			remote_dbbak_dir = get("remote_dbbak_dir");
			ftp_server_host = get("ftp_server_host");
			ftp_server_uname = get("ftp_server_uname");
			ftp_server_pwd = get("ftp_server_pwd");
			mysqldump = get("mysqldump");
			mysql_uname = get("mysql_uname");
			mysql_pwd = get("mysql_pwd");
			dbnames = get("dbnames").split(",");
			ftp_connect();
		} catch(Exception e) {
			log.error(e);
			messenger("FTP服务连接失败, 请检查FTP服务是否正常");
			System.exit(0);
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

	public static void main(String[] args) {
		db_bakdir = mkDbbakDir();
		for(int i = 0; i < dbnames.length; i++) {
			String dbname = dbnames[i];
			bakdb(dbname);
		}
	}

	private static void ftp_connect() {
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
			log.error(e);
			messenger("FTP服务连接失败, 请检查FTP服务是否正常");
		}
	}

	public static void ftp_upload(String localDir, String filename, String remoteDir) {
		FileInputStream fis = null;
		try {
			File localFile = new File(localDir + "\\" + filename);
			fis = new FileInputStream(localFile);
			ftp_client.sendCommand("lcd " + localDir);
			ftp_client.changeWorkingDirectory(remoteDir);
			ftp_client.storeFile(filename, fis);
			log.info(filename + " 已上传到FTP: /" + remoteDir + "/" + filename);
		} catch(IOException e) {
			log.error(e);
			messenger("MysqlBackup.ftp_upload(" + localDir + "," + filename + "," + remoteDir + ") : " + e);
		} finally {
			IOUtils.closeQuietly(fis);
		}
	}

	public static void bakdb(String dbname) {
		String cmd = "cmd /c " + mysqldump + " --opt -u " + mysql_uname + " --password=" + mysql_pwd + " " + dbname + " > " + db_bakdir.local_dir + "\\" + dbname + ".sql";
		Process p;
		try {
			p = Runtime.getRuntime().exec(cmd);
			new Thread(new DbUpload(p.getInputStream(), dbname)).start();
			new Thread(new ProcessError(p.getErrorStream(), dbname)).start();
			p.waitFor();
		} catch(Exception e) {
			log.error(e);
			messenger("MysqlBackup.bakdb(" + dbname + ") : " + e);
		}
	}

	static class DbUpload implements Runnable {
		InputStream	in;
		String		dbname	= null;

		public DbUpload(InputStream in, String dbname) {
			this.in = in;
			this.dbname = dbname;
		}

		@Override
		public void run() {
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String line;
			try {
				synchronized(UPLOAD_LOCK) {
					while((line = br.readLine()) != null) {
						log.info(line);
					}
					log.info(dbname + " 已备份, 正在上传到FTP");
					ftp_upload(db_bakdir.local_dir, dbname + ".sql", db_bakdir.remote_dir);
				}
			} catch(Exception e) {
				log.error(e);
			}
		}
	}

	public static Dir mkDbbakDir() {
		Date now = Calendar.getInstance().getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MMdd");
		String[] yyyy_MMdd = sdf.format(now).split("-");
		File local_dir = new File(local_dbbak_dir + "\\" + yyyy_MMdd[0] + "\\" + yyyy_MMdd[1]);
		local_dir.mkdirs();
		String remote_dir = remote_dbbak_dir + "/" + yyyy_MMdd[0] + "/" + yyyy_MMdd[1];
		try {
			String[] dirs = remote_dir.split("/");
			ftp_client.changeWorkingDirectory("/");
			for(int i = 0; i < dirs.length; i++) {
				String dir = dirs[i];
				ftp_client.makeDirectory(dir);
				ftp_client.changeWorkingDirectory(dir);
			}
		} catch(IOException e) {
			log.error(e);
			messenger("MysqlBackup.mkDbbakDir : " + e);
		}

		return new Dir(local_dir.getAbsolutePath(), remote_dir);
	}

	static class Dir {
		String	local_dir;
		String	remote_dir;

		public Dir(String local_dir, String remote_dir) {
			this.local_dir = local_dir;
			this.remote_dir = remote_dir;
		}
	}

	static class ProcessError implements Runnable {
		InputStream	in;
		String		dbname	= null;

		public ProcessError(InputStream in, String dbname) {
			this.in = in;
			this.dbname = dbname;
		}

		@Override
		public void run() {
			BufferedReader br = null;
			String line;
			try {
				br = new BufferedReader(new InputStreamReader(in, "GB2312"));
				synchronized(ERROR_LOCK) {
					while((line = br.readLine()) != null) {
						log.error(line);
					}
				}
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

	public static String get(String key) {
		return prop.getProperty(key);
	}

	public static void messenger(String content) {
		try {
			if(get("messenger") != null) {
				String[] cmdargs = {get("messenger"), content};
				Runtime.getRuntime().exec(cmdargs);
			}
		} catch(Exception e) {
			log.error(e);
		}
	}
}