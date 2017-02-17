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
<title>消息</title>
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
					<a class="btn btn-primary" style="margin-left: 5px;" onclick="searchMsgroup('1');"> <span
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
				<th width="20%">消息日期</th>
				<th width="20%">操作</th>
			</tr>
			<tbody id="result">
			</tbody>
			<tr>
				<th id="navbar" scope="col" colspan="5"></th>
			</tr>
		</table>
		<script type="text/javascript">
			$tel_mobile = '';
            $pe_name = '';
            $or_name = '';
            function msg(tel_mobile, pe_name, or_name) {
	            $tel_mobile = tel_mobile;
	            $pe_name = pe_name;
	            $or_name = or_name;
	            parent.parent.layer.open({
	                type : 2,
	                title : '查看短信',
	                area : ['1024px', '768px'],
	                scrollbar : true,
	                content : ['jsp/dutymanage/smsdisp/smsdisp_msg.jsp', 'no'],
	                btn : ['关闭'],
	                yes : function(index, layero) {
		                parent.parent.layer.close(index);
	                },
	                success : function(layero, index) {
		                var popup = layero.find('iframe')[0].contentWindow;
		                popup.$(function() {
			                popup.$tel_mobile = $tel_mobile;
			                popup.$pe_name = $pe_name;
			                popup.$or_name = $or_name;
			                popup.$('#pe_name').html($pe_name);
			                popup.$('#or_name').html($or_name);
			                popup.$('#tel_mobile').html($tel_mobile);
			                popup.searchMsg(1);
		                });
	                }
	            });
            }

            function searchMsgroup(page) {
	            $('#page').val(page);
	            $.post('dutymanage/smsdisp/msgroup', $('#searchForm').serialize(), function(result) {
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
					            str += '<td>' + r.msgtimeStr + '</td>';
					            str += '<td>';
					            str += '<a class="btn btn-xs btn-primary" onclick="msg(' + r.tel_mobile + ',\''
					                   + r.pe_name + '\',\'' + r.or_name
					                   + '\');"><span class="glyphicon glyphicon-comment"></span> 查看</a>';
					            str += '</td>';
					            str += '</tr>';
				            }
				            paginationNav('navbar', result.obj, 'searchMsgroup');
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
	            searchMsgroup('1');
            });
		</script>
	</div>
</body>
</html>