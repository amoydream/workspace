package com.lauvan.apps.communication.ccms.model;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.apps.communication.ccms.util.CcmsUtil;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.util.ArrayUtils;

@TableBind(name = "T_FAX_RECORD", pk = "CALLID")
public class T_Fax_Record extends Model<T_Fax_Record> {
	private static final long	serialVersionUID	= 1L;
	public static T_Fax_Record	dao					= new T_Fax_Record();

	public Map<String, Object> delete(String[] idArr, String user_id) {
		Map<String, Object> result = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		try {
			String ids = ArrayUtils.ArrayToString(idArr);
			String sql = "FROM T_FAX_RECORD WHERE CALLID IN (" + ids + ") AND USER_ID = " + user_id;
			if(user_id == null) {
				sql = "FROM T_FAX_RECORD WHERE CALLID IN (" + ids + ")";
			}
			List<T_Fax_Record> list = T_Fax_Record.dao.find("SELECT * " + sql);
			if(user_id != null && list.size() == 0) {
				errorCode = "error";
				msg = "只能删除自己的传真记录";
			} else {
				if(list.size() < idArr.length) {
					msg = "只删除了自己的传真记录";
				}
				success = Db.update("DELETE " + sql) > 0;
				try {
					for(T_Fax_Record rec : list) {
						String RECDFILE = rec.get("RECDFILE");
						if(RECDFILE != null) {
							File recdFile = new File("Y".equals(rec.get("SENDER")) ? CcmsUtil.FAXS_SHPATH : CcmsUtil.FAXR_SHPATH + "\\" + RECDFILE);
							if(recdFile.exists()) {
								recdFile.delete();
							}
						}
					}
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		} catch(Exception e) {
			success = false;
			errorCode = "error";
			msg = e.getMessage();
			e.printStackTrace();
		}

		result.put("success", success);
		result.put("msg", msg);
		result.put("errorcode", errorCode);
		return result;
	}
}
