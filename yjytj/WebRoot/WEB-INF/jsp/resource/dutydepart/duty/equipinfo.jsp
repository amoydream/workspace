<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
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
		$('#equipstoreGrid2').datagrid({url:'<%=basePath%>Main/equipstore/getGridData/${deptid}',queryParams:{pid:treeNode.id}});
		selectedNode=zTree.getSelectedNodes()[0];
		$("#equipstoreGrid2").datagrid("clearSelections");
		$("#equipstoreGrid2").datagrid("clearChecked");
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
		            zTree =$.fn.zTree.init($("#eqs_typeTree2"), setting, zNodes);
		            var node = zTree.getNodes();
		            zTree.selectNode(node[0]);
		            zTree.expandNode(node[0]);
		            zTree.setting.callback.onClick(null, zTree.setting.treeId, node);
		        }  
		    });
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'EQS_ID',
				fitColumns : true, 
		        toolbar: [],
		        url:'<%=basePath%>Main/equipstore/getGridData/${deptid}',
		        onDblClickRow: function(rowIndex, rowData){
					//view();
				}
			};
		$.lauvan.dataGrid("equipstoreGrid2",attrArray);
	});

	
	
	function view(){
		var row = $("#equipstoreGrid2").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '详情',
			height: 560,
			width: 700,
			href:'<%=basePath%>Main/equipstore/view/' +row.EQS_ID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("viewDialog",para,null,null);		
	}
	
	function equipstore_doSearch(){
		$('#equipstoreGrid2').datagrid('load',{
			eqName: $('#eqName2').val(),
			reName: $('#reName2').val(),
		});
	}


	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="eqs_typeTree2" class="ztree"></ul>
		</div>
		 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>装备名称：</span>
			<input id="eqName2" type="text" class="easyui-textbox" >
			<span>仓库名称：</span>
			<input id="reName2" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="equipstore_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
		<div data-options="region:'center',border:false">
			<table id="equipstoreGrid2" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EQS_ID" data-options="hidden:true">ID</th> 
			            <th field="EQN_NAME"  width="100" >装备名称</th>
			            <th field="EQUIPNUM"  width="100" >存放数量</th>
			            <th field="MEASUREUNIT"  width="100" CODE="MAUNIT">计量单位</th>
			            <th field="NAME"  width="100" >存放仓库</th>
			            <th field="ADDRESS"  width="100" >仓库地址</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

