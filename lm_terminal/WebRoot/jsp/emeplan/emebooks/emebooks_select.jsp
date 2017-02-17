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
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-sm-3">
		<div id="books_treeview"></div>
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
  <button type="button" class="btn btn-success" onclick="searchBooks();">搜索</button>
</form>
		<table class="table table-bordered">
			<tr>
				<th>选择</th>
				<th>姓名</th>
				<th>用户类型</th>
				<th>通讯类型</th>
				<th>通信号码</th>
				<th>优先级</th>
				<th>状态</th>
			</tr>
			<tbody id="books_data">
			
			</tbody>
		</table>
		</div>
</div></div>
<script type="text/javascript">
$(function(){
	$.post('emeplan/emeOrgan/tree', {}, function(j) {
		var initSelectableTree = function() {
	        return $('#books_treeview').treeview({
	          data: j,
	          multiSelect: $('#chk-select-multi').is(':checked'),
	          onNodeSelected: function(event, node) {
	        	  $("#orid").val(node.href);
					$.post('work/books/list2', {eoId:node.href}, function(j) {
						datas(j);
					});
	          },
	          onNodeUnselected: function (event, node) {
	          }
	        });
	      };
	      var $selectableTree = initSelectableTree();
	});
	
});
function datas(j){
	$("#books_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		str +="<tr id='books_delete"+j[i].bo_id+"'>";
		str +="<td><input type='radio' name='selectBooks' value='"+j[i].bo_id+","+j[i].emeOrgan.eo_name+","+j[i].person.pe_name+","+j[i].bo_number+"'/></td>";
		if(j[i].person!=undefined){
			str +="<td>"+j[i].person.pe_name+"</td>";
		}else{
			str +="<td></td>";
		}
		
		str +="<td>个人</td>";
		
		if(j[i].bo_type=='1'){
			str +="<td>办公电话</td>";
		}else if(j[i].bo_type=='2'){
			str +="<td>手机</td>";
		}else if(j[i].bo_type=='3'){
			str +="<td>传真</td>";
		}else if(j[i].bo_type=='4'){
			str +="<td>email</td>";
		}else if(j[i].bo_type=='5'){
			str +="<td>住宅电话</td>";
		}else{
			str +="<td></td>";
		}
		str +="<td>"+j[i].bo_number+"</td>";
		str +="<td>"+j[i].bo_index+"</td>";
		if(j[i].bo_state=='0'){
			str +="<td>启用</td>";
		}else{
			str +="<td>停用</td>";
		}
		
		str +="</tr>";
	}
	$("#books_data").append(str);
}

function booksAdd_submitForm(index,window){
	var books = $("input[name='selectBooks']:checked").val().split(",");
	window.$("#bo_id").val(books[0]);
	window.$("#bo_name").val(books[2]);
	parent.layer.close(index);
}
</script>
</body>
</html>