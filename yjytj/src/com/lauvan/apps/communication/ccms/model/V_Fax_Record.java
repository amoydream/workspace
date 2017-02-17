package com.lauvan.apps.communication.ccms.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "V_FAX_RECORD", pk = "CALLID")
public class V_Fax_Record extends Model<V_Fax_Record> {
	private static final long	serialVersionUID	= 1L;
	public static V_Fax_Record	dao					= new V_Fax_Record();

	public Page<Record> getPageList(Integer maxRecords, Integer page, String whereSql) {
		page = page == null || page < 1 ? 1 : page;
		maxRecords = maxRecords == null || maxRecords < 1 ? JFWebConfig.pageSize : maxRecords;
		String sql = "SELECT * ";
		StringBuffer sb = new StringBuffer();
		sb.append("FROM V_FAX_RECORD ");
		sb.append("WHERE 1 = 1 ");
		if(whereSql != null && !"".equals(whereSql)) {
			sb.append(whereSql);
		}

		return Db.paginate(page, maxRecords, sql, sb.toString());
	}
}