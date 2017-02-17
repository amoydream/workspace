<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript">
	$(document).ready(function(){
		var attrArray={
				toolbar: '#duser_tb',
				fitColumns : true,
				idField:'ID',
				rownumbers:false, 
				frozenColumns:[[]],
				url:"<%=basePath%>Main/driver/getSelectData"
	    };
		$.lauvan.dataGrid("usersGrid",attrArray);
		
	});

</script>


<div class="pageContent" style="background: #eef4f5; padding: 0;">
	<div >
			<div id="userBox" style="margin-left:246px; height:410px;margin: 5px;">
			<table id="usersGrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="100px">姓名</th> 
			            <th field="SEX" width="100px">性别</th> 
			            <th field="TYPE" width="100px">准驾车型</th> 		          
			            <th field="TEL" width="100px">电话</th> 		          
			        </tr> 
			    </thead> 
			</table>
			</div>
		<div style="clear: both;" /></div>
</div>


