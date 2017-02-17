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
		idField:'REP_ID',
		fitColumns : true,
		toolbar: [
				  { text:'添加', title:'添加仓库信息', iconCls: 'icon-add',
						dialogParams:{dialogId:'repertoryDialog', href:'<%=basePath%>Main/repertory/add', 
						width:800, height:560, formId:'repertoryAdd', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.repertoryAdd, loginModel.xdlimit)}'}, '-',
				  { text: '修改', title:'修改仓库信息',iconCls: 'icon-pageedit',
							  dialogParams:{dialogId:'repertoryDialog',href:'<%=basePath%>Main/repertory/edit',width:800,
							height:560,formId:'repertoryEdit'},permitParams:'${pert:hasperti(applicationScope.repertoryEdit, loginModel.xdlimit)}'}, '-',
				  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/repertory/delete'},permitParams:'${pert:hasperti(applicationScope.repertoryDel, loginModel.xdlimit)}'}
				],
		url:'<%=basePath%>Main/repertory/getData',
		 onDblClickRow: function(rowIndex, rowData){
				view();
			}
};
$.lauvan.dataGrid("repertoryGrid",attrArray);
});


function repertory_doSearch(){
	$('#repertoryGrid').datagrid('load',{
		reName: $('#reName').val(),
	});
}

function view(){
	var row = $("#repertoryGrid").datagrid('getSelected');
	if(!row){
		$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
		return;
	}

	var para = {
		title: '详情',
		height: 560,
		width: 700,
		href:'<%=basePath%>Main/repertory/getview/' +row.REP_ID,
		buttons:[]
	};
	$.lauvan.openCustomDialog("viewDialog",para,null,null);		
}

</script>


<div class="easyui-layout" data-options="fit:true">
	
	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>仓库名称：</span>
			<input id="reName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="repertory_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
	<table id="repertoryGrid" cellspacing="0" cellpadding="0">
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





