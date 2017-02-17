<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>添加岗位分类</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
<div class="modal-body">
	<form id="positionclassification_addform" class="form-horizontal" role="form">
	<input type="hidden" id="pid" name="pid" value="${param.pid }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="pc_name"><span style="color: red;">* </span>岗位分类</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="pc_name" name="pc_name" type="text"
						placeholder="输入岗位分类" data-bv-trigger="keyup" required="required"/>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>

<script type="text/javascript">
$('#positionclassification_addform').bootstrapValidator();
function classificationAdd_submitForm(index,window,treeObj) {
	$('#positionclassification_addform').bootstrapValidator('validate');
	if($('#positionclassification_addform').data('bootstrapValidator').isValid()){
		$.post('work/positionclassification/add', $('#positionclassification_addform').serialize(), function(j) {	
			if(j.success){
				var pid = $("#pid").val();
				var childZNode = new ZtreeNode(j.obj.pc_id, pid, j.obj.pc_name); //构造子节点  
				var parentZNode = treeObj.getNodeByParam("id", pid, null);	
				treeObj.addNodes(parentZNode, childZNode, true);
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

function ZtreeNode(id, pId, name) {//定义ztree的节点类  
    this.id = id;  
    this.pId = pId;  
    this.name = name;  
}  
</script>
</body>
</html>