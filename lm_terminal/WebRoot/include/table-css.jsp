<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
    <!-- table需要引入的样式 -->
    <link rel="stylesheet" href="<%=basePath%>lauvanUI/bootstrap/css/bootstrap.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="<%=basePath%>lauvanUI/plugins/datatables/css/dataTables.bootstrap.css">
    <link rel="stylesheet" href="<%=basePath%>lauvanUI/plugins/datatables/css/jquery.dataTables.css">
