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
		<form id="books_addform" class="form-horizontal" role="form">
			<input type="hidden" id="pid" name="pid" value="${param.pid }" />
			<input type="hidden" id="orid" name="orid" value="${param.orid }" />
			<input type="hidden" id="eoid" name="eoid" value="${param.eoid }" />
			<fieldset>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="bo_type">通讯类型</label>
					<div class="col-sm-4 input-message">
						<select class="form-control" id="bo_type" name="bo_type" onchange="bo_type_change(this.value);">
							<option value="1">办公电话</option>
							<c:choose>
								<c:when test="${param.contact_type eq 'P'}">
									<option value="2">移动电话</option>
									<option value="5">住宅电话</option>
									<option value="4">电子邮件</option>
								</c:when>
								<c:otherwise>
									<option value="3">传真号码</option>
									<option value="4">电子邮件</option>
								</c:otherwise>
							</c:choose>
						</select>
					</div>
					<label class="col-sm-2 control-label" for="bo_index">排序</label>
					<div class="col-sm-4 input-message">
						<input class="form-control" id="bo_index" name="bo_index" type="text" placeholder="输入排序" data-bv-trigger="keyup"
							required="required" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="bo_number">通讯号码</label>
					<div class="col-sm-4">
						<input class="form-control" id="bo_number" name="bo_number" type="text" placeholder="输入通讯号码" />
					</div>
					<label class="col-sm-2 control-label" for="bo_state">状态</label>
					<div class="col-sm-4">
						<input type="radio" id="bo_state_0" name="bo_state" value="0" checked="checked" />
						启用
						<input type="radio" id="bo_state_1" name="bo_state" value="1" />
						停用
					</div>
				</div>
				<div class="form-group">
					<label for="disabledSelect" class="col-sm-2 control-label">备注</label>
					<div class="col-sm-10">
						<input class="form-control" id="bo_remark" name="bo_remark" type="text" placeholder="输入备注" />
					</div>
				</div>
			</fieldset>
			<span id="msgdemo2" style="margin-left: 30px;"></span>
		</form>
	</div>
	<script type="text/javascript">
		$('#books_addform').bootstrapValidator();
        function organAddBooks_submitForm(index, window, orid) {
	        $('#books_addform').bootstrapValidator('validate');
	        if($('#books_addform').data('bootstrapValidator').isValid()) {
		        $.post('work/books/add', $('#books_addform').serialize(), function(j) {
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

        function bo_type_change() {

        }

        var pe_id = '${param.pid}';
        var or_id = '${param.orid}';
        var bo_usertype = '${param.contact_type}' == 'P' ? '1' : '2';

        function bo_type_change(bo_type) {
	        $.post('work/books/get', {
	            pe_id : pe_id,
	            or_id : or_id,
	            bo_type : bo_type,
	            bo_usertype : bo_usertype
	        }, function(result) {
		        var success = result.success;
		        if(success) {
			        var bo = result.obj;
			        if(bo) {
				        $('#bo_index').val(bo.bo_index);
				        $('#bo_number').val(bo.bo_number);
				        if($('#bo_state').val() == '0') {
					        $('#bo_state_1').prop('checked', 'checked');
					        $('#bo_state_2').removeProp('checked');
				        } else {
					        $('#bo_state_2').prop('checked', 'checked');
					        $('#bo_state_1').removeProp('checked');
				        }

				        $('#bo_remark').val(bo.bo_remark);
			        } else {
				        success = false;
			        }
		        }

		        if(!success) {
			        $('#bo_index').val('');
			        $('#bo_number').val('');
			        if($('#bo_state').val() == '0') {
				        $('#bo_state_1').prop('checked', 'checked');
				        $('#bo_state_2').removeProp('checked');
			        }

			        $('#bo_remark').val('');
		        }
	        });
        }

        $(function() {
	        bo_type_change('1');
        });
	</script>
</body>
</html>