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
<title>类型管理</title>
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
		<div class="col-xs-3">
		   <div id="suppliestreeview" style="overflow:scroll; height:390px; OVERFLOW-X:hidden;"></div>
		</div>
		<div class="col-xs-9">
			<div class="row" style="margin-bottom: 10px;">
			   <form id="searchSuppliesForm" class="form-inline" method="post">
				<input type="hidden" name="query" value="true" />
				<div class="form-group">
					<label for="su_Code">编号</label> <input type="text" name="su_Code"
						class="form-control" id="su_Code" placeholder="输入物资编号">
				</div>
				<div class="form-group">
					<label for="su_Name">名称</label> <input type="text" name="su_Name"
						class="form-control" id="su_Name" placeholder="输入物资名称">
				</div>
				<button type="button" class="btn btn-default"
					onclick="searchSupplies()">搜索</button>
			</form>
			</div>
			<div class="row">
			   <input type="hidden" id="pid" value="${pid }" />
			<table class="table table-bordered">
				<tr>
					<th style="text-align:center">物资编号</th>
					<th style="text-align:center">物资名称</th>
					<th style="text-align:center">型号</th>
					<th style="text-align:center">规格</th>
					<th style="text-align:center">操作</th>
				</tr>
				<tbody id="supplies_data">
				</tbody>
			</table>
			</div>
		</div>
	</div>
    
	<script type="text/javascript">
		$(function() {
			$.post('resource/suppliestype/tree', {}, function(j) {
				var initSelectableTree = function() {
					return $('#suppliestreeview').treeview({
						data : j,
						multiSelect : $('#chk-select-multi').is(':checked'),
						onNodeSelected : function(event, node) {
							$("#pid").val(node.href);
							$.post('resource/supplies/list', {
								su_Typeid : node.href
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
			$("#supplies_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				str += "<tr>";
				
				str += "<td style='text-align:center'>" + j[i].su_Code + "</td>";
				str += "<td style='text-align:center'>" + j[i].su_Name + "</td>";
				str += "<td style='text-align:center'>" + j[i].su_Type + "</td>";
				str += "<td style='text-align:center'>" + j[i].su_Size + "</td>";
				str += "<td style='text-align:center'><input type='checkbox' name='selectSupplies' value='"+j[i].su_Id+"," + j[i].su_Name + "," + j[i].su_Type + "'/></td>";
				str += "</tr>";
			}
			$("#supplies_data").append(str);
		}
		function postChild(id) {
			$.post('resource/supplies/list', {
				su_Typeid : id
			}, function(j) {
				datas(j);
			});
		}

		function searchSupplies() {
			$.post('resource/supplies/list', $('#searchSuppliesForm')
					.serialize(), function(j) {
				datas(j);
			});
		}
		
		function select_Supplies(index, window,pi_id,ids){
			var spps = $("input[name='selectSupplies']:checked");
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
				str += "<tr id='emeSupply"+vs[0]+"'>";
				str += "<td>"+vs[1]+"</td>";
				str += "<td>"+vs[2]+"</td>";
				str += "<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='emeSupply_delete("+vs[0]+")'>删除</a></td>";
				str += "</tr>";
				su_Ids[m]=vs[0];
				m++;
			}
			console.info(su_Ids);
			if(su_Ids.length>0){
				$.post('emeplan/planSupplies/add', {pi_id:pi_id,su_Ids:su_Ids.join(',')}, function(j) {
					if(j.success){
						window.$("#selected_spps").append(str);
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