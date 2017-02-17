<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">创建人：</td>
		    	<td >${report.r_username}</td>	    
		        </tr>
		    	<tr>
		    	<td class="sp-td1">创建时间：</td>
		    	<td >${report.r_createtime}</td>	    
		        </tr>
		    	<tr>
		    	<td class="sp-td1">标题：</td>
		    	<td >${report.r_title}</td>	    
		        </tr>	
		        <tr>
			    <td class="sp-td1">内容：</td>
			    <td colspan="3"><textarea 
					class="textarea" data-options="validType:'length[0,500]'"
					style="width: 573px; height: 80px;" readonly="readonly">${report.r_content}</textarea></td>
		        </tr>	    
	    </table>
   </div>
   </div>