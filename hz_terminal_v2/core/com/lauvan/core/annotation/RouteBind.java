package com.lauvan.core.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author gaocheyang
 * @date 2015年8月12日
 * @Description Route 绑定Controller注解 ,在controller上使用
 */
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ ElementType.TYPE })
public @interface RouteBind {
	/** 对应的路径名 已/开头 */
	String path() default "/";
	
	/** 前端视图所在目录 */
	String viewPath() default "";

}
