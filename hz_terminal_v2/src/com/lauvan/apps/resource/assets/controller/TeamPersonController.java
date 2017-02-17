package com.lauvan.apps.resource.assets.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.resource.assets.model.T_Bus_Team_Person;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;

/**
 * 民间组织人员信息
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/teamperson", viewPath="/resource/assets/team/person")
public class TeamPersonController extends BaseController{

	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String teaId = getPara(0);
		StringBuffer str = new StringBuffer();
		String sql = "t_bus_team_person where teamid="+teaId;
		str.append(sql);
		Page<Record> page = Paginate.dao.getPage(pageSize, pageNumber, str.toString(),
				null, null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void add(){
		String teaId = getPara(0);
		setAttr("tea_id", teaId);
		renderJsp("add.jsp");
	}
	
	public void save(){
		T_Bus_Team_Person info = getModel(T_Bus_Team_Person.class);
		boolean success = false;
		try {
			if(info.get("tpe_id") == null){
				String teaId = getPara(0); //获取队伍ID
				info.set("teamid", teaId);
				info.set("tpe_id", AutoId.nextval(info));
				success= info.save();
			}else{
				success = info.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "teamPersonDialog", "teamPersonGrid", "closeCurrent");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	 public void edit(){
			Integer id=getParaToInt(0);
			T_Bus_Team_Person model=T_Bus_Team_Person.dao.findById(id);
			setAttr("model", model);
			render("edit.jsp");
		}
	 
	 public void delete(){
			String[] ids = getParaValues("ids");
			Map<String, Object> tips = new HashMap<String, Object>();
			boolean success = false;
			String errorCode = "error";
			String msg = "";
			try {
				String idStr = ArrayUtils.ArrayToString(ids);
				T_Bus_Team_Person.dao.deleteByIds(idStr);
				errorCode = "info";
				success = true;
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
			} finally{
				tips.put("success", success);
				tips.put("errorCode", errorCode);
				tips.put("msg", msg);
				renderJson(tips);
			}
		}
	 
	 public void getview(){
			Integer id=getParaToInt(0);
			T_Bus_Team_Person model=T_Bus_Team_Person.dao.findById(id);
			setAttr("model", model);
			render("view.jsp");
		}
	
}
