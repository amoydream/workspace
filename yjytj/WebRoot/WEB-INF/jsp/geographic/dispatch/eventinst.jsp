<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={
			fitColumns : true,
			idField:'ID',
			singleSelect: true,
			url:basePath+"Main/geographic/dispatch/getEventList",
			onDblClickRow:function(rowIndex, rowData){
				goEventPlan(rowData.ID, rowData.NUM);
			}
		};
		
		$.lauvan.dataGrid("eventinstGrid",attrArray);
	});

	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="eventinstGrid" cellspacing="0" cellpadding="0"  data-options="fit:true"> 
			    <thead> 
			        <tr> 
			            <th field="EV_NAME" width="150">事件名称</th> 
			            <th field="EV_TYPE" width="100" CODE="EVTP" >事件类型</th>
			            <th field="EV_LEVEL" width="150" CODE="EVLV">事件级别</th>
			            <th field="EV_DATE" width="100"  >事发时间</th>
			            <th field="EV_STATUS" width="100" CODE="EVST" >事件状态</th>
			            <th field="MARKTIME" width="100"  >登记时间</th>
			        </tr> 
			    </thead> 
			</table> 
			</div>
		</div>

