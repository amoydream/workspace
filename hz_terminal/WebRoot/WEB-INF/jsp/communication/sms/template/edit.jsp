<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	 
	 <form id="smsTempform" method="post" action="<%=basePath %>Main/smsTemp/save" style="width:100%;">
	    <input type="hidden" name="act" value="upd"/>
	     <input type="hidden" name="t_Send_Temp.id" value="${t.id}"/>
	    <table   class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	
		    	<tr>
		  		<td class="sp-td1">内容：</td>
		    	<td>
		    		<textarea name="t_Send_Temp.content" class="textarea easyui-validatebox" 
		    		data-options="required:true,validType:'length[0,70]'"  style="width: 560px;height: 100px;" >${t.content}</textarea>
		    	</td>
		    	</tr>
	    </table>
    </form>
