package jason.ss.tao.designpattern.creational.builder;

public class ThinkPadE520Builder extends ThinkPadBuilder<ThinkPadE520> {
	public ThinkPadE520Builder() {
		super(new ThinkPadE520());
	}

	@Override
	public void assembleCPU() {
		thinkPad.getComponents().add(new CPU("英特尔 第二代酷睿 i7-2860QM"));
	}

	@Override
	public void assembleRAM() {
		thinkPad.getComponents().add(new RAM("三星 DDR3 1333MHz"));
	}

	@Override
	public void assembleGPU() {
		thinkPad.getComponents().add(new GPU("ATI Radeon HD 6400M/7400M Series"));
	}

	@Override
	public void assembleDisk() {
		thinkPad.getComponents().add(new Disk("三星  SSD 840 EVO 250GB"));
	}
}
