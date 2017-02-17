<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	 
	 <form id="eventPlanform" method="post" action="<%=basePath %>Main/eventPlan/startPlanSave" style="width:100%;">
	    <input type="hidden" name="t_Bus_Presch_Instance.event_id" value="${e.id}"/>
	     <input type="hidden" name="t_Bus_Presch_Instance.plan_id" value="${p.id}"/>
	     <input type="hidden" name="t_Bus_Presch_Instance.marktime" value="${nowdate}"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		
	    		<tr>
		    	<td class="sp-td1">事件名称：</td>
		    	<td >
		    	<input type="text"  data-options="disabled:true" value="${e.ev_name}" class="easyui-textbox" style="width: 300px;"/>
		    	</td>
		    	</tr>
	    		
		    	<tr>
		    	<td class="sp-td1">预案名称：</td>
		    	<td >
		    		<input type="text" data-options="disabled:true" value="${p.preschname}" class="easyui-textbox" style="width: 300px;"/>
		    	</td>
		    	
		    	</tr>
	    		
		    	<tr>
		    	<td class="sp-td1">启动时间：</td>
		    	<td >
		    		<input type="text"  name="t_Bus_Presch_Instance.start_time"  class="easyui-datetimebox"   style="width: 300px;"  data-options="editable:false,required:true,icons:iconClear,value:'${nowdate}'"/>
		    	</td>
		    	</tr>
	    		
		    	<tr>
		    	<td class="sp-td1">启动说明：</td>
		    	<td >
		    	<textarea name="t_Bus_Presch_Instance.start_memo" class="textarea" 
		    		data-options="validType:'length[0,300]'"  style="width: 300px;height: 50px;" ></textarea>
		    	
		    	</td>
		    	
		    	
		    	</tr>
		    	
		    	
		    	
	    </table>
    </form>
