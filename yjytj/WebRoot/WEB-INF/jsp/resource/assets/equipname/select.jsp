<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var rootId=${rootId};
	var selectZtree;
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
		$('#selectEquipGrid').datagrid({url:'<%=basePath%>Main/equipname/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode=selectZtree.getSelectedNodes()[0];
		$("#selectEquipGrid").datagrid("clearSelections");
		$("#selectEquipGrid").datagrid("clearChecked");
	}; 

	function initTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/equipname/getTypeTree',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){
		            zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(selectZtree!=null)
		            	selectZtree.destroy();
		            selectZtree =$.fn.zTree.init($("#select_typeTree"), setting, zNodes);
		            
		            var node = selectZtree.getNodeByParam("id", rootId, null);
		            selectZtree.expandNode(node,true,false,true,false);
		            
					if(!selectedNode){
						selectedNode=selectZtree.getNodeByParam("id", '0', null);
						if(selectedNode.children && selectedNode.children.length>0)
							selectedNode=selectedNode.children[0];
					}
		            selectZtree.selectNode(selectedNode);
		            selectZtree.expandNode(selectedNode, true, false, false);
		            selectZtree.setting.callback.onClick(null, selectZtree.setting.treeId, selectedNode);
		        }  
		    });
	}

	function refreshGrid(){
		selectZtree.setting.callback.onClick(null, selectZtree.setting.treeId, selectedNode);
	}
	
	$(function(){
		initTree();

		var selAttrArray={
				idField:'EQN_ID',
				frozenColumns:[[]],
				fitColumns : true, 
				url:'<%=basePath%>Main/equipname/getGridData'
			};
		$.lauvan.dataGrid("selectEquipGrid",selAttrArray);
	});
	
	function equip_doSearch(){
		$('#selectEquipGrid').datagrid('load',{
			eqName: $('#selEqName').val(),
		});
	}

	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="select_typeTree" class="ztree"></ul>
		</div> 
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>装备名称：</span>
			<input id="selEqName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="equip_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
		<div data-options="region:'center',border:false">
			<table id="selectEquipGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EQN_ID" data-options="hidden:true">ID</th> 
			            <th field="EQN_NAME" >装备名称</th>
			            <th field="MEASUREUNIT" CODE="MAUNIT">计量单位</th>
			            <th field="REMARK" >备注</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

