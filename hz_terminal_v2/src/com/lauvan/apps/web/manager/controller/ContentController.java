package com.lauvan.apps.web.manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.web.manager.model.T_Bus_Content;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;
/**
 * 网站内容管理
 * @author zhouyuanhuan
 *
 */
@RouteBind(path="Main/content", viewPath="/web/manager/content")
public class ContentController extends BaseController{

	public void index(){
		List<Record> channelList = Paginate.dao.getList("t_bus_channel", "1=1 order by priority ");
		setAttr("channelList", channelList);
		renderJsp("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		Integer channelid = getParaToInt(0)==null?0:getParaToInt(0);
		String caption = getPara("caption");
		Page<Record> page = T_Bus_Content.dao.getPage(pageSize, pageNumber, channelid, caption, null, "isrecommend", "desc");
		String jsonStr = JsonUtil.getGridData(page.getList(), page.getTotalRow());
		renderText(jsonStr);
	}
	
	public void add(){
		Integer id = getParaToInt(0,0);
		if(id != 0){
			setAttr("channelid", id);
		}
		renderJsp("add.jsp");
	}
	
	public void edit(){
		Integer id = getParaToInt(0);
		T_Bus_Content c = T_Bus_Content.dao.getById(id);
		setAttr("c", c);
		renderJsp("edit.jsp");
	}
	
	public void save(){
		T_Bus_Content content = getModel(T_Bus_Content.class, "c");
		boolean success = false;
		try {
			content.set("isrecommend" , null == getPara("c.isrecommend")?0:getPara("c.isrecommend")); //是否推荐
			//判断文章类型
			if("1".equals(content.getStr("contenttype")) &&
					content.get("imageid") != null){
				T_Attachment.dao.deleteByIds(content.get("imageid").toString()); //如果类型为普通，则将附件删除
				content.set("imageid", null);//设置为空
			}
			
			if(content.get("contentid") == null){
				LoginModel login = getSessionAttr("loginModel");
				content.set("releaseuid", login.getUserId()); //内容发布人
				success = T_Bus_Content.dao.insert(content);
			}else{
				T_Bus_Content c = T_Bus_Content.dao.findById(content.get("contentid"));
				if(c.get("imageid") != null && 
						(content.get("imageid") == null || 
								!c.get("imageid").toString().equals(content.get("imageid").toString()))){ //如果是新上传的图片，则删除旧图片
					T_Attachment.dao.deleteByIds(c.get("imageid").toString()); //删除图片
				}
				success = content.update();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(success){
				toDwzText(success, "保存成功！", "", "contentDialog", "content_data", "closeCurrent");
			}else{
				toDwzText(success, "保存异常！", "", "", "", "");
			}
		}
	}
	
	public void delete(){
		Integer[] ids=getParaValuesToInt("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			T_Bus_Content.dao.del(ids); //删除内容
			success = true;
			errorCode = "info";
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
}
