<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={ toolbar: [
                  { text: '添加',title:'添加业务', iconCls: 'icon-add',
	                   dialogParams:{dialogId:'serviceDialog',href:basePath+"Main/service/add",width:500,
						height:350,formId:'serviceform',isNoParam:true}}, '-', 
                  { text: '修改',title:'编辑业务',iconCls: 'icon-pageedit', 
		                   dialogParams:{dialogId:'serviceDialog',href:basePath+"Main/service/edit",width:500,
								height:350,formId:'serviceform'}}, '-',
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/service/delete'}}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/service/getDataGrid"};
		$.lauvan.dataGrid("serviceGrid",attrArray);
		});

	
	function service_doSearch(){
		$('#serviceGrid').datagrid('load',{
			sname: $('#sname').val(),
			scode: $('#scode').val()
		});
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>业务名称：</span>
			<input id="sname" type="text" class="easyui-textbox" >
			<span>业务代码：</span>
			<input id="scode" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="service_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="serviceGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="SERVICENAME" width="150">业务名称</th> 
			            <th field="SERVICETABLE" width="100"  >业务代码</th>
			            <th field="REMARK" width="150" >备注</th>
			            <th field="MODELNAME" width="100"  >所属功能模块</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

