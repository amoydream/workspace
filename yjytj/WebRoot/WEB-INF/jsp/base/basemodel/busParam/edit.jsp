<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	 
	 <form id="busParam_form" method="post" action="<%=basePath %>Main/busParam/save" style="width:100%;">
	    <input type="hidden" name="act" value="upd"/>
	     <input type="hidden" name="t_Sys_Parameter.id" value="${t.id}"/>
	     <input type="hidden" name="grid" value="${grid}_grid"/>
	     <input type="hidden" name="t_Sys_Parameter.sup_id" value="${t.sup_id}"/>
	     <input type="hidden" name="t_Sys_Parameter.ptype" value="00B"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		    	<td class="sp-td1">父级参数：</td>
		    	<td><input   type="text" class="easyui-textbox" data-options="disabled:true" value="${fpname}"  style="width: 300px;"/>  </td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">参数名称：</td>
		    	<td><input  name="t_Sys_Parameter.p_name" type="text" class="easyui-textbox" data-options="required:true" value="${t.p_name}"  style="width: 300px;"/>  </td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">参数编码：</td>
		    	<td >
		    	<input  name="t_Sys_Parameter.p_acode" type="text" class="easyui-textbox" data-options="required:true" value="${t.p_acode}"  style="width: 300px;"/>    
				</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		    	<td >
		    		<textarea name="t_Sys_Parameter.remark" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;">${t.remark}</textarea> 
		    	</td>
		    	</tr>
	    </table>
    </form>
