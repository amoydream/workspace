<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案应急处置阶段流程管理-监测预警</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<form id="monitor_addform" class="form-horizontal" role="form">
<input type="hidden" name="pi_id" value="${param.pi_id }"/>
		<fieldset>
            <div class="form-group">
				<label for="emw_name" class="col-sm-2 control-label">监测信息名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="emw_name" name="emw_name" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="eal_no">监测部门</label>
				<div class="col-sm-4 input-message">
				   <input type="hidden" id="eo_id" name="emeOrganId"/>
				    <input class="form-control" id="eo_name" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required" onclick="select_books();"/>
				</div>
			</div>
			<div class="form-group">
				<label for="emw_content" class="col-sm-2 control-label">监测内容</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="2" id="emw_content" name="emw_content"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="emw_note" class="col-sm-2 control-label">监测说明</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="2" id="emw_note" name="emw_note"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="emw_remark" class="col-sm-2 control-label">备注</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="2" id="emw_remark" name="emw_remark"></textarea>
				</div>
			</div>
		</fieldset>
	</form>
<script type="text/javascript">
$('#monitor_addform').bootstrapValidator();
function monitorAdd_submitForm(index,window) {
	$('#monitor_addform').bootstrapValidator('validate');
	if($('#monitor_addform').data('bootstrapValidator').isValid()){
		$.post('emeplan/monitoringWarning/add', $('#monitor_addform').serialize(), function(j) {	
			if(j.success){
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
function select_books(){
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'添加通讯录',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/emeplan/emebooks/emebooks_select.jsp','no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.booksAdd_submitForm(index,window);
	    }
	});
}
</script>
</body>
</html>