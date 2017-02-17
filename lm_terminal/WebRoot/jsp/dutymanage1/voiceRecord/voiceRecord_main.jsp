<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>电话调度</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>
<body>
	<ul role="tablist" id="maintab" class="nav nav-tabs">
		<li class="active"><a href="#manage1" data-toggle="tab" onclick="reloadPane('iframepage1')">接听电话</a></li>
		<li><a href="#manage2" data-toggle="tab" onclick="reloadPane('iframepage2')">拨打电话</a></li>
		<li><a href="#manage3" data-toggle="tab" onclick="reloadPane('iframepage3')">通讯录</a></li>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="manage1">
			<iframe id="iframepage1" frameborder="0" scrolling="yes" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/vVoiceRecord/list?query=true&voiceType=1"></iframe>
		</div>
		<div class="tab-pane fade" id="manage2">
			<iframe id="iframepage2" frameborder="0" scrolling="yes" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/vVoiceRecord/list?query=true&voiceType=2"></iframe>
		</div>
		<div class="tab-pane fade" id="manage3">
			<iframe id="iframepage3" frameborder="0" scrolling="yes" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/phonedisp/contacts"></iframe>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	function reloadPane(iframe_id) {
	    document.getElementById(iframe_id).contentWindow.location.reload(true);
    }
</script>
