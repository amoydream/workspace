<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>选择专家类型</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css"
	type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
    <div class="row" style="margin: 25px 10px 0 0;">
		<div class="col-md-3">
		   <div id="type_treeview"></div>
	<input type="hidden" id="typeId"  />
	<input type="hidden" id="typeName"  />		
	</div>
 
	<script type="text/javascript">
		$(function() {
			$.post('resource/experttype/tree', {}, function(j) {
				var initSelectableTree = function() {
					return $('#type_treeview').treeview({
						data : j,
						multiSelect : $('#chk-select-multi').is(':checked'),
						onNodeSelected : function(event, node) {
							$("#typeId").val(node.href);	
							$("#typeName").val(node.text);
						},
						onNodeUnselected : function(event, node) {
						}
					});
				};
				var $selectableTree = initSelectableTree();
			});})
		
		function selectType(index, window){
				window.$("#typeId").val($("#typeId").val());
				window.$("#typeName").val($("#typeName").val());
				var expertAddForm = window.$('#expertAddForm');
				var expertEditForm = window.$('#expertEditForm');
				if(expertAddForm.length> 0){
					window.$('#expertAddForm').data('bootstrapValidator').updateStatus('typeName', 'NOT_VALIDATED', null);
				}
				if(expertEditForm.length> 0){
					window.$('#expertEditForm').data('bootstrapValidator').updateStatus('typeName', 'NOT_VALIDATED', null);
				}	
				
			parent.layer.close(index);
		}
	</script>
</body>
</html>