package jason.ss.tao.designpattern.creational.builder;

public abstract class ThinkPadBuilder<T extends ThinkPad> {
	protected T thinkPad;

	public ThinkPadBuilder(T thinkPad) {
		this.thinkPad = thinkPad;
	}

	public abstract void assembleCPU();

	public abstract void assembleRAM();

	public abstract void assembleGPU();

	public abstract void assembleDisk();

	public T getThinkPad() {
		return thinkPad;
	}
}
