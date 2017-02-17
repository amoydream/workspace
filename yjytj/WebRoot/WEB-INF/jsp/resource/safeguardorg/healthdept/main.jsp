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
						   
						  { text:'添加', title:'添加医疗机构信息', iconCls: 'icon-add', dialogParams:{dialogId:'healthdeptDialog', href:'<%=basePath%>Main/healthdept/add', 
							  width:960,height:600, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改医疗机构信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'healthdeptDialog',href:'<%=basePath%>Main/healthdept/edit',width:960,
									height:600,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/healthdept/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewhealDept}
						],
				url:"<%=basePath%>Main/healthdept/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewhealDept();

				}
			};
		$.lauvan.dataGrid("healthdept_data",attrArray);

		
	});

	function healdeptSrh(){
		$("#healthdept_data").datagrid('load', {
			deptname: $("#healthdeptname").val(),
			levelcode: $("#levelcode").combobox('getValue'),
			classcode: $("#classcode").combobox('getValue'),
			gradecode: $("#gradecode").combobox('getValue')
		});
	}

	function viewhealDept(){
		var row = $("#healthdept_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '医疗机构基本详情',
			height: 550,
			width: 940,
			href:'<%=basePath%>Main/healthdept/view/' +row.DEPTID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("healthdeptDialog",para,null,null);		
	}

	
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
	 	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>机构名称：</span>
			<input id="healthdeptname" type="text" class="easyui-textbox" data-options="icons:iconClear" style="width:150px;"/>
			<span>单位等级：</span>
			<select id="gradecode" class="easyui-combobox" code="YLDWGRADE" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<span>级别：</span>
			<select id="levelcode" class="easyui-combobox" code="ZDFHJBDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<span>密级：</span>
			<select id="classcode" class="easyui-combobox" code="ZDFHMJDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="healdeptSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
		<div data-options="region:'center',border:false">
			<table id="healthdept_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="DEPTID" data-options="hidden:true">ID</th> 
			            <th field="DEPTNAME" width="100">机构名称</th> 
			            <!-- <th field="ADDRESS" width="150">地址</th> -->
			            <th field="DEPTGRADECODE" code="YLDWGRADE" width="100">单位等级</th>
			            <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别</th>
			            <th field="CLASSCODE" code="ZDFHMJDM" width="100">密级</th>
			            <th field="FAX" width="100">传真</th>
			            <th field="BEDNUM" width="100">病床数</th>
			            <th field="DOCTORNUM" width="100">医生数</th>
			            <th field="NURSENUM" width="100">护士数</th>
			            <th field="AMBULANCENUM" width="100">急救车辆数量</th>
			            <th field="RESPPER" width="100">负责人</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
