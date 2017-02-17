<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
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
		$('#selectExpertGrid').datagrid({url:'<%=basePath%>Main/expert/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode=selectZtree.getSelectedNodes()[0];
		$("#selectExpertGrid").datagrid("clearSelections");
		$("#selectExpertGrid").datagrid("clearChecked");
	}; 

	function initTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/expert/getTypeTree',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){
		            zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(selectZtree!=null)
		            	selectZtree.destroy();
		            selectZtree =$.fn.zTree.init($("#selectExpertTree"), setting, zNodes);
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
				idField:'EX_ID',
				frozenColumns:[[]],
				fitColumns : true, 
				url:'<%=basePath%>Main/expert/getGridData'
			};
		$.lauvan.dataGrid("selectExpertGrid",selAttrArray);
	});
	
	function expert_doSearch(){
		$('#selectExpertGrid').datagrid('load',{
			expName: $('#selExpName').val(),
		});
	}

	
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="selectExpertTree" class="ztree"></ul>
		</div> 
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>专家姓名：</span>
			<input id="selExpName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="expert_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
		<div data-options="region:'center',border:false">
			<table id="selectExpertGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EX_ID" data-options="hidden:true">ID</th> 
			            <th field="NAME" >专家名称</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

