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
<title>应急组织人员表管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-md-3">
		<div id="emePerson_treeview">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-md-9" style="padding-left: 0px;">
		<button type="button" class="btn btn-success" onclick="person_addUI();">添加</button>
		<input type="hidden" id="eoId"/>
		<table
					class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
				<th>姓名</th>
				<th>岗位</th>
				<th>办公电话</th>
				<th>手机</th>
				<th>住宅电话</th>
				<th>邮箱</th>
				<th>操作</th>
			</tr>
			<tbody id="emePerson_data">
			
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
	$.post('emeplan/emeOrgan/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
	});
});

function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#eoId").val(treeNode.id);
	$.post('emeplan/emePerson/list', {eoId:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#emePerson_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		if (i % 2 == 0) {
			str +="<tr style='background-color: #ebf8ff;'>";
			str +="<input type='hidden' name='pe_ids' value='"+j[i].pe_id+"'/>";
			str +="<td>"+j[i].pe_name+"</td>";
			str +="<td>"+j[i].pe_jobs+"</td>";
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
			str +="<td><button type='button' class='btn btn-warning btn-sm' onclick='person_editUI("+j[i].pe_id+");'>修改</button>";
			str +="<button type='button' class='btn btn-danger btn-sm' onclick='person_delete("+j[i].pe_id+");'>删除</button>";
			str +="<button type='button' class='btn btn-danger btn-sm' onclick='person_books("+j[i].pe_id+");'>通讯录</button></td>";
			str +="</tr>";
		}else{
			str +="<tr><input type='hidden' name='pe_ids' value='"+j[i].pe_id+"'/>";
			str +="<td>"+j[i].pe_name+"</td>";
			str +="<td>"+j[i].pe_jobs+"</td>";
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
			str +="<td><button type='button' class='btn btn-warning btn-sm' onclick='person_editUI("+j[i].pe_id+");'>修改</button>";
			str +="<button type='button' class='btn btn-danger btn-sm' onclick='person_delete("+j[i].pe_id+");'>删除</button>";
			str +="<button type='button' class='btn btn-danger btn-sm' onclick='person_books("+j[i].pe_id+");'>通讯录</button></td>";
			str +="</tr>";
		}
		
	}
	$("#emePerson_data").append(str);
}
function postChild(id){
	$.post('system/personinfo/list', {id:id}, function(j) {
		datas(j);
	});
}
function person_addUI(){
	var eoId = $("#eoId").val();
	var ids = $("input[name='pe_ids']");
	parent.layer.open({
		type : 2,
		title : '选择人员',
		area : [ '800px', '500px' ],
		scrollbar : false,
		content : [ 'jsp/work/person/person_select2.jsp', 'no' ],
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			layero.find('iframe')[0].contentWindow.select_emePerson(index, window,eoId,ids);
		}
	});
}
function person_editUI(id){
	parent.layer.open({
	    type: 2,
	    title:'修改组织机构',
	    area:['800px','600px'],
	    scrollbar: false,
	    content: ['work/person/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.personEdit_submitForm(index,window);
	    }
	});
}
function person_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('work/person/delete',{id:id}, function(j) {
			if(j.success){
				parent.layer.close(index);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
		}, 'json');
	});
}
function person_books(id){
	parent.layer.open({
	    type: 2,
	    title:'添加通讯录',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/work/books/books_add.jsp?pid='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.organAddBooks_submitForm(index,window);
	    }
	});
}
</script>
</body>
</html>