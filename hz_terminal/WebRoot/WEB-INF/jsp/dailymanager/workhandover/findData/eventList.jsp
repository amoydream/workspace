<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$(function(){
	var attrArray={
			toolbar: '#event_tb',
			fitColumns : true,
			idField:'ID',
			rownumbers:false, 
			frozenColumns:[[]],
			url:"<%=basePath%>Main/workhandover/geteventbyname?eventids=${eventids}"
    };
	$.lauvan.dataGrid("eventGrid",attrArray);
	
});
function doSearch(){
	$('#eventGrid').datagrid('load',{
		ename: $('#ename').val()		
	});
}
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'center',border:false">
<div id="event_tb">
		<span>事件:</span>
		<input id="ename" type="text" class="easyui-textbox">		
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>	 
			<table id="eventGrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ID" width="100px" data-options="hidden:true">ID</th> 
			            <th field="EV_NAME" width="200px">事件名称</th> 	
			            <th field="EV_ADDRESS" width="200px">事发地点</th>	  
			            <th field="EV_DATE" width="200px">事发时间</th>	        
			        </tr> 
			    </thead> 
			</table> 
		</div>
		</div>


