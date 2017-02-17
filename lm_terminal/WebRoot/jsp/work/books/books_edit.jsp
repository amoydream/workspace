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
<title>通讯录管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
	<div class="modal-body">
		<form id="books_editform" class="form-horizontal" role="form">
			<input type="hidden" name="bo_id" value="${books.bo_id}" />
			<fieldset>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="bo_type">通讯类型</label>
					<div class="col-sm-4 input-message">
						<select class="form-control" id="bo_type" name="bo_type" value="${books.bo_type }">
							<option value="1">办公电话</option>
							<option value="2">手机号码</option>
							<option value="3">传真号码</option>
							<option value="4">电子邮件</option>
							<option value="5">住宅电话</option>
						</select>
					</div>
					<label class="col-sm-2 control-label" for="bo_index">排序</label>
					<div class="col-sm-4 input-message">
						<input class="form-control" id="bo_index" name="bo_index" value="${books.bo_index }" type="text"
							placeholder="输入排序" data-bv-trigger="keyup" required="required" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="bo_number">通讯号码</label>
					<div class="col-sm-4">
						<input class="form-control" id="bo_number" name="bo_number" value="${books.bo_number }" type="text"
							placeholder="输入通讯号码" />
					</div>
					<label class="col-sm-2 control-label" for="bo_state">状态</label>
					<div class="col-sm-4">
						<input type="radio" name="bo_state" value="0" <c:if test="${books.bo_state=='0' }">checked="checked"</c:if> />
						启用
						<input type="radio" name="bo_state" value="1" <c:if test="${books.bo_state=='1' }">checked="checked"</c:if> />
						停用
					</div>
				</div>
			</fieldset>
			<span id="msgdemo2" style="margin-left: 30px;"></span>
		</form>
	</div>
	<script type="text/javascript">
		$('#books_editform').bootstrapValidator();
        function booksEdit_submitForm(index, window, orid) {
	        $('#books_editform').bootstrapValidator('validate');
	        if($('#books_editform').data('bootstrapValidator').isValid()) {
		        $.post('work/books/edit', $('#books_editform').serialize(), function(j) {
			        if(j.success) {
				        window.postChild(orid);
				        parent.layer.close(index);
			        }
			        parent.layer.msg(j.msg, {
			            offset : 0,
			            shift : 6
			        });
		        }, 'json');
	        } else {
		        parent.layer.msg('红色输入框必填', {
		            offset : 0,
		            shift : 6
		        });
	        }
        }
	</script>
</body>
</html>