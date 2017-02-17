<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>事件附件管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>

<body>
	<form id="eventdoc_editform" class="form-horizontal" role="form">
	<input type="hidden" name="edoc_id" value="${eventdoc.edoc_id }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="edoc_name">名称</label>
				<div class="col-sm-9">
					<input class="form-control" id="edoc_name" name="edoc_name" type="text" value="${eventdoc.edoc_name }" readonly="readonly"/>
				</div>
				<label class="col-sm-2 control-label" for="edoc_desc">描述</label>
				<div class="col-sm-9">
					<input class="form-control" id="edoc_desc" name="edoc_desc" value="${eventdoc.edoc_desc }"/>
				</div>
			</div>
		</fieldset>
	</form>

<script type="text/javascript">
function eventdocEdit_submitForm(index,window) {
	$.post('event/eventdoc/edit', $('#eventdoc_editform').serialize(), function(j) {	
		if(j.success){
			parent.layer.close(index);
		}else{
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}
		parent.layer.msg(j.msg, {
		    offset: 0,
		    shift: 6
		});
	}, 'json');
}  
</script>
</body>
</html>