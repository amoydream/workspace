<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

	 <form id="form1" method="post" action="<%=basePath %>Main/role/save" style="width:100%;">
	    <input type="hidden" name="act" value="add"/>
	    <input type="hidden" name="t_Sys_Role.pid" value="${pid}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">角色名称</td>
		    	<td >
		    	<input type="text" id="abc" name="t_Sys_Role.role_name" data-options="prompt:'请输入角色名称',required:true,icons:iconClear" class="easyui-textbox" style="width:70%"/></td>
		    	</tr>
		    	<c:if test="${loginModel.isSuper}">
		    	<tr>
		  		<td class="sp-td1">所属部门</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Sys_Role.suporg" data-options="url:'<%=basePath%>Main/department/getComboTree',method:'get',required:true<c:if test="${pid!='0'}">,value:${pid }</c:if>" style="width:70%;">
		    	</td>
		    	</tr>
		    	</c:if>
		    	<tr>
		  		<td class="sp-td1">是否启用</td>
		    	<td >
		    		<select name="t_Sys_Role.status" class="easyui-combobox" style="width:80px;" data-options="panelHeight:45,editable:false">
		    			<option value="1">启用</option>
		    			<option value="0">禁用</option>
		    		</select>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">角色描述</td>
		    	<td >
		    		<textarea name="t_Sys_Role.role_description" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width: 250px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
	    </table>
    </form>
