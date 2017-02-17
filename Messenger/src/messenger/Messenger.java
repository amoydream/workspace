package messenger;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.apache.log4j.Logger;

public class Messenger {
	private static final Logger	log		= Logger.getLogger(Messenger.class);
	private static Properties	prop	= null;

	public static String get(String key) {
		return getProp().getProperty(key);
	}

	public static Properties getProp() {
		if(prop == null) {
			String confgFile = System.getProperty("user.dir") + "/config.properties";
			prop = new Properties();
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(new File(confgFile));
				prop.load(fis);
			} catch(Exception e) {
				log.error(e);
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

		return prop;
	}

	public static void send(String mobiles, String content) {
		try {
			String SMsg_address = get("smsg.address");
			String apiCode = get("smsg.apiCode");
			String loginName = get("smsg.loginName");
			String loginPwd = get("smsg.loginPwd");
			MessengerRemote remote = new MessengerLocator(SMsg_address).getSMsg();
			int code = remote.sendSM(apiCode, loginName, loginPwd, mobiles.split(","), content, 1);
			if(code == 0) {
				log.info("【" + mobiles + "】" + content);
			} else {
				log.error("短信发送失败【" + mobiles + "】");
			}
		} catch(Exception e) {
			log.error(e);
		}
	}

	public static void main(String[] args) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String reporter = get("reporter");
		String receivers = get("receivers");
		String content = get("content");
		if(args != null) {
			if(args.length == 1) {
				content = args[0];
			} else if(args.length > 1) {
				receivers = args[0];
				content = args[1];
			}
		}

		content = sdf.format(new Date()) + "  " + content;

		if(reporter != null && !reporter.trim().equals("")) {
			content = reporter + ": " + content;
		}

		send(receivers, content);
		System.exit(0);
	}
}