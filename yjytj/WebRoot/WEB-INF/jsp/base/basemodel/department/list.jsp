<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>部门列表</title>
	<%@ include file="/include/header.jsp"%>
	<script>

	var selectedTreeNodeId=null;
	function zTreeOnClick(event, treeId, treeNode) {
		$('#list_data').datagrid({url:'<%=basePath%>Main/department/getGridData',queryParams:{pid:treeNode.id}});
		selectedTreeNodeId=$.fn.zTree.getZTreeObj("deptTree").getSelectedNodes()[0].id;
		$("#list_data").datagrid("options").toolbar[0].dialogParams.outerParam=selectedTreeNodeId;
		$("#list_data").datagrid("clearSelections");
		$("#list_data").datagrid("clearChecked");
	};

	function initTree(){
		 $.lauvan.initTree("deptTree","<%=basePath%>Main/department/getTreeData",
				 selectedTreeNodeId,zTreeOnClick);
	}

	function initDataGrid(){
		var attrArray={
				idField:'D_ID',
				toolbar: [
		                   { text: '添加',title:'添加组织机构', iconCls: 'icon-add',dialogParams:{dialogId:'addDialog',href:'<%=basePath%>Main/department/add',firstFn:function(){onSubmit($("#addDialog"));}}}, '-', 
		                   { text: '修改',title:'修改组织机构',iconCls: 'icon-pageedit', dialogParams:{dialogId:'editDialog',href:'<%=basePath%>Main/department/edit',firstFn:function(){onSubmit($("#editDialog"));}}}, '-',
		                   { text: '删除',iconCls: 'icon-delete', delParams:{url:'<%=basePath%>Main/department/delete',successFn:initTree}}
		                  ]
        };
		$.lauvan.dataGrid("list_data",attrArray);
	}
	
	$(function(){
		$.lauvan.initTree("deptTree","<%=basePath%>Main/department/getTreeData",
				 selectedTreeNodeId,zTreeOnClick,initDataGrid);
	});

	function formatDeptType(val,row){
		if(val=='0')
			val='市';
		else if(val=='1')
			val='区';
		else if(val=='2')
			val='县';
		else if(val=='3')
			val='镇';
		return val;
	}
	</script>
  </head>
  
 <body>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="deptTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',border:false">
			<table id="list_data" cellspacing="0" cellpadding="0" style="display:none;"> 
			    <thead> 
			        <tr> 
			            <th field="D_ID" width="100" data-options="hidden:true">部门ID</th> 
			            <th field="D_NAME" width="250">部门名称</th> 
			            <th field="D_NUMBER" width="100">部门编码</th> 
			            <th field="D_PID" width="100" data-options="hidden:true">上级部门ID</th> 
			            <th field="D_TYPE" width="100" data-options="formatter:formatDeptType">部门类别</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

</body>
</html>
