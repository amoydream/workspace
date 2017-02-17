package com.lauvan.init;

import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.ccms.model.T_Ccms_Setting;
import com.lauvan.apps.communication.ccms.util.CcmsUtil;
import com.lauvan.base.basemodel.model.T_Sys_Module;

public class initModuleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);

		List<Record> moduleList = T_Sys_Module.dao.getListByUsable(true);
		for(Record module : moduleList) {
			config.getServletContext().setAttribute(module.getStr("mark"), module.get("id"));
		}

		T_Ccms_Setting setting = T_Ccms_Setting.dao.findFirst("SELECT * FROM T_CCMS_SETTING");
		getServletContext().setAttribute("CCMSET", setting);
		CcmsUtil.init(setting);

		System.out.println("权限初始化加载完成！");
	}
}
