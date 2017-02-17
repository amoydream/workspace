package com.lauvan.interceptor;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * ClassName: Perm 
 * @Description: 权限注解
 * @author 钮炜炜
 * @date 2015年9月10日 上午10:52:57
 */
@Retention(RetentionPolicy.RUNTIME)//指定该注解是在运行期进行
@Target(ElementType.METHOD)//指定该注解要在方法上使用
public @interface Perm {
	/* 权限值 */
	String privilegeValue() default "";
}