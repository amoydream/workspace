<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<div class="easyui-layout"  data-options="fit:true">
<form id="T_AutoView_form" method="post" action="" style="width:100%;margin: 0 auto;padding: 0;">
<input type="hidden" name="act" value="add"/>
<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
<tr>
<td class="sp-td1">对象：</td>
<td><select class="easyui-combobox"  panelHeight="auto"  name="t_AutoView.data_source" style="width: 80px;" data-options="editable:false" >
<option value="1" >4</option>
<option value="2" >5</option>
<option value="3" >6</option>
</select>
</td>
<td class="sp-td1">页面布局：</td>
<td><input  type="text" class="easyui-datebox"  name="t_AutoView.view_layout" style="width: 150px;"/></td>
</tr>
<tr>
<td class="sp-td1">视图类型：</td>
<td><input type="text" class="easyui-textbox"  name="t_AutoView.view_type" style="width: 150px;"/></td>
<td class="sp-td1">主键ID：</td>
<td><textarea  class="textbox easyui-validatebox"  name="t_AutoView.id" style="width: 80%;height: 50px;"></textarea></td>
</tr>
</table>
</form>

</div>
