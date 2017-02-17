import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.eclipse.swt.SWT;
import org.eclipse.swt.SWTError;
import org.eclipse.swt.browser.Browser;
import org.eclipse.swt.browser.CloseWindowListener;
import org.eclipse.swt.browser.LocationEvent;
import org.eclipse.swt.browser.LocationListener;
import org.eclipse.swt.browser.OpenWindowListener;
import org.eclipse.swt.browser.ProgressEvent;
import org.eclipse.swt.browser.ProgressListener;
import org.eclipse.swt.browser.StatusTextEvent;
import org.eclipse.swt.browser.StatusTextListener;
import org.eclipse.swt.browser.TitleEvent;
import org.eclipse.swt.browser.TitleListener;
import org.eclipse.swt.browser.VisibilityWindowAdapter;
import org.eclipse.swt.browser.WindowEvent;
import org.eclipse.swt.events.ShellAdapter;
import org.eclipse.swt.events.ShellEvent;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.graphics.ImageData;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.layout.FormLayout;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.ProgressBar;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.widgets.ToolBar;
import org.eclipse.swt.widgets.ToolItem;

public class WebBrowser {
	Browser		browser;
	boolean		busy;
	Canvas		canvas;
	SWTError	error	= null;
	Image		icon	= null;
	Image		images[];
	int			index;
	ToolItem	itemBack;
	ToolItem	itemForward;
	Text		locationBar;
	Composite	parent;
	ProgressBar	progressBar;
	Label		status;
	boolean		title	= false;
	ToolBar		toolbar;

	public WebBrowser(Composite parent, boolean top) {
		this.parent = parent;
		try {
			browser = new Browser(parent, SWT.NONE);
		} catch(SWTError e) {
			error = e;
			parent.setLayout(new FillLayout());
			Label label = new Label(parent, SWT.CENTER | SWT.WRAP);
			label.setText(Config.get("BrowserNotCreated"));
			parent.layout(true);
			return;
		}
		initResources();
		final Display display = parent.getDisplay();
		browser.setData("WebBrowser", this);
		browser.addOpenWindowListener(new OpenWindowListener() {
			@Override
			public void open(WindowEvent e) {
				Shell shell = new Shell(display);
				Rectangle r = display.getBounds();
				shell.setBounds((r.width - Config.minWidth) / 2, (r.height - Config.minHeight) / 2, Config.minWidth, Config.minHeight);
				if(icon != null) {
					shell.setImage(icon);
				}
				shell.setLayout(new FillLayout());
				WebBrowser wb = new WebBrowser(shell, false);
				wb.setShellDecoration(icon, true);
				e.browser = wb.getBrowser();
			}
		});
		if(top) {
			browser.setUrl(Config.get("Startup"));
			show(false, null, null);
		} else {
			browser.addVisibilityWindowListener(new VisibilityWindowAdapter() {
				@Override
				public void show(WindowEvent e) {
					Browser browser = (Browser)e.widget;
					WebBrowser wb = (WebBrowser)browser.getData("WebBrowser");
					wb.show(true, e.location, e.size);
				}
			});
			browser.addCloseWindowListener(new CloseWindowListener() {
				@Override
				public void close(WindowEvent event) {
					Browser browser = (Browser)event.widget;
					Shell shell = browser.getShell();
					shell.close();
				}
			});
		}
	}

	public static void main(String[] args) throws Exception {
		Display display = new Display();
		Shell shell = new Shell(display);
		Rectangle r = display.getBounds();
		shell.setBounds((r.width - Config.minWidth) / 2, (r.height - Config.minHeight) / 2, Config.minWidth, Config.minHeight);
		shell.setLayout(new FillLayout());
		shell.setMaximized(true);
		shell.setText(Config.get("Title"));
		InputStream stream = new FileInputStream(Config.user_dir + "/icon.ico");
		Image icon = new Image(display, stream);
		shell.setImage(icon);
		try {
			stream.close();
		} catch(IOException e) {
			e.printStackTrace();
		}
		WebBrowser wb = new WebBrowser(shell, true);
		wb.setShellDecoration(icon, true);
		if("Y".equals(Config.get("confirmExit"))) {
			shell.addShellListener(new ShellAdapter() {
				@Override
				public void shellClosed(ShellEvent e) {
					e.doit = false;
					if("Y".equals(Config.get("confirmExit"))) {
						MessageBox msg = new MessageBox(shell, SWT.ICON_QUESTION | SWT.YES | SWT.NO);
						msg.setText("退出系统");
						msg.setMessage("关闭浏览器将丢失当前数据, 确定要关闭吗!");
						if(msg.open() == SWT.YES) {
							new Thread() {
								@Override
								public void run() {
									display.asyncExec(new Runnable() {
										@Override
										public void run() {
											wb.getBrowser().setUrl(Config.get("Logout"));
										}
									});
									try {
										Thread.sleep(100);
										System.exit(0);
									} catch(InterruptedException e) {
										e.printStackTrace();
									}
								};
							}.start();
						}
					}
				}
			});
		}
		shell.open();
		while(!shell.isDisposed()) {
			if(!display.readAndDispatch()) {
				display.sleep();
			}
		}
		icon.dispose();
		wb.dispose();
		display.dispose();
	}

