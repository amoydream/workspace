<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>交接班管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>

<body>
<ul role="tablist" id="maintab" class="nav nav-tabs">
   <li class="active"><a href="#manage1" data-toggle="tab">交班</a></li>
   <li><a a href="#manage2" data-toggle="tab">接班</a></li>
</ul>
<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="manage1">
         <iframe id="iframepage1" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="dutymanage/handoverInfo/list?query=true&hoType=1"></iframe>
      </div>
      <div class="tab-pane fade" id="manage2">
         <iframe id="iframepage2" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="dutymanage/handoverInfo/list?query=true&hoType=2"></iframe>
      </div>
   </div>
</body>
</html>