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
<title>专家信息管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css"
	type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
	<div class="row" style="margin: 25px 10px 0 0;">
		<div class="col-sm-3">
			<div id="experttreeview"></div>
		</div>
		<div class="col-sm-9">
			<div class="row" style="margin-bottom: 10px;">
				<form id="searchExpertForm" class="form-inline" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="ex_Name">名称</label> <input type="text" name="ex_Name"
							class="form-control" id="ex_Name" placeholder="输入专家姓名">
					</div>
					<button type="button" class="btn btn-default"
						onclick="searchExpert()">搜索</button>
				</form>
			</div>
			<div class="row">
				<input type="hidden" id="pid" value="${pid }" />
				<table class="table table-bordered">
					<tr>
						<th style="text-align:center">专家姓名</th>
						<th style="text-align:center">性别</th>
						<th style="text-align:center">所属单位</th>
						<th style="text-align:center">操作</th>
					</tr>
					<tbody id="expert_data">
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$.post('resource/experttype/tree', {}, function(j) {
				var initSelectableTree = function() {
					return $('#experttreeview').treeview({
						data : j,
						multiSelect : $('#chk-select-multi').is(':checked'),
						onNodeSelected : function(event, node) {
							$("#pid").val(node.href);
							$.post('resource/expert/list', {
								ex_Typeid : node.href
							}, function(j) {
								datas(j);
							});
						},
						onNodeUnselected : function(event, node) {
						}
					});
				};
				var $selectableTree = initSelectableTree();
			});

		});
		function datas(j) {
			$("#expert_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				str += "<tr>";
				str += "<td style='text-align:center'>" + j[i].ex_Name
						+ "</td>";
				str += "<td style='text-align:center'>" + j[i].ex_Sex + "</td>";
				str += "<td style='text-align:center'>" + j[i].ex_Deptid.or_name
						+ "</td>";
				str += "<td style='text-align:center'><input type='checkbox' name='selectExperts' value='"+j[i].ex_Id+","+j[i].ex_Name+","+j[i].ex_Remark+"'/></td>";
				str += "</tr>";
			}
			$("#expert_data").append(str);
		}
		function postChild(id) {
			$.post('resource/expert/list', {
				ex_Typeid : id
			}, function(j) {
				datas(j);
			});
		}

		function select_expert(index, window,pi_id,ids){
			var spps = $("input[name='selectExperts']:checked");
			var str = '',su_Ids=[],flag = false,m=0;
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
				str += "<tr id='emeExpert"+vs[0]+"'>";
				str += "<td>"+vs[1]+"</td>";
				if(vs[2]!=undefined){
					str += "<td>"+vs[2]+"</td>";
				}else{
					str += "<td></td>";
				}
				str += "<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='emeExpert_delete("+vs[0]+")'>删除</a></td>";
				str += "</tr>";
				su_Ids[m]=vs[0];
				m++;
			}
			//console.info(su_Ids.join(','));			
			if(su_Ids.length>0){
				$.post('emeplan/planExpert/add', {pi_id:pi_id,su_Ids:su_Ids.join(',')}, function(j) {
					if(j.success){
						window.$("#selected_experts").append(str);
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