	public void dispose() {
		freeResources();
	}

	public void focus() {
		if(locationBar != null) {
			locationBar.setFocus();
		} else if(browser != null) {
			browser.setFocus();
		} else {
			parent.setFocus();
		}
	}

	void freeResources() {
		if(images != null) {
			for(int i = 0; i < images.length; ++i) {
				final Image image = images[i];
				if(image != null) {
					image.dispose();
				}
			}
			images = null;
		}
	}

	public Browser getBrowser() {
		return browser;
	}

	public SWTError getError() {
		return error;
	}

	void initResources() {
		try {
			if(images == null) {
				images = new Image[Config.imageNames.length];
				for(int i = 0; i < Config.imageNames.length; ++i) {
					InputStream sourceStream = new FileInputStream(Config.user_dir + "/images/" + Config.imageNames[i]);
					ImageData source = new ImageData(sourceStream);
					ImageData mask = source.getTransparencyMask();
					images[i] = new Image(null, source, mask);
					try {
						sourceStream.close();
					} catch(IOException e) {
						e.printStackTrace();
					}
				}
			}
			return;
		} catch(Throwable t) {
		}
		freeResources();
		throw new RuntimeException(error);
	}

	public void setShellDecoration(Image icon, boolean title) {
		this.icon = icon;
		this.title = title;
	}

