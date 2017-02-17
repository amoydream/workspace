<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>事件类型管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
	<form id="eventtype_editform" class="form-horizontal" role="form">
	<input type="hidden" id="et_id" name="et_id" value="${eventtype.et_id }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="et_code">编码</label>
				<div class="col-sm-4 input-message">
				    <div class='input-group'>
					<input class="form-control" id="et_code" name="et_code" value="${eventtype.et_code }" type="text"
						placeholder="输入编码"/>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="et_name"><span style="color: red;">* </span>名称</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'>
					<input class="form-control" id="et_name" name="et_name" value="${eventtype.et_name }" type="text"
						placeholder="输入名称" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>

<script type="text/javascript">
$('#eventtype_editform').bootstrapValidator();
function eventtypeEdit_submitForm(index,window,treeObj,pid) {
	$('#eventtype_editform').bootstrapValidator('validate');
	if($('#eventtype_editform').data('bootstrapValidator').isValid()){
		$.post('event/eventtype/edit', $('#eventtype_editform').serialize(), function(j) {	
			if(j.success){
				var etId = $("#et_id").val();
                var etName = $("#et_name").val();
				var node = treeObj.getNodeByParam("id", etId, null);
				node.name = etName;
				 // 更新根节点中第i个节点的名称	        
	            treeObj.updateNode(node);	
				window.postChild(pid); 
				
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