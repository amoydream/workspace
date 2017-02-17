package com.lauvan.apps.communication.ccms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.ccms.model.T_Ccms_Seat;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "/Main/communication/ccms/seat", viewPath = "/communication/ccms/seat")
public class SeatController extends BaseController {
	public void index() {
		render("seat.jsp");
	}

	public void add() {
		Integer dept_id = getParaToInt(0);
		setAttr("dept_id", dept_id);
		setAttr("action", "add");
		render("form.jsp");
	}

	public void edit() {
		Integer id = getParaToInt(0);
		T_Ccms_Seat seat = T_Ccms_Seat.dao.findById(id);
		setAttr("seat", seat);
		setAttr("action", "edit");
		render("form.jsp");
	}

	public void save() {
		boolean success = false;
		String msg = "";
		String loginIP = getPara("loginIP");
		String seatIP = getPara("seatIP");
		String seatID = getPara("seatID");
		Integer priority = getParaToInt("priority");
		Integer seat_id = getParaToInt("seat_id");
		T_Ccms_Seat seat = null;

		seat = T_Ccms_Seat.dao.findFirst("SELECT * FROM T_CCMS_SEAT WHERE LOGINIP = '" + loginIP + "' AND SEATIP = '" + seatIP + "'");
		if(seat != null) {
			msg = "一个登陆IP只能对应一个坐席IP";
		} else {
			seat = T_Ccms_Seat.dao.findFirst("SELECT * FROM T_CCMS_SEAT WHERE LOGINIP = '" + loginIP + "' AND SEATID = '" + seatID + "'");
			if(seat != null) {
				msg = "一个登陆IP只能对应一个坐席号码";
			} else {
				boolean isNew = false;
				if(seat_id != null) {
					seat = T_Ccms_Seat.dao.findById(seat_id);
				} else {
					seat = getModel(T_Ccms_Seat.class);
					isNew = true;
				}

				seat.set("LOGINIP", loginIP);
				seat.set("SEATIP", seatIP);
				seat.set("SEATID", seatID);
				seat.set("PRIORITY", priority);

				try {
					if(isNew) {
						seat.set("SEAT_ID", AutoId.nextval(seat));
						seat.set("DEPT_ID", getParaToInt("dept_id"));
						success = seat.save();
					} else {
						success = seat.update();
					}
				} catch(Exception e) {
					msg = e.getMessage();
					e.printStackTrace();
				}
			}
		}

		renderText("{\"success\":" + success + ", \"msg\":\"" + msg + "\"}");
	}

	public void delete() {
		String[] idArr = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(idArr);
		Map<String, Object> result = new HashMap<String, Object>();
		boolean success = false;
		String msg = "删除成功";
		String errorCode = "info";
		try {
			success = T_Ccms_Seat.dao.delete(ids);
		} catch(Exception e) {
			errorCode = "error";
			msg = e.getMessage();
			e.printStackTrace();
		} finally {
			result.put("success", success);
			result.put("msg", msg);
			result.put("errorcode", errorCode);
			renderJson(result);
		}
	}

	public void getByDeptId() {
		Integer rows = getParaToInt("rows");
		Integer page = getParaToInt("page");
		Integer dept_id = getParaToInt("pid");
		Page<Record> recordPage = T_Ccms_Seat.dao.getSeatPage(rows, page, dept_id);

		List<Record> list = recordPage.getList();
		int totalCount = recordPage.getTotalRow();
		String json = JsonUtil.getGridData(list, totalCount);
		renderText(json);
	}
}
