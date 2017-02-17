package com.lauvan.apps.web.front;

import com.jfinal.kit.StrKit;
import com.lauvan.apps.web.manager.model.T_Bus_Channel;
import com.lauvan.apps.web.manager.model.T_Bus_Content;
import com.lauvan.apps.web.util.NumberTool;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;

@RouteBind(path = "/front",viewPath="web/front")
public class FrontController extends BaseController{

	public void index(){
		String[] paths=getRequest().getAttribute("paths").toString().split("/");
		
		T_Bus_Channel channel=T_Bus_Channel.dao.findByPath(paths[0]);
		
		setAttr("href", getRequest().getRequestURI());
		setAttr("pageNo", NumberTool.toPositiveInt(getPara("pageNumber"), 1));
		
		if(channel!=null){
			String channelTpl=channel.getStr("channeltpl");
			String channelFolder="channel";
			if(StrKit.isBlank(channelTpl)){
				channelTpl="default.jsp";
			}
			channelTpl=channelFolder+"/"+channelTpl;
			
			setAttr("c", channel);
			setAttr("chaNodeList", channel.getNodeList());
			System.out.println(channel.getNodeList());
			
			if(paths.length>1 && NumberTool.isPositiveInt(paths[1])){
				Integer id=Integer.valueOf(paths[1]);
				
				T_Bus_Content con=T_Bus_Content.dao.getById(id);
				if(con!=null){
					setAttr("con", con);
					renderJsp("content/index.jsp");
				}else{
					renderText("您所查看的内容不存在！");
				}
				return;
			}
			renderJsp(channelTpl);
		}else{
			renderJsp("default.jsp");
		}
	}
}
