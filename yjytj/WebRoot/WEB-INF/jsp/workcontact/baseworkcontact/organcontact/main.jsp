<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script>
	var zTree_Organ;
	var zNodes_Organ;
	var selectedNode_Organ;
	var setting = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick_Organ
		}
	};

	function zTreeOnClick_Organ(event, treeId, treeNode) {
		/* if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		} */
		$('#_organcontactlist_data').datagrid({url:'<%=basePath%>Main/organcontact/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode_Organ=zTree_Organ.getSelectedNodes()[0];
		$("#_organcontactlist_data").datagrid("clearSelections");
		$("#_organcontactlist_data").datagrid("clearChecked");
	};

	function initTree_Organ(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/organcontact/getTreeData',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		            zNodes_Organ = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_Organ!=null)
		            	zTree_Organ.destroy();
		            zTree_Organ =$.fn.zTree.init($("#organcontactTree"), setting, zNodes_Organ);
					if(!selectedNode_Organ){
						selectedNode_Organ=zTree_Organ.getNodeByParam("id", '0', null);
						if(selectedNode_Organ.children && selectedNode_Organ.children.length>0)
							selectedNode_Organ=selectedNode_Organ.children[0];
					}
					zTree_Organ.selectNode(selectedNode_Organ);
					zTree_Organ.expandNode(selectedNode_Organ, true, false, false);
					zTree_Organ.setting.callback.onClick(null, zTree_Organ.setting.treeId, selectedNode_Organ);
		            
		        }  
		    });
		 
	}

	function refreshGrid(){
		zTree_Organ.setting.callback.onClick(null, zTree_Organ.setting.treeId, selectedNode_Organ);
	}
	
	$(function(){
		initTree_Organ();

		var attrArray={
				idField:'OR_ID',
				fitColumns : true, 
				toolbar: [ 
						  { text: '添加',title:'添加组织机构', iconCls: 'icon-add',  handler: addClick,permitParams:'${pert:hasperti(applicationScope.addorgan, loginModel.xdlimit)}'}, '-', 
						  { text: '修改', title:'修改组织机构',iconCls: 'icon-pageedit', handler: editClick,permitParams:'${pert:hasperti(applicationScope.editorgan, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',handler: deleteClick,permitParams:'${pert:hasperti(applicationScope.deleteorgan, loginModel.xdlimit)}'},'-',
						  { text: '导入',iconCls: 'icon-undo',handler: importClick,permitParams:'${pert:hasperti(applicationScope.importorgan, loginModel.xdlimit)}'}
						]
			};
		$.lauvan.dataGrid("_organcontactlist_data",attrArray);
	});

	
	function addClick(){
		//var treeObj = $.fn.zTree.getZTreeObj("organcontactTree");
		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				width:500,
				height:350,
				href: '<%=basePath%>Main/organcontact/add/'+zTree_Organ.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("addDialog",attrArray,function(){onSubmit();
				
		});
	}
	
		
	function editClick(){
		var row=$("#_organcontactlist_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录!'});
			return;
		}	

		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				width:500,
				height:350,
				href: '<%=basePath%>Main/organcontact/edit/'+row.OR_ID
		};
		$.lauvan.openCustomDialog("editDialog",attrArray,function(){onSubmit($("#editDialog"));});
	}
	
	
	function deleteClick(){
		var rows=$("#_organcontactlist_data").datagrid('getChecked');
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		//避免选择OR_ID为空的记录
		/* var ids=[];
		for(var i=0;i<rows.length;i++){
			ids[i] = rows[i]["OR_ID"];
			if(ids[i]==''||ids[i]==null){
			$.lauvan.MsgShow({msg:'请不要选择没有ID的数据项!'});
			return;
			}
		} */
		
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(y){
		    if (y){
		    	var ids=[];
		        for(var i=0;i<rows.length;i++){
					ids[i] = rows[i]["OR_ID"];
				}
		        $.ajax({
	            	url:'<%=basePath%>Main/organcontact/delete',
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'ids':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功！'});
	            		   for(var i=0;i<ids.length;i++){
	            			var treeObj = $.fn.zTree.getZTreeObj("organcontactTree");
					        var node = treeObj.getNodeByParam("id", ids[i], null);
					        if(node) {
						        treeObj.removeNode(node);
					        }
	            		   }
	            		refreshGrid();
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	
	function importClick(){
		var options=$(this).linkbutton("options");
		var attrArray={
				title:'批量创建组织机构通讯录',
				iconCls:options.iconCls,
				href: '<%=basePath%>Main/organcontact/importOrgan',
			buttons : []
		};
		$.lauvan.openCustomDialog("importDialog", attrArray, null);
	}
	
	
	function doSearchOrgan(){
		$('#_organcontactlist_data').datagrid('load',{
			or_name: $('#or_nameid').val()		
		});
	}
	
	function CallNumber(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=callView('"+row.OR_WORKNUMBER+"') ><span></span>拨打</a></li>"
			+"</ul>";
	    return act;
	}
	
	function callView(worknum){
		var attrArray={
				title:'拨打电话',
				iconCls:'icon-help',
				width:500,
				height:210,
				href: '<%=basePath%>Main/organcontact/callview',
				queryParams:{worknum:worknum},
				buttons:[]
		};
		$.lauvan.openCustomDialog("calloutDialog",attrArray);	
	}
</script>

<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true,Prder:false"
		style="width: 230px">
		<ul id="organcontactTree" class="ztree"></ul>
	</div>
	 <div data-options="region:'north'" style="padding: 5px;background:#f7f7f7;">
			<span>机构名称：</span>
			<input id="or_nameid" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="doSearchOrgan()" data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',Prder:false">
		<table id="_organcontactlist_data" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="OR_ID" data-options="hidden:true">ID</th>
					<th field="OR_NAME" width="80">机构名称</th>
					<th field="OR_WORKNUMBER" width="150">办公电话</th>
					<th field="OR_FAX" width="100">传真</th>
					<th field="OR_EMAIL" width="100">Email</th>
					<!-- <th field="OR_ADDRESS" width="150">地址</th> -->
					<th field="CALL" width="60" formatter="CallNumber">拨打电话</th>
				</tr>
			</thead>
		</table>
	</div>
</div>

