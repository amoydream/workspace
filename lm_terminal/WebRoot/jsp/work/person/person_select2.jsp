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
				<th>办公电话</th>
				<th>手机</th>
				<th>住宅电话</th>
				<th>邮箱</th>
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
	$.post('work/person/list', {orId:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#person_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		str +="<tr>";
		str +="<td>"+j[i].pe_name+"</td>";
		if(j[i].pe_jobs!=undefined){
			str +="<td>"+j[i].pe_jobs+"</td>";
		}else{
			str +="<td></td>";
		}
		if(j[i].officephone==undefined){
			str +="<td></td>";
		}else{
			str +="<td>"+j[i].officephone+"</td>";
		}
		if(j[i].mobilephone==undefined){
			str +="<td></td>";
		}else{
			str +="<td>"+j[i].mobilephone+"</td>";
		}
		if(j[i].homephone==undefined){
			str +="<td></td>";
		}else{
			str +="<td>"+j[i].homephone+"</td>";
		}
		if(j[i].email==undefined){
			str +="<td></td>";
		}else{
			str +="<td>"+j[i].email+"</td>";
		}
		str +="<td><input type='checkbox' name='selectPersons' value='"+j[i].pe_id+","+j[i].pe_name+","+j[i].pe_jobs+","+j[i].officephone+","+j[i].mobilephone+","+j[i].homephone+","+j[i].email+"'/></td>";
		str +="</tr>";
	}
	$("#person_data").append(str);
}
function postChild(id){
	$.post('system/personinfo/list', {id:id}, function(j) {
		datas(j);
	});
}

function select_emePerson(index, window,eoId,ids){
	var spps = $("input[name='selectPersons']:checked");
	var str = '',su_Ids=[],flag = false;
	for(var i=0,h=spps.length;i<h;i++){
		var vv = spps[i].value;
		var vs = vv.split(",");
		
		for(var j=0,h1=ids.length;j<h1;j++){
			if(vs[0] == ids[j].value){
				flag = true;
				break;
			}
		}
		if(flag){
			flag = false;
			continue;
		}
		
		str += "<tr>";
		str += "<td>"+vs[1]+"</td>";
		str += "<td>"+vs[2]+"</td>";
		
		if(vs[3]!='undefined'){
			str += "<td>"+vs[3]+"</td>";
		}else{
			str += "<td></td>";
		}
		if(vs[4]!='undefined'){
			str += "<td>"+vs[4]+"</td>";
		}else{
			str += "<td></td>";
		}
		if(vs[5]!='undefined'){
			str += "<td>"+vs[5]+"</td>";
		}else{
			str += "<td></td>";
		}
		if(vs[6]!='undefined'){
			str += "<td>"+vs[6]+"</td>";
		}else{
			str += "<td></td>";
		}
		
		str +="<td><button type='button' class='btn btn-warning btn-sm' onclick='person_editUI("+vs[0]+");'>修改</button>";
		str +="<button type='button' class='btn btn-danger btn-sm' onclick='person_delete("+vs[0]+");'>删除</button>";
		str +="<button type='button' class='btn btn-danger btn-sm' onclick='person_books("+vs[0]+");'>通讯录</button></td>";
		
		str += "</tr>";
		su_Ids[i]=vs[0];
	}
	if(su_Ids.length>0){
		$.post('emeplan/emePerson/add', {eoId:eoId,su_Ids:su_Ids.join(',')}, function(j) {
			if(j.success){
				window.$("#emePerson_data").append(str);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.layer.close(index);
		});
	}else{
		parent.layer.close(index);
	}
}
</script>
</body>
</html>