
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;

public class Config {
	protected static final String	user_dir	= System.getProperty("user.dir");
	private static final Logger		log			= Logger.getLogger(Config.class);
	private static Properties		prop		= null;
	protected static String[]		imageNames	= null;
	protected static int			minWidth	= 1280;
	protected static int			minHeight	= 900;

	static {
		if(prop == null) {
			getProp();
		}
		Iterator<Object> i = prop.keySet().iterator();
		List<String> list = new ArrayList<String>();
		while(i.hasNext()) {
			String key = i.next().toString();
			if(key.startsWith("Image_")) {
				list.add(get(key));
			}
		}
		imageNames = list.toArray(new String[list.size()]);

		Object mw = get("minWidth");
		if(mw != null) {
			try {
				int w = Integer.parseInt(mw.toString());
				if(w > 200) {
					minWidth = w;
				}
			} catch(Exception e) {
				log.error(e);
			}
		}

		Object mh = get("minHeight");
		if(mh != null) {
			try {
				int h = Integer.parseInt(mh.toString());
				if(h > 200) {
					minHeight = h;
				}
			} catch(Exception e) {
				log.error(e);
			}
		}
	}

	public static Properties getProp() {
		if(prop == null) {
			String confgFile = user_dir + "/webrowser.properties";
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

	public static String get(String key) {
		return getProp().getProperty(key);
	}
}