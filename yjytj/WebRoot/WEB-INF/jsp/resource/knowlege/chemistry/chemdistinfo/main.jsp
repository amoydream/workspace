<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	var chemdistinfoEditor;
	$(function(){
		var attrArray={
				idField:'ID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加危化品应急处置信息', iconCls: 'icon-add', handler:addChemdist}, '-',
						  { text: '修改', title:'修改危化品应急处置信息',iconCls: 'icon-pageedit',handler:editChemdist}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/chemdistinfo/delete'}} ,'-',
						  { text: '查看', iconCls: 'icon-eye', title:'查看危化品详情', handler:'chemdistinfoView', url:''}
						],
				url:"<%=basePath%>Main/chemdistinfo/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					chemdistinfoView();
				}
			};
		$.lauvan.dataGrid("chemdistinfo_data",attrArray);
	});
	function chemdistSeach(){
		$("#chemdistinfo_data").datagrid('load',{
			chemdistname: $("#chemdistname").textbox('getValue')
		});
	}

	function addChemdist(){
		var para = {
			title: '添加危化品应急处置信息',
			width:670, 
			height:580,
			href :'<%=basePath%>Main/chemdistinfo/add',
			onClose: function(){
				//if(chemdistinfoEditor != null &&
				//		chemdistinfoEditor != undefined){
				//	chemdistinfoEditor.blur();
				//}
				KindEditor.remove('textarea[name="t_Bus_Chemdistinfo.distway"]');
				$(this).dialog('destroy');
				$("#chemdistinfoDialog").remove();
			}

		};
		$.lauvan.openCustomDialog("chemdistinfoDialog", para, null, "form1");
	}

	function editChemdist(){
		var options = $(this).linkbutton("options");
		var row = $("#chemdistinfo_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var para = {
			title: options.title,
			iconCls: options.iconCls,
			href:'<%=basePath%>Main/chemdistinfo/edit/' + row.ID,
			width:670,
			height:580,
			onClose:function(){
				//if(chemdistinfoEditor != null &&
				//		chemdistinfoEditor != undefined){
				//	chemdistinfoEditor.blur();
				//}
				KindEditor.remove('textarea[name="c.content"]');
				$(this).dialog('destroy');
				$("#chemdistinfoDialog").remove();
			}
		};
		$.lauvan.openCustomDialog("chemdistinfoDialog", para, null, "form1");
	}
	
	function chemdistinfoView(){
		var row = $("#chemdistinfo_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg: '请选择相应的记录！'});
			return ;
		}
		var para ={
				title: '危化品应急处置详情',
				height: 500,
				width: 670,
				href:'<%=basePath%>Main/chemdistinfo/view/' +row.ID,
				buttons:[]
				};
		$.lauvan.openCustomDialog("chemdistinfoDialog",para,null,null);		
	}
	
	</script>
		<div id="cheminfo_box" class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
				<span >危化品名称：</span>
				<input id="chemdistname" type="text" class="easyui-textbox" style="width:150px;"/>
				<a href="javascript:chemdistSeach();" class="easyui-linkbutton" data-options="iconCls:'icon-search', plain:true">查询</a>
			</div>
			<div data-options="region:'center', border:false">
			<table id="chemdistinfo_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ID" data-options="hidden:true">ID</th> 
			            <th field="CHEMNAME" width="100">化学品名称</th>
			            <th field="COLUMN1" width="100">化学品俗称</th>
			            <th field="CHEMNAMEEN" width="100">化学品英文名称</th>
			            <th field="ACHEMLIASEN" width="100">化学品英文简称</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
