<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案综合管理-预案信息公布</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>

<body>
<ul id="teamEdit" class="nav nav-tabs">
   <li class="active"><a href="#resource1" data-toggle="tab">通知单位</a></li>
   <li><a a href="#resource2" data-toggle="tab">通告单位</a></li>
</ul>
<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="resource1" >
         <iframe id="f2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" src="jsp/emeplan/management/manage_publication_proclamation.jsp?pi_id=${param.piId }" ></iframe>
      </div>
      <div class="tab-pane fade" id="resource2" >
         <iframe id="f2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" src="jsp/emeplan/management/manage_publication_notification.jsp?pi_id=${param.piId }" ></iframe>
      </div>
   </div>
</body>
</html>