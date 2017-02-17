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
<title>选择短信模板</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp" />
<script type="text/javascript">
	var layerIndex = -1;
    var opener = null;
    
    function setOpener(index, window) {
	    layerIndex = index;
	    opener = window;
    }

    function returnTemplate(content) {
	    opener.$("#content").val(content);
	    parent.layer.close(layerIndex);
    }

    var searchTmpl = function(page) {
	    $.post("dutymanage/smsdisp/template/" + page, {}, function(result) {
		    if(result.success) {
			    var str = '';
			    if(result.obj && result.obj.records) {
				    $.each(result.obj.records, function(i, r) {
					    if(i % 2 == 1) {
						    str += '<tr class="warning">';
					    } else {
						    str += '<tr>';
					    }
					    str += '<td width="80%">' + r.content + '</td>';
					    str += '<td>';
					    str += '<a class="btn btn-primary btn-xs" onclick=\'returnTemplate("' + r.content
					           + '");\'><span class="glyphicon glyphicon-ok"></span>选择</a>';
					    str += '</td>';
					    str += '</tr>';
				    });
				    paginationNav('navbar', result.obj, 'parent.parent.searchTmpl');
			    }
			    $("#result").html(str);
		    }
	    });
    }

    $(function() {
	    searchTmpl('1');
    });
</script>
</head>
<body>
	<div style="margin-top: 10px; margin-left: 10px; margin-right: 10px;">
		<form id="searchForm">
			<input type="hidden" id="page" name="page">
		</form>
		<table class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
				<th width="90%">短信模板</th>
				<th>操作</th>
			</tr>
			<tbody id="result">
			</tbody>
			<tr>
				<th id="navbar" scope="col" colspan="2"></th>
			</tr>
		</table>
	</div>
</body>
</html>