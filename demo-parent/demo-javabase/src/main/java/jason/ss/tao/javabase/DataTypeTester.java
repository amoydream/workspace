package jason.ss.tao.javabase;

public class DataTypeTester extends JavaTester {

	@Override
	public void test() throws Exception {
		// local variable must be initialized before using
		boolean bl = false;// true|false, def:false
		p(bl);

		char c = '\u0000';// 2Byte, 16bit, 无符号， '\u0000'~'\uffff', [0, 2^16 - 1]
		p(c);

		// 低转高自动转， 高转低强制转
		// l=i；正确， i = l；错误， -i = (int)l；正确
		// Java在对表达式求值时，将自动把这些类型扩大为 int型，而且，表达式的值也是int型
		// 赋值时如果超出范围需要强制转型，否则编译出错
		byte b1 = 1, b2 = 2;
		byte b = (byte)(b1 + b2);// 1字节（Byte）, 8位(bit), [-2^7, 2^7 - 1], def: 0
		p(b);
		short s = 0;// 2 Byte, 16 bit, [-2^15, 2^15 - 1], def: 0
		p(s);
		int i = 0;// 4 Byte, 32 bit, [-2^31, 2^31 - 1], def:0
		p(i);
		long l = 0L;// 8 Byte, 64 bit, [-2^63, 2^63 - 1], def:0L
		p(l);

		long l1 = -(Byte.MAX_VALUE + 123);
		p(INT.BYTE.forceCast(l1));
		p((byte)l1);

		long l2 = Short.MAX_VALUE + 1234;
		p(INT.SHORT.forceCast(l2));
		p((short)l2);

		long l3 = -(Integer.MAX_VALUE + 1234);
		p(INT.INT.forceCast(l3));
		p((int)l3);

		long l4 = Long.MAX_VALUE + 1234567890;
		p(INT.LONG.forceCast(l4));
		p(l4);

		// 小数默认是double类型
		float f = 0.0f;// float f = 0.0 compile-error
		p(f);
		double d = 0.0d;// D或d可以不写，d = 1.5E2, 1.5e2
		p(d);

		Object o = null;//
		p(o);

		byte byte1 = -1;
		p("byte1: " + byte1);
		String bStr = toBinary(byte1);
		p("binary: " + bStr);
		String revStr = reverseString(bStr);
		p("reverse: " + revStr);
		byte byte2 = binaryStrToByte(revStr);
		p("byte2: " + byte2);
	}

	enum INT {
		BYTE(Byte.MIN_VALUE, Byte.MAX_VALUE), SHORT(Short.MIN_VALUE,
			Short.MAX_VALUE),
		INT(Integer.MIN_VALUE, Integer.MAX_VALUE), LONG(Long.MIN_VALUE,
			Long.MAX_VALUE);
		private long	min;
		private long	max;

		private INT(long min, long max) {
			this.min = min;
			this.max = max;
		}

		public long getMax() {
			return max;
		}

		public long getMin() {
			return min;
		}

		public long forceCast(long x) {
			if(compareTo(LONG) != 0) {
				long T = max - min + 1;
				if(x >= 0) {
					x = x % T;
					if(x > max) {
						x = x - T;
					}
				} else {
					x = -(-x % T);
					if(x < min) {
						x = T + x;
					}
				}
			}
			return x;
		}
	}

	public static String toBinary(byte b) {
		String bStr = Integer.toBinaryString(b & 0xff);
		if(bStr.length() < 8) {
			for(int i = 0; i < 8 - bStr.length(); i++) {
				bStr = "0" + bStr;
			}
		}

		return bStr;
	}

	public static byte binaryStrToByte(String bStr) {
		char[] cc = bStr.toCharArray();
		byte b = 0;
		for(int i = 1; i < cc.length; i++) {
			b = (byte)(b + Integer.parseInt(String.valueOf(cc[i])) * Math.pow(2, cc.length - i - 1));
		}

		if(cc[0] == '1') {
			b = (byte)(b - 128);
		}

		return b;
	}

	public static String reverseString(String s) {
		char[] cc = s.toCharArray();
		String str = "";
		for(int i = cc.length - 1; i >= 0; i--) {
			str = str + cc[i];
		}

		return str;
	}
}
