<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script>
    var rootId=${rootId};
	var storeZtree;
	var zNodes;
	var selectedNode;
	var setting = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick
		}
	};

	function zTreeOnClick(event, treeId, treeNode) {
		if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		}
		$('#storeGrid').datagrid({url:'<%=basePath%>Main/store/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode=storeZtree.getSelectedNodes()[0];
		$("#storeGrid").datagrid("clearSelections");
		$("#storeGrid").datagrid("clearChecked");
	}; 

	function initTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/store/getTypeTree',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){
		            zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(storeZtree!=null)
		            	storeZtree.destroy();
		            storeZtree =$.fn.zTree.init($("#sto_typeTree"), setting, zNodes);
		            
		            var node = storeZtree.getNodeByParam("id", rootId, null);
		            storeZtree.expandNode(node,true,false,true,false);
		            
					if(!selectedNode){
						selectedNode=storeZtree.getNodeByParam("id", '0', null);
						if(selectedNode.children && selectedNode.children.length>0)
							selectedNode=selectedNode.children[0];
					}
					storeZtree.selectNode(selectedNode);
					storeZtree.expandNode(selectedNode, true, false, false);
					storeZtree.setting.callback.onClick(null, storeZtree.setting.treeId, selectedNode);
		        }  
		    });
	}

	function refreshGrid(){
		storeZtree.setting.callback.onClick(null, storeZtree.setting.treeId, selectedNode);
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'STO_ID',
				fitColumns : true, 
				toolbar: [
						  { text:'添加', title:'添加物资存储信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'storeDialog', href:'<%=basePath%>Main/store/add', 
								width:800, height:560, formId:'storeAdd', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.storeAdd, loginModel.xdlimit)}'}, '-',
						  { text: '修改', title:'修改物资存储信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'storeDialog',href:'<%=basePath%>Main/store/edit',width:800,
									height:560,formId:'storeEdit'},permitParams:'${pert:hasperti(applicationScope.storeEdit, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/store/delete'},permitParams:'${pert:hasperti(applicationScope.storeDel, loginModel.xdlimit)}'}
						],
		        url:'<%=basePath%>Main/store/getGridData',
		        onDblClickRow: function(rowIndex, rowData){
					view();
				}
			};
		$.lauvan.dataGrid("storeGrid",attrArray);
	});

	function findRepertory(){
		var param = {
			title:'选择所在仓库',
			width:600,
			height:500,
			href:'<%=basePath%>Main/repertory/getRepertory',
			buttons:[{
				text:'确定',
				iconCls:'icon-save',
				handler: function(){
					var row = $("#selectRepertoryGrid").datagrid("getSelected");
					$("#repertoryid").val(row.REP_ID);
					$("#repertoryname").textbox('setValue', row.NAME);
					$("#repertoryDialog").dialog('close');
				}
			},{
				text:'关闭',
				iconCls:'icon-no',
				handler:function(){
					$("#repertoryDialog").dialog('close');
				}

			}]
		};
		$.lauvan.openCustomDialog("repertoryDialog", param, null, null);
	}
	
	function findMaterial(){
		var param = {
			title:'选择物资',
			width:600,
			height:500,
			href:'<%=basePath%>Main/materialname/getMaterial',
			buttons:[{
				text:'确定',
				iconCls:'icon-save',
				handler: function(){
					var row = $("#selectMaGrid").datagrid("getSelected");
					$("#materialid").val(row.MN_ID);
					$("#materialname").textbox('setValue', row.MN_NAME);
					$("#selectDialog").dialog('close');
				}
			},{
				text:'关闭',
				iconCls:'icon-no',
				handler:function(){
					$("#selectDialog").dialog('close');
				}

			}]
		};
		$.lauvan.openCustomDialog("selectDialog", param, null, null);
	}
	
	function store_doSearch(){
		$('#storeGrid').datagrid('load',{
			maName: $('#maName').val(),
			reName: $('#reName').val(),
		});
	}
	
	function view(){
		var row = $("#storeGrid").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '详情',
			height: 560,
			width: 700,
			href:'<%=basePath%>Main/store/getview/' +row.STO_ID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("viewDialog",para,null,null);		
	}

	</script>


<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="sto_typeTree" class="ztree"></ul>
    </div>
    <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>物资名称：</span>
			<input id="maName" type="text" class="easyui-textbox" >
			<span>仓库名称：</span>
			<input id="reName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="store_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
		<table id="storeGrid" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="STO_ID" data-options="hidden:true"></th>
					<th field="STO_CODE" width="200">编号</th>
					<th field="MN_NAME" width="200">物资名称</th>
					<th field="NUM" width="400">存储数量</th>
					<th field="NAME" width="400">仓库名称</th>
				</tr>
			</thead>
		</table>
	</div>
</div>





