import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Region;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Shell;

public class Snooker extends Shell implements Listener {
	private final Region	REGION		= new Region();
	private final Point		TL			= new Point(44, 42);
	private final Point		TC			= new Point(514, 24);
	private final Point		TR			= new Point(983, 42);
	private final Point		BR			= new Point(983, 519);
	private final Point		BC			= new Point(514, 539);
	private final Point		BL			= new Point(44, 519);
	private final int		WIDTH		= 1024;
	private final int		HEIGHT		= 560;
	private final int		R			= 15;
	private boolean			showLine	= false;
	private boolean			drag		= false;
	private Point			p			= null;
	private Display			display		= null;

	private Snooker(Display display) throws Exception {
		super(display, SWT.NO_TRIM | SWT.ON_TOP);
		this.display = display;
		setBounds(0, 25, WIDTH, HEIGHT);
		setLocation(447, 180);
		setBackground(new Color(display, 0, 0, 0));
		REGION.add(circle(WIDTH - 13, HEIGHT - 13, R));
		setRegion(REGION);
		addListener(SWT.MouseDown, this);
		addListener(SWT.MouseUp, this);
		addListener(SWT.MouseMove, this);
		//addListener(SWT.MouseDoubleClick, this);
		addListener(SWT.KeyUp, this);
		open();

		while(!isDisposed()) {
			if(!display.readAndDispatch()) {
				display.sleep();
			} else {
				display.asyncExec(new Runnable() {
					@Override
					public void run() {
						if(showLine && !drag) {
							drawLine();
						}
					}
				});

				Thread.sleep(50);
			}
		}

		display.dispose();
	}

	public void drawLine() {
		Point cl = display.getCursorLocation();
		Point l = getLocation();
		cl.x -= l.x;
		cl.y -= l.y;
		if(cl.x > 20 && cl.x < WIDTH + 20 && cl.y > 20 && cl.y < HEIGHT + 20) {
			Region r = new Region();
			r.add(circle(cl.x, cl.y, 2 * R));
			r.subtract(circle(cl.x, cl.y, 2 * R - 1));
			r.add(circle(TL.x, TL.y, R - 1));
			r.add(circle(TC.x, TC.y, R - 1));
			r.add(circle(TR.x, TR.y, R - 1));
			r.add(circle(BL.x, BL.y, R - 1));
			r.add(circle(BC.x, BC.y, R - 1));
			r.add(circle(BR.x, BR.y, R - 1));
			r.subtract(circle(TL.x, TL.y, R - 2));
			r.subtract(circle(TC.x, TC.y, R - 2));
			r.subtract(circle(TR.x, TR.y, R - 2));
			r.subtract(circle(BL.x, BL.y, R - 2));
			r.subtract(circle(BC.x, BC.y, R - 2));
			r.subtract(circle(BR.x, BR.y, R - 2));
			r.add(new int[]{TL.x, TL.y, cl.x + (cl.x > cl.y ? 0 : 1), cl.y, cl.x, cl.y + (cl.x >= cl.y ? 1 : 0)});
			if(cl.x >= TC.x) {
				r.add(new int[]{TC.x, TC.y, cl.x + (cl.x - TC.x > cl.y ? 0 : 1), cl.y, cl.x, cl.y + (cl.x - TC.x >= cl.y ? 1 : 0)});
			} else {
				r.add(new int[]{TC.x, TC.y, cl.x, cl.y + (TC.x - cl.x >= cl.y ? 1 : 0), cl.x + (TC.x - cl.x > cl.y ? 0 : -1), cl.y});
			}
			r.add(new int[]{TR.x, TR.y, cl.x, cl.y + (TR.x - cl.x >= cl.y ? 1 : 0), cl.x + (TR.x - cl.x > cl.y ? 0 : -1), cl.y});
			r.add(new int[]{BR.x, BR.y, cl.x, cl.y + (BR.x - cl.x >= BR.y - cl.y ? -1 : 0), cl.x + (BR.x - cl.x > BR.y - cl.y ? 0 : 1), cl.y});
			if(cl.x >= BC.x) {
				r.add(new int[]{BC.x, BC.y, cl.x + (cl.x - BC.x > BC.y - cl.y ? 0 : 1), cl.y, cl.x, cl.y + (cl.x - BC.x >= BC.y - cl.y ? -1 : 0)});
			} else {
				r.add(new int[]{BC.x, BC.y, cl.x, cl.y + (BC.x - cl.x >= BC.y - cl.y ? -1 : 0), cl.x + (BC.x - cl.x > BC.y - cl.y ? 0 : -1), cl.y});
			}
			r.add(new int[]{BL.x, BL.y, cl.x, cl.y + (cl.x - BL.x >= BL.y - cl.y ? -1 : 0), cl.x + (cl.x - BL.x > BL.y - cl.y ? 0 : 1), cl.y});

			r.add(circle(cl.x, cl.y, R - 1));
			r.subtract(circle(cl.x, cl.y, R - 2));
			r.add(REGION);
			setRegion(r);
		} else if(getRegion() != REGION) {
			setRegion(REGION);
		}
	}

	public int[] circle(int x, int y, int r) {
		int[] circle = new int[8 * r];
		for(int i = 0; i <= 2 * r; i++) {
			int _x = i - r;
			int _y = (int)Math.sqrt(r * r - _x * _x);
			circle[2 * i] = _x + x;
			circle[2 * i + 1] = _y + y;
			circle[8 * r - 2 * i - 2] = _x + x;
			circle[8 * r - 2 * i - 1] = y - _y;
		}
		return circle;
	}

	@Override
	public void handleEvent(Event e) {
		switch(e.type) {
		case SWT.MouseDown:
			showLine = !showLine;
			p = new Point(e.x, e.y);
			drag = true;
			if(!showLine) {
				setRegion(REGION);
			}
			break;
		case SWT.MouseUp:
			drag = false;
			break;
		case SWT.MouseMove:
			if(drag) {
				showLine = false;
				Point loc = getLocation();
				setLocation(loc.x + e.x - p.x, loc.y + e.y - p.y);
			}
			break;
		case SWT.KeyUp:
			int kcode = e.keyCode;
			char kchar = e.character;
			Point loc = getLocation();
			Point cl = display.getCursorLocation();
			if(kcode == 16777217) {
				setLocation(loc.x, loc.y - 1);
			} else if(kcode == 16777218) {
				setLocation(loc.x, loc.y + 1);
			} else if(kcode == 16777219) {
				setLocation(loc.x - 1, loc.y);
			} else if(kcode == 16777220) {
				setLocation(loc.x + 1, loc.y);
			} else if(kchar == 'w' || kchar == 'W') {
				display.setCursorLocation(cl.x, cl.y - 1);
			} else if(kchar == 's' || kchar == 'S') {
				display.setCursorLocation(cl.x, cl.y + 1);
			} else if(kchar == 'a' || kchar == 'A') {
				display.setCursorLocation(cl.x - 1, cl.y);
			} else if(kchar == 'd' || kchar == 'D') {
				display.setCursorLocation(cl.x + 1, cl.y);
			}
			break;
		case SWT.MouseDoubleClick:
			System.exit(0);
		default:
			break;
		}
	}

	@Override
	protected void checkSubclass() {
	}

	public static void main(String args[]) throws Exception {
		new Snooker(Display.getDefault());
	}
}
