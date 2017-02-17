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
<title>法律法规管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
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
			<div id="legalTypeTree"></div>
		</div>
		<div class="col-sm-9">
			<div class="row" style="margin-bottom: 10px;">
				<form id="searchLegalForm" class="form-inline" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="le_Name">名称</label> <input type="text" name="le_Name"
							class="form-control" id="le_Name" placeholder="输入法律名称">
					</div>
					<button type="button" class="btn btn-default"
						onclick="searchLegal()">搜索</button>
				</form>
			</div>
			<div class="row">
				<input type="hidden" id="pid" value="${pid }" />
				<div style="overflow:scroll; height:600px; OVERFLOW-X:hidden;">
					<table class="table table-bordered">
						<tr>
							<th style="text-align:center">编号</th>
							<th style="text-align:center">标题</th>
							<th style="text-align:center">操作</th>
						</tr>
						<tbody id="legal_data">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$.post('resource/legal/list', function(j) {
				datas(j);
			});
			
			var treedata = [ {
				text : "应急法律分类",
				tags : "1",
				nodes : [ {
					text : "法律",
					tags : "2"
				}, {
					text : "法规",
					tags : "3"
				}, {
					text : "其他",
					tags : "4"
				} ]
			} ];
			var initSelectableTree = function() {
				return $('#legalTypeTree').treeview({
					data : treedata,
					multiSelect : $('#chk-select-multi').is(':checked'),
					onNodeSelected : function(event, node) {
						$("#pid").val(node.tags);
						$.post('resource/legal/list', {
							le_Type : node.tags
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

		function datas(j) {
			$("#legal_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				str += "<tr>";
				str += "<td style='text-align:center'>" + j[i].le_Code
						+ "</td>";
				str += "<td style='text-align:center'>" + j[i].le_Name
						+ "</td>";
				str += "<td style='text-align:center'><input type='checkbox' name='selectLegals' value='"+j[i].le_Id+"," + j[i].le_Name + "'/></td>";
				str += "</tr>";
			}
			$("#legal_data").append(str);
		}

		function select_Legals(index, window,pi_id,ids){
			var spps = $("input[name='selectLegals']:checked");
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
				str += "<tr id='planLagal"+vs[0]+"'>";
				str += "<td>"+vs[1]+"</td>";
				str += "<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='planLagal_delete("+vs[0]+")'>删除</a></td>";
				str += "</tr>";
				su_Ids[m]=vs[0];
				m++;
			}
			if(su_Ids.length>0){
				$.post('emeplan/planinfo/addLegal', {pi_id:pi_id,le_Ids:su_Ids.join(',')}, function(j) {
					if(j.success){
						window.$("#planinfo_legals").append(str);
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