package jason.ss.tao.designpattern.structural;

import jason.ss.tao.designpattern.structural.adapter.classadapter.ReaderAdapter;
import jason.ss.tao.designpattern.structural.adapter.defaultadapter.Chicken;
import jason.ss.tao.designpattern.structural.adapter.defaultadapter.Duck;
import jason.ss.tao.designpattern.structural.adapter.defaultadapter.Swan;
import jason.ss.tao.designpattern.structural.adapter.objectadapter.MediaPlayerAdapter;
import junit.framework.TestCase;

public class AdapterTest extends TestCase {
	public void testObjectAdapter() {
		MediaPlayerAdapter mediaPlayer = new MediaPlayerAdapter();
		mediaPlayer.playMusic("Jam.wma");
		mediaPlayer.playVedio("Jam.wmv");
	}

	public void testClassAdapter() {
		ReaderAdapter mediaPlayer = new ReaderAdapter();
		mediaPlayer.readTXT("readme.txt");
		mediaPlayer.readPDF("readme.pdf");
	}

	public void testDefaultAdapter() {
		Chicken chicken = new Chicken();
		chicken.walk();

		Duck duck = new Duck();
		duck.walk();
		duck.swim();

		Swan swan = new Swan();
		swan.fly();
		swan.swim();
		swan.walk();
	}
}
