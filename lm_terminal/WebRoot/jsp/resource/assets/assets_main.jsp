<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案综合管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>

<body>
<ul role="tablist" id="maintab" class="nav nav-tabs">
   <li class="active"><a href="#square" data-toggle="tab">广场</a></li>
   <li ><a a href="#school" data-toggle="tab">学校</a></li>
   <li ><a a href="#bazaar" data-toggle="tab">市场</a></li>
   <li ><a a href="#supermarket" data-toggle="tab">商场</a></li>
   <li ><a a href="#hospital" data-toggle="tab">医院</a></li>
   <li ><a a href="#reservoir" data-toggle="tab">水库</a></li>
   <li ><a a href="#uptown" data-toggle="tab">社区</a></li>
   <li ><a a href="#company" data-toggle="tab">企业</a></li>
   <li ><a a href="#busstation" data-toggle="tab">汽车站</a></li>
   <li ><a a href="#entertainment" data-toggle="tab">娱乐场所</a></li>
</ul>
<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="square" >
         <iframe id="iframepage1" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/square"></iframe>
      </div>
      <div class="tab-pane fade" id="school" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/school"></iframe>
      </div>
      <div class="tab-pane fade" id="bazaar" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/bazaar"></iframe>
      </div>
      <div class="tab-pane fade" id="supermarket" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/supermarket"></iframe>
      </div>
      <div class="tab-pane fade" id="hospital" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/hospital"></iframe>
      </div>
      <div class="tab-pane fade" id="reservoir" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/reservoir"></iframe>
      </div>
      <div class="tab-pane fade" id="uptown" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/uptown"></iframe>
      </div>
      <div class="tab-pane fade" id="company" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/company"></iframe>
      </div>
      <div class="tab-pane fade" id="entertainment" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/entertainment"></iframe>
      </div>
      <div class="tab-pane fade" id="busstation" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="800px" src="resource/assets/busstation"></iframe>
      </div>
      
   </div>
</body>
</html>