package jason.ss.tao.thread;

public class DeadLock {
	static String	lock1	= "LOCK1";
	static String	lock2	= "LOCK2";

	public static void main(String[] args) {
		Thread thread1 = new Thread(new Runnable() {
			@Override
			public void run() {
				int n = 100;
				while(n > 0) {
					synchronized(lock1) {
						System.out.println(lock1 + " in " + Thread.currentThread().getName());
						synchronized(lock2) {
							System.out.println(lock2 + " in " + Thread.currentThread().getName());
						}
					}
				}
			}
		});

		Thread thread2 = new Thread(new Runnable() {
			@Override
			public void run() {
				int n = 100;
				while(n > 0) {
					synchronized(lock2) {
						System.out.println(lock2 + " in " + Thread.currentThread().getName());
						synchronized(lock1) {
							System.out.println(lock1 + " in " + Thread.currentThread().getName());
						}
					}
				}
			}
		});

		thread1.start();

		thread2.start();
	}
}
