<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案综合管理-事件分类分级-状况分类</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<form id="emeConditionType_addform" class="form-horizontal" role="form">
<input type="hidden" id="pi_id" name="pi_id"/>
		<fieldset>
		    <div class="form-group">
				<label for="eec_name" class="col-sm-2 control-label"><span style="color: red;">* </span>名称</label>
				<div class="col-sm-9 input-message">
				    <input class="form-control" id="eec_name" name="eec_name" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label for="eec_desc" class="col-sm-2 control-label">描述</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="2" id="eec_desc" name="eec_desc"></textarea>
				</div>
			</div>
		</fieldset>
	</form>
<script type="text/javascript">
$('#emeConditionType_addform').bootstrapValidator();
function emeConditionTypeAdd_submitForm(index, window,pi_id,ids) {
	$("#pi_id").val(pi_id);
	$('#emeConditionType_addform').bootstrapValidator('validate');
	if($('#emeConditionType_addform').data('bootstrapValidator').isValid()){
		$.post('emeplan/conditionType/add', $('#emeConditionType_addform').serialize(), function(j) {	
			if(j.success){
				var str = '';
				str +="<tr id='emeConditionType"+j.obj.eec_id+"'>";
				str +="<td>"+j.obj.eec_name+"</td>";
				str +="<td><a href='javascript:void(0);' class='btn btn-primary btn-xs' onclick='emeConditionType_edit("+j.obj.eec_id+")'>编辑</a>  ";
				str +="<a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='emeConditionType_delete("+j.obj.eec_id+")'>删除</a></td>";
				str +="</tr>";
				window.$("#selected_emeConditionTypes").append(str);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.layer.close(index);
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