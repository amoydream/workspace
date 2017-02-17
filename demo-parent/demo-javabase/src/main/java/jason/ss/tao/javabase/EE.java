package jason.ss.tao.javabase;

//枚举类型不能有public constructor
//ordinal() int ： 取得枚举值的序列号，从0开始

public enum EE {
	A("A"), B("B"), C("C"), D;

	private String value;

	EE() {

	}

	private EE(String s) {
		value = s;
	}

	public String getValue() {
		return value;
	}
}
