<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	$(function(){
		var attrArray={
				toolbar: [
		                   { text: '添加',title:'添加组织机构', iconCls: 'icon-add',
			                   dialogParams:{dialogId:'departDialog',href:'<%=basePath%>Main/department/add',
			                   defVal:0,formId:'form1'}}, '-', 
		                   { text: '修改',title:'修改组织机构',iconCls: 'icon-pageedit', 
				                   dialogParams:{dialogId:'departDialog',href:'<%=basePath%>Main/department/edit'
					                   ,formId:'form1'}}, '-',
		                   { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/department/delete'}
					                   ,permitParams:'${!loginModel.isAdmin && !loginModel.isSuper}'}
		                  ],
				fitColumns : true,
				idField:'D_ID',    
			    treeField:'D_NAME',
			    pagination:false,
				url:"<%=basePath%>Main/department/getGridData"
        };
		$.lauvan.treeGrid("departTree",attrArray);
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

 <div class="easyui-layout"  data-options="fit:true">
		
		<div data-options="region:'center',border:false">	
			<table id="departTree" class="easyui-treegrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="D_ID" data-options="hidden:true">部门ID</th> 
			            <th field="D_NAME" width="25%">部门名称</th>
			            <th field="D_NUMBER" width="25%">部门编码</th>
			            <th field="D_PID" data-options="hidden:true">上级部门ID</th>
			            <th field="D_TYPE" width="25%" data-options="formatter:formatDeptType">部门类别</th>
			            <th field="SEATIDS" width="25%">坐席</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>


