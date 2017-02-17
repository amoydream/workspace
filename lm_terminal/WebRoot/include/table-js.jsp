<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
    <!-- table需要引入的js -->
    <!-- jQuery 2.1.4 -->
    <script src="<%=basePath%>lauvanUI/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="<%=basePath%>lauvanUI/bootstrap/js/bootstrap.min.js"></script>
    <!-- DataTables -->
    <script src="<%=basePath%>lauvanUI/plugins/datatables/js/jquery.dataTables.js"></script>
    <script src="<%=basePath%>lauvanUI/plugins/datatables/js/dataTables.bootstrap.js"></script>
  