package tasklistener;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

public class TaskListener {
	private static final Logger		log						= Logger.getLogger(TaskListener.class);
	private static SortedProperties	prop					= null;
	private static List<Task>		taskList				= null;
	private static int				timeout					= 30000;
	private static int				RESTART_FAILED_COUNT	= 3;
	private static boolean			WAIT_FOR_EXEC			= false;
	private static boolean			WAIT_FOR_ERROR			= false;
	private static boolean			ERROR_REPORTED			= false;

	static {
		String propFile = System.getProperty("user.dir") + "/config.properties";
		prop = new SortedProperties();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(new File(propFile));
			prop.load(fis);
			taskList = new ArrayList<Task>();
			Set<Object> keySet = prop.keySet();
			Iterator<Object> i = keySet.iterator();
			timeout = (int)(Float.parseFloat(get("timeout")) * 60 * 1000);
			RESTART_FAILED_COUNT = Integer.parseInt(get("restartFailedCount"));
			while(i.hasNext()) {
				String key = String.valueOf(i.next());
				String name = null;
				String type = null;
				if(key.startsWith("IMAGE_")) {
					type = "IMAGE";
					name = key.replaceFirst("IMAGE_", "");
					String cmd = get(key);
					taskList.add(new Task(name, type, cmd, 0));
				} else if(key.startsWith("SERVICE_")) {
					type = "SERVICE";
					name = key.replaceFirst("SERVICE_", "");
					String cmd = get(key);
					taskList.add(new Task(name, type, cmd, 0));
				}
			}
		} catch(Exception e) {
			messenger("程序监测服务启动失败: " + e.toString());
			log.error(e);
			System.exit(0);
		} finally {
			if(fis != null) {
				try {
					fis.close();
				} catch(IOException e) {
					log.error(e);
				}
			}
		}
	}

	public static void main(String[] args) throws IOException {
		log.info("程序监测服务已启动");
		while(true) {
			try {
				Thread.sleep(timeout);
				for(int i = 0; i < taskList.size();) {
					WAIT_FOR_EXEC = true;
					WAIT_FOR_ERROR = true;
					Task task = taskList.get(i);
					String checkCmd = null;
					if(task.type.equals("IMAGE")) {
						checkCmd = "TASKLIST /NH /SVC /FI \"IMAGENAME eq " + task.name + "\"";
					} else if(task.type.equals("SERVICE")) {
						checkCmd = "TASKLIST /NH /SVC /FI \"SERVICES eq " + task.name + "\"";
					}
					Process p = Runtime.getRuntime().exec(checkCmd);
					new Thread(new CheckTask(p.getInputStream(), task)).start();
					p.waitFor();
					while(WAIT_FOR_EXEC || WAIT_FOR_ERROR) {
						Thread.sleep(20);
					}
					i++;
				}
			} catch(Exception e) {
				WAIT_FOR_EXEC = false;
				WAIT_FOR_ERROR = false;
				log.error(e);
			}
		}
	}

	static class CheckTask implements Runnable {
		InputStream	in;
		Task		task;

		public CheckTask(InputStream in, Task task) {
			this.in = in;
			this.task = task;
		}

		@Override
		public void run() {
			InputStreamReader isr = null;
			BufferedReader br = null;
			try {
				isr = new InputStreamReader(in, "GB2312");
				br = new BufferedReader(isr);
				String line = null;
				boolean RUNNING = false;
				while((line = br.readLine()) != null) {
					if(line.indexOf(task.name) != -1) {
						log.info(task.name + " 正常运行中");
						RUNNING = true;
						WAIT_FOR_EXEC = false;
						WAIT_FOR_ERROR = false;
						if(task.restartFailedCount >= RESTART_FAILED_COUNT) {
							messenger("尝试启动【" + task.name + "】" + RESTART_FAILED_COUNT + "次后启动成功");
						}
						task.restartFailedCount = 0;
						break;
					}
				}
				if(!RUNNING) {
					task.restartFailedCount++;
					if(task.restartFailedCount == RESTART_FAILED_COUNT) {
						messenger("尝试启动【" + task.name + "】" + RESTART_FAILED_COUNT + "次失败");
					}
					log.info(task.name + " 未启动");
					log.info(task.name + " 正在启动...");
					Process p = null;
					if(task.type.equals("IMAGE")) {
						p = new ProcessBuilder(task.cmd).start();
					} else {
						p = Runtime.getRuntime().exec(task.cmd);
					}
					new Thread(new ExecInfo(p.getInputStream(), task)).start();
					new Thread(new ExecError(p.getErrorStream(), task)).start();
				}
			} catch(Exception e) {
				WAIT_FOR_EXEC = false;
				WAIT_FOR_ERROR = false;
				log.error(e);
				if(!ERROR_REPORTED) {
					messenger(task.name + " " + e.getClass());
					ERROR_REPORTED = true;
				}
			} finally {
				try {
					br.close();
					isr.close();
					in.close();
				} catch(Exception e) {
					log.error(e);
				}
			}
		}
	}

	static class ExecInfo implements Runnable {
		InputStream	in;
		Task		task;

		public ExecInfo(InputStream in, Task task) {
			this.in = in;
			this.task = task;
		}

		@Override
		public void run() {
			InputStreamReader isr = null;
			BufferedReader br = null;
			try {
				isr = new InputStreamReader(in, "GB2312");
				br = new BufferedReader(isr);
				if(task.type.equals("IMAGE")) {
					throw new TaskException();
				} else {
					String line = br.readLine();
					while(line != null) {
						log.info(line);
						line = br.readLine();
					}
				}
			} catch(Exception e) {
				if(!e.getClass().equals(TaskException.class)) {
					log.error(e);
				}
			} finally {
				WAIT_FOR_EXEC = false;
				if(task.type.equals("IMAGE")) {
					try {
						Thread.sleep(1000);
					} catch(InterruptedException e) {
					} finally {
						WAIT_FOR_ERROR = false;
						log.info(task.name + " 启动成功");
					}
				}
				try {
					br.close();
					isr.close();
					in.close();
				} catch(Exception e) {
					log.error(e);
				}
			}
		}
	}

	static class ExecError implements Runnable {
		InputStream	in;
		Task		task;

		public ExecError(InputStream in, Task task) {
			this.in = in;
			this.task = task;
		}

		@Override
		public void run() {
			InputStreamReader isr = null;
			BufferedReader br = null;
			try {
				isr = new InputStreamReader(in, "GB2312");
				br = new BufferedReader(isr);
				String line = br.readLine();
				while(line != null) {
					log.error(line);
					line = br.readLine();
				}
			} catch(Exception e) {
				if(!e.getClass().equals(TaskException.class)) {
					log.error(e);
				}
			} finally {
				WAIT_FOR_ERROR = false;
				WAIT_FOR_EXEC = false;
				try {
					br.close();
					isr.close();
					in.close();
				} catch(Exception e) {
					log.error(e);
				}
			}
		}
	}

	static class Task {
		String	name;
		String	type;
		String	cmd;
		int		restartFailedCount;

		public Task(String name, String type, String cmd, int restartFailedCount) {
			this.name = name;
			this.type = type;
			this.cmd = cmd;
			this.restartFailedCount = restartFailedCount;
		}
	}

	public static String get(String key) {
		return prop.getProperty(key);
	}

	public static void messenger(String content) {
		try {
			if(get("messenger") != null) {
				String[] cmdargs = {get("messenger"), content};
				Runtime.getRuntime().exec(cmdargs);
			}
		} catch(Exception e) {
			log.error(e);
		}
	}
}