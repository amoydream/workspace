package com.lauvan.apps.dailymanager.report.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

/**
 * @author Bob
 * 要情快报表
 */
@TableBind(name = "t_bus_report", pk = "r_id")
public class T_Bus_Report extends Model<T_Bus_Report> {
	private static final long	serialVersionUID	= 1L;
	public static T_Bus_Report	dao					= new T_Bus_Report();

	/**
	 * 删除快报
	 *
	 * @param    ids    快报id
	 * @return
	 */
	public boolean delete(Integer[] ids) throws Exception {
		try {
			boolean flag = false;
			for(Integer id : ids) {
				flag = dao.deleteById(id);
			}
			return flag;
		} catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
	}

}
