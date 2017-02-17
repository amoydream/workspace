package jason.ss.tao.dynamicproxy;

import java.lang.reflect.Proxy;

public class UserManagerImpl implements UserManager {
	@Override
	public void addUser(String user) {
		System.out.println(user + " added");
	}

	@Override
	public void deleteUser(String user) {
		System.out.println(user + " deleted");
	}

	public static void main(String[] args) {
		UserManager userMgr = new UserManagerImpl();
		UserManager userMgrProxy = (UserManager)Proxy.newProxyInstance(userMgr.getClass().getClassLoader(), userMgr.getClass().getInterfaces(), new SecurityHandler(userMgr));
		userMgrProxy.addUser("Jason");
		userMgrProxy.deleteUser("Jason");
	}
}
