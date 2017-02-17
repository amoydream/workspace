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
		<div class="well col-sm-3">
		<div id="books_treeview" style="overflow-y:auto; height:550px; OVERFLOW-X:hidden;">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-sm-9" style="padding-left: 0px;">
<form id="serach_booksform" class="form-inline" method="post">
<input type="hidden" name="query" value="true"/>
  <div class="form-group">
						<label for="bo_number">通信号码</label>
						<input type="text" name="bo_number" class="form-control" id="bo_number" placeholder="输入通信号码">
					</div>
  <div class="form-group">
    <label for="us_Mophone">姓名</label>
    <input name="personName" class="form-control" id="personName" placeholder="输入姓名">
  </div>
  <button type="button" class="btn btn-primary" onclick="searchBooks();"><i class="icon-search"></i>搜索</button>
</form>
		<table class="table table-bordered">
			<tr>
				<th>姓名</th>
				<th>用户类型</th>
				<th>岗位</th>
				<th>通讯类型</th>
				<th>通信号码</th>
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
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getNodes();
        treeObj.expandNode(nodes[0], true);
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
		if(j[i].bo_usertype=='1'){
			str +="<td>"+j[i].personName+"</td>";
		}else{
			str +="<td></td>";
		}
		
		if(j[i].bo_usertype=='1'){
			str +="<td>个人</td>";
		}else{
			str +="<td>单位</td>";
		}
		
		if(j[i].positionName!=undefined){
			str +="<td>"+j[i].positionName+"</td>";
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
		str +='<td><a class="btn btn-link btn-xs" onclick="parent.parent.callOut(\''+j[i].bo_number+'\');"><i class="icon-phone"></i>'+j[i].bo_number+'</a></td>';
		/* str +="<td>"+j[i].bo_index+"</td>";
		if(j[i].bo_state=='0'){
			str +="<td>启用</td>";
		}else{
			str +="<td>停用</td>";
		} */
		str +="</tr>";
	}
	$("#books_data").append(str);
}

function books_editUI(id){
	parent.layer.open({
	    type: 2,
	    title:'修改通讯录',
	    area:['800px','600px'],
	    scrollbar: false,
	    content: ['work/books/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.booksEdit_submitForm(index,window);
	    }
	});
}
function books_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('work/books/delete',{id:id}, function(j) {
			if(j.success){
				$("#books_delete"+id).remove();
				parent.layer.close(index);
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	});
}
function searchBooks(){
	$.post('work/books/list', $('#serach_booksform').serialize(), function(j) {
		datas(j);
	});
}
</script>
</body>
</html>