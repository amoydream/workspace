<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var rootId=${rootId};
	var maNameZtree;
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
		$('#manameGrid').datagrid({url:'<%=basePath%>Main/materialname/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode=maNameZtree.getSelectedNodes()[0];
		$("#manameGrid").datagrid("clearSelections");
		$("#manameGrid").datagrid("clearChecked");
	}; 

	function initTree(){
		
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/materialname/getTypeTree',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){
		            zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(maNameZtree!=null)
		            	maNameZtree.destroy();
		            maNameZtree =$.fn.zTree.init($("#maNameZtree"), setting, zNodes);
		            
		            var node = maNameZtree.getNodeByParam("id", rootId, null);
		    		maNameZtree.expandNode(node,true,false,true,false);
		            
					if(!selectedNode){
						selectedNode=maNameZtree.getNodeByParam("id", '0', null);
						if(selectedNode.children && selectedNode.children.length>0)
							selectedNode=selectedNode.children[0];
					}
		            maNameZtree.selectNode(selectedNode);
		            maNameZtree.expandNode(selectedNode, true, false, false);
		            maNameZtree.setting.callback.onClick(null, maNameZtree.setting.treeId, selectedNode);
		        }  
		    });
	}

	function refreshGrid(){
		maNameZtree.setting.callback.onClick(null, maNameZtree.setting.treeId, selectedNode);
	}
	
	$(function(){
		
		initTree();
		
		var attrArray={
				idField:'MN_ID' ,
				fitColumns : true, 
		        toolbar: [
				  { text:'添加', title:'添加物资信息', iconCls: 'icon-add',handler:add,permitParams:'${pert:hasperti(applicationScope.manameAdd, loginModel.xdlimit)}'}, '-',
				  { text: '修改', title:'修改物资信息',iconCls: 'icon-pageedit',
							  dialogParams:{dialogId:'manameDialog',href:'<%=basePath%>Main/materialname/edit',width:700,
							height:560,formId:'manameEdit'},permitParams:'${pert:hasperti(applicationScope.manameEdit, loginModel.xdlimit)}'}, '-',
				  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/materialname/delete'},permitParams:'${pert:hasperti(applicationScope.manameDel, loginModel.xdlimit)}'}
				],
				url:'<%=basePath%>Main/materialname/getGridData',
				 onDblClickRow: function(rowIndex, rowData){
						view();
					}
			};
		$.lauvan.dataGrid("manameGrid",attrArray);
	});

	function add(){
		var options=$(this).linkbutton("options");
		if(!maNameZtree.getSelectedNodes()[0]||maNameZtree.getSelectedNodes()[0].id==rootId){
			$.lauvan.MsgShow({msg:'请选择具体的物资类型节点!'});
			return;
		}
		var attrArray={
				title:options.title,
				width: 800,
				height: 600,
				href: '<%=basePath%>Main/materialname/add/'+maNameZtree.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("manameDialog",attrArray,manameAdd_dialogSubmit,"manameAdd");
	}
	
	function manameAdd_dialogSubmit(){
		$.lauvan.dialogSubmit("manameAdd","manameDialog");
		}
	
	function view(){
		var row = $("#manameGrid").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '详情',
			height: 560,
			width: 700,
			href:'<%=basePath%>Main/materialname/getview/' +row.MN_ID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("viewDialog",para,null,null);		
	}
	
	function material_doSearch(){
		$('#manameGrid').datagrid('load',{
			maName: $('#maName').val(),
		});
	}
	

	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="maNameZtree" class="ztree"></ul>
		</div>
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>物资名称：</span>
			<input id="maName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="material_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
		<div data-options="region:'center',border:false">
			<table id="manameGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="MN_ID" data-options="hidden:true">ID</th> 
			            <th field="MN_NAME" width="200">物资名称</th>
			            <th field="MEASUREUNIT" width="80" CODE="MAUNIT">计量单位</th>
			            <th field="TYPECLASS" width="100">型号</th>
			            <th field="SIZECLASS" width="100">规格</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

