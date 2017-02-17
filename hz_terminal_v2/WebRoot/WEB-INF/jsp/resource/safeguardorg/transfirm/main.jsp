<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'FIRMID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加运输企业信息', iconCls: 'icon-add', dialogParams:{dialogId:'transfirmDialog', href:'<%=basePath%>Main/transfirm/add', 
							  width:960,height:600, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改运输企业信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'transfirmDialog',href:'<%=basePath%>Main/transfirm/edit',width:960,
									height:600,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/transfirm/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewTransfirm}
						],
				url:"<%=basePath%>Main/transfirm/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewTransfirm();

				}//,
				//view: detailview,
				//detailFormatter:function(index, row){
				//	return '<div style=""><table id="tool_"' + row.FIRMID + '"></table></div>';
				//},
				//onExpandRow: function(index,row){
				//	$("#tool_"+ row.FIRMID).datagrid({
				//		fil

				//	});
				//}
				
			};
		$.lauvan.dataGrid("transfirm_data",attrArray);

		
	});

	function comfirmSrh(){
		$("#transfirm_data").datagrid('load', {
			firmname: $("#transfirmname").val(),
			levelcode: $("#transfirmlevelcode").combobox('getValue'),
			classcode: $("#transfirmclasscode").combobox('getValue'),
		});
	}

	function viewTransfirm(){
		//var title= '运输企业基本详情';
		//var mainTab = $("#mainTab");
		var row = $("#transfirm_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		//var url = "<%=basePath%>Main/transfirm/view/" +row.FIRMID;
		//if(mainTab.tabs('exists', title)){
		//	mainTab.tabs('select', title);
		//	mainTab.tabs('getSelected').panel('refresh', url);
		//}else{
			//新建查看组织详情的tab
		//	mainTab.tabs('add', {
		//		title: title,
		//		href: url,
		//		iconCls: 'icon-eye',
		//		closable: true
		//	});
		var para = {
			title: '运输企业基本详情',
			height: 600,
			width: 960,
			href:'<%=basePath%>Main/transfirm/view/' +row.FIRMID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("transfirmDialog",para,null,null);	
	}

	
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
	 	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>机构名称：</span>
			<input id="transfirmname" type="text" class="easyui-textbox" data-options="icons:iconClear" style="width:150px;"/>
			<span>级别：</span>
			<select id="transfirmlevelcode" class="easyui-combobox" code="ZDFHJBDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<span>密级：</span>
			<select id="transfirmclasscode" class="easyui-combobox" code="ZDFHMJDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="comfirmSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
		<div data-options="region:'center',border:false">
			<table id="transfirm_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="FIRMID" data-options="hidden:true">ID</th> 
			            <th field="FIRMNAME" width="100">名称</th> 
			            <th field="ADDRESS" width="150">地址</th>
			            <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别</th>
			            <th field="CLASSCODE" code="ZDFHMJDM" width="100">密级</th>
			            <th field="FAX" width="100">传真</th>
			            <th field="RESPPER" width="100">负责人</th>
			            <th field="RESPOTEL" width="130">负责人办公电话</th>
			            <th field="CONTACTPER" width="100">联系人</th>
			            <th field="CONTACTOTEL" width="130">联系人办公电话</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
