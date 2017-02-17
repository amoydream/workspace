<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

 
	 
	 <form id="common_form" method="post" action="<%=basePath %>Main/common/changeBusSave" style="width:100%;">
	    <input type="hidden" name="tids" value="${tid}"/>
	    <input type="hidden" name="sup_id" value="${sup_id}"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">参数名称：</td>
		    	<td >
		    	<input type="text"  data-options="disabled:true" value="${tname}" class="easyui-textbox" style="width: 180px;"/></td>
		    	</tr>
		    	<%--<tr>
		  		<td class="sp-td1">菜单名称：</td>
		    	<td >
		    	<input type="text" name="modname" value="${tname}"  required="true" data-options="prompt:'请输入菜单名称',icons:iconClear"
		    	 class="easyui-textbox" style="width: 180px;"/></td>
		    	</tr>
		    	
		    	--%><tr>
		  		<td class="sp-td1">所属菜单目录</td>
		    	<td >
		    		<input class="easyui-combotree" name="model_id"
		    		data-options="url:'<%=basePath%>Main/busParam/getBusModelTree',method:'get',editable:false,required:true,icons:iconClear"
		    		 style="width:180px;">
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">页面形式：</td>
		    	<td >
		    	<select name="modsel" class="easyui-combobox" required="true" panelHeight="auto" style="width:180px;">
		    		<option value="1">树页面</option>
		    		<option value="0">列表页面</option>
		    	</select>
		    	</tr>
		    	
	    </table>
    </form>
