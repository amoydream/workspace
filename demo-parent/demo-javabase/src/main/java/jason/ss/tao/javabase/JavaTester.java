package jason.ss.tao.javabase;

public abstract class JavaTester {
	public static void main(String[] args) throws Exception {
		JavaTester tester = new DataTypeTester();
		tester.test();
	}

	public abstract void test() throws Exception;

	public void p(Object obj) {
		System.out.println(obj);
	}

	public void p(byte b) {
		System.out.println(b);
	}

	public void p(boolean b) {
		System.out.println(b);
	}

	public void p(char c) {
		System.out.println(c);
	}

	public void p(short s) {
		System.out.println(s);
	}

	public void p(int i) {
		System.out.println(i);
	}

	public void p(long l) {
		System.out.println(l);
	}

	public void p(float f) {
		System.out.println(f);
	}

	public void p(double d) {
		System.out.println(d);
	}

	public void p(Enum<EE> e) {
		System.out.println(e);
	}
}
