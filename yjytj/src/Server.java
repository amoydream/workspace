import java.io.File;

import com.jfinal.core.JFinal;
import com.jfinal.kit.PathKit;

public class Server {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String webAppDir = PathKit.getWebRootPath().replace(File.separator, "/");
		try {
			JFinal.start(webAppDir, 80, "/hzyj", 2);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
