package jason.ss.tao.dynamicproxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public class SecurityHandler implements InvocationHandler {
	private Object targetObject;

	public SecurityHandler(Object targetObject) {
		this.targetObject = targetObject;
	}

	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		validate();
		Object result = method.invoke(targetObject, args);
		return result;
	}

	public void validate() {
		System.out.println("SecurityHandler.validate()");
	}
}
