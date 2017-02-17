<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'DEPTID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加募捐机构信息', iconCls: 'icon-add', dialogParams:{dialogId:'colldeptDialog', href:'<%=basePath%>Main/colldept/add', 
							  width:960,height:600, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改募捐机构信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'colldeptDialog',href:'<%=basePath%>Main/colldept/edit',width:960,
									height:600,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',warnMsg:'您确定删除该募捐机构以及相关的募捐现存资金和分项资金吗？',delParams:{url:'<%=basePath%>Main/colldept/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewColldept}
						],
				url:"<%=basePath%>Main/colldept/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewColldept();

				}
			};
		$.lauvan.dataGrid("colldept_data",attrArray);

		
	});

	function colldeptSrh(){
		$("#colldept_data").datagrid('load', {
			colldeptname: $("#colldeptname").val(),
			colldepttype: $("#colldepttype").combobox('getValue'),
		});
	}

	function viewColldept(){
		var title= '募捐机构基本详情';
		var mainTab = $("#mainTab");
		var row = $("#colldept_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var url = '<%=basePath%>Main/colldept/view/' +row.DEPTID;
		if(mainTab.tabs('exists', title)){
			mainTab.tabs('select', title);
			mainTab.tabs('getSelected').panel('refresh', url);
		}else{
			mainTab.tabs('add',{
				title: title,
				href: url,
				iconCls:'icon-eye',
				closable: true
			});

		}
	}

	
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
	 	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>机构名称：</span>
			<input id="colldeptname" type="text" class="easyui-textbox" data-options="icons:iconClear" style="width:150px;"/>
			<span>机构类型：</span>
			<select id="colldepttype" data-options="icons:iconClear,panelHeight:145,method:'get',url:'<%=basePath%>Main/genekno/getTypeTreeByAcode/YJJG'" class="easyui-combotree"" style="width:150px;"></select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="colldeptSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
		<div data-options="region:'center',border:false">
			<table id="colldept_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="DEPTID" data-options="hidden:true">ID</th> 
			            <th field="DEPTNAME" width="100">机构名称</th> 
			            <th field="ADDRESS" width="150">地址</th>
			            <th field="DEPTTYPECODE" code="YJJG" width="100">机构类型</th>
			            <th field="FAX" width="100">传真</th>
			            <th field="RESPPER" width="100">负责人</th>
			            <th field="RESPOTEL" width="130">负责人办公电话</th>
			            <th field="CONTACTPER" width="100">联系人</th>
			            <th field="CONTACTOTEL" width="130">联系人办公电话</th>
			            <th field="CONTACTTEL" width="100">捐赠热线电话</th>
			            <th field="OPENACCBANK" width="100">开户行</th>
			            <th field="ACCOUNTNAME" width="100">账户名称</th>
			            <th field="ACCOUNTS" width="100">账号</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
