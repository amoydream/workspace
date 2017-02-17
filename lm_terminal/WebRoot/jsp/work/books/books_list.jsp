<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>通讯录管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<link rel="stylesheet" href="lauvanUI/layer/skin/layer.css" type="text/css"></link>
<script src="lauvanUI/layer/layer.js"></script>
</head>
<body>
	<div class="container-fluid" style="margin-left: -20px; margin-top: 10px;">
		<div class="col-md-3">
			<div id="book_treeview" style="width: 100%; height: 800px; overflow: scroll;"></div>
		</div>
		<div id="page-wrapper" class="col-md-9" style="margin-left: -20px;">
			<form id="bookSearchForm" class="form-inline" method="post">
				<input type="hidden" id="group_id" name="group_id">
				<input type="hidden" id="or_id" name="or_id">
				<input type="hidden" name="page" id="page" />
				<div class="form-group">
					<label for="or_name">部门</label>
					<input type="text" name="or_name" class="form-control" id="or_name" placeholder="输入部门名称">
				</div>
				<div class="form-group">
					<label for="pe_name">姓名</label>
					<input type="text" name="pe_name" class="form-control" id="pe_name" placeholder="输入姓名">
				</div>
				<div class="form-group">
					<label for="bo_number">通信号码</label>
					<input type="text" name="tel_number" class="form-control" id="tel_number" placeholder="输入通信号码">
				</div>
				<button type="button" style="margin-left: 5px;" class="btn btn-primary"
					onclick="$('#group_id').val('');$('#or_id').val('');searchBooks('1');">
					<span class="glyphicon glyphicon-search"></span>
					搜索
				</button>
				<button style="float: right; margin-left: 5px;" type="button" class="btn btn-primary" onclick="exportContacts();">
					<span class="glyphicon glyphicon-export"></span>
					导出手机通讯录
				</button>
				<button style="float: right;" type="button" class="btn btn-primary" onclick="contactGroup();">
					<span class="glyphicon glyphicon-book"></span>
					分组管理
				</button>
			</form>
			<div>
				<table style="margin-top: 10px;" class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
						<th width="10%">姓名</th>
						<th width="10%">部门</th>
						<th width="15%">岗位</th>
						<th width="10%">办公电话</th>
						<th width="10%">住宅电话</th>
						<th width="10%">手机号码</th>
						<th width="10%">传真号码</th>
						<th width="15%">电子邮箱</th>
						<th width="10%">操作</th>
					</tr>
					<tbody id="books_data">
					</tbody>
					<tr>
						<th id="contactDataNav" scope="col" colspan="9" align="right"></th>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function exportContacts() {
	        $.post('contact/export', {}, function(result) {
		        parent.layer.msg(result.msg, {
		            offset : 300,
		            shift : 6
		        });
	        });
        }

        function bookTree() {
	        $.post('contact/contactree', {}, function(organTree) {
		        $('#book_treeview').treeview({
		            data : [organTree[0], organTree[1][0]],
		            multiSelect : false,
		            onNodeSelected : function(event, node) {
			            $('#bookSearchForm')[0].reset();
			            if(node.name == 'group') {
				            $('#or_id').val('');
				            $('#group_id').val(node.href);
			            } else if(node.name == 'organ') {
				            $('#or_id').val(node.href);
				            $('#group_id').val('');
			            }
			            searchBooks('1');
		            }
		        });
	        });
        }

        $(function() {
	        bookTree();
	        searchBooks('1');
        });

        function searchBooks(page) {
	        $('#page').val(page);
	        $.post('work/books/list', $('#bookSearchForm').serialize(), function(result) {
		        if(result.success) {
			        datas(result.obj.records);
			        paginationNav('contactDataNav', result.obj, 'searchBooks');
		        } else {
			        parent.layer.msg(result.msg, {
			            offset : 0,
			            shift : 6
			        });
		        }
	        });
        }

        function datas(j) {
	        $("#books_data").empty();
	        var str = '';
	        for(var i = 0; i < j.length; i++) {
		        var p = j[i];
		        if(i % 2 == 0) {
		        	str += "<tr id='books_delete_" + p.contact_id + "' style='background-color: #ebf8ff;'>";
		        } else {
			        str += "<tr id='books_delete_" + p.contact_id + "'>";
		        }
		        str += "<td>" + $.trim(p.pe_name) + "</td>";
		        str += "<td>" + $.trim(p.or_name) + "</td>";
		        str += "<td>" + $.trim(p.p_names) + "</td>";
		        str += "<td>" + telNoBtn($.trim(p.tel_office)) + "</td>";
		        str += "<td>" + telNoBtn($.trim(p.tel_home)) + "</td>";
		        str += "<td>" + telNoBtn($.trim(p.tel_mobile)) + "</td>";
		        str += "<td>" + $.trim(p.fax_number) + "</td>";
		        str += "<td>" + $.trim(p.email) + "</td>";
		        str += "<td><lauvanpt:permission privilege='booksDelete'><button type='button' class='btn btn-danger btn-xs' onclick='books_delete(\"" + p.contact_id + "\");'><span class='glyphicon glyphicon-remove'></span> 删除</button></lauvanpt:permission></td>";
		        str += "</tr>";
	        }
	        $("#books_data").append(str);
        }

        function books_editUI(id) {
	        var orid = $("#orid").val();
	        parent.layer.open({
	            type : 2,
	            title : '修改通讯录',
	            area : ['800px', '600px'],
	            scrollbar : false,
	            content : ['work/books/editip?id=' + id, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.booksEdit_submitForm(index, window, orid);
	            }
	        });
        }
        
        function books_delete(contact_id) {
	        parent.layer.confirm('您确定要删除么', function(index) {
		        $.post('work/books/delete', {
		        	contact_id : contact_id
		        }, function(j) {
			        if(j.success) {
				        $("#books_delete_" + contact_id).remove();
				        parent.layer.close(index);
			        }
			        parent.layer.msg(j.msg, {
			            offset : 0,
			            shift : 6
			        });
		        }, 'json');
	        });
        }

        function contactGroup() {
	        parent.parent.layer.open({
	            type : 2,
	            title : '联系人分组',
	            area : ['1080px', '720px'],
	            scrollbar : false,
	            content : ['jsp/common/contact/contact_group.jsp', 'yes'],
	            btn : ['关闭'],
	            yes : function(index, layero) {
		            bookTree();
		            parent.parent.layer.close(index);
	            },
	            success : function(layero, index) {
		            var popup = layero.find('iframe')[0].contentWindow;
	            }
	        });
        }
	</script>
</body>
</html>