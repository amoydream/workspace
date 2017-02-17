<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
<title>测试</title>
	<%@ include file="/include/header.jsp"%>
	
  </head>
  
 <body>
 <div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'center',title:'center title'">
<div style="margin-top: 5px;margin-left: 5px;">
对象：<select class="easyui-combobox"  panelHeight="auto"  name="data_source_ser" style="width: 80px;" data-options="editable:false" >
<option value="1" >4</option>
<option value="2" >5</option>
<option value="3" >6</option>
</select>
页面布局：<input  type="text" class="easyui-datebox"  name="view_layout_ser" style="width: 150px;"/>
视图类型：<input type="text" class="easyui-textbox"  name="view_type_ser" style="width: 150px;"/>
<a href="javascript:void(0);" class="easyui-linkbutton"  data-options="iconCls:'icon-search',plain:true">
查询</a>
</div>
<table class="easyui-datagrid" cellspacing="0" cellpadding="0" data-options="fitColumns:true,pageSize:20,pageList:[20,50,100], pagination:true"  name="T_AutoView_grid">
 <thead>
 <tr>
<th field="DATA_SOURCE" width="150">对象</th>
<th field="VIEW_LAYOUT" width="150">页面布局</th>
<th field="VIEW_TYPE" width="150">视图类型</th>
<th field="ID" width="150">主键ID</th>
 </tr>
 </thead>
 </table>
</div>

	</div>

</body>
</html>
