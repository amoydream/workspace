package com.lauvan.util;

/**
 * @describe  系统日志操作类型枚举类
 * @author 陈存登
 * @version 1.0 6-9-2015
 */
public enum EnumLogUtil {
    
	/**登录*/
	LOGIN{public String getName(){return "登录操作";}},
	/**登出*/
	LOGOUT{public String getName(){return "登出操作";}},
	/**增加*/
	ADD{public String getName(){return "增加操作";}},
	/**修改*/
	EDIT{public String getName(){return "修改操作";}},
	/**删除*/
	DELETE{public String getName(){return "删除操作";}};
	
	public abstract String getName();
	
}
