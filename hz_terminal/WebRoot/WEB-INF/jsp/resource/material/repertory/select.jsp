<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script>
var basePath = '<%=basePath%>';
$(function(){
var attrArray={
		fitColumns : true,
		frozenColumns:[[]],
		idField:'REP_ID',
		url:basePath+"Main/repertory/getData"
};
$.lauvan.dataGrid("selectRepertoryGrid",attrArray);
});

function repertory_doSearch(){
	$('#selectRepertoryGrid').datagrid('load',{
		reName: $('#selectReName').val(),
	});
}

</script>


<div class="easyui-layout" data-options="fit:true">
	
	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>仓库名称：</span>
			<input id="selectReName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="repertory_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
	<table id="selectRepertoryGrid" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="REP_ID" data-options="hidden:true"></th>
					<th field="CODE" width="200">编号</th>
					<th field="NAME" width="200">仓库名称</th>
					<th field="LINKMANPHONE" width="400">联系人手机</th>
					<th field="ADDRESS" width="400">地址</th>
				</tr>
			</thead>
		</table>
	</div>
</div>





