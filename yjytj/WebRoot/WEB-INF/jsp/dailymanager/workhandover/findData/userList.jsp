<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$(function(){
	var attrArray={
			toolbar: '#user_tb',
			fitColumns : true,
			idField:'ID',
			rownumbers:false, 
			frozenColumns:[[]],
			url:"<%=basePath%>Main/workhandover/getuserbyname"
    };
	$.lauvan.dataGrid("usersGrid",attrArray);
	
});
function doSearch(){
	$('#usersGrid').datagrid('load',{
		name: $('#name').val()		
	});
}
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'center',border:false">
<div id="user_tb">
		<span>接班人:</span>
		<input id="name" type="text" class="easyui-textbox">		
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>	 
			<table id="usersGrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="USER_ID" width="100px" data-options="hidden:true">ID</th> 
			            <th field="USER_NAME" width="200px">接班人</th> 		          
			        </tr> 
			    </thead> 
			</table> 
		</div>
		</div>


