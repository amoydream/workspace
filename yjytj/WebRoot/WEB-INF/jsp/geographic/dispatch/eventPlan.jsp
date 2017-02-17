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
			checkbox:false,
			url:basePath+"Main/geographic/dispatch/getEventPlanList?eventid=${eventid}",
			onDblClickRow:function(rowIndex, rowData){
				$("#eventinstdialog2").dialog('destroy');
				$("#eventinstDialog").dialog('destroy');
				parent.$("#gisiframe").attr("src", 
						basePath+"Main/geographic/dispatch/main?eventid=${eventid}&instid=" + 
						rowData.ID +"&planid="+rowData.PLAN_ID);
			}
		};
		
		$.lauvan.dataGrid("eventPlanGrid2",attrArray);
	});

	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
				<table id="eventPlanGrid2" cellspacing="0" cellpadding="0"> 
							    <thead> 
							        <tr> 
							            <th field="PLANNAME" width="150">预案名称</th> 
							            <th field="START_TIME" width="100"  >启动时间</th>
							            <th field="START_MAN" width="100" >启动人</th>
							            <th field="START_MEMO" width="150"  >启动说明</th>
							        </tr> 
							    </thead> 
							</table>
			</div>
		</div>

