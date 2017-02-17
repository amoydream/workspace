<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	var zTree_type;
	var zNodes_type;
	var selectedNode_type;
	var setting_type = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick_type
		}
	};
	function zTreeOnClick_type(event, treeId, treeNode) {
		if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		}
		$('#deviceGrid').datagrid({url:'<%=basePath%>Main/comdevicemanagement/getGridData',queryParams:{p_acode:treeNode.p_acode}});
		selectedNode_type=zTree_type.getSelectedNodes()[0];
		$("#deviceGrid").datagrid("clearSelections");
		$("#deviceGrid").datagrid("clearChecked");
	};
	function initTree_typetree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/comdevicemanagement/getTree',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		            zNodes_type = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_type!=null)
		            	zTree_type.destroy();
		            zTree_type =$.fn.zTree.init($("#typeTree"), setting_type, zNodes_type);
					if(!selectedNode_type){
						selectedNode_type=zTree_type.getNodeByParam("id", '325', null);
						if(selectedNode_type.children && selectedNode_type.children.length>0)
							selectedNode_type=selectedNode_type.children[0];
					}
		            zTree_type.selectNode(selectedNode_type);
		            zTree_type.expandNode(selectedNode_type, true, false, false);
		            zTree_type.setting.callback.onClick(null, zTree_type.setting.treeId, selectedNode_type);
		            
		        }  
		    });
		 
	}
	$(function(){
		initTree_typetree();
		var attrArray={
				//toolbar: '#device_tb',
				toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:adddevice,permitParams:'${pert:hasperti(applicationScope.comdeviceadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:upddevice,permitParams:'${pert:hasperti(applicationScope.comdeviceupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:deldevice,permitParams:'${pert:hasperti(applicationScope.comdevicedel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/comdevicemanagement/getGridData",
				onDblClickRow:deciveview
        };
		$.lauvan.dataGrid("deviceGrid",attrArray);
		
	});
	function device_doSearch(){
		$('#deviceGrid').datagrid('load',{
			p_acode:selectedNode_type.p_acode,
			dname: $('#devicename').val(),
			dcode: $('#devicecode').val()
			
		});	
	}
	function adddevice(){
		var attrArray={
				title:'新增设备信息',
				height: 500,
				width:800,
				href: '<%=basePath%>Main/comdevicemanagement/deviceadd/'+selectedNode_type.p_acode,
		};
		
		$.lauvan.openCustomDialog("deviceDialog",attrArray,device_dialogSubmit,'device_form');	
	}
	function deciveview(){
		var node = $("#deviceGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var attrArray={
				title:'设备详情',
				height: 500,
				width:800,
				href: '<%=basePath%>Main/comdevicemanagement/deviceview/'+node.ID,
				buttons:[{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#deviceGrid").datagrid('reload');
						$("#deviceDialog").dialog('close');
					}
				}
							         ]
		};
		$.lauvan.openCustomDialog("deviceDialog",attrArray,null,null);
	}
	function upddevice(){
		var node = $("#deviceGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改设备信息',
				height: 500,
				width:800,
				href: '<%=basePath%>Main/comdevicemanagement/deviceupd/'+node.ID
		};
		$.lauvan.openCustomDialog("deviceDialog",attrArray,device_dialogSubmit,'device_form');
	}
	function device_dialogSubmit(){
  		$('#device_form').form('submit',{
  			onSubmit:function(param){
  			var dname=$('#dname').textbox('getValue');
  			var dip=$('#dip').textbox('getValue');
  			var dgroup=$('#dgroup').textbox('getValue');
  			var dchannel=$('#dchannel').textbox('getValue');
  			var pointx=$('#pointx').textbox('getValue');
  			var pointy=$('#pointy').textbox('getValue'); 			
  			if(dname==""||dip==""||dgroup==""||dchannel==""||pointx==""||pointy==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				} 
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	function deldevice(){
    	/* var node= $("#deviceGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#deviceGrid").datagrid('getChecked');
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
	            	//url:'<%=basePath%>Main/comdevicemanagement/devicedel/'+node.ID,
	            	url:'<%=basePath%>Main/comdevicemanagement/devicedel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#deviceGrid").datagrid('clearSelections');
	            			$("#deviceGrid").datagrid('clearChecked');
	            			$("#deviceGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	
	</script>

		
 <div class="easyui-layout" data-options="fit:true">
 	 <div data-options="region:'west',split:true,border:false" style="width:20%">
			<ul id="typeTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',border:false">
		<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<!-- <span>设备类型:</span>
		<select id="devicetype" class="easyui-combobox" data-options="icons:iconClear" editable="false" panelHeight="auto" code="TXSBLX" style="width:150px;"></select>		 -->
		<span>设备编码:</span>
		<input id="devicecode" type="text" class="easyui-textbox" >
		<span>设备名称:</span>
		<input id="devicename" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="device_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
		
		<!-- <div id="device_tb">
		<a href="javascript:void(0);" onclick="adddevice()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<a  href="javascript:void(0);" onclick="upddevice()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<a href="javascript:void(0);" onclick="deldevice()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div> -->
		
			<table id="deviceGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> <th field="DCODE" width="100">设备编码</th> 
			            <th field="DNAME" width="100">设备名称</th> 
			            <th field="DTYPE" code="TXSBLX" width="100">设备类型</th>	
			            <th field="IP" width="100">设备IP</th>
			             <th field="PORT" width="100">设备端口</th>
			             <th field="ADDRESS" width="300">设备地址</th> 
			             	         
			        </tr> 
			    </thead> 
			</table> 
		</div>
		</div>
		</div>
		</div>
