<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'FIRMID',
				fitColumns : true, 
				toolbar: [],
				frozenColumns:[[]],
				url:"<%=basePath%>Main/transfirm/getGridData",
			};
		$.lauvan.dataGrid("transfirmGird",attrArray);

		
	});
	
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="transfirmGird" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="FIRMID" data-options="hidden:true">ID</th> 
			            <th field="FIRMNAME" width="100">名称</th> 
			            <%--<th field="ADDRESS" width="150">地址</th>
			            <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别代码</th>
			            <th field="CLASSCODE" code="ZDFHMJDM" width="100">密级代码</th>
			            <th field="FAX" width="100">传真</th>
			            <th field="RESPPER" width="100">负责人</th>
			            <th field="RESPOTEL" width="130">负责人办公电话</th>
			            <th field="CONTACTPER" width="100">联系人</th>
			            <th field="CONTACTOTEL" width="130">联系人办公电话</th>
			        --%></tr> 
			    </thead> 
			</table> 
</div></div>
