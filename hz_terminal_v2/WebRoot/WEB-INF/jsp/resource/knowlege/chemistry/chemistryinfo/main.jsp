<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'CHEMID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加危化品信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'cheminfoDialog', href:'<%=basePath%>Main/chemistryinfo/add/', 
								width:770, height:480, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改危化品信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'cheminfoDialog',href:'<%=basePath%>Main/chemistryinfo/edit',width:780,
									height:480,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',warnMsg:'您确定删除该危化品信息及其相关信息吗？',delParams:{url:'<%=basePath%>Main/chemistryinfo/delete'}} ,'-',
						  { text: '查看', iconCls: 'icon-eye', title:'查看危化品详情', handler:'cheminfoView', url:''}
						],
				url:"<%=basePath%>Main/chemistryinfo/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					cheminfoView();
				}
			};
		$.lauvan.dataGrid("cheminfo_data",attrArray);
		//var html = $("#selectbox").html();
		//$("#selectbox").empty();
		//$(html).prependTo("#cheminfo_box .datagrid-toolbar table tbody tr");
	});

	function chemSeach(){
		$("#cheminfo_data").datagrid('load',{
			colName: $("#colName").combobox('getValue'),
			colVal: $("#colVal").textbox('getValue')
		});
	}

	function cheminfoView(){
		//var options = $(this).linkbutton("options");
		var title = "查看危化品详情";
		var mainTab = $("#mainTab");
		var row = $("#cheminfo_data").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg: '请选择相应的记录！'});
			return ;
		}
		var url = "<%=basePath%>Main/chemistryinfo/view/" + row.CHEMID;
		if(mainTab.tabs('exists', title)){
			mainTab.tabs('select', title);
			mainTab.tabs('getSelected').panel('refresh', url);
		}else{
			mainTab.tabs('add', {
				title: title,
				href:url,
				iconCls: 'icon-eye',
				closable:true

			});
		}

	}
	
	</script>
		<div id="cheminfo_box" class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
				<span >按：</span><select id="colName" class="easyui-combobox" data-options="panelHeight:130">
					<option value="casno">casno</option>
					<option value="chemname">化学品名称</option>
					<option value="column1">化学品俗称</option>
					<option value="chemnameen">化学品英文名称</option>
					<option value="achemliasen">化学品英文简称</option>
				</select>
				<input id="colVal" type="text" class="easyui-textbox" style="width:150px;"/>
				<a href="javascript:chemSeach();" class="easyui-linkbutton" data-options="iconCls:'icon-search', plain:true">查询</a>
			</div>
			<div data-options="region:'center', border:false">
			<table id="cheminfo_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="CHEMID" data-options="hidden:true">ID</th> 
			            <th field="CASNO" width="100">CASNO</th> 
			            <th field="CHEMNAME" width="100">化学品名称</th>
			            <th field="COLUMN1" width="100">化学品俗称</th>
			            <th field="CHEMNAMEEN" width="100">化学品英文名称</th>
			            <th field="ACHEMLIASEN" width="100">化学品英文简称</th>
			            <th field="MOLEFORM" width="100">分子式</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
