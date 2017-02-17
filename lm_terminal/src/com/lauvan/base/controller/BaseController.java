package com.lauvan.base.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.lauvan.system.service.SequenceService;
import com.lauvan.util.Json;
/**
 * 
 * ClassName: BaseController 
 * @Description: 基础控制类
 * @author 钮炜炜
 * @date 2015年9月11日 下午3:31:40
 */
@Controller
public class BaseController {
	
	@Autowired
	SequenceService sequenceService;
	
	/**
	 * 封装返回json消息
	 * @param success
	 * @param msg
	 * @return
	 */
	protected Json json(boolean success,String msg){
		Json json = new Json();
		json.setMsg(msg);
		json.setSuccess(success);
		return json;
	}
	/**
	 * 封装返回json消息
	 * @param success
	 * @param msg
	 * @param obj 自定义参数
	 * @return
	 */
	protected Json json(boolean success,String msg,Object obj){
		Json json = new Json();
		json.setMsg(msg);
		json.setSuccess(success);
		json.setObj(obj);
		return json;
	}
	
	/**
	 * 默认返回错误消息的json
	 * @param msg
	 * @return
	 */
	protected Json json(String msg){
		Json json = new Json();
		json.setMsg(msg);
		return json;
	}
	
	/**
	 * 获取表ID值
	 * @param tableName
	 * @return
	 */
	protected Integer nextval(String tableName) {
		return sequenceService.nextval(tableName);
	}
}
