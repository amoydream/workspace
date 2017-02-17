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
		<div style="margin-bottom: 15px;">
			<p>
				<label>联系人: </label>
				<span id="pe_name"></span>
			</p>
			<p>
				<label>部门 : </label>
				<span id="or_name"></span>
			</p>
			<p>
				<label>手机号码 : </label>
				<span id="tel_mobile"></span>
			</p>
		</div>
		<div style="width: 100%; height: 500px; overflow: scroll;">
			<table class="table table-bordered table-striped table-hover table-condensed">
				<tr class="info">
					<th width="60%">内容</th>
					<th width="20%">日期</th>
					<th width="10%">状态</th>
					<th width="10%">操作</th>
				</tr>
				<tbody id="result">
				</tbody>
				<tr>
					<th id="navbar" scope="col" colspan="4"></th>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$tel_mobile = '';
        $pe_name = '';
        $or_name = '';
        function viewmsg(msg_id) {
	        var content = '';
	        var msgtype = msg_id.substr(0, 1);
	        msg_id = msg_id.substr(1);
	        
	        if(msgtype == '1') {
		        content = 'dutymanage/smsdisp/viewsent/' + msg_id;
	        } else if(msgtype == '2') {
		        content = 'dutymanage/smsdisp/viewunread/' + msg_id;
	        } else if(msgtype == '3') {
		        content = 'dutymanage/smsdisp/viewread/' + msg_id;
	        }
	        parent.parent.layer.open({
	            type : 2,
	            title : '查看短信',
	            area : ['1024px', '768px'],
	            scrollbar : false,
	            content : [content, 'no'],
	            btn : ['发送', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.send(index, window);
	            }
	        });
        }

        function searchMsg(page) {
	        $.post('dutymanage/smsdisp/searchMsg/' + $tel_mobile + '/' + page, {}, function(result) {
		        if(result.success) {
			        var str = '';
			        if(result.obj && result.obj.records) {
				        var records = result.obj.records;
				        for(var i = 0; i < records.length; i++) {
					        var r = records[i];
					        var state = r.msgtype == 1 ? '已发送' : r.msgtype == 2 ? '未阅读' : r.msgtype == 3 ? '已阅读' : '';
					        if(i % 2 == 1) {
						        str += '<tr class="warning">';
					        } else {
						        str += '<tr>';
					        }
					        str += '<td>' + r.content + '</td>';
					        str += '<td>' + r.msgtimeStr + '</td>';
					        str += '<td>' + state + '</td>';
					        str += '<td>';
					        str += '<a class="btn btn-xs btn-primary" onclick="viewmsg(\'' + r.msgtype + r.msg_id
					               + '\');"><span class="glyphicon glyphicon-comment"></span> 查看</a>';
					        str += '</td>';
					        str += '</tr>';
				        }
				        paginationNav('navbar', result.obj, 'searchMsg');
			        }
			        $('#result').html(str);
			        
		        } else {
			        parent.layer.msg(result.msg, {
			            offset : 300,
			            shift : 6
			        });
		        }
	        });
        }
	</script>
</body>
</html>