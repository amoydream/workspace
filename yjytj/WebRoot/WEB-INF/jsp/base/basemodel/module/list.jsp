<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>功能模块</title>
	<%@ include file="/include/header.jsp"%>
	<script>
	var selectedTreeNodeId=null;
	function zTreeOnClick(event, treeId, treeNode) {
		$('#list_data').datagrid({url:'<%=basePath%>Main/module/getGridData',queryParams:{pid:treeNode.id}});
		selectedTreeNodeId=$.fn.zTree.getZTreeObj("moduleTree").getSelectedNodes()[0].id;
		$("#list_data").datagrid("options").toolbar[0].dialogParams.outerParam=selectedTreeNodeId;
		$("#list_data").datagrid("clearSelections");
		$("#list_data").datagrid("clearChecked");
	};

	function initTree(){
		$.lauvan.initTree("moduleTree","<%=basePath%>Main/module/getTreeData",
				 selectedTreeNodeId,zTreeOnClick);
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'ID',
				toolbar: [
						  { text: '添加',title:'添加模块', iconCls: 'icon-add', dialogParams:{dialogId:'addDialog',href:'<%=basePath%>Main/module/add',width:700,
								height:400,firstFn:function(){onSubmit($("#addDialog"));}}}, '-', 
						  { text: '修改', title:'修改模块',iconCls: 'icon-pageedit',dialogParams:{dialogId:'editDialog',href:'<%=basePath%>Main/module/edit',width:700,
									height:400,firstFn:function(){onSubmit($("#editDialog"));}}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/module/delete',successFn:initTree}}
						]
			};
		$.lauvan.dataGrid("list_data",attrArray);
		
	});

	function formatStatus(val,row){
		if(val=='1')
			return '启用';
		else if(val=='0')
			return '禁用';
		else
			return val;
	}
	</script>
  </head>
  
 <body>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="moduleTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',border:false">
			<table id="list_data" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="ID" data-options="hidden:true">ID</th> 
			            <th field="MARK" width="100">模块标识</th> 
			            <th field="NAME" width="180">模块名称</th> 
			            <th field="ADDRESS" width="300">模块地址</th> 
			            <th field="ORDERINDEX" width="100">顺序</th> 
			            <th field="USABLE" width="100" data-options="formatter:formatStatus">状态</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

</body>
</html>
