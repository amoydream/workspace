package com.lauvan.util;

import org.apache.log4j.Logger;

public class Messenger {
	private static final Logger	log			= Logger.getLogger(Messenger.class);
	public static int			sendLimit	= 5;
	public static int			sendCount	= 0;
	static {
		Object obj = SiteUrl.readUrl("sendLimit");
		if(obj != null) {
			try {
				sendLimit = Integer.parseInt(obj.toString());
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

	public static void send(String content) {
		try {
			if(SiteUrl.readUrl("messenger") != null && sendCount <= sendLimit) {
				String[] cmdargs = {SiteUrl.readUrl("messenger"), content};
				Runtime.getRuntime().exec(cmdargs);
				sendCount++;
			}
		} catch(Exception e) {
			log.error(e);
		}
	}
}