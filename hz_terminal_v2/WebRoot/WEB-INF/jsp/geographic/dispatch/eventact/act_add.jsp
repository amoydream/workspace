<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	 <form id="actform1" method="post" action="<%=basePath%>Main/geographic/dispatch/saveEventAct" style="width:100%;">
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		    	<td class="sp-td1">行动名称：</td>
		    	<td>
		    		<input type="hidden" name="t_Bus_Event_PreschAction.preschid" value="${planid}"/> <!-- 预案 -->
		    		<input type="hidden" name="t_Bus_Event_PreschAction.actphase" value="${phaseid}"/> <!-- 阶段 -->
		    		<input type="hidden" name="t_Bus_Event_PreschAction.istempact" value="Y"/>
		    		<input type="hidden" name="t_Bus_Event_PreschAction.eventid" value="${eventid}"/><!-- 事件id -->
		    		<input type="hidden" name="t_Bus_Event_PreschAction.instid" value="${instid}"/><!-- 实例 -->
		    		<input  name="t_Bus_Event_PreschAction.actname" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/> 
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">行动代号：</td>
		    	<td>
		    		<input  name="t_Bus_Event_PreschAction.actcode" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/> 
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">执行序号：</td>
		    	<td >
			    	<input  name="t_Bus_Event_PreschAction.actorder" type="text" class="easyui-numberbox" data-options="required:true,min:0"  style="width: 180px;"/>     
				</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">内容：</td>
		    	<td >
		    		<textarea name="t_Bus_Event_PreschAction.actcont" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;"></textarea> 
		    	</td>
		    	</tr>
	    </table>
    </form>