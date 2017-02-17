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
<title>阅读短信</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
	function send(index, window) {
	    if($('#content').val().trim() == '') {
		    parent.parent.layer.msg("请输入短信内容", {
		        offset : 300,
		        shift : 6
		    });
		    return;
	    }
	    parent.parent.layer.confirm('按【确定】发送', function() {
		    $.post('dutymanage/smsdisp/send', $('#smsForm').serialize(), function(result) {
			    if(result.success) {
				    parent.parent.layer.msg(result.msg, {
				        offset : 300,
				        shift : 6
				    });
				    parent.parent.layer.close(index);
			    } else {
				    parent.layer.msg(result.msg, {
				        offset : 300,
				        shift : 6
				    });
			    }
		    });
	    });
    }

    function selectTemplate() {
	    parent.layer.open({
	        type : 2,
	        title : '选择短信模板',
	        area : ['1024px', '768px'],
	        scrollbar : false,
	        content : ['jsp/dutymanage/smsdisp/smsdisp_selecttmpl.jsp', 'yes'],
	        btn : ['取消'],
	        yes : function(index, layero) {
		        parent.layer.close(index);
	        },
	        success : function(layero, index) {
		        layero.find('iframe')[0].contentWindow.setOpener(index, window);
	        }
	    });
    }
</script>
</head>
<body>
	<div style="margin-top: 10px; margin-left: 10px; margin-right: 10px;">
		<form id="smsForm">
			<div class="form-group">
				<input type="hidden" name="us_Id" value="${userVo.us_Id}">
				<input type="hidden" name="pe_id" value="${smsVo.pe_id}">
				<input type="hidden" name="ev_id" value="${smsVo.ev_id}">
				<input type="hidden" name="tel_mobile_arr" value="${smsVo.tel_mobile}">
				<p>
					<label>联系人 : </label>
					${smsVo.pe_name}
				</p>
				<p>
					<label>部门 : </label>
					${smsVo.or_name}
				</p>
				<p>
					<label>手机号码 : </label>
					${smsVo.tel_mobile}
				</p>
				<p>
					<label>消息内容 : </label>
				</p>
				<p>${smsVo.content}</p>
			</div>
			<div class="form-group">
				<label for="msg">短信内容 : </label>
				<a style="float: right; margin-bottom: 2px;" class="btn btn-primary" onclick="selectTemplate();">
					<i class="icon-file-alt"></i>&nbsp;选择模板
				</a>
				<textarea rows="10" id="content" name="content" class="form-control" placeholder="短信内容"></textarea>
			</div>
		</form>
	</div>
</body>
</html>
