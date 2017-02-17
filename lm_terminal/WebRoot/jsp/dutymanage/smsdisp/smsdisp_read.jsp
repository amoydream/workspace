<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lauvanpt" uri="http://java.lauvan.com/lauvan/permission"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>已读短信</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/layer/skin/layer.css" type="text/css"></link>
<script src="lauvanUI/layer/layer.js"></script>
</head>
<body>
	<div style="margin-top: 10px; margin-left: 10px; margin-right: 10px;">
		<div style="margin-bottom: 10px;">
			<form id="searchForm" class="form-inline">
				<input type="hidden" id="page" name="page" value="${smsVo.page}" />
				<div class="form-group">
					<label for="pe_name">联系人</label>
					<input type="text" id="pe_name" name="pe_name" class="form-control" placeholder="联系人名称"
						value="${smsVo.pe_name}" />
				</div>
				<div class="form-group">
					<label for="tel_mobile">手机号码</label>
					<input type="tel" id="tel_mobile" name="tel_mobile" class="form-control" placeholder="手机号码"
						value="${smsVo.tel_mobile}" />
				</div>
				<div class="form-group">
					<a class="btn btn-primary" style="margin-left: 5px;" onclick="searchRead('1');"> <span
							class="glyphicon glyphicon-search"></span> 搜索
					</a>
				</div>
			</form>
		</div>
		<table class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
				<th width="20%">联系人</th>
				<th width="20%">部门</th>
				<th width="20%">手机号码</th>
				<th width="20%">接收日期</th>
				<th width="20%">操作</th>
			</tr>
			<tbody id="result">
			</tbody>
			<tr>
				<th id="navbar" scope="col" colspan="5"></th>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
		function viewread(rece_id) {
	        parent.parent.layer.open({
	            type : 2,
	            title : '查看短信',
	            area : ['1024px', '768px'],
	            scrollbar : false,
	            content : ['dutymanage/smsdisp/viewread/' + rece_id, 'no'],
	            btn : ['发送', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.send(index, window);
	            }
	        });
        }

        function searchRead(page) {
	        $('#page').val(page);
	        $.post('dutymanage/smsdisp/read', $('#searchForm').serialize(), function(result) {
		        if(result.success) {
			        var str = '';
			        if(result.obj && result.obj.records) {
				        var records = result.obj.records;
				        for(var i = 0; i < records.length; i++) {
					        var r = records[i];
					        if(i % 2 == 1) {
						        str += '<tr class="warning">';
					        } else {
						        str += '<tr>';
					        }
					        str += '<td>' + r.pe_name + '</td>';
					        str += '<td>' + r.or_name + '</td>';
					        str += '<td>' + r.tel_mobile + '</td>';
					        str += '<td>' + r.recetimeStr + '</td>';
					        str += '<td>';
					        str += '<a class="btn btn-xs btn-primary" onclick="viewread(' + r.rece_id
					               + ');"><span class="glyphicon glyphicon-comment"></span> 查看</a>';
					        str += '</td>';
					        str += '</tr>';
				        }
				        paginationNav('navbar', result.obj, 'searchRead');
			        }
			        $('#result').html(str);
		        }
	        });
        }

        $(function() {
	        searchRead('1');
        });
	</script>
</body>
</html>