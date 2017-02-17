<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    <tr>
		  	<td class="sp-td1" style="text-align: center;">号码</td>
		  	<td class="sp-td1" style="text-align: center;">时间</td>
		  	<td class="sp-td1" style="text-align: center;">状态</td>
		 </tr>
	    <c:if test="${!empty rptlist}">
	    <c:forEach items="${rptlist}" var="rptlist">
	    <tr>
	    	<td>${rptlist.mobile}</td>
	    	<td>${rptlist.rpt_time}</td>
	    	<td>${rptlist.rpt_desc}</td>
	    </tr>
	   </c:forEach>
		  </c:if>  	
		    <c:if test="${empty rptlist}">
		    <tr>
		  		<td colspan="3">暂无回执信息</td>
		  	</tr>
		    </c:if>
	    </table>
   </div>
   </div>
