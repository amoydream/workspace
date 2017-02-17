package com.lauvan.base.main.controller;

import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.lauvan.core.annotation.RouteBind;

@RouteBind(path = "/")
public class IndexController extends Controller {
	/** 主界面 */
	@Clear
	public void index() {
		redirect("/Login/index");
	}
}
