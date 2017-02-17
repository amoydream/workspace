<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'ID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加人员信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'personDialog', href:'<%=basePath%>Main/emsperson/add/${deptid}-${deptype}', 
								width:700, height:400, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改人员信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'personDialog',href:'<%=basePath%>Main/emsperson/edit',width:700,
									height:400,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/emsperson/delete'}}, '-',
						  { text: '查看',iconCls: 'icon-eye', handler:viewEmsperson}

						],
				url:"<%=basePath%>Main/emsperson/getGridData/${deptid}-${deptype}",
				onDblClickRow:function(rowIndex, rowData){
					viewEmsperson();
				}
			};
		$.lauvan.dataGrid("emsperson_data",attrArray);

	});

	

	function formatSex(val, row){
		if(val == '0'){
			return '男';
		}else{
			return '女';

		}

	}

	function viewEmsperson(){
		var row = $("#emsperson_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var para = {
				title: '人员信息详情',
				height:300,
				width: 650,
				href:'<%=basePath%>Main/emsperson/view/' +row.ID,
				buttons:[]
			};
			$.lauvan.openCustomDialog("personDialog",para,null,null);		
	}
	</script>

			<table id="emsperson_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ID" data-options="hidden:true">ID</th> 
			            <th field="PERSNAME" width="100">人员姓名</th> 
			           <%-- <th field="DEPTNAME" width="100">所属单位</th>
			            <th field="EQUTEAMNO" width="100">所属应急队伍编号</th> 
			            <th field="EQUTEAMNAME" width="100">所属应急队伍名称</th> 
			            --%><th field="PERSSEX" width="100" data-options="formatter:formatSex">性别</th> 
			             <th field="PERSNATIONID" code="MZ" width="100">民族</th> 
			            <th field="TEL_NUM" width="100">联系电话</th> 
			             <th field="FAMILYADDR" width="200">住址</th> 
			        </tr> 
			    </thead> 
			</table> 

