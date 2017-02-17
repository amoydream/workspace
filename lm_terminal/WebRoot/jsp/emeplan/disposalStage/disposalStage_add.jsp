<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案应急处置阶段流程管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<form id="disposalStage_addform" class="form-horizontal" role="form">
<input type="hidden" name="eds_pid" value="${param.pid }"/>
<input type="hidden" name="pi_id" value="${param.pi_id }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="eds_name"><span style="color: red;">* </span>阶段名称</label>
				<div class="col-sm-4 input-message">
				   <div class='input-group'>
					<input class="form-control" id="eds_name" name="eds_name" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="eds_index"><span style="color: red;">* </span>执行序号</label>
				<div class="col-sm-4 input-message">
				   <div class='input-group'>
					<input class="form-control" id="eds_index" name="eds_index" type="text"
						placeholder="执行序号" data-bv-trigger="keyup" required="required"/>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label for="pt_desc" class="col-sm-2 control-label">任务说明</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="eds_task" name="eds_task"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="pt_remark" class="col-sm-2 control-label">备注</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="2" id="eds_remark" name="eds_remark"></textarea>
				</div>
			</div>
		</fieldset>
	</form>
<script type="text/javascript">
$('#disposalStage_addform').bootstrapValidator();
function disposalStageAdd_submitForm(index,window,level) {
	$('#disposalStage_addform').bootstrapValidator('validate');
	if($('#disposalStage_addform').data('bootstrapValidator').isValid()){
		$.post('emeplan/disposalStage/add', $('#disposalStage_addform').serialize(), function(j) {	
			if(j.success){
				var str = '';
				str +="<tr id='disposalStageListsDel"+j.obj.eds_id+"'>";
				str +="<td>"+j.obj.eds_name+"</td>";
				str +="<td>"+j.obj.eds_index+"</td>";
				str +="<td>"+j.obj.eds_task+"</td>";
				
				str +="<td><button type='button' class='btn btn-primary btn-sm' onclick='disposalStage_editUI("+j.obj.eds_id+","+level+");'>编辑</button>";
				str +="<button type='button' class='btn btn-danger btn-sm' onclick='disposalStage_delete("+j.obj.eds_id+","+level+");'>删除</button></td>";
				str +="</tr>";
				window.$("#disposalStageLists_data").append(str);
				window.autoTree1();
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