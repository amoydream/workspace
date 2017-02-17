<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>岗位名称修改</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
<div class="modal-body">
	<form id="position_editform" class="form-horizontal" role="form">
	<input type="hidden" name="p_id" value="${position.p_id}"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="p_name"><span style="color: red;">* </span>岗位名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="p_name" name="p_name" value="${position.p_name }" type="text"
						placeholder="输入岗位名称" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="p_name"><span style="color: red;">* </span>所属分类</label>
				<div class="col-sm-4 input-message">
				    <input type="hidden" id="posiclassID" name="pc_id" value="${posiclass.pc_id }"/>
					<input class="form-control" id="posiclassNameID" name="pc_name" type="text"
						placeholder="请选择所属分类" onclick="select_classificationType();" value="${posiclass.pc_name }" 
						data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>

<script type="text/javascript">
$('#position_editform').bootstrapValidator();

function positionEdit_submitForm(index,window,pid) {
	$('#position_editform').bootstrapValidator('validate');
	if($('#position_editform').data('bootstrapValidator').isValid()){
		$.post('work/position/edit', $('#position_editform').serialize(), function(j) {	
			if(j.success){
				window.initPosition(pid);
				parent.layer.close(index);
				}
			else{
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

function select_classificationType(){
	parent.layer.open({
	    type: 2,
	    title:'选择岗位分类',
	    area:['500px','500px'],
	    scrollbar: false,
	    content: 'jsp/work/positionclassification/positionclassification_select.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.selectType(index,window);
	    }
	});
}
</script>
</body>
</html>