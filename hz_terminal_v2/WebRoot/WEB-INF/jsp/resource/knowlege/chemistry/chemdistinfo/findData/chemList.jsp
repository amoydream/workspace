<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'CHEMID',
				fitColumns : true, 
				toolbar: [],
				frozenColumns:[[]],
				url:"<%=basePath%>Main/chemistryinfo/getGridData",
			};
		$.lauvan.dataGrid("chemdistGird",attrArray);

		
	});
	
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="chemdistGird" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="CHEMID" data-options="hidden:true">ID</th> 
			            <th field="CHEMNAME" width="100">危化品名称</th> 
			           </tr> 
			    </thead> 
			</table> 
</div></div>
