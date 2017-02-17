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
<title>通讯录管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
	<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
		<div class="row-fluid">
			<div class="col-md-3">
				<div id="books_treeview">
					<ul id="treeDemo" class="ztree"></ul>
				</div>
			</div>
			<div id="page-wrapper" class="col-md-9" style="padding-left: 0px;">
				<form id="serach_booksform" class="form-inline" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="us_Name">部门</label> <input type="text"
							name="organName" class="form-control" id="organName"
							placeholder="输入部门">
					</div>
					<div class="form-group">
						<label for="us_Mophone">姓名</label> <input type="email"
							name="personName" class="form-control" id="personName"
							placeholder="输入姓名">
					</div>
					<button type="button" class="btn btn-success"
						onclick="searchBooks();">搜索</button>
				</form>
				<table
					class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
						<th>姓名</th>
						<th>用户类型</th>
						<th>通讯类型</th>
						<th>通信号码</th>
						<th>优先级</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
					<tbody id="books_data">

					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var setting = {
			data : {
				simpleData : {
					enable : true
				}
			},
			callback : {
				onClick : zTreeOnClick
			}
		};

		$(function() {
			$.post('emeplan/emeOrgan/tree2', {}, function(j) {
				zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
			});
		});

		function zTreeOnClick(event, treeId, treeNode, clickFlag) {
			$("#orid").val(treeNode.id);
			$.post('emeplan/emeBooks/list', {
				eoId : treeNode.id
			}, function(j) {
				datas(j);
			});
		}

		function datas(j) {
			$("#books_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				if (i % 2 == 0) {
					str += "<tr id='books_delete"+j[i].bo_id+"' style='background-color: #ebf8ff;'>";
					if (j[i].bo_usertype == '1') {
						if (j[i].person != undefined) {
							str += "<td>" + j[i].person.pe_name + "</td>";
						} else {
							str += "<td></td>";
						}
					} else {
						str += "<td></td>";
					}

					if (j[i].bo_usertype == '1') {
						str += "<td>个人</td>";
					} else {
						str += "<td>单位</td>";
					}

					if (j[i].bo_type == '1') {
						str += "<td>办公电话</td>";
					} else if (j[i].bo_type == '2') {
						str += "<td>手机</td>";
					} else if (j[i].bo_type == '3') {
						str += "<td>传真</td>";
					} else if (j[i].bo_type == '4') {
						str += "<td>email</td>";
					} else if (j[i].bo_type == '5') {
						str += "<td>住宅电话</td>";
					} else {
						str += "<td></td>";
					}
					str += "<td>" + j[i].bo_number + "</td>";
					str += "<td>" + j[i].bo_index + "</td>";
					if (j[i].bo_state == '0') {
						str += "<td>启用</td>";
					} else {
						str += "<td>停用</td>";
					}

					str += "<td><button type='button' class='btn btn-warning btn-sm' onclick='books_editUI("
							+ j[i].bo_id + ");'>修改</button>";
					str += "<button type='button' class='btn btn-danger btn-sm' onclick='books_delete("
							+ j[i].bo_id + ");'>删除</button></td>";
					str += "</tr>";
				} else {
					str += "<tr id='books_delete"+j[i].bo_id+"'>";
					if (j[i].bo_usertype == '1') {
						if (j[i].person != undefined) {
							str += "<td>" + j[i].person.pe_name + "</td>";
						} else {
							str += "<td></td>";
						}
					} else {
						str += "<td></td>";
					}

					if (j[i].bo_usertype == '1') {
						str += "<td>个人</td>";
					} else {
						str += "<td>单位</td>";
					}

					if (j[i].bo_type == '1') {
						str += "<td>办公电话</td>";
					} else if (j[i].bo_type == '2') {
						str += "<td>手机</td>";
					} else if (j[i].bo_type == '3') {
						str += "<td>传真</td>";
					} else if (j[i].bo_type == '4') {
						str += "<td>email</td>";
					} else if (j[i].bo_type == '5') {
						str += "<td>住宅电话</td>";
					} else {
						str += "<td></td>";
					}
					str += "<td>" + j[i].bo_number + "</td>";
					str += "<td>" + j[i].bo_index + "</td>";
					if (j[i].bo_state == '0') {
						str += "<td>启用</td>";
					} else {
						str += "<td>停用</td>";
					}

					str += "<td><button type='button' class='btn btn-warning btn-sm' onclick='books_editUI("
							+ j[i].bo_id + ");'>修改</button>";
					str += "<button type='button' class='btn btn-danger btn-sm' onclick='books_delete("
							+ j[i].bo_id + ");'>删除</button></td>";
					str += "</tr>";
				}

			}
			$("#books_data").append(str);
		}

		function books_editUI(id) {
			parent.layer.open({
				type : 2,
				title : '修改通讯录',
				area : [ '800px', '600px' ],
				scrollbar : false,
				content : [ 'work/books/editip?id=' + id, 'no' ],
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow
							.booksEdit_submitForm(index, window);
				}
			});
		}
		function books_delete(id) {
			parent.layer.confirm('您确定要删除么？', function(index) {
				$.post('work/books/delete', {
					id : id
				}, function(j) {
					if (j.success) {
						parent.layer.close(index);
						$("#books_delete" + id).remove();
					} else {
						parent.layer.msg(j.msg, {
						    offset: 0,
						    shift: 6
						});
					}
				}, 'json');
			});
		}
		function searchBooks() {
			$.post('work/books/list', $('#serach_booksform').serialize(),
					function(j) {
						datas(j);
					});
		}
	</script>
</body>
</html>