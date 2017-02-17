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
<c:if test="${param.pid==null }">
<ul role="tablist" id="maintab" class="nav nav-tabs">
   <li class="active"><a href="#faxsend" data-toggle="tab">传真发送</a></li>
   <li><a a href="#faxreceive" data-toggle="tab">传真接收</a></li>
   <li><a a href="#sendgroup" data-toggle="tab">群发传真</a></li>
</ul>

<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="faxsend" >
         <iframe id="iframepage1" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="dutymanage/fax/sendlist"></iframe>
      </div>
      <div class="tab-pane fade" id="faxreceive" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="dutymanage/fax/receivelist"></iframe>
      </div>
      <div class="tab-pane fade" id="sendgroup" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="dutymanage/fax/sendgroup"></iframe>
      </div>
   </div>
</c:if>

<c:if test="${param.pid==1 }">
<ul role="tablist" id="maintab" class="nav nav-tabs">
   <li><a href="#faxsend" data-toggle="tab">传真发送</a></li>
   <li class="active"><a a href="#faxreceive" data-toggle="tab">传真接收</a></li>
   <li><a href="#sendgroup" data-toggle="tab">群发传真</a></li>
</ul>

<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade " id="faxsend" >
         <iframe id="iframepage1" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="dutymanage/fax/sendlist"></iframe>
      </div>
      <div class="tab-pane fade in active" id="faxreceive" >
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="dutymanage/fax/receivelist"></iframe>
      </div>
      <div class="tab-pane fade " id="sendgroup" >
         <iframe id="iframepage1" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="dutymanage/fax/sendgroup"></iframe>
      </div>
   </div>
</c:if>

</body>
</html>