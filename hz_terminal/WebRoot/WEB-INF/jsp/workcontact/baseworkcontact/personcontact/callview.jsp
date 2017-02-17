<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<style>
.call-td{ background:#F1F7FF; color:#FF5809;border-right:1px solid #B9CDE3; width:120px; text-align:left;font-size:15px;}
</style>
		<form id="view_form1" style="width:100%;">
	    <table  id="viewform" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<c:forEach items="${wnlist}" varStatus="status" var="item1" >
		    	<tr>
		    	<td class="sp-td1" style="width:30px;">${status.index + 1 }.办公电话：</td>
		    	<td class="call-td">
		        <ul class="specil_button">
		        <li><span>${item1}</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="callout(${item1 },null);$('#calloutDialog').dialog('close');"><span></span>拨打</a></li></ul>
		    	</td>	    	    
		        </tr>	
		        </c:forEach>     
		        <c:forEach items="${mnlist}" varStatus="status" var="item2" > 
		    	<tr>
		    	<td class="sp-td1" style="width:30px;">${status.index + 1 }.手机：</td>
		    	<td class="call-td">
		        <ul class="specil_button">
		        <li><span>${item2 }</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="callout(${item2 },null);$('#calloutDialog').dialog('close');"><span></span>拨打</a></li></ul>
		        </td>	    	    
		        </tr>	
		        </c:forEach>       
		         <c:forEach items="${hnlist}" varStatus="status" var="item3" >   
		    	<tr>
		    	<td class="sp-td1" style="width:30px;">${status.index + 1 }.住宅电话：</td>
		    	<td class="call-td">
		        <ul class="specil_button">
		        <li><span>${item3 }</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="callout(${item3 },null);$('#calloutDialog').dialog('close');"><span></span>拨打</a></li></ul>
		    	</td>	      
		        </tr>	
		        </c:forEach>           
	    </table>
	    </form>