<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案应急处置阶段流程管理-行动清单</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<form id="actionlist_editform" class="form-horizontal" role="form">
<input type="hidden" name="eal_id" value="${action_List.eal_id }"/>
		<fieldset>
		    <div class="form-group">
				<label for="eal_name" class="col-sm-2 control-label">名称 </label>
				<div class="col-sm-9">
				    <input class="form-control" id="eal_name" name="eal_name" value="${action_List.eal_name }" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="eal_no">代号</label>
				<div class="col-sm-4 input-message">
				   <div class='input-group'>
					<input class="form-control" id="eal_no" name="eal_no" value="${action_List.eal_no }" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="eal_level">执行序号</label>
				<div class="col-sm-4 input-message">
				   <div class='input-group'>
					<select class="form-control" id="eal_level" name="eal_level">
						<option value="1" <c:if test="${action_List.eal_level=='1' }">selected="selected"</c:if>>一级事件</option>
						<option value="2" <c:if test="${action_List.eal_level=='2' }">selected="selected"</c:if>>二级事件</option>
						</select>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label for="eal_content" class="col-sm-2 control-label">内容</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="2" id="eal_content" name="eal_content">${action_List.eal_content }</textarea>
				</div>
			</div>
		</fieldset>
	</form>
<script type="text/javascript">
$('#actionlist_editform').bootstrapValidator();
function actionlistEdit_submitForm(index,window,id) {
	$('#actionlist_editform').bootstrapValidator('validate');
	if($('#actionlist_editform').data('bootstrapValidator').isValid()){
		$.post('emeplan/actionList/edit', $('#actionlist_editform').serialize(), function(j) {	
			if(j.success){
				window.$("#actionListsDel"+id).remove();
				var str = '';
				str +="<tr id='actionListsDel"+j.obj.eal_id+"'>";
				str +="<td>"+j.obj.eal_no+"</td>";
				str +="<td>"+j.obj.eal_name+"</td>";
				
				str +="<td><button type='button' class='btn btn-primary btn-sm' onclick='actionList_editUI("+j.obj.eal_id+");'>编辑</button>";
				str +="<button type='button' class='btn btn-danger btn-sm' onclick='actionList_delete("+j.obj.eal_id+");'>删除</button></td>";
				str +="</tr>";
				window.$("#actionLists_data").append(str);
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