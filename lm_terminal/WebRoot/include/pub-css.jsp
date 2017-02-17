<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
    <!-- table需要引入的样式 -->
    <link rel="stylesheet" href="<%=basePath%>lauvanUI/bootstrap/css/bootstrap.min.css"></link>
    <link rel="stylesheet" href="lauvanUI/bootstrap/css/font-awesome.min.css"
	type="text/css"></link>
 