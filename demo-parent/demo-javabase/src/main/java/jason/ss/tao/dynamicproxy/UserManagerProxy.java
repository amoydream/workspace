package jason.ss.tao.dynamicproxy;

import java.lang.reflect.Proxy;

public class UserManagerProxy implements ProxyInterface<UserManager> {
	@Override
	public UserManager getProxy(UserManager userMgr) {
		return (UserManager)Proxy.newProxyInstance(userMgr.getClass().getClassLoader(), userMgr.getClass().getInterfaces(), new SecurityHandler(userMgr));
	}
}
