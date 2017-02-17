package jason.ss.tao.javabase;

public class OperatorTester extends JavaTester {

	@Override
	public void test() throws Exception {

		int a = 0b01100101_01000101_00101010_00010101;
		int b = 0b10010101_11010101_11100010_11101010;

		// &
		p("&");
		p(toBinaryStr(a) + ", " + a);
		p(toBinaryStr(b) + ", " + b);
		p(toBinaryStr(a & b) + ", " + (a & b));

		// |
		p("|");
		p(toBinaryStr(a) + ", " + a);
		p(toBinaryStr(b) + ", " + b);
		p(toBinaryStr(a | b) + ", " + (a | b));

		// ~
		p("~");
		p(toBinaryStr(a) + ", " + a);
		p(toBinaryStr(~a) + ", " + ~a);

		// ^
		p("^");
		p(toBinaryStr(a) + ", " + a);
		p(toBinaryStr(b) + ", " + b);
		p(toBinaryStr(a ^ b) + ", " + (a ^ b));

		// <<
		p("<<");
		p(toBinaryStr(a) + ", " + a);
		p(toBinaryStr(a << 1) + ", " + (a << 1));

		// >>
		p(">>");
		p(toBinaryStr(a) + ", " + a);
		p(toBinaryStr(a >> 3) + ", " + (a >> 3));
		p(toBinaryStr(b) + ", " + b);
		p(toBinaryStr(b >> 3) + ", " + (b >> 3));

		// >>>,无符号右移
		p(">>>");
		p(toBinaryStr(a) + ", " + a);
		p(toBinaryStr(a >>> 3) + ", " + (a >>> 3));
		p(toBinaryStr(b) + ", " + b);
		p(toBinaryStr(b >>> 3) + ", " + (b >>> 3));
	}

	private String toBinaryStr(int i) {
		String s = Integer.toBinaryString(i);
		if(i > 0) {
			int n = 32 - s.length();
			while(n > 0) {
				s = "0" + s;
				n--;
			}
		}

		int x = 4;
		String binaryStr = "";
		while(s.length() > x) {
			binaryStr += "_" + s.substring(0, x);
			s = s.substring(x);
		}

		return binaryStr.substring(1);
	}
}
