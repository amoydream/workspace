package com.lauvan.apps.communication.ccms.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "T_CCMS_SEAT", pk = "SEAT_ID")
public class T_Ccms_Seat extends Model<T_Ccms_Seat> {
	private static final long		serialVersionUID	= 1L;
	public static final T_Ccms_Seat	dao					= new T_Ccms_Seat();

	public boolean delete(String ids) throws Exception {
		return Db.update("DELETE FROM T_CCMS_SEAT WHERE SEAT_ID IN (" + ids + ")") > 0;
	}

	public T_Ccms_Seat getSeat(Integer dept_id, String loginIP) {
		return T_Ccms_Seat.dao.findFirst("SELECT * FROM T_CCMS_SEAT WHERE DEPT_ID = " + dept_id + " AND LOGINIP = '" + loginIP + "'");
	}

	public Page<Record> getSeatPage(Integer pageSize, Integer pageNumber, Integer dept_id) {
		String select = "SELECT * ";
		StringBuffer str = new StringBuffer();
		str.append("FROM T_CCMS_SEAT ");
		if(dept_id != null) {
			str.append("WHERE DEPT_ID = " + dept_id + " ORDER BY PRIORITY");
		}

		return Db.paginate(pageNumber, pageSize, select, str.toString());
	}

	public String getDeptSeats(Integer dept_id) {
		String deptSeats = "";
		List<T_Ccms_Seat> list = T_Ccms_Seat.dao.find("SELECT * FROM T_CCMS_SEAT WHERE DEPT_ID = " + dept_id);
		if(list != null && list.size() > 0) {
			for(T_Ccms_Seat seat : list) {
				String seatID = seat.getStr("SEATID");
				deptSeats += "," + seatID;
			}
		}

		if(!"".equals(deptSeats)) {
			deptSeats = deptSeats.substring(1);
		}

		return deptSeats;
	}
}