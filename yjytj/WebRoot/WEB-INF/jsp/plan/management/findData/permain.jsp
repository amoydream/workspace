<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'TPE_ID',
				fitColumns : true, 
				url:"<%=basePath%>Main/teamperson/getGridData/${team.tea_id}"
			};
		$.lauvan.dataGrid("teamPersonGrid",attrArray);

	});
	

	</script>

			<table id="teamPersonGrid" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ID" data-options="hidden:true">ID</th> 
			            <th field="TPE_NAME" width="100">人员姓名</th>
			            <th field="SEX" width="100" CODE="SEX">性别</th> 
			            <th field="PHONE" width="100">手机</th>
			        </tr> 
			    </thead> 
			</table> 

