<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>组织管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>

</head>

<body>
<ul id="treeDemo" class="ztree"></ul>

<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
<script type="text/javascript">

var zTree;
var setting = {
		check: {
			enable: true,
			chkStyle: "radio",
			radioType: "all"
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};
$(function(){
	$.post('work/organ/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
	});
});
function selectOrgan(index,window){
	var nodes = zTree.getCheckedNodes(true);
	if(nodes.length>0){
		window.$("#organId").val(nodes[0].id);
		window.$("#organName").val(nodes[0].name);
		var expertAddForm = window.$('#expertAddForm');
		var expertEditForm = window.$('#expertEditForm');
		var teamAddForm = window.$('#teamAddForm');
		var teamEditForm = window.$('#teamEditForm');
		var shelterAddForm = window.$('#shelterAddForm');
		var shelterEditForm = window.$('#shelterEditForm');
		var dangerAddForm = window.$('#dangerAddForm');
		var dangerEditForm = window.$('#dangerEditForm');
		if(expertAddForm.length> 0){
			window.$('#expertAddForm').data('bootstrapValidator').updateStatus('organName', 'NOT_VALIDATED', null);
		}
		if(expertEditForm.length> 0){
			window.$('#expertEditForm').data('bootstrapValidator').updateStatus('organName', 'NOT_VALIDATED', null);
		}
		if(teamAddForm.length> 0){
			window.$('#teamAddForm').data('bootstrapValidator').updateStatus('organName', 'NOT_VALIDATED', null);
		}
		if(teamEditForm.length> 0){
			window.$('#teamEditForm').data('bootstrapValidator').updateStatus('organName', 'NOT_VALIDATED', null);
		}
		if(shelterAddForm.length> 0){
			window.$('#shelterAddForm').data('bootstrapValidator').updateStatus('organName', 'NOT_VALIDATED', null);
		}
		if(shelterEditForm.length> 0){
			window.$('#shelterEditForm').data('bootstrapValidator').updateStatus('organName', 'NOT_VALIDATED', null);
		}
		if(dangerAddForm.length> 0){
			window.$('#dangerAddForm').data('bootstrapValidator').updateStatus('organName', 'NOT_VALIDATED', null);
		}
		if(dangerEditForm.length> 0){
			window.$('#dangerEditForm').data('bootstrapValidator').updateStatus('organName', 'NOT_VALIDATED', null);
		}
	}
	parent.layer.close(index);
}
</script>
</body>
</html>