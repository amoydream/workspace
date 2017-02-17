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
		idField:'MF_ID',
		fitColumns : true,
	    toolbar: [
		  { text:'添加', title:'添加物资生产企业', iconCls: 'icon-add',
				dialogParams:{dialogId:'mafirmDialog', href:'<%=basePath%>Main/materialfirm/add', 
				width:800, height:580, formId:'mafirmAdd', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.mafirmAdd, loginModel.xdlimit)}'}, '-',
		  { text: '修改', title:'修改物资生产企业',iconCls: 'icon-pageedit',
					  dialogParams:{dialogId:'mafirmDialog',href:'<%=basePath%>Main/materialfirm/edit',width:800,
					height:580,formId:'mafirmEdit'},permitParams:'${pert:hasperti(applicationScope.mafirmEdit, loginModel.xdlimit)}'}, '-',
		  { text: '删除',iconCls: 'icon-delete',warnMsg:'确定要删除？',delParams:{url:'<%=basePath%>Main/materialfirm/delete'},permitParams:'${pert:hasperti(applicationScope.mafirmDel, loginModel.xdlimit)}'}, '-',
		  {text :'查看', iconCls:'icon-eye', title:'查看企业', tabid:'mafirmtabs',handler:'view',permitParams:'${pert:hasperti(applicationScope.mafirmView, loginModel.xdlimit)}'}
		],
		url:basePath+"Main/materialfirm/getData",
		onDblClickRow: function(rowIndex, rowData){
			view();
		}
};
$.lauvan.dataGrid("mafirmGrid",attrArray);
});

function mafirm_doSearch(){
	$('#mafirmGrid').datagrid('load',{
		mfName: $('#mfName').val(),
	});
}

function view(){
	var title = '查看详情';
	var mainTab = $("#mainTab");
	var row = $("#mafirmGrid").datagrid("getSelected");
	if(!row){
		$.lauvan.MsgShow({msg:'请选择相应的记录！'});
		return;
	}
	var url = "<%=basePath%>Main/materialfirm/getview/" + row.MF_ID;
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
			<span>企业名称：</span>
			<input id="mfName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="mafirm_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
	    <div data-options="region:'center',border:false">
		<table id="mafirmGrid" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="MF_ID" data-options="hidden:true"></th>
					<th field="MF_NAME" width="200">企业名称</th>
					<th field="MFTYPE" width="100" CODE="ORGA">企业类型</th>
					<th field="LINKMAN" width="100">联系人</th>
					<th field="LINKMANPHONE" width="100">联系人手机</th>
					<th field="ADDRESS" width="400">地址</th>
				</tr>
			</thead>
		</table>
	</div>
</div>





