<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script>
    var basePath = '<%=basePath%>';
    $(function(){
    var caseAttrArray={
		idField:'CAS_ID',
		fitColumns : true,
	    toolbar: [
		  { text:'添加', title:'添加案例信息', iconCls: 'icon-add',
				dialogParams:{dialogId:'casesDialog', href:'<%=basePath%>Main/cases/add', 
				width:800, height:580, formId:'casesForm', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.casesAdd, loginModel.xdlimit)}'}, '-',
		  { text: '修改', title:'修改案例信息',iconCls: 'icon-pageedit',
					  dialogParams:{dialogId:'casesDialog',href:'<%=basePath%>Main/cases/edit',width:800,
					height:580,formId:'casesForm'},permitParams:'${pert:hasperti(applicationScope.casesEdit, loginModel.xdlimit)}'}, '-',
		  { text: '删除',iconCls: 'icon-delete',warnMsg:'确定要删除？',delParams:{url:'<%=basePath%>Main/cases/delete'},permitParams:'${pert:hasperti(applicationScope.casesDel, loginModel.xdlimit)}'}, '-',
		  {text :'查看', iconCls:'icon-eye', title:'查看案例', tabid:'casestabs',handler:'mainView',permitParams:'${pert:hasperti(applicationScope.casesView, loginModel.xdlimit)}'}
		],
		url:basePath+"Main/cases/getData",
		onDblClickRow: function(rowIndex, rowData){
			mainView();
		}
};
    $.lauvan.dataGrid("casesGrid",caseAttrArray);
});

    function cases_doSearch(){
	$('#casesGrid').datagrid('load',{
		caTitle: $('#caTitle').val(),
	});
}
    
    function findDanger(){
		var param = {
			title:'选择相关危险源',
			width:800,
			height:500,
			href:'<%=basePath%>Main/danger/getDanger',
			buttons:[{
				text:'确定',
				iconCls:'icon-save',
				handler: function(){
					var row = $("#selectDangerGrid").datagrid("getSelected");
					$("#dangerid").val(row.DANGERID);
					$("#dangername").textbox('setValue', row.DANGERNAME);
					$("#selectDangerDialog").dialog('close');
				}
			},{
				text:'关闭',
				iconCls:'icon-no',
				handler:function(){
					$("#selectDangerDialog").dialog('close');
				}

			}]
		};
		$.lauvan.openCustomDialog("selectDangerDialog", param, null, null);
	}

    function mainView(){
	var title = '查看详情';
	var mainTab = $("#mainTab");
	var row = $("#casesGrid").datagrid("getSelected");
	if(!row){
		$.lauvan.MsgShow({msg:'请选择相应的记录！'});
		return;
	}
	var url = "<%=basePath%>Main/cases/getview/" + row.CAS_ID;
		if (mainTab.tabs('exists', title)) {//如果查看组织详情的tab已经打开
			mainTab.tabs('select', title); //选中tab
			mainTab.tabs('getSelected').panel('refresh', url); //刷新tab

		} else {
			//新建查看组织详情的tab
			mainTab.tabs('add', {
				title : title,
				href : url,
				iconCls : 'icon-eye',
				closable : true

			});
		}
	}
</script>


<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false"
		style="padding: 5px;background:#f7f7f7;">
		<span>案例标题：</span> <input id="caTitle" type="text"
			class="easyui-textbox"> <a href="javascript:void(0);"
			class="easyui-linkbutton" onclick="cases_doSearch()"
			data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
		<table id="casesGrid" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="CAS_ID" data-options="hidden:true"></th>
					<th field="CODE" width="200">编号</th>
					<th field="TITLE" width="200">案例标题</th>
					<th field="ADDRESS" width="400">事发地址</th>
				</tr>
			</thead>
		</table>
	</div>
</div>





