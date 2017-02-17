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
		idField:'SHE_ID',
		fitColumns : true,
		toolbar: [
				
				],
		url:basePath+"Main/shelter/getData/${deptid}",
		 onDblClickRow: function(rowIndex, rowData){
				view();
			}
};
$.lauvan.dataGrid("shelterGrid2",attrArray);
});

function shelter_doSearch(){
	$('#shelterGrid2').datagrid('load',{
		shName: $('#shName2').val(),
	});
}

function view(){
	var row = $("#shelterGrid2").datagrid('getSelected');
	if(!row){
		$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
		return;
	}

	var para = {
		title: '详情',
		height: 560,
		width: 700,
		href:'<%=basePath%>Main/shelter/view/' +row.SHE_ID,
		buttons:[]
	};
	$.lauvan.openCustomDialog("viewDialog",para,null,null);		
}

</script>


<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>场所名称：</span>
			<input id="shName2" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="shelter_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
	    <div data-options="region:'center',border:false">
		<table id="shelterGrid2" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="SHE_ID" data-options="hidden:true"></th>
					<th field="CODE" width="200">编号</th>
					<th field="NAME" width="200">庇护场所名称</th>
					<th field="ADDRESS" width="400">地址</th>
				</tr>
			</thead>
		</table>
	</div>
</div>





