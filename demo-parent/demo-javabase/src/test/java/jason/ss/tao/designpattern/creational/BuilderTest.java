package jason.ss.tao.designpattern.creational;

import jason.ss.tao.designpattern.creational.builder.ThinkPad;
import jason.ss.tao.designpattern.creational.builder.ThinkPadDirector;
import jason.ss.tao.designpattern.creational.builder.ThinkPadE420;
import jason.ss.tao.designpattern.creational.builder.ThinkPadE420Builder;
import jason.ss.tao.designpattern.creational.builder.ThinkPadE520;
import jason.ss.tao.designpattern.creational.builder.ThinkPadE520Builder;
import junit.framework.TestCase;

public class BuilderTest extends TestCase {
	public void testThinkPadBuilder() {
		ThinkPad thinkpadE420 = new ThinkPadDirector<ThinkPadE420>(new ThinkPadE420Builder()).assembleThinkPad();
		System.out.println(thinkpadE420);

		ThinkPad thinkpadE520 = new ThinkPadDirector<ThinkPadE520>(new ThinkPadE520Builder()).assembleThinkPad();
		System.out.println(thinkpadE520);
	}
}
