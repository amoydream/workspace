<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>岗位分类修改</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
<div class="modal-body">
	<form id="positionclassification_editform" class="form-horizontal" role="form">
	<input type="hidden" id="pc_id" name="pc_id" value="${pc.pc_id }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="pc_name"><span style="color: red;">* </span>岗位分类</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="pc_name" name="pc_name" value="${pc.pc_name }" type="text"
						placeholder="输入岗位分类" data-bv-trigger="keyup" required="required"/>
			</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>

<script type="text/javascript">
$('#positionclassification_editform').bootstrapValidator();
function classificationEdit_submitForm(index,window,treeObj,pid) {
	$('#positionclassification_editform').bootstrapValidator('validate');
	if($('#positionclassification_editform').data('bootstrapValidator').isValid()){
		$.post('work/positionclassification/edit', $('#positionclassification_editform').serialize(), function(j) {	
			if(j.success){
				    var pcId = $("#pc_id").val();
				    var pcName = $("#pc_name").val();
					var node = treeObj.getNodeByParam("id", pcId, null);
					node.name = pcName;
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