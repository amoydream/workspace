package com.lauvan.apps.autocreate.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.autocreate.model.T_AutoAttr;
import com.lauvan.apps.autocreate.model.T_AutoAttr_Ext;
import com.lauvan.apps.autocreate.model.T_AutoView;
import com.lauvan.apps.autocreate.utils.AutoCreate;
import com.lauvan.apps.autocreate.utils.UIutils;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/autoView",viewPath="/autoCreate/view")
public class AutoViewController extends BaseController {
	public void index(){
		render("main.jsp");
	}
	
	public void  getDataGrid(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String viewName = getPara("viewName");
		String objName = getPara("objName");
		StringBuffer str = new StringBuffer();
		if(viewName!=null && !"".equals(viewName)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append("  view_name like '%").append(viewName).append("%'");
		}
		if(objName!=null && !"".equals(objName)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append("  lower(data_source) like '%").append(objName.toLowerCase()).append("%'");
		}
		Page<Record> page=Paginate.dao.getPage("t_autoview", pageSize, pageNumber, str.toString(), "id", null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void getGridDataView(){
		String viewid = getPara("id");
		List<Record> list = T_AutoAttr_Ext.dao.getExtList(viewid);
		String json=JsonUtil.getGridData(list, list.size());
		renderText(json);
	}
	
	public void getSource(){
		render("source.jsp");
	}
	public void getSourceData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String objName = getPara("objName");
		String objCode = getPara("objCode");
		StringBuffer str = new StringBuffer();
		if(objName!=null && !"".equals(objName)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append("  table_name like '%").append(objName).append("%'");
		}
		if(objCode!=null && !"".equals(objCode)){
			if(str.length()>0){
				str.append(" and ");
			}
			str.append(" table_code like '%").append(objCode).append("%'");
		}
		Page<Record> page=Paginate.dao.getPage("t_autotable", pageSize, pageNumber, str.toString(), "id", null);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void getAttrData(){
		String tcode = getPara("tcode");
		List<Record> list = T_AutoAttr.dao.getListByCode(tcode);
		String json=JsonUtil.getGridData(list, list.size());
		renderText(json);
	}
	
	public void add(){
		render("add.jsp");
	}
	
	public void edit(){
		render("edit.jsp");
	}
	
	public void delete(){
		String id = getPara("id");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		try {
			T_AutoView view = T_AutoView.dao.findById(id);
			if(view!=null){
				//删除控件记录
				T_AutoAttr_Ext.dao.deleteByView(id);
				//删除页面
				T_AutoView.dao.deleteView(view);
				//删除view
				success = view.delete();
				msg = "删除成功！";
			}else{
				errorCode="error";
				msg = "该视图不存在，请检查！";
			}
		} catch (Exception e) {
			errorCode="error";
			msg=e.getMessage();
			e.printStackTrace();
		}finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
	
	public void save(){
		boolean success = true;
		try {
			T_AutoView view = getModel(T_AutoView.class);
			String[] viewType = getParaValues("viewType");
			if(viewType!=null && viewType.length>0){
				view.set("view_type", ArrayUtils.ArrayToString(viewType));
			}
			String[] viewlayout = getParaValues("viewlayout");
			if(viewlayout!=null && viewlayout.length>0){
				view.set("view_layout", ArrayUtils.ArrayToString(viewlayout));
			}
			String jsppath = view.getStr("view_path");
			String packpath = view.getStr("pack_path");
			//保存数据
			T_AutoView.dao.insert(view);
			Integer fnum = getParaToInt("fnum");
			List<T_AutoAttr_Ext> addlist = new ArrayList<T_AutoAttr_Ext>();
			List<T_AutoAttr_Ext> editlist = new ArrayList<T_AutoAttr_Ext>();
			List<T_AutoAttr_Ext> gridlist = new ArrayList<T_AutoAttr_Ext>();
			List<T_AutoAttr_Ext> searchlist = new ArrayList<T_AutoAttr_Ext>();
			for(int i=0;i<fnum;i++){
				T_AutoAttr_Ext e = new T_AutoAttr_Ext();
				String uitype = getPara("_uitype_"+i);
				String isview = getPara("_isview_"+i);
				String issearch = getPara("_issearch_"+i);
				String isadd = getPara("_isadd_"+i);
				String isedit = getPara("_isedit_"+i);
				e.set("filedcode", getPara("_attrcode_"+i));
				e.set("filedtext", getPara("_attrtext_"+i));
				e.set("uitype", uitype);
				e.set("issearch", issearch);
				e.set("isadd", isadd);
				e.set("isedit", isedit);
				e.set("isview",isview);
				e.set("uival", getPara("_uival_"+i));
				e.set("staticval", getPara("_staticval_"+i));
				e.set("deafulval", getPara("_deafulval_"+i));
				e.set("viewid", view.get("id"));
				e.set("attrid", getPara("_attrid_"+i));
				T_AutoAttr_Ext.dao.insert(e);
				if("1".equals(isview)){
					gridlist.add(e);
				}
				if(uitype!=null && !"".equals(uitype) && "1".equals(issearch)){
					searchlist.add(e);
				}
				if(uitype!=null && !"".equals(uitype) && "1".equals(isadd)){
					addlist.add(e);
				}
				if(uitype!=null && !"".equals(uitype) && "1".equals(isedit)){
					editlist.add(e);
				}
			}
			Integer num = getParaToInt("fcol_num");
			String name = view.getStr("data_source");
			//根据配置新建jsp页面
			if(jsppath!=null && !"".equals(jsppath)){
				T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("jsp", "AUTO");
				String file = p.getStr("p_acode");
				for(int j=0;j<viewType.length;j++){
					String tab = viewType[j];
					StringBuffer str = new StringBuffer();
					if("00M".equals(tab)){//主页
						for(int k=0;k<viewlayout.length;k++){
							String wh = getPara("viewWH_"+viewlayout[k]);
							if("north".equals(viewlayout[k])){
								str.append(UIutils.getNorthUI(wh));
							}else if("south".equals(viewlayout[k])){
								str.append(UIutils.getSouthUI(wh));
							}else if("west".equals(viewlayout[k])){
								str.append(UIutils.getWestUI(wh));
							}else if("east".equals(viewlayout[k])){
								str.append(UIutils.getEastUI(wh));
							}else{
								str.append(UIutils.getCenterUI());
								if(searchlist!=null && searchlist.size()>0){
									getSearchUI(str,searchlist);
								}
								if(gridlist!=null && gridlist.size()>0){
									getGridUI(str,gridlist,name);
								}
								str.append("</div>");
							}
						}
					}else if("00A".equals(tab)){//新增页面
						if(addlist !=null && addlist.size()>0){
							getFormUI(str,addlist,name+"_form",num,tab,name,null);
						}
					}else{//修改页面
						if(addlist !=null && addlist.size()>0){
							String var = getPara("varval");
							getFormUI(str,addlist,name+"_form",num,tab,name,var);
						}
					}
					//创建页面
					AutoCreate.createJSP(file, tab, jsppath, str.toString(), view.getStr("view_name"));
				}
			}
			//创建controller
			if(packpath!=null && !"".equals(packpath)){
				T_Sys_Parameter p2 = T_Sys_Parameter.dao.getByCode("controller", "AUTO");
				String file2 = p2.getStr("p_acode");
				String cname = view.getStr("controller");
				AutoCreate.createController(file2, cname.replaceFirst(cname.substring(0, 1), cname.substring(0, 1).toUpperCase()),
						packpath, name, jsppath, "Main/"+cname,view.getStr("view_name"));
			}
		} catch (Exception e) {
			success = false;
			e.printStackTrace();
		}
		if(success){
			toDwzText(success, "保存成功！", "", "autoViewDialog", "autoViewtable", "closeCurrent");
		}else{
			toDwzText(success, "保存失败！", "", "", "", "");
		}
	}
	
	//预览
	public void view(){
		T_AutoView view = getModel(T_AutoView.class);
		String[] viewType = getPara("viewType").split(",");
		if(viewType!=null && viewType.length>0){
			view.set("view_type", ArrayUtils.ArrayToString(viewType));
		}
		String[] viewlayout = getPara("viewlayout").split(",");
		if(viewlayout!=null && viewlayout.length>0){
			view.set("view_layout", ArrayUtils.ArrayToString(viewlayout));
		}
		Integer fnum = getParaToInt("fnum");
		Integer num = getParaToInt("fcol_num");
		String name = view.getStr("data_source");
		List<T_AutoAttr_Ext> addlist = new ArrayList<T_AutoAttr_Ext>();
		List<T_AutoAttr_Ext> editlist = new ArrayList<T_AutoAttr_Ext>();
		List<T_AutoAttr_Ext> gridlist = new ArrayList<T_AutoAttr_Ext>();
		List<T_AutoAttr_Ext> searchlist = new ArrayList<T_AutoAttr_Ext>();
		for(int i=0;i<fnum;i++){
			T_AutoAttr_Ext e = new T_AutoAttr_Ext();
			String uitype = getPara("_uitype_"+i);
			String isview = getPara("_isview_"+i);
			String issearch = getPara("_issearch_"+i);
			String isadd = getPara("_isadd_"+i);
			String isedit = getPara("_isedit_"+i);
			e.set("uitype", uitype);
			e.set("filedcode", getPara("_attrcode_"+i));
			e.set("filedtext", getPara("_attrtext_"+i));
			e.set("issearch", issearch);
			e.set("isadd", getPara("_isadd_"+i));
			e.set("isedit", getPara("_isedit_"+i));
			e.set("isview", isview);
			e.set("uival", getPara("_uival_"+i));
			e.set("staticval", getPara("_staticval_"+i));
			e.set("deafulval", getPara("_deafulval_"+i));
			if("1".equals(isview)){
				gridlist.add(e);
			}
			if(uitype!=null && !"".equals(uitype) && "1".equals(issearch)){
				searchlist.add(e);
			}
			if(uitype!=null && !"".equals(uitype) && "1".equals(isadd)){
				addlist.add(e);
			}
			if(uitype!=null && !"".equals(uitype) && "1".equals(isedit)){
				editlist.add(e);
			}
		}
		for(int j=0;j<viewType.length;j++){
			String tab = viewType[j];
			StringBuffer str = new StringBuffer();
			if("00M".equals(tab)){//主页
				for(int k=0;k<viewlayout.length;k++){
					String wh = getPara("viewWH_"+viewlayout[k]);
					if("north".equals(viewlayout[k])){
						str.append(UIutils.getNorthUI(wh));
					}else if("south".equals(viewlayout[k])){
						str.append(UIutils.getSouthUI(wh));
					}else if("west".equals(viewlayout[k])){
						str.append(UIutils.getWestUI(wh));
					}else if("east".equals(viewlayout[k])){
						str.append(UIutils.getEastUI(wh));
					}else{
						str.append(UIutils.getCenterUI());
						if(searchlist!=null && searchlist.size()>0){
							getSearchUI(str,searchlist);
						}
						if(gridlist!=null && gridlist.size()>0){
							getGridUI(str,gridlist,name);
						}
						str.append("</div>");
					}
				}
				setAttr("zytab",str.toString());
			}else if("00A".equals(tab)){//新增页面
				StringBuffer str2 = new StringBuffer();
				if(addlist !=null && addlist.size()>0){
					getFormUI(str2,addlist,name+"_form",num,tab,name,null);
					setAttr("xztab",str2.toString());
				}
			}else{//修改页面
				StringBuffer str3 = new StringBuffer();
				if(addlist !=null && addlist.size()>0){
					String var = getPara("varval");
					getFormUI(str3,addlist,name+"_form",num,tab,name,var);
					setAttr("xgtab",str3.toString());
				}
			}
		}
		render("view.jsp");
	}
	/**
	 * 创建检索控件
	 * @param str 			拼接控件语句
	 * @param searchlist 	检索控件数组
	 * */
	public void getSearchUI(StringBuffer str ,List<T_AutoAttr_Ext> searchlist){
		str.append("<div style=\"margin-top: 5px;margin-left: 5px;\">");
		for(T_AutoAttr_Ext sext: searchlist){
			String text = sext.getStr("filedtext");
			String textcode = sext.getStr("filedcode")+"_ser";
			String uitype_ser = sext.getStr("uitype");
			str.append(text).append("：");
			if("001".equals(uitype_ser)){
				str.append(UIutils.getDateUI(textcode,"150px",null));
			}else if("002".equals(uitype_ser)){
				str.append(UIutils.getInputUI(textcode,"150px",null));
			}else if("003".equals(uitype_ser)){
				String attrcode = sext.getStr("staticval");
				if(attrcode!=null && !"".equals(attrcode)){
					str.append(UIutils.getComboxUI(textcode, "80px", attrcode, null));
				}else{
					String option = sext.get("uival")==null?"":sext.getStr("uival");
					String opval = sext.get("deafulval")==null?"":sext.getStr("deafulval");
					str.append(UIutils.getComboxUI(textcode, "80px", option.split(","), opval.split(","),null));
				}
			}else if("004".equals(uitype_ser)){
				String val = sext.getStr("deafulval");
				String coption = sext.getStr("uival");
				str.append(UIutils.getCheckboxUI(textcode, val, coption,null));
			}else if("005".equals(uitype_ser)){
				String val = sext.getStr("deafulval");
				String coption = sext.getStr("uival");
				str.append(UIutils.getRadioUI(textcode, val, coption,null));
			}else{
				str.append(UIutils.getTextUI(textcode, "80%", "50px",null));
			}
		}
		str.append("<a href=\"javascript:void(0);\" class=\"easyui-linkbutton\"  data-options=\"iconCls:'icon-search',plain:true\">查询</a>");
		str.append("</div>");
	}
	
	/**
	 * 创建datagrid控件
	 * @param str 			拼接控件语句
	 * @param gridlist 	表格控件数组
	 * */
	public void getGridUI(StringBuffer str ,List<T_AutoAttr_Ext> gridlist,String name){
		StringBuffer fileds = new StringBuffer();
		StringBuffer ftexts = new StringBuffer();
		StringBuffer widths = new StringBuffer();
		StringBuffer codes = new StringBuffer();
		for(T_AutoAttr_Ext ext: gridlist){
			String filed = ext.getStr("filedcode").toUpperCase();
			String ftext = ext.getStr("filedtext");
			String code = ext.getStr("staticval");
			fileds.append(",").append(filed);
			ftexts.append(",").append(ftext);
			codes.append(",").append(code);
			widths.append(",150");
		}
		String grid = UIutils.getDatagridUI(name+"_grid", fileds.substring(1).split(",")
				, ftexts.substring(1).split(","), widths.substring(1).split(","), codes.substring(1).split(","));
		str.append(grid);
	}
	/**
	 * 创建表单控件
	 * @param str 			拼接控件语句
	 * @param formlist 		表单控件数组
	 * */
	public void getFormUI(StringBuffer str ,List<T_AutoAttr_Ext> formlist,String id,Integer num,
						String act,String name,String var){
		//默认一行2个属性
		if(num==null){
			num = 2;
		}
		//第一个字母小写
		name = name.replaceFirst(name.substring(0, 1), name.substring(0, 1).toLowerCase());
		str.append("<form id=\"").append(id);
		str.append("\" method=\"post\" action=\"\" style=\"width:100%;margin: 0 auto;padding: 0;\">");
		if("00A".equals(act)){
			str.append("<input type=\"hidden\" name=\"act\" value=\"add\"/>");
		}else{
			str.append("<input type=\"hidden\" name=\"act\" value=\"upd\"/>");
			str.append("<input type=\"hidden\" name=\"_updid\" value=\"${").append(var).append(".id}\"/>");
		}
		str.append("<table class=\"sp-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">");
		for(int i=0;i<formlist.size();i++){
			if(i%num==0){
				str.append("<tr>");
			}
			T_AutoAttr_Ext sext =  formlist.get(i);
			String text = sext.getStr("filedtext");
			String textcode = name+"."+sext.getStr("filedcode");
			String varval = var==null?null:(var+"."+sext.getStr("filedcode").toLowerCase());
			String uitype_ser = sext.getStr("uitype");
			str.append("<td class=\"sp-td1\">").append(text).append("：").append("</td>");
			str.append("<td>");
			if("001".equals(uitype_ser)){
				str.append(UIutils.getDateUI(textcode,"150px",varval));
			}else if("002".equals(uitype_ser)){
				str.append(UIutils.getInputUI(textcode,"150px",varval));
			}else if("003".equals(uitype_ser)){
				String attrcode = sext.getStr("staticval");
				if(attrcode!=null && !"".equals(attrcode)){
					str.append(UIutils.getComboxUI(textcode, "80px", attrcode, varval));
				}else{
					String option = sext.get("uival")==null?"":sext.getStr("uival");
					String opval = sext.get("deafulval")==null?"":sext.getStr("deafulval");
					str.append(UIutils.getComboxUI(textcode, "80px", option.split(","), opval.split(","),varval));
				}
			}else if("004".equals(uitype_ser)){
				String val = sext.getStr("deafulval");
				String coption = sext.getStr("uival");
				str.append(UIutils.getCheckboxUI(textcode, val, coption,varval));
			}else if("005".equals(uitype_ser)){
				String val = sext.getStr("deafulval");
				String coption = sext.getStr("uival");
				str.append(UIutils.getRadioUI(textcode, val, coption,varval));
			}else{
				str.append(UIutils.getTextUI(textcode, "80%", "50px",varval));
			}
			str.append("</td>");
			if(i%num==(num-1)){
				str.append("</tr>");
			}
		}
		str.append("</table>");
		str.append("</form>");
	}
}
