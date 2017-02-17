import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Shell;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Font;
import org.eclipse.swt.layout.FormLayout;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.wb.swt.SWTResourceManager;
import org.eclipse.swt.widgets.Text;

public class DouDiZhu {
	protected Shell						shlDoudizhu;
	private static final List<String>	paiList	= new ArrayList<String>();
	private static Text					weichu;
	private static Text					yichu;
	private static Text					zuojia;
	private static Text					youjia;
	private static Text					zijia;
	private Text						_zijia;
	private boolean						sort	= true;
	static {
		String[] paiArr = {"3", "3", "3", "3", "4", "4", "4", "4", "5", "5", "5", "5", "6", "6", "6", "6", "7", "7", "7", "7", "8", "8", "8", "8", "9", "9", "9", "9", "10", "10", "10", "10", "J", "J", "J", "J", "Q", "Q", "Q", "Q", "K", "K", "K", "K", "A", "A", "A", "A", "2", "2", "2", "2", "W", "W"};
		for(String pai : paiArr) {
			paiList.add(pai);
		}
	}

	public static void main(String[] args) {
		try {
			DouDiZhu window = new DouDiZhu();
			window.open();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public void open() {
		Display display = Display.getDefault();
		createContents();
		shlDoudizhu.open();
		shlDoudizhu.layout();
		while(!shlDoudizhu.isDisposed()) {
			if(!display.readAndDispatch()) {
				display.sleep();
			}
		}
	}

	protected void createContents() {
		shlDoudizhu = new Shell();
		shlDoudizhu.setSize(600, 470);
		shlDoudizhu.setText("斗地主");
		shlDoudizhu.setLayout(new FormLayout());

		Font font = SWTResourceManager.getFont("楷体", 18, SWT.BOLD);

		weichu = new Text(shlDoudizhu, SWT.BORDER | SWT.WRAP);
		weichu.setForeground(SWTResourceManager.getColor(SWT.COLOR_DARK_GREEN));
		weichu.setFont(font);
		FormData fd_weichu = new FormData();
		fd_weichu.left = new FormAttachment(0);
		fd_weichu.top = new FormAttachment(0);
		weichu.setLayoutData(fd_weichu);
		for(String pai : paiList) {
			weichu.append(pai + " ");
		}
		weichu.addListener(SWT.MouseDoubleClick, new Listener() {
			@Override
			public void handleEvent(Event e) {
				sort = !sort;
			}
		});

		yichu = new Text(shlDoudizhu, SWT.BORDER | SWT.WRAP);
		fd_weichu.bottom = new FormAttachment(yichu, -6);
		fd_weichu.right = new FormAttachment(yichu, 0, SWT.RIGHT);
		yichu.setForeground(SWTResourceManager.getColor(SWT.COLOR_DARK_BLUE));
		yichu.setFont(font);
		FormData fd_yichu = new FormData();
		fd_yichu.top = new FormAttachment(0, 105);
		fd_yichu.left = new FormAttachment(0);
		fd_yichu.right = new FormAttachment(100);
		yichu.setLayoutData(fd_yichu);

		zuojia = new Text(shlDoudizhu, SWT.BORDER | SWT.WRAP);
		fd_yichu.bottom = new FormAttachment(zuojia, -6);
		zuojia.setForeground(SWTResourceManager.getColor(SWT.COLOR_MAGENTA));
		zuojia.setFont(font);
		FormData fd_zuojia = new FormData();
		fd_zuojia.left = new FormAttachment(0);
		fd_zuojia.top = new FormAttachment(0, 216);
		zuojia.setLayoutData(fd_zuojia);

		youjia = new Text(shlDoudizhu, SWT.BORDER | SWT.WRAP);
		fd_zuojia.right = new FormAttachment(youjia, -6);
		youjia.setForeground(SWTResourceManager.getColor(SWT.COLOR_LINK_FOREGROUND));
		youjia.setFont(font);
		FormData fd_youjia = new FormData();
		fd_youjia.left = new FormAttachment(0, 299);
		fd_youjia.right = new FormAttachment(100);
		fd_youjia.bottom = new FormAttachment(zuojia, 0, SWT.BOTTOM);
		fd_youjia.top = new FormAttachment(zuojia, 0, SWT.TOP);
		youjia.setLayoutData(fd_youjia);

		zijia = new Text(shlDoudizhu, SWT.BORDER | SWT.WRAP);
		fd_zuojia.bottom = new FormAttachment(zijia, -6);
		zijia.setFont(font);
		FormData fd_zijia = new FormData();
		fd_zijia.left = new FormAttachment(0);
		fd_zijia.top = new FormAttachment(0, 327);
		fd_zijia.bottom = new FormAttachment(100);
		zijia.setLayoutData(fd_zijia);

		_zijia = new Text(shlDoudizhu, SWT.BORDER | SWT.WRAP);
		fd_zijia.right = new FormAttachment(_zijia, -6);
		_zijia.setForeground(SWTResourceManager.getColor(SWT.COLOR_DARK_YELLOW));
		_zijia.setFont(font);
		FormData fd__zijia = new FormData();
		fd__zijia.bottom = new FormAttachment(zijia, 0, SWT.BOTTOM);
		fd__zijia.top = new FormAttachment(youjia, 6);
		fd__zijia.left = new FormAttachment(0, 299);
		fd__zijia.right = new FormAttachment(100);
		_zijia.setLayoutData(fd__zijia);
		_zijia.addListener(SWT.MouseDoubleClick, new Listener() {
			@Override
			public void handleEvent(Event e) {
				reset();
			}
		});
		_zijia.addListener(SWT.KeyUp, new TextListener(_zijia));
		zijia.addListener(SWT.KeyUp, new TextListener(zijia));
		zuojia.addListener(SWT.KeyUp, new TextListener(zuojia));
		youjia.addListener(SWT.KeyUp, new TextListener(youjia));
	}

	private void reset() {
		weichu.setText("");
		for(String pai : paiList) {
			weichu.append(pai + " ");
		}
		yichu.setText("");
		zuojia.setText("");
		youjia.setText("");
		zijia.setText("");
		_zijia.setText("");
	}

	private void sort(Text t) {
		char[] pais = t.getText().replaceAll(" ", "").toCharArray();
		List<String> l = new ArrayList<String>();
		for(char pai : pais) {
			l.add(pai + "");
		}

		if(sort) {
			l.sort(new Comparator<String>() {
				@Override
				public int compare(String o1, String o2) {
					return o1.compareTo(o2);
				}
			});
		}

		t.setText("");
		for(String pai : l) {
			t.append(pai + " ");
		}
		t.setText(t.getText().trim());
	}

	class TextListener implements Listener {
		Text text;

		public TextListener(Text t) {
			text = t;
		}

		@Override
		public void handleEvent(Event e) {
			char c = e.character;
			if(!paiList.contains(c + "")) {
				text.setText(text.getText().replaceFirst(c + "", ""));
			} else {
				if(text != _zijia) {
					weichu.setText(weichu.getText().replaceFirst(c + "", "").replaceAll("  ", " ").trim());
					yichu.setText(filter(yichu.getText() + c, c));
				}
				String fs = filter(text.getText(), c);
				if(!fs.equals(text.getText())) {
					text.setText(fs);
				}
			}
		}
	}

	private String filter(String str, char c) {
		int n = 0;
		if(c == 'W' && str.length() > 2) {
			n = 2;
		} else if(str.length() > 4) {
			n = 4;
		}

		if(n != 0) {
			String _str = str;
			for(int x = 0; x < n; x++) {
				_str = _str.replaceFirst(c + "", "");
				if(x == n - 1 && _str.contains(c + "")) {
					str = str.substring(0, str.length() - 1);
					return str;
				}
			}
		}

		return str;
	}
}
