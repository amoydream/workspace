<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 	 
	 <form id="pwd_form" method="post" action="<%=basePath %>Main/pwordSave" style="width:100%;">
	    <input type="hidden" name="userid" value="${userid}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">账号：</td>
		    	<td>${useraccount}</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">新密码：</td>
		    	<td >
		    	<input id="pwd" name="pwd" type="password" class="easyui-textbox" data-options="required:true,validType:'password'" style="width: 200px;" />   
				</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">确认密码：</td>
		    	<td >
		    		<input id="rpwd" name="rpwd" type="password" class="easyui-textbox"     
   						 required="required" validType="equals['#pwd']" style="width: 200px;"/> 
		    	</td>
		    	</tr>
	    </table>
  
    </form>
