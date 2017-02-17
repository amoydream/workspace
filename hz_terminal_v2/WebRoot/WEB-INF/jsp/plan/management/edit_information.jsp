<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	 <form id="planMgform" method="post" action="<%=basePath %>Main/planMg/save" style="width:100%;">
	    <input type="hidden" name="act" value="upd_pinformation"/>
	     <input type="hidden" name="t_Bus_PlanItem.preschid" value="${p.preschid}"/>
	     <input type="hidden" name="t_Bus_PlanItem.id" value="${p.id}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">通知单位：</td>
		    	<td>
		    		<input class="easyui-combotree" name="t_Bus_PlanItem.itemid" 
		    		data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get',editable:false,required:true,icons:iconClear,value:'${p.itemid}'" 
		    		style="width:180px;">
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		    	<td >
		    		<textarea name="t_Bus_PlanItem.itemcontent" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;">${p.itemcontent}</textarea> 
		    	</td>
		    	</tr>
	    </table>
    </form>