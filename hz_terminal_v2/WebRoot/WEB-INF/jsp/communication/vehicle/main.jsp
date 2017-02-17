<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				//toolbar: '#mobileuser_tb',
				toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:addVehicle,permitParams:'${pert:hasperti(applicationScope.Vehicleadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:updVehicle,permitParams:'${pert:hasperti(applicationScope.Vehicleupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:delVehicle,permitParams:'${pert:hasperti(applicationScope.Vehicledel, loginModel.xdlimit)}'}, '-',              
                  { text: '务派',iconCls: 'icon-car',handler:missionVehicle,permitParams:'${pert:hasperti(applicationScope.Vehicledel, loginModel.xdlimit)}'}             
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true, 
				url:"<%=basePath%>Main/vehicle/getGridData"
				<%-- ,
				onDblClickRow:function(rowIndex, rowData) {
			        //打开详情页面
			        $("#VehicleViewDialog").dialog({
			            title : '公告详情',
			            width : 800,
			            height : 380,
			            cache : false,
			            modal : true,
			            href : "<%=basePath%>Main/vehicle/view/" + rowData.ID,
			            buttons : []
			        });
		        } --%>
        };
		$.lauvan.dataGrid("vehicleGrid",attrArray);
		
	});
	
	function missionVehicle(){
		var node = $("#vehicleGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲务派的车辆！'});
			return;
		}
		var attrArray={
				title:'车辆务派',
				height: 400,
				width:650,
				href: '<%=basePath%>Main/vehicle/missionip/'+node.ID,
				buttons : []	
		};
		$.lauvan.openCustomDialog("missionDialog",attrArray,Vehicle_editSubmit,'vehicle_form');			
	}
	
	function showView(rowIndex, rowData){
		$("#missionViewDialog").dialog({
            title : '务派详情',
            width : 500,
            height : 450,       
            href : "<%=basePath%>Main/vehicle/getmissionview/" + rowData.ID,
            buttons : []
        });		
	}
	
	function Vehicle_doSearch(){
		$('#vehicleGrid').datagrid('load',{
			title:$('#titleid').val(),
			username:$('#usernameid').val(),
			createtime:$('#createtimeid').datebox('getValue')	
		});	
	}
	function addVehicle(){
		var attrArray={
				title:'新增车辆',
				height: 510,
				width:460,
				href: '<%=basePath%>Main/vehicle/add'	
		};
		
		$.lauvan.openCustomDialog("VehicleDialog",attrArray,Vehicle_addSubmit,'vehicle_form');	
	}
	function updVehicle(){
		var node = $("#vehicleGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改车辆',
				height: 510,
				width:460,
				href: '<%=basePath%>Main/vehicle/edit/'+node.ID				
		};
		$.lauvan.openCustomDialog("VehicleDialog",attrArray,Vehicle_editSubmit,'vehicle_form');
	}
	
	function Vehicle_addSubmit(){
  		$('#Vehicle_form').form('submit',{
  			onSubmit:function(param){				
  			var title=$('#atitleid').textbox('getValue');	
  			var content=document.getElementById("acontentid").value;	
  			if(title==""||content==""){
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
	function Vehicle_editSubmit(){
  		$('#vehicle_form').form('submit',{
  			onSubmit:function(param){
  				var title=$('#utitleid').textbox('getValue');
  				var content=document.getElementById("ucontentid").value;		
  	  			if(title==""||content==""){
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
	function delVehicle(){
		var nodes= $("#vehicleGrid").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请勾选欲删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
			 ids=ids+nodes[i].ID+",";
			 }
    	ids=ids.substring(0,ids.length-1);
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	url:'<%=basePath%>Main/Vehicle/del?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#vehicleGrid").datagrid('clearSelections');
	            			$("#vehicleGrid").datagrid('clearChecked');
	            			$("#vehicleGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	
	function sendtask(id){
		var attrArray={
				title:'发送任务',
				height: 300,
				width:700,
				href: '<%=basePath%>Main/mobileuser/sendtask?ids='+id,
				buttons: [{
					text:'发送',
					iconCls:'icon-save',
					id : 'sendtaskButid',
					handler:function(){
					sendtasktom_dialogSubmit();
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#sendtasktomDialog").dialog('close');
					}
				}]
		};
		$.lauvan.openCustomDialog("sendtasktomDialog",attrArray,sendtasktom_dialogSubmit,'sendtasktom_form');	
	}
	
	function sendTaskList(){
		var rows= $("#mobileuserGrid").datagrid('getChecked');
		var ids="";
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请勾选需要发送的终端用户!'});
			return;
		}
		for (var i = 0; i < rows.length; i++) {
			 ids=ids+rows[i].ID+",";
			 }
   	     ids=ids.substring(0,ids.length-1);	
		var attrArray={
				title:'发送任务',
				height: 300,
				width:700,
				href: '<%=basePath%>Main/mobileuser/sendtask?ids='+ids,
				buttons: [{
					text:'发送',
					iconCls:'icon-save',
					id : 'sendtaskButid',
					handler:function(){
					sendtasktom_dialogSubmit();
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#sendtasktomDialog").dialog('close');
					}
				}]
		};
		$.lauvan.openCustomDialog("sendtasktomDialog",attrArray,sendtasktom_dialogSubmit,'sendtasktom_form');	
		
	}
	
	
		
	function sendAdd_dialogSubmit(){
		$("#Vehicle_form").attr("action","<%=basePath%>Main/Vehicle/send");
		$('#Vehicle_form').form('submit',{
  			onSubmit:function(param){
  				var title=$('#atitleid').textbox('getValue');
  				var content=document.getElementById("acontentid").value;		
  	  			if(title==""||content==""){
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
	
	function sendUdp_dialogSubmit(){  
		$("#Vehicle_form").attr("action","<%=basePath%>Main/Vehicle/send");
		$('#Vehicle_form').form('submit',{
  			onSubmit:function(param){
  				var title=$('#utitleid').textbox('getValue');
  				var content=document.getElementById("ucontentid").value;		
  	  			if(title==""||content==""){
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
	
	function searchTaskList(){
		var node= $("#mobileuserGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲查询的终端用户 ！'});
			return;
		}
		var attrArray={
				title:'发送记录',
				height: 500,
				width:1000,
				href: '<%=basePath%>Main/mobileuser/getTaskView/'+node.ID,
				buttons:[]
		};
		$.lauvan.openCustomDialog("taskDialog",attrArray,null,null);
	}
	
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>品牌:</span>
		<input id="titleid" type="text" class="easyui-textbox" data-options="icons:iconClear">
		<span>车牌号:</span>
		<input id="usernameid" type="text" class="easyui-textbox" data-options="icons:iconClear">				
		<a href="javascript:void(0);"
			class="easyui-linkbutton" onclick="Vehicle_doSearch()"
			data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="vehicleGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="BRAND" width="120">品牌</th>
			            <th field="VNUM" width="100">车辆型号</th> 
			            <th field="VNO" width="100">车牌号</th>	
			            <th field="GRADE" width="100">等级</th>	
			            <th field="BOX" width="100">厢型</th>	
			            <th field="SEATNUM" width="100">座数</th>				            
			            <th field="SPEEDLIMIT" width="100">限速（km/时）</th>				            
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
	<div id="VehicleViewDialog"></div>
