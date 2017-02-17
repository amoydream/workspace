<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>添加岗位</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
<div class="modal-body">
	<form id="position_addform" class="form-horizontal" role="form">
	<input type="hidden" id="pid" name="id" value="${param.pid }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="p_name"><span style="color: red;">* </span>岗位名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="p_name" name="p_name" type="text"
						placeholder="输入岗位名称" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>

<script type="text/javascript">
$('#position_addform').bootstrapValidator();
function positionAdd_submitForm(index,window,pid) {
	$('#position_addform').bootstrapValidator('validate');
	if($('#position_addform').data('bootstrapValidator').isValid()){
		$.post('work/position/add', $('#position_addform').serialize(), function(j) {	
			if(j.success){
				window.initPosition(pid);
				parent.layer.close(index);	
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}
</script>
</body>
</html>