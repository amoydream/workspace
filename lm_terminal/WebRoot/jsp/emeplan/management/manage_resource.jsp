<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案综合管理-应急资源配置</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>

<body>
<ul id="teamEdit" class="nav nav-tabs">
   <li class="active"><a href="#resource1" data-toggle="tab">应急物资</a></li>
   <li><a a href="#resource2" data-toggle="tab">应急专家</a></li>
   <li><a a href="#resource3" data-toggle="tab">应急队伍</a></li>
</ul>
<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="resource1" >
         <iframe id="iframepage1" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" height="500px" width="99%" src="emeplan/planSupplies/list?pi_id=${param.piId }"></iframe>
      </div>
      <div class="tab-pane fade" id="resource2" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" height="500px" width="99%" src="emeplan/planExpert/list?pi_id=${param.piId }"></iframe>
      </div>
      <div class="tab-pane fade" id="resource3" >
         <iframe id="iframepage3" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" height="500px" width="99%" src="emeplan/planTeam/list?pi_id=${param.piId }"></iframe>
      </div>
   </div>
</body>
</html>