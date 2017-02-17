package com.lauvan.core.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author gaocheyang
 * @date 2015年8月12日
 * @Description 权限绑定标志 在controller上使用
 */
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ ElementType.METHOD, ElementType.TYPE })
public @interface PowerBind {
	/** 对应权限代码 */
	String code() default "";

	/** 验证标记 true:需要验证 */
	boolean v() default false;

}
