<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var typeList=${typeJson};
	var rootId=${rootId};
	var expertTree;
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
		$('#expertGrid').datagrid({url:'<%=basePath%>Main/expert/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode=expertTree.getSelectedNodes()[0];
		$("#expertGrid").datagrid("clearSelections");
		$("#expertGrid").datagrid("clearChecked");
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
		            if(expertTree!=null)
		            	expertTree.destroy();
		            expertTree =$.fn.zTree.init($("#exp_typeTree"), setting, zNodes);
		            
		            var node = expertTree.getNodeByParam("id", rootId, null);
		    		expertTree.expandNode(node,true,false,true,false);
		            
					if(!selectedNode){
						selectedNode=expertTree.getNodeByParam("id", '0', null);
						if(selectedNode.children && selectedNode.children.length>0)
							selectedNode=selectedNode.children[0];
					}
		            expertTree.selectNode(selectedNode);
		            expertTree.expandNode(selectedNode, true, false, false);
		            expertTree.setting.callback.onClick(null, expertTree.setting.treeId, selectedNode);
		        }  
		    });
	}

	function refreshGrid(){
		expertTree.setting.callback.onClick(null, expertTree.setting.treeId, selectedNode);
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'EX_ID',
				fitColumns : true, 
		        toolbar: [
				  { text:'添加', title:'添加专家信息', iconCls: 'icon-add',handler: add,permitParams:'${pert:hasperti(applicationScope.expertAdd, loginModel.xdlimit)}'}, '-',
				  { text: '修改', title:'修改专家信息',iconCls: 'icon-pageedit',
							  dialogParams:{dialogId:'expertDialog',href:'<%=basePath%>Main/expert/edit',width:800,
							height:580,formId:'expertEdit'},permitParams:'${pert:hasperti(applicationScope.expertEdit, loginModel.xdlimit)}'}, '-',
				  { text: '删除',iconCls: 'icon-delete',warnMsg:'确定要删除？',delParams:{url:'<%=basePath%>Main/expert/delete'},permitParams:'${pert:hasperti(applicationScope.expertDel, loginModel.xdlimit)}'}
				],
				url:'<%=basePath%>Main/expert/getGridData',
				onDblClickRow: function(rowIndex, rowData){
					view();
				}
			};
		$.lauvan.dataGrid("expertGrid",attrArray);
	});

	function add(){
		var options=$(this).linkbutton("options");
		if(!expertTree.getSelectedNodes()[0]||expertTree.getSelectedNodes()[0].id==rootId){
			$.lauvan.MsgShow({msg:'请选择具体的专家类型节点!'});
			return;
		}
		var attrArray={
				title:options.title,
				width: 800,
				height: 600,
				href: '<%=basePath%>Main/expert/add/'+expertTree.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("expertDialog",attrArray,expertAdd_dialogSubmit,"expertAdd");
	}
	function expertAdd_dialogSubmit(){
		$.lauvan.dialogSubmit("expertAdd","expertDialog");
		}

	function formatType(val,row){
		for(var i=0;i<typeList.length;i++){
			if(val==typeList[i].ID)
				return typeList[i].P_NAME;
		}
	} 
	
	function view(){
		var row = $("#expertGrid").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '详情',
			height: 560,
			width: 700,
			href:'<%=basePath%>Main/expert/getview/' +row.EX_ID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("viewDialog",para,null,null);		
	}
	
	function expert_doSearch(){
		$('#expertGrid').datagrid('load',{
			expName: $('#expName').val(),
		});
	}

	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="exp_typeTree" class="ztree"></ul>
		</div>
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>专家姓名：</span>
			<input id="expName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="expert_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
	    </div>
		<div data-options="region:'center',border:false">
			<table id="expertGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EX_ID" data-options="hidden:true">ID</th> 
			            <th field="NAME" width="150" >姓名</th>
			            <th field="TYPEID" width="150" data-options="formatter:formatType">类型</th>			    			          
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

