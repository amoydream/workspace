<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>应急组织机构管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-md-3">
		<div id="emeOrgan_treeview">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-md-9" style="padding-left: 0px;">
		<button type="button" class="btn btn-success" onclick="emeOrgan_addUI();">添加</button>
		<input type="hidden" id="pid" value="${pid }"/>
		<table
					class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
				<th>机构名称</th>
				<th>地址</th>
				<th>办公电话</th>
				<th>传真</th>
				<th>邮箱</th>
				<th>操作</th>
			</tr>
			<tbody id="emeOrgan_data">
			
			</tbody>
		</table>
		</div>
</div>
</div>
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
	$.post('emeplan/emeOrgan/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
	});
	$.post('emeplan/emeOrgan/list', {}, function(j) {
		datas(j);
	});
});

function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#pid").val(treeNode.id);
	$.post('emeplan/emeOrgan/list', {id:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#emeOrgan_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		if (i % 2 == 0) {
			str += "<tr style='background-color: #ebf8ff;'>";
			str +="<td>"+j[i].eo_name+"</td>";
			str +="<td>"+j[i].eo_address+"</td>";
			if(j[i].officephone==undefined){
				str +="<td></td>";
			}else{
				str +="<td>"+j[i].officephone+"</td>";
			}
			if(j[i].fax==undefined){
				str +="<td></td>";
			}else{
				str +="<td>"+j[i].fax+"</td>";
			}
			if(j[i].email==undefined){
				str +="<td></td>";
			}else{
				str +="<td>"+j[i].email+"</td>";
			}
			
			str +="<td><button type='button' class='btn btn-warning btn-sm' onclick='emeOrgan_editUI("+j[i].eo_id+");'>修改</button>";
			str +="<button type='button' class='btn btn-danger btn-sm' onclick='emeOrgan_delete("+j[i].eo_id+");'>删除</button>";
			str +="<button type='button' class='btn btn-danger btn-sm' onclick='emeOrgan_books("+j[i].eo_id+");'>通讯录</button></td>";
			str +="</tr>";
		}else{
			str +="<tr>";
			str +="<td>"+j[i].eo_name+"</td>";
			str +="<td>"+j[i].eo_address+"</td>";
			if(j[i].officephone==undefined){
				str +="<td></td>";
			}else{
				str +="<td>"+j[i].officephone+"</td>";
			}
			if(j[i].fax==undefined){
				str +="<td></td>";
			}else{
				str +="<td>"+j[i].fax+"</td>";
			}
			if(j[i].email==undefined){
				str +="<td></td>";
			}else{
				str +="<td>"+j[i].email+"</td>";
			}
			
			str +="<td><button type='button' class='btn btn-warning btn-sm' onclick='emeOrgan_editUI("+j[i].eo_id+");'>修改</button>";
			str +="<button type='button' class='btn btn-danger btn-sm' onclick='emeOrgan_delete("+j[i].eo_id+");'>删除</button>";
			str +="<button type='button' class='btn btn-danger btn-sm' onclick='emeOrgan_books("+j[i].eo_id+");'>通讯录</button></td>";
			str +="</tr>";
		}
		
	}
	$("#emeOrgan_data").append(str);
}
function postChild(id){
	$.post('emeplan/emeOrgan/list', {id:id}, function(j) {
		datas(j);
	});
}
function emeOrgan_addUI(){
	var pid = $("#pid").val();
	parent.layer.open({
	    type: 2,
	    title:'添加应急组织机构',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/emeplan/emeorgan/emeorgan_add.jsp?pid='+pid,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.emeOrganAdd_submitForm(index,window);
	    }
	});
}
function emeOrgan_editUI(id){
	parent.layer.open({
	    type: 2,
	    title:'修改应急组织机构',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['emeplan/emeOrgan/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.emeOrganEdit_submitForm(index,window);
	    }
	});
}
function emeOrgan_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/emeOrgan/delete',{id:id}, function(j) {
			if(j.success){
				parent.layer.close(index);
				window.location.reload();
			}else{
				parent.layer.tips(j.msg, '.layui-layer-btn0',{
				    tips: 1
				});
			}
		}, 'json');
	});
}
function emeOrgan_books(id){
	parent.layer.open({
	    type: 2,
	    title:'添加通讯录',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/work/books/books_add.jsp?eoid='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.organAddBooks_submitForm(index,window);
	    }
	});
}
</script>
</body>
</html>