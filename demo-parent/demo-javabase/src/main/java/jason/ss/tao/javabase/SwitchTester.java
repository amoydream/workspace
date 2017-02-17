package jason.ss.tao.javabase;

//switch语句只支持byte(Byte)、char(Character)、short(Short)、int(Integer)、enum，不支持long，jdk7及以上支持String
//执行到某一分支时，如果此分支没有break语句，程序会继续进入余下分支执行，知道遇到break语句或者switch完毕
//同return，break语句之后的语句无效，出现编译错误
//case内可定义变量，作用范围是分支以内
public class SwitchTester extends JavaTester {

	@Override
	public void test() throws Exception {
		byte b = 1;
		switch(b) {
		}
		Byte B = new Byte(b);
		switch(B) {
		}
		char c = 'c';
		switch(c) {
		}
		Character C = new Character(c);
		switch(C) {
		}
		short s = 1;
		switch(s) {
		}
		Short S = new Short(s);
		switch(S) {
		}
		int i = 1;
		switch(i) {
		}
		Integer I = new Integer(i);
		switch(I) {
		}
		EE e = EE.A;
		switch(e) {
		case A:
			break;
		default:
			break;
		}
		String str = "";//String.equals避免null pointer
		switch(str) {
		case "":
			p("Empty String");
		case "a":
			p(str);
		default:
			p(str);
		}

		//Cannot switch on a value of type long. Only convertible int values, strings or enum variables are permitted
		//      long l = 1L;
		//      switch(l) {
		//      default:
		//         break;
		//      }
	}
}
