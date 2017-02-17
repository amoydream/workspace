<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<c:if test="${!empty ellist}">
	<c:forEach items="${ellist}" var="ellist">
		<input type="radio" name="epradio" value="${ellist.itemid}" onclick="epradioClick(this.value)" <c:if test="${ellist.ischecked==1}"> checked="checked"</c:if> style="width: 20px;"/>
		${ellist.name} : ${ellist.itemcontent}</br>
	</c:forEach>
</c:if>
<input type="radio" name="epradio" value="" onclick="epradioClick(this.value)" <c:if test="${empty ellist || elevel==''}"> checked="checked"</c:if> style="width: 20px;"/>*级 : 无相关判断条件</br>
