<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script>
    var rootId=${rootId};
	var selectZtree2;
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
		$('#storeGrid2').datagrid({url:'<%=basePath%>Main/store/getGridData/${deptid}',queryParams:{pid:treeNode.id}});
		selectedNode=selectZtree2.getSelectedNodes()[0];
		$("#storeGrid2").datagrid("clearSelections");
		$("#storeGrid2").datagrid("clearChecked");
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
		            if(selectZtree2!=null)
		            	selectZtree2.destroy();
		            selectZtree2 =$.fn.zTree.init($("#sto_typeTree2"), setting, zNodes);
		            
		            var node = selectZtree2.getNodeByParam("id", rootId, null);
		            selectZtree2.expandNode(node,true,false,true,false);
		            
					if(!selectedNode){
						selectedNode=selectZtree2.getNodeByParam("id", '0', null);
						if(selectedNode.children && selectedNode.children.length>0)
							selectedNode=selectedNode.children[0];
					}
					selectZtree2.selectNode(selectedNode);
					selectZtree2.expandNode(selectedNode, true, false, false);
					selectZtree2.setting.callback.onClick(null, selectZtree2.setting.treeId, selectedNode);
		        }  
		    });
	}

	function refreshGrid(){
		selectZtree2.setting.callback.onClick(null, selectZtree2.setting.treeId, selectedNode);
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'STO_ID',
				fitColumns : true, 
				toolbar: [
						 
						],
		        url:'<%=basePath%>Main/store/getGridData/${deptid}',
		        onDblClickRow: function(rowIndex, rowData){
					//view();
				}
			};
		$.lauvan.dataGrid("storeGrid2",attrArray);
	});

	
	function store_doSearch(){
		$('#storeGrid2').datagrid('load',{
			maName: $('#maName2').val(),
			reName: $('#reName2').val(),
		});
	}
	
	function view(){
		var row = $("#storeGrid2").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '详情',
			height: 560,
			width: 700,
			href:'<%=basePath%>Main/store/view/' +row.STO_ID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("viewDialog",para,null,null);		
	}

	</script>


<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="sto_typeTree2" class="ztree"></ul>
    </div>
    <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>物资名称：</span>
			<input id="maName2" type="text" class="easyui-textbox" >
			<span>仓库名称：</span>
			<input id="reName2" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="store_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
		<table id="storeGrid2" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="STO_ID" data-options="hidden:true"></th>
					<th field="CODE" width="200">编号</th>
					<th field="MN_NAME" width="200">物资名称</th>
					<th field="NUM" width="400">存储数量</th>
					<th field="NAME" width="400">仓库名称</th>
				</tr>
			</thead>
		</table>
	</div>
</div>





