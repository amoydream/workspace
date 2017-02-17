<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var rootId=${rootId};
	var eqnameTree;
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
		$('#equipnameGrid').datagrid({url:'<%=basePath%>Main/equipname/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode=eqnameTree.getSelectedNodes()[0];
		$("#equipnameGrid").datagrid("clearSelections");
		$("#equipnameGrid").datagrid("clearChecked");
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
		            if(eqnameTree!=null)
		            	eqnameTree.destroy();
		            eqnameTree =$.fn.zTree.init($("#typeTree"), setting, zNodes);
		            
		            var node = eqnameTree.getNodeByParam("id", rootId, null);
		    		eqnameTree.expandNode(node,true,false,true,false);
		            
					if(!selectedNode){
						selectedNode=eqnameTree.getNodeByParam("id", '0', null);
						if(selectedNode.children && selectedNode.children.length>0)
							selectedNode=selectedNode.children[0];
					}
		            eqnameTree.selectNode(selectedNode);
		            eqnameTree.expandNode(selectedNode, true, false, false);
		            eqnameTree.setting.callback.onClick(null, eqnameTree.setting.treeId, selectedNode);
		        }  
		    });
	}

	function refreshGrid(){
		eqnameTree.setting.callback.onClick(null, eqnameTree.setting.treeId, selectedNode);
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'EQN_ID',
				fitColumns : true, 
				toolbar: [
						  { text:'添加', title:'添加装备信息', iconCls: 'icon-add',handler: add,permitParams:'${pert:hasperti(applicationScope.eqnameAdd, loginModel.xdlimit)}'}, '-',
						  { text: '修改', title:'修改装备信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'equipnameDialog',href:'<%=basePath%>Main/equipname/edit',width:800,
									height:600,formId:'equipnameEdit'},permitParams:'${pert:hasperti(applicationScope.eqnameEdit, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/equipname/delete'},permitParams:'${pert:hasperti(applicationScope.eqnameDel, loginModel.xdlimit)}'}
						],
				        url:'<%=basePath%>Main/equipname/getGridData',
				        onDblClickRow: function(rowIndex, rowData){
							view();
						}
					};
		$.lauvan.dataGrid("equipnameGrid",attrArray);
	});
	
	function add(){
		var options=$(this).linkbutton("options");
		if(!eqnameTree.getSelectedNodes()[0]||eqnameTree.getSelectedNodes()[0].id==rootId){
			$.lauvan.MsgShow({msg:'请选择具体的装备类型节点!'});
			return;
		}
		var attrArray={
				title:options.title,
				width: 800,
				height: 600,
				href: '<%=basePath%>Main/equipname/add/'+eqnameTree.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("equipnameDialog",attrArray,equipnameAdd_dialogSubmit,"equipnameAdd");
	}
	
	function equipnameAdd_dialogSubmit(){
		$.lauvan.dialogSubmit("equipnameAdd","equipnameDialog");
		}

	function view(){
		var row = $("#equipnameGrid").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '详情',
			height: 560,
			width: 700,
			href:'<%=basePath%>Main/equipname/getview/' +row.EQN_ID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("viewDialog",para,null,null);		
	}
	
	function equip_doSearch(){
		$('#equipnameGrid').datagrid('load',{
			eqName: $('#eqName').val(),
		});
	}

	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="typeTree" class="ztree"></ul>
		</div>
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>装备名称：</span>
			<input id="eqName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="equip_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
		<div data-options="region:'center',border:false">
			<table id="equipnameGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EQN_ID" data-options="hidden:true">ID</th> 
			            <th field="EQN_NAME" width="200">装备名称</th>
			            <th field="MEASUREUNIT" width="80" CODE="MAUNIT">计量单位</th>
			             <th field="TYPECLASS" width="100">型号</th>
			            <th field="SIZECLASS" width="100">规格</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

