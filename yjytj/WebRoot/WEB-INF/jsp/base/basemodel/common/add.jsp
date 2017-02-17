<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

	 <form id="common_form" method="post" action="<%=basePath %>Main/common/save" style="width:100%;">
	    <input type="hidden" name="act" value="add"/>
	    <input type="hidden" name="t_Sys_Parameter.sup_id" value="${pid}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">参数名称：</td>
		    	<td><input  name="t_Sys_Parameter.p_name" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/>  </td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">参数编码：</td>
		    	<td >
		    	<input  name="t_Sys_Parameter.p_acode" type="text" class="easyui-textbox" data-options="required:true" style="width: 300px;"/>    
				</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		    	<td >
		    		<textarea name="t_Sys_Parameter.remark" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;"></textarea> 
		    	</td>
		    	</tr>
	    </table>
    </form>
