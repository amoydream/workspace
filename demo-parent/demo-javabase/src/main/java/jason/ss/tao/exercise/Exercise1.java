package jason.ss.tao.exercise;

import java.util.ArrayList;
import java.util.List;

public class Exercise1 {

	public static void main(String[] args) {
		List<String> l = new ArrayList<String>();
		l.add("1");
		for(int x = 1; x < 9; x++) {
			List<String> li = new ArrayList<String>();
			for(int i = 0; i < l.size(); i++) {
				li.add(l.get(i) + (x + 1));
				li.add(l.get(i) + "+" + (x + 1));
				li.add(l.get(i) + "-" + (x + 1));
			}
			l = li;
		}

		System.out.println(l.size());
		for(String s : l) {
			int val = calc(s);
			if(val == 100) {
				System.out.println(s + "=100");
			} else {
				//System.out.println(s + "=" + val);
			}
		}
	}

	private static int calc(String exp) {
		String[] aa = exp.split("[\\+-]");
		String[] bb = exp.split("[\\d]+");
		int val = Integer.parseInt(aa[0]);

		for(int i = 1; i < bb.length; i++) {
			if(bb[i].equals("+")) {
				val = val + Integer.parseInt(aa[i]);
			} else {
				val = val - Integer.parseInt(aa[i]);
			}
		}

		return val;
	}
}
