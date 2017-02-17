<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'FUNDID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加应急救援资金信息', iconCls: 'icon-add', dialogParams:{dialogId:'emfundDialog', href:'<%=basePath%>Main/emfund/add', 
							  width:960,height:550, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改应急救援资金信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'emfundDialog',href:'<%=basePath%>Main/emfund/edit',width:960,
									height:550,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/emfund/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewEmfundfirm}
						],
				url:"<%=basePath%>Main/emfund/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewEmfundfirm();

				}
				
			};
		$.lauvan.dataGrid("emfund_data",attrArray);

		
	});

	function emfundSrh(){
		$("#emfund_data").datagrid('load', {
			fundname: $("#emfundname").val(),
			levelcode: $("#emfundlevelcode").combobox('getValue'),
			classcode: $("#emfundclasscode").combobox('getValue'),
		});
	}

	function viewEmfundfirm(){
		var row = $("#emfund_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		
		var para = {
			title: '应急救援资金详情',
			height: 500,
			width: 960,
			href:'<%=basePath%>Main/emfund/view/' +row.FUNDID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("emfundDialog",para,null,null);	
	}

	
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
	 	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>资金名称：</span>
			<input id="emfundname" type="text" class="easyui-textbox" data-options="icons:iconClear" style="width:150px;"/>
			<span>级别：</span>
			<select id="emfundlevelcode" class="easyui-combobox" code="ZDFHJBDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<span>密级：</span>
			<select id="emfundclasscode" class="easyui-combobox" code="ZDFHMJDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="emfundSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
		<div data-options="region:'center',border:false">
			<table id="emfund_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="FUNDID" data-options="hidden:true">ID</th> 
			            <th field="FUNDNAME" width="100">名称</th> 
			            <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别</th>
			            <th field="CLASSCODE" code="ZDFHMJDM" width="100">密级</th>
			            <th field="FAX" width="100">传真</th>
			            <th field="RESPPER" width="100">负责人</th>
			            <th field="RESPOTEL" width="130">负责人办公电话</th>
			            <th field="CONTACTPER" width="100">联系人</th>
			            <th field="CONTACTOTEL" width="130">联系人办公电话</th>
			             <th field="FUNDSOURCECODE" code="FUNDCOME" width="100">资金来源代码</th>
			              <th field="AMOUNT" width="100">资金金额</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
