package jason.ss.tao.designpattern.structural.composite;

public class Boss extends Leader {
	private static final Boss boss = new Boss("Jason");

	private Boss(String name) {
		super(name, 0, null);
	}

	public static Boss getBoss() {
		return boss;
	}
}
