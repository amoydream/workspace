<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


	<script>
	var basePath = '<%=basePath%>';
	var zTree_data;
	var zNodes_data;
	var selectedNode_data;
	var setting_data = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_data
		}
	};

	function zTreeOnClick_data(event, treeId, treeNode) {
		if(treeNode.id==0){
			return;
		}
		$('#list_data').datagrid({url:'<%=basePath%>Main/dataService/getDataGrid/'+treeNode.id});
		selectedNode_data=zTree_data.getSelectedNodes()[0];
		$("#list_data").datagrid("clearSelections");
		$("#list_data").datagrid("clearChecked");
	};
	var zNodes_data =[
				{ id:"0", pid:"0", name:"组织机构",open:true}
	     		<c:forEach items="${deptTree}" var="organ" varStatus="vx">
	     		,{ id:"${organ.d_id}", pid:"${empty organ.d_pid ? 0 : organ.d_pid}", name:"${organ.d_name}"
	     		}
	     		</c:forEach>	
	     	];
	$(function(){
		//生成树
		$.fn.zTree.init($("#deptTreedemo"), setting_data, zNodes_data);
		zTree_data = $.fn.zTree.getZTreeObj('deptTreedemo');
		var attrArray={
				idField:'ID',
				fitColumns : true,
				toolbar: [
						  { text: '配置', iconCls: 'icon-add',handler:dataServiceSet}, '-', 
						  { text: '删除',iconCls: 'icon-delete',handler:delDataService}
						]
			};
		$.lauvan.dataGrid("list_data",attrArray);
		zTree_data.selectNode(zTree_data.getNodeByParam("id", '${apId}', null));	
	});

	function dataServiceSet(){
		var dept = "";
		if(selectedNode_data==null){
			dept='${apId}';
		}else{
			dept = selectedNode_data.id;
		}
		var row = $("#list_data").datagrid("getSelected");
		if(row){
			var attrArray={
					title:'配置数据权限',
					width: 400,
					height: 350,
					queryParams:{deptid:dept},
					href: basePath+"Main/dataService/dataRole/"+row.ID
			};
			$.lauvan.openCustomDialog("dataserviceDialog",attrArray,null,"dataserviceform");
		}else{
			$.lauvan.MsgShow({msg:'请选择相应的记录！'});
		}
	}

	function delDataService(){
		var rows=$("#list_data").datagrid('getChecked');
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲清除的数据!'});
			return;
		}
		$.messager.confirm("清除",'您确定清除选择的数据吗？',function(r){
		    if (r){
		    	var ids=[];
		        for(var i=0;i<rows.length;i++){
					ids[i]=rows[i].ID;
				}
		        var dept = "";
				if(selectedNode_data==null){
					dept='${apId}';
				}else{
					dept = selectedNode_data.id;
				}
		       $.ajax({
	            	url:basePath+"Main/dataService/delete",
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'ids':ids,'dept':dept},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:data.msg});
	            			$("#list_data").datagrid('clearSelections');
	            			$("#list_data").datagrid('clearChecked');
	            			$("#list_data").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	
	function dataService_doSearch(){
		$('#list_data').datagrid('load',{
			sername: $('#fname').val()
		});
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px;">
			<ul id="deptTreedemo" class="ztree"></ul>
		</div>
		<div data-options="region:'center',border:false">
		 <div class="easyui-layout"  data-options="fit:true">
			<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
				<span>业务名称:</span>
				<input id="fname" type="text" class="easyui-textbox" >
				<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="dataService_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
			<div data-options="region:'center',border:false">
			<table id="list_data" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="SERVICENAME" width="100">业务名称</th>
			            <th field="DEPTNAME" width="100">跨部门</th> 
			        </tr> 
			    </thead> 
			</table>
			</div> 
			</div>
		</div>
	</div>

