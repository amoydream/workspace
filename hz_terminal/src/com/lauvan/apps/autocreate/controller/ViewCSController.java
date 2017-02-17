package com.lauvan.apps.autocreate.controller;

import java.util.List;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/viewCSController", viewPath = "autoCreate/viewCS")
public class ViewCSController extends BaseController {
	/**
	 *模块主页方法
	 */
	public void index() {
		render("main.jsp");
	}

	/**
	 *模块列表查询方法
	 */
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		//查询字段
		StringBuffer str = new StringBuffer();
		Page<Record> page = Paginate.dao.getPage("T_AutoView", pageSize, pageNumber, str.toString(), null, null);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	/**
	 *新增
	 */
	public void add() {
		render("add.jsp");
	}

	/**
	 *修改
	 */
	public void edit() {
		render("edit.jsp");
	}

	/**
	 *删除
	 */
	public void delete() {

	}

	/**
	 *保存
	 */
	public void save() {

	}

}
