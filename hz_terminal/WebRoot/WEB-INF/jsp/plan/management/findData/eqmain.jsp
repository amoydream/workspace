<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'TEQ_ID',
				fitColumns : true,
				url:"<%=basePath%>Main/teamequip/getGridData/${team.tea_id}"
			};
		$.lauvan.dataGrid("teamEquipGrid",attrArray);

	});

	function getPoint(){
		$.lauvan.openGisDialog($("#pox").val(), $("#poy").val(), function(lng, lat){
			$("#pox").textbox('setValue', lng);
			$("#poy").textbox('setValue', lat);
			
		});
  	}

	function findEquipname(){
		var param = {
			title:'选择装备',
			width:600,
			height:500,
			href:'<%=basePath%>Main/equipname/getEquipname',
			buttons:[{
				text:'确定',
				iconCls:'icon-save',
				handler: function(){
					var row = $("#selectEquipGrid").datagrid("getSelected");
					$("#equipnameid").val(row.EQN_ID);
					$("#equipname").textbox('setValue', row.EQN_NAME);
					$("#selectDialog").dialog('close');
				}
			},{
				text:'关闭',
				iconCls:'icon-no',
				handler:function(){
					$("#selectDialog").dialog('close');
				}

			}]
		};
		$.lauvan.openCustomDialog("selectDialog", param, null, null);
	}

	</script>

			<table id="teamEquipGrid" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="TEQ_ID" data-options="hidden:true">ID</th> 
			            <th field="EQN_NAME" width="100">应急装备名称</th> 
			            <th field="NUM" width="100">数量</th>
			            <th field="MEASUREUNIT" CODE="MAUNIT" width="60">计量单位</th>
			            <th field="EQUIPDESC" width="100">装备描述</th>
			            <th field="ADDRESS" width="100">停放地址</th> 
			        </tr> 
			    </thead> 
			</table> 

