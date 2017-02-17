package jason.ss.tao.jvmspec;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;

//-Xms10M -Xmx10M
public class HeapOutOfMemoryError {

	public static void main(String[] args) {
		List<Object> list = new ArrayList<Object>();
		while(true) {
			list.add(new JFrame());
		}
	}

}
