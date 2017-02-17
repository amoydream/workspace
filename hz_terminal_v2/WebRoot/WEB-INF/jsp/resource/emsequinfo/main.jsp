<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'EQUID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加设备信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'equinfoDialog', href:'<%=basePath%>Main/emsequinfo/add/${civi.deptid}', 
								width:700, height:560, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改设备信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'equinfoDialog',href:'<%=basePath%>Main/emsequinfo/edit',width:700,
									height:560,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/emsequinfo/delete'}}

						],
				url:"<%=basePath%>Main/emsequinfo/getGridData/${civi.deptid}"
			};
		$.lauvan.dataGrid("equinfo_data",attrArray);

	});

	function getPoint(){
		$.lauvan.openGisDialog($("#pox").val(), $("#poy").val(), function(lng, lat){
			$("#pox").textbox('setValue', lng);
			$("#poy").textbox('setValue', lat);
			
		});
  	}

	function findequip(){
  		var param = {
  				title:'选择装备',
  				width:690,
  				height:500,
  				href:'<%=basePath%>Main/emsequinfo/getEquipList',
  				buttons:[{
  					text:'确定',
  					iconCls:'icon-save',
  					handler: function(){
  						var row = $("#equGrid").datagrid("getSelected");
  						$("#equtypeid").val(row.EQU_ID);
  						$("#equname").textbox('setValue', row.EQN_NAME);
  						$("#equipDialog").dialog('close');
  					}
  				},{
  					text:'关闭',
  					iconCls:'icon-no',
  					handler:function(){
  						$("#equipDialog").dialog('close');
  					}

  				}]
  			};
  			$.lauvan.openCustomDialog("equipDialog", param, null, null);
  	}
	</script>

			<table id="equinfo_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="EQUID" data-options="hidden:true">ID</th> 
			            <th field="EQUNAME" width="100">应急装备名称</th> 
			            <th field="EQULINKER" width="100">联系人</th>
			            <th field="EQURECDATE" width="100">填报日期</th> 
			        </tr> 
			    </thead> 
			</table> 

