<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>通讯录管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-sm-3">
		<div id="books_treeview">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-sm-9" style="padding-left: 0px;">
<form id="serach_booksform" class="form-inline" method="post">
<input type="hidden" name="query" value="true"/>
  <div class="form-group">
    <label for="us_Name">部门</label>
    <input type="text" name="organName" class="form-control" id="organName" placeholder="输入部门">
  </div>
  <div class="form-group">
    <label for="us_Mophone">姓名</label>
    <input type="email" name="personName" class="form-control" id="personName" placeholder="输入姓名">
  </div>
  <button type="submit" class="btn btn-primary"><i class="icon-search"></i>搜索</button>
  <button type="button" class="btn btn-success" onclick="overuseList();">常用联系人</button>
</form>
		<table class="table table-bordered">
			<tr>
				<th>姓名</th>
				<th>用户类型</th>
				<th>岗位</th>
				<th>通讯类型</th>
				<th>通信号码</th>
				<th>优先级</th>
				<th>操作</th>
			</tr>
			<tbody id="books_data">
			
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
	$("#orid").val(treeNode.id);
	$.post('work/books/list3', {orId:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#books_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		str +="<tr id='books_delete"+j[i].bo_id+"'>";
		if(j[i].person!=undefined){
			str +="<td>"+j[i].person.pe_name+"</td>";
			str +="<td>个人</td>";
			if(j[i].position!=undefined){
				str +="<td>"+j[i].position.p_name+"</td>";
			}else{
				str +="<td></td>";
			}
			if(j[i].bo_type=='1'){
				str +="<td>办公电话</td>";
			}else if(j[i].bo_type=='2'){
				str +="<td>手机号码</td>";
			}else if(j[i].bo_type=='3'){
				str +="<td>传真号码</td>";
			}else if(j[i].bo_type=='4'){
				str +="<td>email</td>";
			}else if(j[i].bo_type=='5'){
				str +="<td>住宅电话</td>";
			}else{
				str +="<td></td>";
			}
			str +="<td>"+j[i].bo_number+"</td>";
			str +="<td>"+j[i].bo_index+"</td>";
			str +="<td><input type='radio' name='selectBooks' value='"+j[i].bo_id+","+j[i].person.pe_name+"'/></td>";
			str +="</tr>";
		}
	}
	$("#books_data").append(str);
}
function booksSelect_redio(index,window){
	var books = $("input[name='selectBooks']:checked").val().split(",");
	window.$("#bo_id").val(books[0]);
	window.$("#bo_name").val(books[1]);
	parent.layer.close(index);
}
</script>
</body>
</html>