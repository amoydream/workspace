package jason.ss.tao.dynamicproxy;

public interface ProxyInterface<T> {
	T getProxy(UserManager userMgr);
}
