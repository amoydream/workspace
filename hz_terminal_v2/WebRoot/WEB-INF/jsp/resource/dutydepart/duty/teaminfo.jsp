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
						 
						],
				url:"<%=basePath%>Main/team/getGridData/${deptid}",
				onDblClickRow: function(rowIndex, rowData){
				//	viewFn();
				}
			};
		$.lauvan.dataGrid("teamGrid2",attrArray);
	//	var html = $("#civi_tb").html();
	//	$("#civi_tb").empty();
	//	$(html).prependTo("#civi_box .datagrid-toolbar table tbody tr");
	
	});

	function viewFn(){
		var title = '查看队伍';
		var mainTab = $("#mainTab");
		var row = $("#teamGrid2").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择相应的记录！'});
			return;
		}
		var url = "<%=basePath%>Main/team/view/" + row.TEA_ID;
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
		$("#teamGrid2").datagrid('load',{
			teName: $("#teName2").val()
			});
	}

	</script>

<div id="team_box" class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false"
		style="padding: 5px;background:#f7f7f7;">
		<span>队伍名称：</span> <input id="teName2" type="text"
			class="easyui-textbox" /> <a href="javascript:teamSearch();"
			class="easyui-linkbutton"
			data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
		<table id="teamGrid2" cellspacing="0" cellpadding="0" width="100%">
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