	void show(boolean isMain, Point location, Point size) {
		boolean addressBar = Config.get("addressBar") == null || Config.get("addressBar").equals("yes") ? true : false;
		boolean statusBar = Config.get("statusBar") == null || Config.get("statusBar").equals("yes") ? true : false;
		boolean toolBar = Config.get("toolBar") == null || Config.get("toolBar").equals("yes") ? true : false;
		final Shell shell = browser.getShell();
		if(isMain) {
			if(location != null) {
				shell.setLocation(location);
			}
			if(size != null) {
				shell.setSize(shell.computeSize(size.x, size.y));
			}
		}
		FormData data = null;
		if(toolBar) {
			toolbar = new ToolBar(parent, SWT.NONE);
			data = new FormData();
			data.top = new FormAttachment(0, 5);
			toolbar.setLayoutData(data);
			itemBack = new ToolItem(toolbar, SWT.PUSH);
			itemBack.setText(Config.get("Back"));
			itemForward = new ToolItem(toolbar, SWT.PUSH);
			itemForward.setText(Config.get("Forward"));
			final ToolItem itemStop = new ToolItem(toolbar, SWT.PUSH);
			itemStop.setText(Config.get("Stop"));
			final ToolItem itemRefresh = new ToolItem(toolbar, SWT.PUSH);
			itemRefresh.setText(Config.get("Refresh"));
			final ToolItem itemGo = new ToolItem(toolbar, SWT.PUSH);
			itemGo.setText(Config.get("Go"));

			itemBack.setEnabled(browser.isBackEnabled());
			itemForward.setEnabled(browser.isForwardEnabled());
			Listener listener = new Listener() {
				@Override
				public void handleEvent(Event event) {
					ToolItem item = (ToolItem)event.widget;
					if(item == itemBack) {
						browser.back();
					} else if(item == itemForward) {
						browser.forward();
					} else if(item == itemStop) {
						browser.stop();
					} else if(item == itemRefresh) {
						browser.refresh();
					} else if(item == itemGo) {
						browser.setUrl(locationBar.getText());
					}
				}
			};
			itemBack.addListener(SWT.Selection, listener);
			itemForward.addListener(SWT.Selection, listener);
			itemStop.addListener(SWT.Selection, listener);
			itemRefresh.addListener(SWT.Selection, listener);
			itemGo.addListener(SWT.Selection, listener);

			canvas = new Canvas(parent, SWT.NO_BACKGROUND);
			data = new FormData();
			data.width = 24;
			data.height = 24;
			data.top = new FormAttachment(0, 5);
			data.right = new FormAttachment(100, -5);
			canvas.setLayoutData(data);

			final Rectangle rect = images[0].getBounds();
			canvas.addListener(SWT.Paint, new Listener() {
				@Override
				public void handleEvent(Event e) {
					Point pt = ((Canvas)e.widget).getSize();
					e.gc.drawImage(images[index], 0, 0, rect.width, rect.height, 0, 0, pt.x, pt.y);
				}
			});
			canvas.addListener(SWT.MouseDown, new Listener() {
				@Override
				public void handleEvent(Event e) {
					browser.setUrl(Config.get("Startup"));
				}
			});

			final Display display = parent.getDisplay();
			display.asyncExec(new Runnable() {
				@Override
				public void run() {
					if(canvas.isDisposed()) {
						return;
					}
					if(busy) {
						index++;
						if(index == images.length) {
							index = 0;
						}
						canvas.redraw();
					}
					display.timerExec(150, this);
				}
			});
		}
		if(addressBar) {
			locationBar = new Text(parent, SWT.BORDER);
			data = new FormData();
			if(toolbar != null) {
				data.top = new FormAttachment(toolbar, 0, SWT.TOP);
				data.left = new FormAttachment(toolbar, 5, SWT.RIGHT);
				data.right = new FormAttachment(canvas, -5, SWT.DEFAULT);
			} else {
				data.top = new FormAttachment(0, 0);
				data.left = new FormAttachment(0, 0);
				data.right = new FormAttachment(100, 0);
			}
			locationBar.setLayoutData(data);
			locationBar.addListener(SWT.DefaultSelection, new Listener() {
				@Override
				public void handleEvent(Event e) {
					browser.setUrl(locationBar.getText());
				}
			});
		}
		if(statusBar) {
			status = new Label(parent, SWT.NONE);
			progressBar = new ProgressBar(parent, SWT.NONE);
			data = new FormData();
			data.left = new FormAttachment(0, 5);
			data.right = new FormAttachment(progressBar, 0, SWT.DEFAULT);
			data.bottom = new FormAttachment(100, -5);
			status.setLayoutData(data);
			data = new FormData();
			data.right = new FormAttachment(100, -5);
			data.bottom = new FormAttachment(100, -5);
			progressBar.setLayoutData(data);
			browser.addStatusTextListener(new StatusTextListener() {
				@Override
				public void changed(StatusTextEvent event) {
					status.setText(event.text);
				}
			});
		}
		parent.setLayout(new FormLayout());

		Control aboveBrowser = toolBar ? (Control)canvas : addressBar ? (Control)locationBar : null;
		data = new FormData();
		data.left = new FormAttachment(0, 0);
		data.top = aboveBrowser != null ? new FormAttachment(aboveBrowser, 5, SWT.DEFAULT) : new FormAttachment(0, 0);
		data.right = new FormAttachment(100, 0);
		data.bottom = status != null ? new FormAttachment(status, -5, SWT.DEFAULT) : new FormAttachment(100, 0);
		browser.setLayoutData(data);

		if(statusBar || toolBar) {
			browser.addProgressListener(new ProgressListener() {
				@Override
				public void changed(ProgressEvent event) {
					if(event.total == 0) {
						return;
					}
					int ratio = event.current * 100 / event.total;
					if(progressBar != null) {
						progressBar.setSelection(ratio);
					}
					busy = event.current != event.total;
					if(!busy) {
						index = 0;
						if(canvas != null) {
							canvas.redraw();
						}
					}
				}

				@Override
				public void completed(ProgressEvent event) {
					if(progressBar != null) {
						progressBar.setSelection(0);
					}
					busy = false;
					index = 0;
					if(canvas != null) {
						itemBack.setEnabled(browser.isBackEnabled());
						itemForward.setEnabled(browser.isForwardEnabled());
						canvas.redraw();
					}
				}
			});
		}
		if(addressBar || statusBar || toolBar) {
			browser.addLocationListener(new LocationListener() {
				@Override
				public void changed(LocationEvent event) {
					busy = true;
					if(event.top && locationBar != null) {
						locationBar.setText(event.location);
					}
				}

				@Override
				public void changing(LocationEvent event) {
				}
			});
		}
		if(title) {
			browser.addTitleListener(new TitleListener() {
				@Override
				public void changed(TitleEvent event) {
					shell.setText(event.title);
				}
			});
		}
		parent.layout(true);
		if(isMain) {
			shell.open();
		}
	}
}