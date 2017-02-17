<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
 
	 
	 <form id="serviceform" method="post" action="<%=basePath %>Main/service/save" style="width:100%;">
	    <input type="hidden" name="act" value="upd"/>
	    <input type="hidden" name="t_Sys_DataService.id" value="${s.id}"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">业务名称：</td>
		    	<td >
		    	<input type="text" name="t_Sys_DataService.servicename" data-options="prompt:'请输入业务名称',required:true,icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;" value="${s.servicename}"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">业务代码</td>
		    	<td >
		    	<input type="text" name="t_Sys_DataService.servicetable"  required="true" data-options="prompt:'请输入数据库中的业务表名或业务视图名',icons:iconClear"
		    	 class="easyui-textbox" style="width: 180px;" value="${s.servicetable}"/></td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">所属功能模块</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Sys_DataService.model_id" data-options="url:'<%=basePath%>Main/service/getModelTree',method:'get',required:true,value:${s.model_id}" style="width:180px;">
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注</td>
		    	<td >
		    		<textarea name="t_Sys_DataService.remark" class="textarea" 
		    		data-options="validType:'length[0,200]'"  style="width: 200px;height: 50px;" >${s.remark}</textarea>
		    	</td>
		    	</tr>
	    </table>
    </form>
