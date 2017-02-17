package jason.ss.tao.spring;

public class DemoBean {
	public void hello() {
		System.out.println("Hello");
	}

	public static void main(String[] args) {
		/*
		ApplicationContext ac =
		new ClassPathXmlApplicationContext("applicationContext-spring.xml");
		PrintStream out = ac.getBean("out", PrintStream.class);
		out.println("OK");

		Properties prop = ac.getBean("prop", Properties.class);

		out.println(prop.get("hello"));

		String jframeTitle = ac.getBean("jframeTitle", String.class);
		out.println(jframeTitle);

		ExpressionParser ep = new SpelExpressionParser();
		out.println(ep.parseExpression("new String(\"Hello\")").getValue());
		*/}
}
