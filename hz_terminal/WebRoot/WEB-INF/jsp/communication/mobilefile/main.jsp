<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var zTree_user2;
	var zNodes_user2;
	var selectedNode_user2;
	var setting_user2 = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick_mobileuser
		}
	};

	function zTreeOnClick_mobileuser(event, treeId, treeNode) {
		if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		}
		$('#mobilefile').datagrid({url:'<%=basePath%>Main/mobilefile/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode_user2=zTree_user2.getSelectedNodes()[0];
		$("#mobilefile").datagrid("clearSelections");
		$("#mobilefile").datagrid("clearChecked");
	};

	function initTree_mobileuser(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/gpsinfo/getusertree',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		            zNodes_user2 = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_user2!=null)
		            	zTree_user2.destroy();
		            zTree_user2 =$.fn.zTree.init($("#mobileuserTree"), setting_user2, zNodes_user2);
					if(!selectedNode_user2){
						selectedNode_user2=zTree_user2.getNodeByParam("id", '0', null);
						if(selectedNode_user2.children && selectedNode_user2.children.length>0)
							selectedNode_user2=selectedNode_user2.children[0];
					}
		            zTree_user2.selectNode(selectedNode_user2);
		            zTree_user2.expandNode(selectedNode_user2, true, false, false);
		            zTree_user2.setting.callback.onClick(null, zTree_user2.setting.treeId, selectedNode_user2);
		            
		        }  
		    });
		 
	}

	function refreshGrid(){
		zTree_user2.setting.callback.onClick(null, zTree_user2.setting.treeId, selectedNode_user2);
	}
	
	$(function(){
		initTree_mobileuser();
		var attrArray={
				//toolbar: '#mobilefile_tb',
				toolbar: [
                  { text: '详情', iconCls: 'icon-eye',handler:searchview}, '-', 
                  { text: '删除',iconCls: 'icon-delete',handler:delfile,permitParams:'${pert:hasperti(applicationScope.mobilefiledel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/mobilefile/getGridData"
        };
		$.lauvan.dataGrid("mobilefile",attrArray);
	});
	function delfile(){
		/* var node= $("#mobilefile").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#mobilefile").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
			 ids=ids+nodes[i].ID+",";
			 }
    	ids=ids.substring(0,ids.length-1);
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	//url:'<%=basePath%>Main/mobilefile/filedel/'+node.ID,
	            	url:'<%=basePath%>Main/mobilefile/filedel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#mobilefile").datagrid('clearSelections');
	            			$("#mobilefile").datagrid('clearChecked');
	            			$("#mobilefile").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function searchview(){
		var node= $("#mobilefile").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲查看的数据!'});
			return;
		}
		var attrArray={
				title:'获取地理位置',
				width:1000,
				height:600,
				iconCls:"icon-world",
				href:'<%=basePath%>Main/geographic/common/openMedia?lat='+node.POSY+'&lng='+node.POSX+"&type="+node.FILETYPE+"&path="+node.PATH,
				buttons:[
				{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#gisDialog").dialog('close');
					}
				}
			 ]
			}; 
			$.lauvan.openCustomDialog("gisDialog",attrArray,null,null);
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		 <div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="mobileuserTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',border:false">
		<!-- <div id="mobilefile_tb">
		<a href="javascript:void(0);" onclick="searchview()" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">详情</a>
		<a href="javascript:void(0);" onclick="delfile()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div> -->
			<table id="mobilefile" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="USERID" width="100">终端用户ID</th> 
			            <th field="MSG" width="300">说明</th>
			            <th field="PATH" width="300">路径</th> 
			            <th field="TIME" width="200">发送时间</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

