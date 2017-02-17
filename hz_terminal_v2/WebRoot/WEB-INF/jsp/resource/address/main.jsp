<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'ADD_CODE',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加通讯信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'addressDialog', href:'<%=basePath%>Main/address/add/${s.personid}', 
								width:700, height:460, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改通讯信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'addressDialog',href:'<%=basePath%>Main/address/edit',width:700,
									height:460,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/address/delete'}}

						],
				url:"<%=basePath%>Main/address/getGridData/${s.personid}"
			};
		$.lauvan.dataGrid("address_data",attrArray);

	});

	
	</script>

			<table id="address_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ADD_CODE" data-options="hidden:true">ID</th>
			            <th field="TELE_TYPE" code="CONN" width="100">联系方式</th>  
			            <th field="TELE_CODE" width="100">联系号码</th> 
			            <th field="DISTINCTION" width="100">优先级别</th>
			        </tr> 
			    </thead> 
			</table> 

