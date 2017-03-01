package jason.ss.tao.dynamicproxy;

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
		UserManager userMgrProxy = new UserManagerProxy().getProxy(userMgr);
		userMgrProxy.addUser("Jason");
		userMgrProxy.deleteUser("Jason");
	}
}
