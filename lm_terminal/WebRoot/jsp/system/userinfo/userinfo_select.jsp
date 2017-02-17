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
<title>选择用户</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
	var index = -1, win = null;
    
    function setLayer(i, window) {
	    index = i;
	    win = window;
    }

    function search(page) {
	    $('#page').val(page);
	    $.post('system/userinfo/search', $('#userSearchForm').serialize(), function(result) {
		    if(result.success) {
			    var records = result.obj.records;
			    var userData = "";
			    for(var i = 0; i < records.length; i++) {
				    var userInfo = records[i];
				    userData += '<tr onclick="selectUser(\'' + userInfo.us_Id + '\');">';
				    userData += '<td>' + userInfo.us_Name + '</td>';
				    userData += '<td>' + userInfo.us_Mophone + '</td>';
				    userData += '<td>';
				    userData += '<button type="button" class="btn btn-primary" onclick="selectUser(\'' + userInfo.us_Id
				                + '\');">选择</button>';
				    userData += '</td>';
				    userData += '</tr>';
			    }
			    $('#user_data').html(userData);
			    paginationNav('userDataNav', result.obj, 'search');
		    }
	    });
    }

    function selectUser(us_Id) {
	    $.post('system/userinfo/select/' + us_Id, {}, returnUser);
    }

    $(function() {
	    search(1);
    });
</script>
</head>
<body>
	<div class="container-fluid" style="margin-top: 15px; padding-left: 15px;">
		<div class="row-fluid">
			<div id="page-wrapper" class="col-xd-12" style="padding-left: 0px;">
				<div style="margin-bottom: 15px;">
					<form id="userSearchForm" class="form-inline" action="system/userinfo/search" method="post">
						<div class="form-group">
							<label for="us_Name">姓名</label>
							<input type="text" id="us_Name" name="us_Name" class="form-control" placeholder="人员名称">
						</div>
						<div class="form-group">
							<label for="us_Mophone">电话号码</label>
							<input type="tel" id="us_Mophone" name="us_Mophone" class="form-control" placeholder="电话号码">
						</div>
						<input type="hidden" id="page" name="page">
						<input type="button" class="btn btn-success" value="搜索" onclick="search('1');">
					</form>
				</div>
				<table class="table table-bordered">
					<tr>
						<th>姓名</th>
						<th>电话</th>
						<th>操作</th>
					</tr>
					<tbody id="user_data">
					</tbody>
					<tr>
						<th id="userDataNav" scope="col" colspan="3"></th>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>