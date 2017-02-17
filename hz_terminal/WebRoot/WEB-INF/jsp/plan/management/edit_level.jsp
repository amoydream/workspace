<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	 <form id="planMgform" method="post" action="<%=basePath %>Main/planMg/save" style="width:100%;">
	    <input type="hidden" name="act" value="upd_plevel"/>
	    <input type="hidden" name="t_Bus_PlanItem.id" value="${p.id}"/>
	     <input type="hidden" name="t_Bus_PlanItem.preschid" value="${p.preschid}"/>
	      <input type="hidden" name="t_Bus_PlanItem.planitemcode" value="${p.planitemcode}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<c:if test="${p.planitemcode=='1010'}">
		    	<tr>
		    	<td class="sp-td1">事件类型：</td>
		    	<td>
		    		<input class="easyui-combotree" name="t_Bus_PlanItem.itemid" 
		    		data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,required:true,icons:iconClear,value:'${p.itemid}'" style="width:180px;">
		    	</td>
		    	</tr>
		    	</c:if>
		    	<c:if test="${p.planitemcode=='8010'}">
		    	<tr>
		  		<td class="sp-td1">事件级别：</td>
		    	<td >
			    	<select class="easyui-combobox" name="t_Bus_PlanItem.itemid"  panelHeight="auto" 
			    	code="EVLV" style="width: 180px;" data-options="editable:false,required:true,icons:iconClear,value:'${p.itemid}'" ></select>    
				</td>
		    	</tr>
		    	</c:if>
		    	<tr>
		  		<td class="sp-td1">详情：</td>
		    	<td >
		    		<textarea name="t_Bus_PlanItem.itemcontent" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;">${p.itemcontent}</textarea> 
		    	</td>
		    	</tr>
	    </table>
    </form>