<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


	<script>

	
	$(function(){
		var attrArray={
			idField:'ROLE_ID',
			toolbar: [
					  { text: '添加',title:'添加角色', iconCls: 'icon-add',
						  dialogParams:{dialogId:'roleDialog',href:'<%=basePath%>Main/role/add',
							  defVal:'0',formId:'form1'}}, '-', 
					  { text: '修改', title:'修改角色',iconCls: 'icon-pageedit', handler: editClick}, '-',
					  { text: '删除',iconCls: 'icon-delete',handler: deleteClick},'-',
					  { text: '权限分配', iconCls: 'icon-groupedit',handler: authAssignClick },'-',
					  { text: '用户分配',iconCls: 'icon-userkey', handler: userAssignClick}
					],
			fitColumns : true, 
			frozenColumns:[[  {field:'ck',checkbox:true} ]],
			treeField:'ROLE_NAME',
			url:"<%=basePath%>Main/role/getGridData?suporg=${suporg}"
		};
		$.lauvan.treeGrid("rolelist_data",attrArray);
		//$.parser.parse();
	});


	function editClick(){
		var row=$("#rolelist_data").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录!'});
			return;
		}
		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				href: '<%=basePath%>Main/role/edit/'+row.ROLE_ID
		};
		$.lauvan.openCustomDialog("roleDialog",attrArray,null,"form1");
	}

	function deleteClick(){
		var rows=$("#rolelist_data").treegrid('getChecked');
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据！'});
			return;
		}
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	var ids=[];
		        for(var i=0;i<rows.length;i++){
					ids[i]=rows[i]["ROLE_ID"];
				}
		        $.ajax({
	            	url:'<%=basePath%>Main/role/delete',
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'ids':ids},
	            	success:function(data){
	            		if(data.success){
							$.lauvan.MsgShow({msg:'数据删除成功！'});
							$("#rolelist_data").treegrid('clearSelections');
							$("#rolelist_data").treegrid('clearChecked');
							$("#rolelist_data").treegrid('reload'); 
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}

	function authAssignClick(){
		var row = $("#rolelist_data").treegrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择相应记录！'});
			return;
		}

		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title?options.title:row.ROLE_NAME+" "+options.text,
				iconCls:options.iconCls,
				width: 800,
			    height: 450,
			    maximized:true,
				href: '<%=basePath%>Main/role/authAssign/'+row.ROLE_ID
		};
		$.lauvan.openCustomDialog("authAssignDialog",attrArray,function(){onSubmit($("#authAssignDialog"));});

	}

	function userAssignClick(){
		var row=$("#rolelist_data").datagrid("getSelected");
		if(!row){
			$.messager.show({title:'提示',msg:'请选择相应的记录！',timeout:1000,showType:'fade',style:{right:'',bottom:''}});
			return;
		}

		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title?options.title:row.ROLE_NAME+" "+options.text,
				iconCls:options.iconCls,
				width: 800,
			    height: 450,
			    maximized:true,
			    href: '<%=basePath%>Main/role/userAssign/'+row.ROLE_ID
		};
		$.lauvan.openCustomDialog("userAssignDialog",attrArray,function(){onSubmit($("#userAssignDialog"));});

	}

	function formatStatus(val,row){
		return val==1?'启用':'禁用';
	}

	function formatDepartment(val,row){
		for(var i=0;i<deptList.length;i++){
			if(val==deptList[i].D_ID)
				return deptList[i].D_NAME;
		}
	}

	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="rolelist_data"  class="easyui-treegrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ROLE_ID"  data-options="hidden:true">ID</th> 
			            <th field="ROLE_NAME" width="150">角色名称</th>
			            <th field="ROLE_DESCRIPTION" width="300">角色描述</th> 
			            <th field="STATUS" width="80" data-options="formatter:formatStatus">状态</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

