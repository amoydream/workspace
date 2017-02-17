<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var typeList=${typeJson};
	var rootId=${rootId};
	var zTree4;
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
		$('#expertGrid2').datagrid({url:'<%=basePath%>Main/expert/getGridData/${deptid}',queryParams:{pid:treeNode.id}});
		selectedNode=zTree4.getSelectedNodes()[0];
		$("#expertGrid2").datagrid("clearSelections");
		$("#expertGrid2").datagrid("clearChecked");
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
		            if(zTree4!=null)
		            	zTree4.destroy();
		            zTree4 =$.fn.zTree.init($("#exp_typeTree2"), setting, zNodes);
		            
		            var node = zTree4.getNodeByParam("id", rootId, null);
		    		zTree4.expandNode(node,true,false,true,false);
		            
					if(!selectedNode){
						selectedNode=zTree4.getNodeByParam("id", '0', null);
						if(selectedNode.children && selectedNode.children.length>0)
							selectedNode=selectedNode.children[0];
					}
		            zTree4.selectNode(selectedNode);
		            zTree4.expandNode(selectedNode, true, false, false);
		            zTree4.setting.callback.onClick(null, zTree4.setting.treeId, selectedNode);
		        }  
		    });
	}

	function refreshGrid(){
		zTree4.setting.callback.onClick(null, zTree4.setting.treeId, selectedNode);
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'EX_ID',
				fitColumns : true, 
		        toolbar: [
				],
				url:'<%=basePath%>Main/expert/getGridData/${deptid}'
			};
		$.lauvan.dataGrid("expertGrid2",attrArray);
	});



	function formatType(val,row){
		for(var i=0;i<typeList.length;i++){
			if(val==typeList[i].ID)
				return typeList[i].P_NAME;
		}
	} 
	
	function expert_doSearch(){
		$('#expertGrid2').datagrid('load',{
			expName: $('#expName2').val(),
		});
	}

	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="exp_typeTree2" class="ztree"></ul>
		</div>
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>专家姓名：</span>
			<input id="expName2" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="expert_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
		<div data-options="region:'center',border:false">
			<table id="expertGrid2" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EX_ID" data-options="hidden:true">ID</th> 
			            <th field="NAME"  width="100">姓名</th>
			            <th field="TYPEID" width="100" data-options="formatter:formatType">类型</th>			    			          
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

