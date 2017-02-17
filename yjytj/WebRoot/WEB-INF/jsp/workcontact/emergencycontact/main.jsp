<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var zTreeEmergency;
	var zNodes;
	var selectedNode_emergency;
	var setting = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},callback: {
			onClick: zTreeOnClick
		}
	};

	function zTreeOnClick(event, treeId, treeNode) {
		if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		}
		$('#_contactlist_data').datagrid({url:'<%=basePath%>Main/emergencycontact/getGridData',queryParams:{e_id:treeNode.id}});
		selectedNode_emergency=zTreeEmergency.getSelectedNodes()[0];
		$("#_contactlist_data").datagrid("clearSelections");
		$("#_contactlist_data").datagrid("clearChecked");
	};

	function initTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/emergencycontact/getTreeData',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		            zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTreeEmergency!=null)
		            	zTreeEmergency.destroy();
		            zTreeEmergency =$.fn.zTree.init($("#customTree"), setting, zNodes);
					if(!selectedNode_emergency){
						selectedNode_emergency=zTreeEmergency.getNodeByParam("id", '0', null);
						if(selectedNode_emergency.children && selectedNode_emergency.children.length>0)
							selectedNode_emergency=selectedNode_emergency.children[0];
					}
					zTreeEmergency.selectNode(selectedNode_emergency);
					zTreeEmergency.expandNode(selectedNode_emergency, true, false, false);
					zTreeEmergency.setting.callback.onClick(null, zTreeEmergency.setting.treeId, selectedNode_emergency);
		            
		        }  
		    });
		 
	}
	
	function refreshEmergencyGrid(){
		zTreeEmergency.setting.callback.onClick(null, zTreeEmergency.setting.treeId, selectedNode_emergency);
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'ID',
				fitColumns : true, 
				toolbar: [ 
						  { text: '添加分组',title:'添加分组', iconCls: 'icon-add',  handler: addGroupClick,permitParams:'${pert:hasperti(applicationScope.userAdd, loginModel.xdlimit)}'}, '-', 
						  { text: '修改分组', title:'修改分组',iconCls: 'icon-pageedit', handler: editGroupClick,permitParams:'${pert:hasperti(applicationScope.userAdd, loginModel.xdlimit)}'}, '-',
						  { text: '删除分组',iconCls: 'icon-delete',handler: deleteGroupClick,permitParams:'${pert:hasperti(applicationScope.userAdd, loginModel.xdlimit)}'}, '-',
						  { text: '编辑分组-机构人员通讯', title:'编辑分组-机构人员通讯',iconCls: 'icon-pageedit', handler: editPersonClick,permitParams:'${pert:hasperti(applicationScope.userAdd, loginModel.xdlimit)}'}, '-',
						  { text: '编辑分组-应急人员通讯', title:'编辑分组-应急人员通讯',iconCls: 'icon-pageedit', handler: editUserClick,permitParams:'${pert:hasperti(applicationScope.userAdd, loginModel.xdlimit)}'}, '-',
						  { text: '删除分组人员',iconCls: 'icon-delete',handler: deleteClick,permitParams:'${pert:hasperti(applicationScope.userAdd, loginModel.xdlimit)}'}
						]
			};
		$.lauvan.dataGrid("_contactlist_data",attrArray);
	});
	
	
	function addGroupClick(){
  
		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				width:500,
				height:180,
				href: '<%=basePath%>Main/emergencycontact/add/'+zTreeEmergency.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("addGroupDialog",attrArray,function(){onSubmit($("#addGroupDialog"));});
	}
	
	function editPersonClick(){
		var treeid=zTreeEmergency.getSelectedNodes()[0].id;
		if(treeid=='0'){
			$.lauvan.MsgShow({msg:'请点击具体分组节点!'});
			return;
		}
		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				width:850,
				height:500,
				href: '<%=basePath%>Main/emergencycontact/editPersonContact/'+zTreeEmergency.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("addDialog",attrArray,function(){onSubmit($("#addDialog"));});
		
	}
	
	function editUserClick(){
		var treeid=zTreeEmergency.getSelectedNodes()[0].id;
		if(treeid=='0'){
			$.lauvan.MsgShow({msg:'请点击具体分组节点!'});
			return;
		}
		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				width:850,
				height:500,
				href: '<%=basePath%>Main/emergencycontact/editUserContact/'+zTreeEmergency.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("addDialog",attrArray,function(){onSubmit($("#addDialog"));});
			
	}
	

	function editGroupClick(){
		var treeid=zTreeEmergency.getSelectedNodes()[0].id;
		if(treeid=='0'){
			$.lauvan.MsgShow({msg:'请点击具体分组节点再修改!'});
			return;
		}

		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				width:500,
				height:180,
				href: '<%=basePath%>Main/emergencycontact/edit/'+treeid
		};
		$.lauvan.openCustomDialog("editGroupDialog",attrArray,function(){onSubmit($("#editGroupDialog"));});
	}
	
	
	function deleteGroupClick(){
		var node = zTreeEmergency.getSelectedNodes()[0];
		if(node==undefined||node==null){
			$.lauvan.MsgShow({msg:'请选择需要删除的分组节点!'});
			 return;
		}
		var treeid=node.id;
		var treename=node.name;
		if(node!=null&&node.children!=null&&node.children.length!=null&&node.children.length>0){
			$.lauvan.MsgShow({msg:'该分组包含子节点，无法执行删除!'});
			 return;	
		}
		
		$.messager.confirm('删除','您确定要删除分组《'+treename+'》吗？',function(y){	
			   if(y){
		        $.ajax({
	            	url:'<%=basePath%>Main/emergencycontact/delete',
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'id':treeid},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功！'});
	            			if(treeid!=null||treeid!=""){
	 	            			var treeObj = $.fn.zTree.getZTreeObj("customTree");
	 					        var node = treeObj.getNodeByParam("id", treeid, null);
	 					        if(node) {
	 						        treeObj.removeNode(node);
	 					        }
	            			} 
	            			refreshEmergencyGrid();
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
			  }
		});
	}
	
	function deleteClick(){
		var rows=$("#_contactlist_data").datagrid('getChecked');
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
			
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	var ids=[];
		    	var ztreeeid = zTreeEmergency.getSelectedNodes()[0].id;
		        for(var i=0;i<rows.length;i++){
					ids[i] = rows[i]["ID"];
				}
		        $.ajax({
	            	url:'<%=basePath%>Main/emergencycontact/deletePerson',
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'ids':ids,'e_id':ztreeeid},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功！'});
	            			refreshEmergencyGrid();
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	
	
	function CallNumber(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=phonecall('"+row.P_WORKNUMBER+"') ><span></span>拨打</a></li>"
			+"</ul>";
	    return act;
	}
	
	function phonecall(num){
		alert("拨打电话...");
	}


	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,Prder:false" style="width:200px">
			<ul id="customTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',Prder:false">
			<table id="_contactlist_data" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="ID" data-options="hidden:true">ID</th> 
			            <th field="NAME" width="80">姓名</th>			    			          
			            <th field="POSITION" width="100">岗位</th>
			            <th field="WORKNUMBER" width="100">办公电话</th> 		    			          
			            <th field="MOBILE" width="100">手机</th> 
			            <th field="HOMENUMBER" width="100">住宅电话</th> 
			            <!-- <th field="FAX" width="100">传真</th> 
			            <th field="EMAIL" width="100">Email</th> -->
			            <th field="ADDRESS" width="100">地址</th>   
			            <th field="CALLACTION" width="80" formatter="CallNumber">拨打电话</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

