<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var rootId=${rootId};
	var zTree;
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
		$('#equipstoreGrid').datagrid({url:'<%=basePath%>Main/equipstore/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode=zTree.getSelectedNodes()[0];
		$("#equipstoreGrid").datagrid("clearSelections");
		$("#equipstoreGrid").datagrid("clearChecked");
	}; 

	function initTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/equipstore/getTypeTree',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){
		            zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree!=null)
		            	zTree.destroy();
		            zTree =$.fn.zTree.init($("#eqs_typeTree"), setting, zNodes);
		            
		            var node = zTree.getNodeByParam("id", rootId, null);
		    		zTree.expandNode(node,true,false,true,false);
		            
					if(!selectedNode){
						selectedNode=zTree.getNodeByParam("id", '0', null);
						if(selectedNode.children && selectedNode.children.length>0)
							selectedNode=selectedNode.children[0];
					}
		            zTree.selectNode(selectedNode);
		            zTree.expandNode(selectedNode, true, false, false);
		            zTree.setting.callback.onClick(null, zTree.setting.treeId, selectedNode);
		        }  
		    });
	}

	function refreshGrid(){
		zTree.setting.callback.onClick(null, zTree.setting.treeId, selectedNode);
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'EQS_ID',
				fitColumns : true, 
		        toolbar: [
				  { text:'添加', title:'添加装备存储信息', iconCls: 'icon-add',
						dialogParams:{dialogId:'equipstoreDialog', href:'<%=basePath%>Main/equipstore/add', 
						width:700, height:560, formId:'equipstoreAdd', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.eqstoreAdd, loginModel.xdlimit)}'}, '-',
				  { text: '修改', title:'修改装备存储信息',iconCls: 'icon-pageedit',
							  dialogParams:{dialogId:'equipstoreDialog',href:'<%=basePath%>Main/equipstore/edit',width:700,
							height:560,formId:'equipstoreEdit'},permitParams:'${pert:hasperti(applicationScope.eqstoreEdit, loginModel.xdlimit)}'}, '-',
				  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/equipstore/delete'},permitParams:'${pert:hasperti(applicationScope.eqstoreDel, loginModel.xdlimit)}'}
				],
		        url:'<%=basePath%>Main/equipstore/getGridData',
		        onDblClickRow: function(rowIndex, rowData){
					view();
				}
			};
		$.lauvan.dataGrid("equipstoreGrid",attrArray);
	});

	function findEquipname(){
		var param = {
			title:'选择装备',
			width:600,
			height:500,
			href:'<%=basePath%>Main/equipname/getEquipname',
			buttons:[{
				text:'确定',
				iconCls:'icon-save',
				handler: function(){
					var row = $("#selectEquipGrid").datagrid("getSelected");
					$("#equipnameid").val(row.EQN_ID);
					$("#equipname").textbox('setValue', row.EQN_NAME);
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
	
	function view(){
		var row = $("#equipstoreGrid").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '详情',
			height: 560,
			width: 700,
			href:'<%=basePath%>Main/equipstore/getview/' +row.EQS_ID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("viewDialog",para,null,null);		
	}
	
	function equipstore_doSearch(){
		$('#equipstoreGrid').datagrid('load',{
			eqName: $('#eqName').val(),
		});
	}


	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="eqs_typeTree" class="ztree"></ul>
		</div>
		 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>装备名称：</span>
			<input id="eqName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="equipstore_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
		<div data-options="region:'center',border:false">
			<table id="equipstoreGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EQS_ID" data-options="hidden:true">ID</th> 
			            <th field="EQN_NAME" width="150">装备名称</th>
			            <th field="EQUIPNUM" width="80">存放数量</th>
			            <th field="MEASUREUNIT" width="80" CODE="MAUNIT">计量单位</th>
			            <th field="ADDRESS" width="200">地址</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

