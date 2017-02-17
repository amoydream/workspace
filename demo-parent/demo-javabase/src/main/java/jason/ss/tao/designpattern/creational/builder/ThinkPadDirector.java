package jason.ss.tao.designpattern.creational.builder;

public class ThinkPadDirector<T extends ThinkPad> {
	private ThinkPadBuilder<T> thinkpadBuilder;

	public ThinkPadDirector(ThinkPadBuilder<T> thinkpadBuilder) {
		this.thinkpadBuilder = thinkpadBuilder;
	}

	public T assembleThinkPad() {
		thinkpadBuilder.assembleCPU();
		thinkpadBuilder.assembleRAM();
		thinkpadBuilder.assembleDisk();
		thinkpadBuilder.assembleGPU();
		return thinkpadBuilder.getThinkPad();
	}
}
