package jason.ss.tao.javabase;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Main {

	public static void main(String[] args) throws IOException {
		File f1 = new File("D:\\Oracle\\scripts\\CSMS_DATA_50000\\_CSMS_DATA_50000.sql");
		File f2 = new File("D:\\Oracle\\scripts\\CSMS_DATA_50000\\_CSMS_DATA_50000_.sql");
		List<String> l1 = readFile(f1);
		List<String> l2 = readFile(f2);
		for(String s : l1) {
			if(l2.contains(s)) {
				System.out.println(s);
			}
		}

	}

	static List<String> readFile(File f) throws IOException {
		List<String> l = new ArrayList<String>();
		BufferedReader br = new BufferedReader(new FileReader(f));
		String s = null;
		while((s = br.readLine()) != null) {
			l.add(s);
		}

		return l;
	}

}
