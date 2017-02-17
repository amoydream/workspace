import java.io.File;

public class rename {
	public static void main(String[] args) throws Exception {
		File d = new File("E:\\话说中国");
		String dn = d.getAbsolutePath();
		File[] fs = d.listFiles();
		for(File f : fs) {
			String fn = f.getName();
			fn = fn.replace("LRTS#第", "").replace("集", "").replaceFirst("#27249#[0-9]*", "");
			f.renameTo(new File(dn + "\\" + fn));
		}
	}
}
