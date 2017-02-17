<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案综合管理-监测预警</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top: 25px;">
	<div class="row-fluid"> 
	<button type="button" class="btn btn-primary btn-sm" onclick="monitor_addUI(${pi_id});">添加</button>
<table class="table table-bordered">
			<tr>
				<th>监测信息名称</th>
				<th>监测部门</th>
				<th>监测内容</th>
				<th>监测说明</th>
			</tr>
			<c:forEach items="${monitoring_Warnings}" var="entry">
				<tr>
					<td>${entry.emw_name}</td>
					<td>${entry.emeOrgan.eo_name}</td>
					<td>${entry.emw_content}</td>
					<td>${entry.emw_note}</td>
				</tr>
			</c:forEach>
		</table>
</div></div>
<script type="text/javascript">
function monitor_addUI(id){
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'添加监测预警',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/emeplan/monitor/monitor_add.jsp?pi_id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.monitorAdd_submitForm(index,window);
	    }
	});
}
</script>
</body>
</html>