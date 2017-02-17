<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	
	$(function(){
		var attrArray={
				idField:'ID',
				toolbar: [
						  { text: '添加',title:'添加模块', iconCls: 'icon-add',
							   dialogParams:{dialogId:'modelDialog',href:'<%=basePath%>Main/module/add',width:700,
								height:480,defVal:0,formId:'form1'}}, '-', 
						  { text: '修改', title:'修改模块',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'modelDialog',href:'<%=basePath%>Main/module/edit',width:700,
									height:480,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/module/delete'}}
						],
				fitColumns : true, 
				frozenColumns:[[  {field:'ck',checkbox:true} ]],
				pagination:false,//分页控件
				treeField:'NAME',
				url:"<%=basePath%>Main/module/getGridData",
				onBeforeExpand:function(row){
					//动态设置展开查询的参数
			        $("#module_data").treegrid("options").queryParams = {"pid":row.ID};  
			        return true;
				}
			};
		$.lauvan.treeGrid("module_data",attrArray);
		
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

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="module_data" class="easyui-treegrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ID" data-options="hidden:true">ID</th> 
			            <th field="NAME" width="180">模块名称</th> 
			            <th field="MARK" width="100">模块标识</th> 
			            <th field="ADDRESS" width="300">模块地址</th> 
			            <th field="ORDERINDEX" width="100">顺序</th> 
			            <th field="USABLE" width="100" data-options="formatter:formatStatus">状态</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

