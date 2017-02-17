<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script>
	var deptList=${deptJson};
	var zTree_user;
	var zNodes_user;
	var selectedNode_user;
	var setting_user = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick_user
		}
	};

	function zTreeOnClick_user(event, treeId, treeNode) {
		if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		}
		$('#_userlist_data').datagrid({url:'<%=basePath%>Main/user/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode_user=zTree_user.getSelectedNodes()[0];
		$("#_userlist_data").datagrid("clearSelections");
		$("#_userlist_data").datagrid("clearChecked");
	};

	function initTree_user(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/department/getTreeData',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		            zNodes_user = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_user!=null)
		            	zTree_user.destroy();
		            zTree_user =$.fn.zTree.init($("#deptTree"), setting_user, zNodes_user);
					if(!selectedNode_user){
						selectedNode_user=zTree_user.getNodeByParam("id", '0', null);
						if(selectedNode_user.children && selectedNode_user.children.length>0)
							selectedNode_user=selectedNode_user.children[0];
					}
		            zTree_user.selectNode(selectedNode_user);
		            zTree_user.expandNode(selectedNode_user, true, false, false);
		            zTree_user.setting.callback.onClick(null, zTree_user.setting.treeId, selectedNode_user);
		            
		        }  
		    });
		 
	}

	function refreshGrid(){
		zTree_user.setting.callback.onClick(null, zTree_user.setting.treeId, selectedNode_user);
	}
	
	$(function(){
		initTree_user();

		var attrArray={
				idField:'USER_ID',
				fitColumns : true, 
				toolbar: [
						  { text: '添加',title:'添加用户', iconCls: 'icon-add',  handler: addClick,permitParams:'${pert:hasperti(applicationScope.userAdd, loginModel.xdlimit)}'}, '-', 
						  { text: '修改', title:'修改用户',iconCls: 'icon-pageedit', handler: editClick,permitParams:'${pert:hasperti(applicationScope.userEdit, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',handler: deleteClick,permitParams:'${!loginModel.isAdmin && !loginModel.isSuper}'},'-',
						  { text: '导入',iconCls: 'icon-undo',handler: importClick,permitParams:'${pert:hasperti(applicationScope.userImport, loginModel.xdlimit)}'}
						]
			};
		$.lauvan.dataGrid("_userlist_data",attrArray);
	});

	function addClick(){

		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				href: '<%=basePath%>Main/user/add/'+zTree_user.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("addDialog",attrArray,function(){onSubmit($("#addDialog"));});
	}

	function editClick(){
		var row=$("#_userlist_data").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录!'});
			return;
		}

		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				href: '<%=basePath%>Main/user/edit/'+row.USER_ID
		};
		$.lauvan.openCustomDialog("editDialog",attrArray,function(){onSubmit($("#editDialog"));});
	}

	function deleteClick(){
		var rows=$("#_userlist_data").datagrid('getChecked');
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	var ids=[];
		        for(var i=0;i<rows.length;i++){
					ids[i]=rows[i]["USER_ID"];
				}
		        $.ajax({
	            	url:'<%=basePath%>Main/user/delete',
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'ids':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功！'});
	            			refreshGrid();
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}

	function importClick(){
		var options=$(this).linkbutton("options");
		var attrArray={
				title:'批量创建用户',
				iconCls:options.iconCls,
				href: '<%=basePath%>Main/user/importuser',
				buttons:[]
		};
		$.lauvan.openCustomDialog("importDialog",attrArray,null);
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
	
	function user_doSearch(){
		$('#_userlist_data').datagrid({url:'<%=basePath%>Main/user/getGridData'
			,queryParams:{uname: $('#username_yh').val(),uaccount: $('#useraccount_yh').val()}});
	}
	
	function formatUGRP(val, row) {
	    return val == 1 ? '技能组一' : val == 2 ? '技能组二' : '';
    }
	
	function formatOPLEVEL(val, row) {
	    return val == 2 ? '主管' : val == 1 ? '班长' : val == 0 ? '普通' : '';
    }
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true,border:false" style="width: 230px">
		<ul id="deptTree" class="ztree"></ul>
	</div>
	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>用户名称：</span>
			<input id="username_yh" type="text" class="easyui-textbox" >
			<span>用户账号：</span>
			<input id="useraccount_yh" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="user_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
	<div data-options="region:'center',border:false">
		<table id="_userlist_data" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="USER_ID" data-options="hidden:true">ID</th>
					<th field="USER_NAME" width="100">姓名</th>
					<th field="USER_ACCOUNT" width="100">登录帐号</th>
					<th field="DEPT_ID" width="150" data-options="formatter:formatDepartment">所属部门</th>
					<th field="SEATID" width="150">坐席编号</th>
					<th field="UGRPNO" width="150" data-options="formatter:formatUGRP">技能组</th>
					<th field="OPLEVEL" width="150" data-options="formatter:formatOPLEVEL">级别</th>
					<th field="CALLLEVEL" width="150">拨打权限</th>
					<th field="STATUS" width="100" data-options="formatter:formatStatus">状态</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
