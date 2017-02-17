<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'TRANSTYPEID',
				fitColumns : true, 
				toolbar: [],
				frozenColumns:[[]],
				url:"<%=basePath%>Main/transtype/getGridData",
				
			};
		$.lauvan.dataGrid("transtypeGrid",attrArray);

	});
	</script>
			 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="transtypeGrid" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="TRANSTYPEID" data-options="hidden:true">ID</th> 
			            <th field="TRANSTYPE" width="100">运输工具型号</th> 
			            <th field="PRODUCEVENDER" width="100">生产企业</th><%--
			            <th field="TRANSLOAD" width="100">载重</th>
			            <th field="USEFUEL" width="100">使用燃料</th>
			            <th field="TRANSWAYNAME" width="100">运输方式</th>
			        --%></tr> 
			    </thead> 
			</table> 
</div></div>
