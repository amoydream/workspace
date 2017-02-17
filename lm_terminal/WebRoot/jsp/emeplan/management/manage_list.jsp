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
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>

<body>
<ul role="tablist" id="maintab" class="nav nav-tabs">
   <li class="active"><a href="#manage1" data-toggle="tab">预案基本信息</a></li>
   <li><a a href="#manage2" data-toggle="tab">预案应急机构</a></li>
   <li><a a href="#manage3" data-toggle="tab">应急资源配置</a></li>
   <li><a href="#manage4" data-toggle="tab">事件分类分级</a></li>
   <li><a href="#manage5" data-toggle="tab">预案应急处置</a></li>
</ul>
<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="manage1" >
         <iframe id="iframepage0" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="emeplan/planinfo/view?id=${param.piId }"></iframe>
      </div>
      <div class="tab-pane fade" id="manage2" >
         <iframe id="iframepage0" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="jsp/emeplan/management/manage_organ.jsp?piId=${param.piId }"></iframe>
      </div>
      <div class="tab-pane fade" id="manage3" >
         <iframe id="iframepage1" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="jsp/emeplan/management/manage_resource.jsp?piId=${param.piId }"></iframe>
      </div>
      <div class="tab-pane fade" id="manage4" >
         <iframe id="iframepage3" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="jsp/emeplan/management/manage_event.jsp?piId=${param.piId }"></iframe>
      </div>
      <div class="tab-pane fade" id="manage5" >
         <iframe id="iframepage4" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="jsp/emeplan/management/manage_handle.jsp?piId=${param.piId }"></iframe>
      </div>
   </div>
</body>
</html>