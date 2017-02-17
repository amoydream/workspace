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
		idField:'EG_ID',
		fitColumns : true,
	    toolbar: [
		  { text:'添加', title:'添加专家组信息', iconCls: 'icon-add',
				dialogParams:{dialogId:'exgroupDialog', href:'<%=basePath%>Main/expertgroup/add', 
				width:800, height:580, formId:'exgroupAdd', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.exgroupAdd, loginModel.xdlimit)}'}, '-',
		  { text: '修改', title:'修改专家组信息',iconCls: 'icon-pageedit',
					  dialogParams:{dialogId:'exgroupDialog',href:'<%=basePath%>Main/expertgroup/edit',width:800,
					height:580,formId:'exgroupEdit'},permitParams:'${pert:hasperti(applicationScope.exgroupEdit, loginModel.xdlimit)}'}, '-',
		  { text: '删除',iconCls: 'icon-delete',warnMsg:'确定要删除？',delParams:{url:'<%=basePath%>Main/expertgroup/delete'},permitParams:'${pert:hasperti(applicationScope.exgroupDel, loginModel.xdlimit)}'}, '-',
		  {text :'查看', iconCls:'icon-eye', title:'查看专家组', tabid:'exgrouptabs',handler:'view',permitParams:'${pert:hasperti(applicationScope.exgroupView, loginModel.xdlimit)}'}
		],
		url:basePath+"Main/expertgroup/getData",
		onDblClickRow: function(rowIndex, rowData){
			view();
		}
};
$.lauvan.dataGrid("exgroupGrid",attrArray);
});

function exgroup_doSearch(){
	$('#exgroupGrid').datagrid('load',{
		egName: $('#egName').val(),
	});
}

function view(){
	var title = '查看详情';
	var mainTab = $("#mainTab");
	var row = $("#exgroupGrid").datagrid("getSelected");
	if(!row){
		$.lauvan.MsgShow({msg:'请选择相应的记录！'});
		return;
	}
	var url = "<%=basePath%>Main/expertgroup/getview/" + row.EG_ID;
	if(mainTab.tabs('exists', title)){//如果查看组织详情的tab已经打开
		mainTab.tabs('select', title); //选中tab
		mainTab.tabs('getSelected').panel('refresh', url); //刷新tab

	}else{
		//新建查看组织详情的tab
		mainTab.tabs('add', {
			title: title,
			href: url,
			iconCls: 'icon-eye',
			closable: true

		});
	}
}


</script>


<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>专家组名称：</span>
			<input id="egName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="exgroup_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
	    <div data-options="region:'center',border:false">
		<table id="exgroupGrid" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="EG_ID" data-options="hidden:true"></th>
					<th field="EG_NAME" width="200">专家组名称</th>
					<th field="EGTYPE" width="200" CODE="EGTYPE">类型</th>
					<th field="NUM" width="400">人员数</th>
				</tr>
			</thead>
		</table>
	</div>
</div>





