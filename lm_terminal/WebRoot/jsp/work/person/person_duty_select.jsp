<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>机构人员管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-sm-3">
		<div id="person_treeview">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-sm-9" style="padding-left: 0px;">
		<input type="hidden" id="or_id"/>
		<table class="table table-bordered">
			<tr>
				<th>姓名</th>
				<th>岗位</th>
				<th>手机</th>
				<th>操作</th>
			</tr>
			<tbody id="person_data">
			</tbody>
		</table>
		</div>
</div></div>
<script type="text/javascript">

var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: zTreeOnClick
		}
};

$(function(){
	$.post('work/organ/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
	});
});

function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#pid").val(treeNode.id);
	$.post('work/person/list', {or_id:treeNode.id}, function(j) {
		datas(j.obj.records);
	});
}

function datas(j){
	$("#person_data").empty();
	console.info(j.length);
	var str = '';
	for(var i=0;i<j.length;i++){
		console.info(j[i].pe_name);
		str +="<tr>";
		str +="<td>"+j[i].pe_name+"</td>";
		if(j[i].pe_jobs!=undefined){
			str +="<td>"+j[i].pe_jobs+"</td>";
		}else{
			str +="<td></td>";
		}
		
		if(j[i].mobilephone==undefined){
			str +="<td></td>";
		}else{
			str +="<td>"+j[i].mobilephone+"</td>";
		}
		
		str +="<td><input type='radio' name='selectPersons' value='"+j[i].pe_id+","+j[i].pe_name+"'/></td>";
		str +="</tr>";
	}
	$("#person_data").append(str);
}
function postChild(id){
	$.post('system/personinfo/list', {id:id}, function(j) {
		datas(j);
	});
}

function select_DutyPerson(index, window){
	var sulist = $("input[name='selectPersons']:checked").val().split(",");
	window.$("#pe_id").val(sulist[0]);
	window.$("#pe_name").val(sulist[1]);
	parent.layer.close(index);
}
</script>
</body>
</html>