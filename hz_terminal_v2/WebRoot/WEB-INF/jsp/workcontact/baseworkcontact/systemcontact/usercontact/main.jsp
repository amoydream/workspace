<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var zTree_contactuser;
	var zNodes_contactuser;
	var selectedNode_contactuser;
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
		$('#_usercontactlist_data').datagrid({url:'<%=basePath%>Main/systemcontact/usercontact/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode_contactuser=zTree_contactuser.getSelectedNodes()[0];
		$("#_usercontactlist_data").datagrid("clearSelections");
		$("#_usercontactlist_data").datagrid("clearChecked");
	};

	function initTree_ContactUser(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/department/getTreeData',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		            zNodes_contactuser = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_contactuser!=null)
		            	zTree_contactuser.destroy();
		            zTree_contactuser =$.fn.zTree.init($("#usercontactTree"), setting, zNodes_contactuser);
					if(!selectedNode_contactuser){
						selectedNode_contactuser=zTree_contactuser.getNodeByParam("id", '0', null);
						if(selectedNode_contactuser.children && selectedNode_contactuser.children.length>0)
							selectedNode_contactuser=selectedNode_contactuser.children[0];
					}
					zTree_contactuser.selectNode(selectedNode_contactuser);
					zTree_contactuser.expandNode(selectedNode_contactuser, true, false, false);
					zTree_contactuser.setting.callback.onClick(null, zTree_contactuser.setting.treeId, selectedNode_contactuser);
		            
		        }  
		    });
		 
	}

	function refreshGrid(){
		zTree_contactuser.setting.callback.onClick(null, zTree_contactuser.setting.treeId, selectedNode_contactuser);
	}
	
	$(function(){
		initTree_ContactUser();

		var attrArray={
				idField:'BO_ID',
				fitColumns : true, 
				toolbar: [ 
						  { text: '编辑通讯信息', title:'编辑通讯信息',iconCls: 'icon-pageedit', handler: editClick,permitParams:'${pert:hasperti(applicationScope.editusercontact, loginModel.xdlimit)}'}, '-',
						  { text: '删除通讯信息',iconCls: 'icon-delete',handler: deleteClick,permitParams:'${pert:hasperti(applicationScope.deleteusercontact, loginModel.xdlimit)}'},'-',
						  { text: '导入',iconCls: 'icon-undo',handler: importClick,permitParams:'${pert:hasperti(applicationScope.importusercontact, loginModel.xdlimit)}'}
						]
			};
		$.lauvan.dataGrid("_usercontactlist_data",attrArray);
	});

	function editClick(){
		var row=$("#_usercontactlist_data").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲编辑的记录!'});
			return;
		}

		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				href: '<%=basePath%>Main/systemcontact/contactbook/editForUser/'+row.USER_ID
		};
		$.lauvan.openCustomDialog("editDialog",attrArray,function(){onSubmit($("#editDialog"));});
	}
	
	
	function deleteClick(){
		var rows=$("#_usercontactlist_data").datagrid('getChecked');
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		//避免选择BO_ID为空的记录
		var ids=[];
		for(var i=0;i<rows.length;i++){
			ids[i] = rows[i]["BO_ID"];
			if(ids[i]==''||ids[i]==null){
				$.lauvan.MsgShow({msg:'请不要选择没有关联通讯录数据项!'});
			return;
			}
		}
		
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	var ids=[];
		        for(var i=0;i<rows.length;i++){
					ids[i] = rows[i]["BO_ID"];
				}
		        $.ajax({
	            	url:'<%=basePath%>Main/systemcontact/usercontact/delete',
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'ids':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功！'});
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
				title:'批量导入应急人员通讯录',
				iconCls:options.iconCls,
				href: '<%=basePath%>Main/systemcontact/usercontact/importusercontact',
				buttons:[]
		};
		$.lauvan.openCustomDialog("importDialog",attrArray,null);
	}
     
	function doSearchUser(){
		$('#_usercontactlist_data').datagrid('load',{
			user_name: $('#user_nameid').val()			
		});		
	}
	
	function CallNumber(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=callView('"+row.BO_WORKNUMBER+"','"+row.BO_MOBILE+"','"+row.BO_HOMENUMBER+"')><span></span>拨打</a></li>"
			+"</ul>";
	    return act;
	}
	
	function callView(worknum,mobilenum,homenum){
		var attrArray={
				title:'拨打电话',
				iconCls:'icon-help',
				width:500,
				height:210,
				href: '<%=basePath%>Main/systemcontact/usercontact/callview',
				queryParams:{worknum:worknum,mobilenum:mobilenum,homenum:homenum},
				buttons:[]
		};
		$.lauvan.openCustomDialog("calloutDialog",attrArray);	
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,Prder:false" style="width:230px">
			<ul id="usercontactTree" class="ztree"></ul>
		</div>
		<div data-options="region:'north'" style="padding: 5px;background:#f7f7f7;">
			<span>姓名：</span>
			<input id="user_nameid" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="doSearchUser()" data-options="iconCls:'icon-search',plain:true">查询</a>
	   </div>
		<div data-options="region:'center',Prder:false">
			<table id="_usercontactlist_data" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="BO_ID" data-options="hidden:true">ID</th> 
			            <th field="USER_NAME" width="80">姓名</th>
			            <th field="EMPOSITION" width="80">岗位</th>
			            <th field="BO_WORKNUMBER" width="80">办公电话</th> 			    			          
			            <th field="BO_MOBILE" width="80">手机</th> 
			            <th field="BO_HOMENUMBER" width="80">住宅电话</th> 
			            <th field="BO_FAX" width="80">传真</th> 
			            <th field="BO_EMAIL" width="80">Email</th> 
			            <th field="BO_ADDRESS" width="130">地址</th> 
			            <th field="CALL" width="60" formatter="CallNumber">拨打电话</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

