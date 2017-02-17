<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var zTree_user1;
	var zNodes_user1;
	var selectedNode_user1;
	var setting_user1 = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick_gpsuser
		}
	};

	function zTreeOnClick_gpsuser(event, treeId, treeNode) {
		if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		}
		$('#gpsinfo').datagrid({url:'<%=basePath%>Main/gpsinfo/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode_user1=zTree_user1.getSelectedNodes()[0];
		$("#gpsinfo").datagrid("clearSelections");
		$("#gpsinfo").datagrid("clearChecked");
	};

	function initTree_gpsuser(){
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
		            zNodes_user1 = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_user1!=null)
		            	zTree_user1.destroy();
		            zTree_user1 =$.fn.zTree.init($("#gpsuserTree"), setting_user1, zNodes_user1);
					if(!selectedNode_user1){
						selectedNode_user1=zTree_user1.getNodeByParam("id", '0', null);
						if(selectedNode_user1.children && selectedNode_user1.children.length>0)
							selectedNode_user1=selectedNode_user1.children[0];
					}
		            zTree_user1.selectNode(selectedNode_user1);
		            zTree_user1.expandNode(selectedNode_user1, true, false, false);
		            zTree_user1.setting.callback.onClick(null, zTree_user1.setting.treeId, selectedNode_user1);
		            
		        }  
		    });
		 
	}

	function refreshGrid(){
		zTree_user1.setting.callback.onClick(null, zTree_user1.setting.treeId, selectedNode_user1);
	}
	
	$(function(){
		initTree_gpsuser();
		var attrArray={
				//toolbar: '#gpsinfo_tb',
				toolbar: [
                  { text: '轨迹', iconCls: 'icon-eye',handler:selectLocator}, '-', 
                  { text: '删除',iconCls: 'icon-delete',handler:dellocator,permitParams:'${pert:hasperti(applicationScope.gpsinfodel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/gpsinfo/getGridData"
        };
		$.lauvan.dataGrid("gpsinfo",attrArray);
	});
	function dellocator(){
		/* var node= $("#gpsinfo").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#gpsinfo").datagrid('getChecked');
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
	            	//url:'<%=basePath%>Main/gpsinfo/infodel/'+node.ID,
	            	url:'<%=basePath%>Main/gpsinfo/infodel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#gpsinfo").datagrid('clearSelections');
	            			$("#gpsinfo").datagrid('clearChecked');
	            			$("#gpsinfo").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	
	function selectLocator(){
		var attrArray={
				title:'选择时间段',
				iconCls:'icon-eye',
				width:400,
				height:200,
				href: '<%=basePath%>Main/gpsinfo/getSelect/'+zTree_user1.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("locatorDialog",attrArray,searchlocator,null);
		
	}
	
	function locatorSubmit(){
		
  		/* $('#locator_form1').form('submit',{
  			onSubmit:function(){
				return $(this).form('enableValidation').form('validate');
			},
			success:function(result){
				var obj=$.parseJSON(result);
				if(obj.success){
					$("#locatorDialog").dialog('close');
					
				}else{
					$.messager.alert('错误',obj.msg);
				}
			}
		}); */
  	}
	
	function searchlocator(){
		var begintime = $("#btimeid").datetimebox('getValue');
		var endtime = $("#etimeid").datetimebox('getValue');
		var userid = $("#luserid").val();
		if(begintime.substring(0,10)!=endtime.substring(0,10)){
			$.lauvan.MsgShow({msg:'请选择同一天的时间点!'});
			return;
		}
		
		//$("#locatorDialog").dialog('close');
		var attrArray={
				title:'获取地理位置',
				width:1000,
				height:600,
				iconCls:"icon-world",
				href:'<%=basePath%>Main/geographic/common/openTrack?uid='+userid+'&btime='+begintime+'&etime='+endtime,
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
			<ul id="gpsuserTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',border:false">
		<!-- <div id="gpsinfo_tb">
		<a href="javascript:void(0);" onclick="searchlocator()" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">详情</a>
		<a href="javascript:void(0);" onclick="dellocator()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div> -->
			<table id="gpsinfo" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="USERID" width="50">终端用户ID</th> 
			            <th field="POSX" width="200">经度</th>
			            <th field="POSY" width="200">纬度</th> 
			            <th field="TIME" width="200">发送时间</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

