<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script type="text/javascript">
	
	
	function task_doSearch(){
		$('#taskGrid').datagrid('load',{
			sendtime: $('#sendtimeid').datetimebox('getValue'),
		});
	}
	
	function addMission(){
		var attrArray={
				title:'新增派务',
				height: 300,
				width:600,
				href: '<%=basePath%>Main/vehicle/addmission'	
		};
		
		$.lauvan.openCustomDialog("missionDialog",attrArray,mission_addSubmit,'mission_form');	
	}
	
	function mission_addSubmit(){
		
	}
	
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<div id="vip_tb" style="margin-left:10px">
		<span>务派时间:</span>
		<input id="sendtimeid" type="text" class="easyui-datebox" editable="false">
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="task_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		<a href="javascript:void(0);" onclick="addMission()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增派务</a>
		</div>
		
			<table id="missionGrid" class="easyui-datagrid"  data-options="url:'Main/vehicle/missionGridData?id=${id}',pagination:true,onDblClickRow:showView"  cellspacing="0" cellpadding="0" height="92%" width="100%"> 
			    <thead> 
			        <tr> 			       
			            <th field="MISSION" width="150">派务</th> 
			            <th field="DRIVER"  width="100">司机</th> 
			            <th field="TEL"  width="100">电话</th> 
			            <th field="TIME"  width="130">时间</th> 			         
			            <th field="VNO"  width="120">车牌号</th> 			         
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
    <div id="missionViewDialog"></div>
