<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案分类管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<form id="plantype_addform" class="form-horizontal" role="form">
<input type="hidden" name="pid" value="${param.pid }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="pt_name">名称</label>
				<div class="col-sm-9 input-message">
					<input class="form-control" id="pt_name" name="pt_name" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>

			<div class="form-group">
				<label for="pt_desc" class="col-sm-2 control-label">描述</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pt_desc" name="pt_desc"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="pt_remark" class="col-sm-2 control-label">备注</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pt_remark" name="pt_remark"></textarea>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
<script type="text/javascript">
$('#plantype_addform').bootstrapValidator();
function plantypeAdd_submitForm(index,window) {
	$('#plantype_addform').bootstrapValidator('validate');
	if($('#plantype_addform').data('bootstrapValidator').isValid()){
		$.post('emeplan/plantype/add', $('#plantype_addform').serialize(), function(j) {	
			if(j.success){
				parent.layer.close(index);
				window.location.reload();
			}else{
				parent.layer.tips(j.msg, '.layui-layer-btn0',{
				    tips: 1
				});
			}
		}, 'json');
	}else{
		parent.layer.tips('红色输入框必填', '.layui-layer-btn0',{
		    tips: 1
		});
	}
}
</script>
</body>
</html>