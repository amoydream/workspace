<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script>
	
	$(function(){
		var attrArray={
				idField:'TEA_ID',
				fitColumns : true, 
				toolbar: [
						  { text:'添加', title:'添加队伍', iconCls: 'icon-add',
								dialogParams:{dialogId:'teamDialog', href:'<%=basePath%>Main/team/add', 
								width:800, height:580, formId:'form1', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.teamAdd, loginModel.xdlimit)}'}, '-',
						  { text: '修改', title:'修改队伍',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'teamDialog',href:'<%=basePath%>Main/team/edit',width:800,
									height:580,formId:'form1'},permitParams:'${pert:hasperti(applicationScope.teamEdit, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',warnMsg:'注意！该队伍的人员配置和装备配置信息也将被删除',delParams:{url:'<%=basePath%>Main/team/delete'},permitParams:'${pert:hasperti(applicationScope.teamDel, loginModel.xdlimit)}'}, '-',
						  {text :'查看', iconCls:'icon-eye', title:'查看队伍', tabid:'civitabs',url:'<%=basePath%>Main/team/view',handler:'viewFn',permitParams:'${pert:hasperti(applicationScope.teamView, loginModel.xdlimit)}'}
						],
				url:"<%=basePath%>Main/team/getGridData",
				onDblClickRow: function(rowIndex, rowData){
					viewFn();
				}
			};
		$.lauvan.dataGrid("teamGrid",attrArray);
	//	var html = $("#civi_tb").html();
	//	$("#civi_tb").empty();
	//	$(html).prependTo("#civi_box .datagrid-toolbar table tbody tr");
	
	});

	function viewFn(){
		var title = '查看队伍';
		var mainTab = $("#mainTab");
		var row = $("#teamGrid").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择相应的记录！'});
			return;
		}
		var url = "<%=basePath%>Main/team/getview/" + row.TEA_ID;
		if(mainTab.tabs('exists', title)){//如果查看队伍详情的tab已经打开
			mainTab.tabs('select', title); //选中tab
			mainTab.tabs('getSelected').panel('refresh', url); //刷新tab

		}else{
			//新建查看队伍详情的tab
			mainTab.tabs('add', {
				title: title,
				href: url,
				iconCls: 'icon-eye',
				closable: true

			});
		}
	}

	function teamSearch(){
		$("#teamGrid").datagrid('load',{
			teName: $("#teName").val()
			});
	}

	</script>

<div id="team_box" class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false"
		style="padding: 5px;background:#f7f7f7;">
		<span>队伍名称：</span> <input id="teName" type="text"
			class="easyui-textbox" /> <a href="javascript:teamSearch();"
			class="easyui-linkbutton"
			data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
		<table id="teamGrid" cellspacing="0" cellpadding="0" width="100%">
			<thead>
				<tr>
					<th field="TEA_ID" data-options="hidden:true">ID</th>
					<th field="NAME" width="100">队伍名称</th>
					<th field="TYPE" CODE="YJDW" width="100">类别</th>
					<th field="LINKMAN" width="100">联系人</th>
					<th field="LINKMANPHONE" width="100">联系人手机</th>
				</tr>
			</thead>
		</table>
	</div>
</div>

