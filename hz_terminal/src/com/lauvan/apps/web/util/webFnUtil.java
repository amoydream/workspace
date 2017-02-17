package com.lauvan.apps.web.util;

import java.util.List;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.web.manager.model.T_Bus_Channel;
import com.lauvan.apps.web.manager.model.T_Bus_Content;

public class webFnUtil {

	/**
	 * 返回内容列表
	 * @param pageSize --页大小
	 * @param pageNumber -- 页码
	 * @param channelid --栏目id
	 * @param contenttype 内容类型，1-普通，2-图文
	 * @return
	 */
	public static Page<Record> contents(Integer pageSize, Integer pageNumber, String channelpath, String contenttype) {
		String sqlWhere = null;
		if(null != contenttype && !"".equals(contenttype)) {
			sqlWhere = "contenttype = '" + contenttype + "' ";
		}
		T_Bus_Channel c = T_Bus_Channel.dao.findByPath(channelpath);
		Page<Record> page = T_Bus_Content.dao.getPage(pageSize, pageNumber, c.getBigDecimal("channelid").intValue(), null, sqlWhere, "releasedate", "desc");

		return page;
	}

	/**
	 * 默认获取显示的栏目
	 * @return
	 */
	public static List<T_Bus_Channel> channels(Integer parentid) {
		return T_Bus_Channel.dao.getList("1", parentid);//获取显示的栏目
	}
}
