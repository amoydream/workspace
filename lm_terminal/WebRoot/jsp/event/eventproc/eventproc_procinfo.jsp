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
<title>过程信息</title>
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
	function promptViewForm(pr_id, ev_name) {
	    parent.layer.open({
	        type : 2,
	        title : ev_name,
	        area : ['1080px', '640px'],
	        scrollbar : false,
	        content : ['event/eventproc/viewproc/' + pr_id, 'no'],
	        btn : ['保存', '取消'],
	        yes : function(index, layero) {
	        	parent.layer.close(index);
		        //layero.find('iframe')[0].contentWindow.send(index, window);
	        }
	    });
    }

    function reviewProcess(ev_id) {
	    parent.layer.open({
	        type : 2,
	        title : '过程信息',
	        area : ['800px', '640px'],
	        scrollbar : false,
	        content : ['event/eventproc/review/' + ev_id, 'yes'],
	        btn : ['确定', '取消'],
	        yes : function(index, layero) {
		        //layero.find('iframe')[0].contentWindow.send(index, window);
	        }
	    });
    }
</script>
</head>
<body>
	<div class="row"
		style="padding-left: 10px; padding-right: 15px; padding-top: 5px; margin-left: 0px; margin-right: 10px;">
		<div style="margin-bottom: 15px;">
			<button class="btn btn-primary" onclick="reviewProcess(${eventProcessVo.ev_id});">过程回顾</button>
		</div>
		<table class="table table-bordered">
			<tr>
				<th>联系人</th>
				<th>电话号码</th>
				<th>事务</th>
				<th>处置内容</th>
				<th>处置日期</th>
				<th>操作</th>
			</tr>
			<tbody id="sms_data">
				<c:forEach var="vo" items="${eventProcessList}">
					<tr>
						<td>${vo.us_Name}</td>
						<td>${vo.us_Mophone}</td>
						<td>${vo.ev_name}</td>
						<td>${vo.pr_content}</td>
						<td>${vo.pr_date}</td>
						<td>
							<button type="button" class="btn btn-primary" onclick="promptViewForm('${vo.pr_id}', '${vo.ev_name}');">查看</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>