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
<title>短信调度</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp" />
</head>
<body>
	<ul role="tablist" id="maintab" class="nav nav-tabs">
		<li class="active"><a id="a_msgroup" href="#tab_msgroupane" data-toggle="tab"
			onclick="reloadPane('iframe_msgroup');">消息</a></li>
		<li><a id="a_unread" href="#tab_unreadpane" data-toggle="tab"
			onclick="reloadPane('iframe_unread');">未阅读</a></li>
		<li><a href="#tab_readpane" data-toggle="tab" onclick="reloadPane('iframe_read');">已阅读</a></li>
		<li><a href="#tab_sentpane" data-toggle="tab" onclick="reloadPane('iframe_sent');">已发送</a></li>
		<li><a href="#tab_failedpane" data-toggle="tab" onclick="reloadPane('iframe_failed');">发送失败</a></li>
		<li><a href="#tab_tmplpane" data-toggle="tab" onclick="reloadPane('iframe_template');">短信模板</a></li>
		<li><a href="#tab_sendpane" data-toggle="tab" onclick="reloadPane('iframe_send');">新建短信</a></li>
	</ul>
	<div id="tab_content" class="tab-content">
		<div class="tab-pane fade in active" id="tab_msgroupane">
			<iframe id="iframe_msgroup" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/smsdisp/msgroupane"></iframe>
		</div>
		<div class="tab-pane fade" id="tab_unreadpane">
			<iframe id="iframe_unread" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/smsdisp/unreadpane"></iframe>
		</div>
		<div class="tab-pane fade" id="tab_readpane">
			<iframe id="iframe_read" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/smsdisp/readpane"></iframe>
		</div>
		<div class="tab-pane fade" id="tab_sentpane">
			<iframe id="iframe_sent" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/smsdisp/sentpane"></iframe>
		</div>
		<div class="tab-pane fade" id="tab_failedpane">
			<iframe id="iframe_failed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/smsdisp/failedpane"></iframe>
		</div>
		<div class="tab-pane fade" id="tab_tmplpane">
			<iframe id="iframe_template" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/smsdisp/tmplpane"></iframe>
		</div>
		<div class="tab-pane fade" id="tab_sendpane">
			<iframe id="iframe_send" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
				width="99%" height="800px" src="dutymanage/smsdisp/sendpane"></iframe>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	$(function() {
	    if('${activePage}' == 'unread') {
		    $('#a_unread').tab('show');
	    } else {
		    $('#a_msgroup').tab('show');
	    }
    });
    
    function reloadPane(iframe_id) {
	    document.getElementById(iframe_id).contentWindow.location.reload(true);
    }
</script>
