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
<title>已发送短信</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp" />
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
					<a class="btn btn-primary" style="margin-left: 5px;" onclick="searchFailed('1');"> <span
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
				<th width="20%">发送日期</th>
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
		function resend(tr, send_id) {
	        parent.parent.layer.confirm('按【确定】发送', function() {
		        $.post('dutymanage/smsdisp/resend/' + send_id, {}, function(result) {
			        if(result.success) {
				        $(tr).remove();
				        if($('#result') != null && $('#result').find('tr') != null
				           && $('#result').find('tr').length > 0) {
					        searchFailed($('#page').val());
				        } else {
					        if($('#page').val() > 1) {
						        searchFailed($('#page').val() - 1);
					        } else {
						        searchFailed('1');
					        }
				        }
			        }
			        
			        parent.parent.layer.msg(result.msg, {
			            offset : 300,
			            shift : 6
			        });
		        });
	        });
        }
        $result_tr = null;
        function viewFailed(tr, send_id) {
	        $result_tr = $(tr);
	        parent.parent.layer.open({
	            type : 2,
	            title : '重发短信',
	            area : ['1024px', '768px'],
	            scrollbar : false,
	            content : ['dutymanage/smsdisp/viewfailed/' + send_id, 'no'],
	            btn : ['发送', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.resend(index, window);
	            }
	        });
        }

        function searchFailed(page) {
	        $('#page').val(page);
	        $.post('dutymanage/smsdisp/failed', $('#searchForm').serialize(), function(result) {
		        if(result.success) {
			        var str = '';
			        if(result.obj && result.obj.records) {
				        var records = result.obj.records;
				        for(var i = 0; i < records.length; i++) {
					        var r = records[i];
					        str += '<tr>'
					        str += '<td>' + r.pe_name + '</td>';
					        str += '<td>' + r.or_name + '</td>';
					        str += '<td>' + r.tel_mobile + '</td>';
					        str += '<td>' + r.sendtimeStr + '</td>';
					        str += '<td>';
					        str += '<a class="btn btn-xs btn-primary" onclick="viewFailed($(this).parent().parent(), '
					               + r.send_id + ');"><span class="glyphicon glyphicon-comment"></span> 查看</a>&nbsp;';
					        str += '<a class="btn btn-xs btn-primary" onclick="resend($(this).parent().parent(), '
					               + r.send_id + ');"><span class="glyphicon glyphicon-send"></span> 重发</a>';
					        str += '</td>';
					        str += '</tr>';
				        }
				        
				        paginationNav('navbar', result.obj, 'searchFailed');
			        }
			        
			        $('#result').html(str);
		        } else {
			        layer.msg(result.msg, {
			            offset : 300,
			            shift : 6
			        });
		        }
	        });
        }

        $(function() {
	        searchFailed('1');
        });
	</script>
</body>
</html>