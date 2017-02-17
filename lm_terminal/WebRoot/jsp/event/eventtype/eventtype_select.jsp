<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>事件类型管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<style type="text/css">
    .table th, .table td {
        text-align: center;
    }
</style>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-sm-3">
		<div id="eventtype_treeview"></div>
		</div>
		<div id="page-wrapper" class="col-sm-9" style="padding-left: 0px;">
		<input type="hidden" id="pid" value="${pid }"/>
		<table class="table table-bordered">
			<tr>
				<th>选择</th>
				<th>编码</th>
				<th>名称</th>
			</tr>
			<tbody id="eventtype_data">
			
			</tbody>
		</table>
		</div>
</div></div>
<script type="text/javascript">
$(function(){
	$.post('event/eventtype/tree', {}, function(j) {
		var initSelectableTree = function() {
	        return $('#eventtype_treeview').treeview({
	          data: j,
	          multiSelect: $('#chk-select-multi').is(':checked'),
	          onNodeSelected: function(event, node) {
	        	  $("#pid").val(node.href);
					$.post('event/eventtype/list', {id:node.href}, function(j) {
						datas(j);
					});
	          },
	          onNodeUnselected: function (event, node) {
	          }
	        });
	      };
	      var $selectableTree = initSelectableTree();
	});
	$.post('event/eventtype/list', {}, function(j) {
		datas(j);
	});
	
});
function datas(j){
	$("#eventtype_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		str +="<tr>";
		str +="<td><input type='checkbox' name='selectEventTypes' value='"+j[i].et_id+"," + j[i].et_name + "'/></td>";
		str +="<td>"+j[i].et_code+"</td>";
		str +="<td>"+j[i].et_name+"</td>";
		str +="</tr>";
	}
	$("#eventtype_data").append(str);
}
function postChild(id){
	$.post('event/eventtype/list', {id:id}, function(j) {
		datas(j);
	});
}
function select_eventType(index, window,pi_id,ids){
	var spps = $("input[name='selectEventTypes']:checked");
	var str = '',su_Ids=[],flag = false,m=0;
	for(var i=0;i<spps.length;i++){
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
		str += "<tr id='emeEventType"+vs[0]+"'>";
		str += "<td>"+vs[1]+"</td>";
		str += "<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='emeEventType_delete("+vs[0]+")'>删除</a></td>";
		
		str += "</tr>";
		su_Ids[m]=vs[0];
		m++;
	}
	$.post('emeplan/eventType/add', {pi_id:pi_id,et_Ids:su_Ids.join(',')}, function(j) {
		if(j.success){
			window.$("#selected_eventTypes").append(str);
		}else{
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}
		parent.layer.close(index);
	});
}
</script>
</body>
</html>