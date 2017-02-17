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
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	type="text/css"></link>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<script type="text/javascript">
	$(function() {
	    $('#menu_treeview').treeview({
	        data : [{
	            text : "当日待办事宜",
	            href : "dutymanage/dutylog/curmatter"
	        }, {
	            text : "生成值班日志",
	            href : "dutymanage/dutylog/genlog"
	        }, {
	            text : "查看值班日志",
	            href : "dutymanage/dutylog/monthlog",
	            nodes : [{
	                text : "按月查看值班日志",
	                href : "dutymanage/dutylog/monthlog"
	            }, {
	                text : "按日查看值班日志",
	                href : "dutymanage/dutylog/daylog"
	            }]
	        }],
	        multiSelect : false,
	        onNodeSelected : function(event, node) {
		        if(node.href) {
		        	forwardTo(node.href);
		        }
	        }
	    });
    });
	
	function forwardTo(url) {
		url = "<%=request.getContextPath() %>" + "/" + url;
		window.location.href = url;
	}
    
    function topage(page) {
	    var form = document.forms[0];
	    form.page.value = page;
	    form.submit();
    }
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 25px;">
			<div class="col-md-3">
				<div id="menu_treeview"></div>
			</div>
			<div class="col-md-9">
				<jsp:include page="dutylog_${requestScope.dispatch}.jsp" />
			</div>
		</div>
	</div>
</body>
</html>