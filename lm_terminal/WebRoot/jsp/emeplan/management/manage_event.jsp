<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案综合管理-事件分类分级</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>

<body>
<ul id="teamEdit" class="nav nav-tabs">
   <li class="active"><a href="#resource1" data-toggle="tab">状况分类</a></li>
   <li><a a href="#resource2" data-toggle="tab">事件分级</a></li>
</ul>
<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="resource1" >
         <iframe id="f2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="500px" src="emeplan/conditionType/list?pi_id=${param.piId }"></iframe>
      </div>
      <div class="tab-pane fade" id="resource2" >
         <iframe id="f2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="500px" src="emeplan/classification/list?pi_id=${param.piId }"></iframe>
      </div>
   </div>
</body>
</html>