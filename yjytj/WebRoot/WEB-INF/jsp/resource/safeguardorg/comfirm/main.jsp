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
						   
						  { text:'添加', title:'添加通讯保障机构信息', iconCls: 'icon-add', dialogParams:{dialogId:'comfirmDialog', href:'<%=basePath%>Main/comfirm/add', 
							  width:960,height:600, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改通讯保障机构信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'comfirmDialog',href:'<%=basePath%>Main/comfirm/edit',width:960,
									height:600,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/comfirm/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewComfirm}
						],
				url:"<%=basePath%>Main/comfirm/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewComfirm();

				}
			};
		$.lauvan.dataGrid("comfirm_data",attrArray);

		
	});

	function comfirmSrh(){
		$("#comfirm_data").datagrid('load', {
			firmname: $("#firmname").val(),
			levelcode: $("#firmlevelcode").combobox('getValue'),
			classcode: $("#firmclasscode").combobox('getValue'),
		});
	}

	function viewComfirm(){
		var row = $("#comfirm_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '通讯保障机构基本详情',
			height: 550,
			width: 940,
			href:'<%=basePath%>Main/comfirm/view/' +row.FIRMID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("comfirmDialog",para,null,null);		
	}

	
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
	 	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>机构名称：</span>
			<input id="firmname" type="text" class="easyui-textbox" data-options="icons:iconClear" style="width:150px;"/>
			<span>级别：</span>
			<select id="firmlevelcode" class="easyui-combobox" code="ZDFHJBDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<span>密级：</span>
			<select id="firmclasscode" class="easyui-combobox" code="ZDFHMJDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="comfirmSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
		<div data-options="region:'center',border:false">
			<table id="comfirm_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="FIRMID" data-options="hidden:true">ID</th> 
			            <th field="FIRMNAME" width="100">名称</th> 
			            <!-- <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别</th>
			            <th field="CLASSCODE" code="ZDFHMJDM" width="100">密级</th> -->
			            <th field="FAX" width="100">传真</th>
			            <th field="RESPPER" width="100">负责人</th>
			            <th field="RESPOTEL" width="130">负责人办公电话</th>
			            <th field="CONTACTPER" width="100">联系人</th>
			            <th field="CONTACTOTEL" width="130">联系人办公电话</th>
			            <!-- <th field="COMMVEHNUM" width="100">应急通信车数</th>
			            <th field="POWERVEHNUM" width="100">应急发电车数</th>
			            <th field="SATTELNUM" width="100">卫星电话数</th>
			            <th field="BASESTATIONNUM" width="100">基站总数</th> -->
			            <th field="ADDRESS" width="200">地址</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
