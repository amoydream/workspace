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
		<div class="col-sm-3">
		<div id="emeOrgan_treeview">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-sm-9" style="padding-left: 0px;">
		<table class="table table-bordered">
			<tr>
				<th>机构名称</th>
				<th>机构简称</th>
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
		str +="<tr>";
		str +="<td>"+j[i].eo_name+"</td>";
		if(j[i].eo_sname!=undefined){
			str +="<td>"+j[i].eo_sname+"</td>";
		}else{
			str +="<td></td>";
		}
		str +="<td><input type='checkbox' name='selectEmeOrgans' value='"+j[i].eo_id+","+j[i].eo_name+"'/></td>";
		str +="</tr>";
	}
	$("#emeOrgan_data").append(str);
}
function postChild(id){
	$.post('emeplan/emeOrgan/list', {id:id}, function(j) {
		datas(j);
	});
}

function select_emeOrgan(window,pi_id,pid,ids){
	
	var spps = $("input[name='selectEmeOrgans']:checked");
	var str = '',su_Ids=[],flag = false;
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
		str += "<tr>";
		str += "<td>"+vs[1]+"</td>";
		str += "<td></td>";
		str += "<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='organ_delete("+ vs[0] + ")'>删除</a></td>";
		str += "</tr>";
		su_Ids[i]=vs[0];
	}
	if(su_Ids.length>0){
		$.post('emeplan/planOrgan/addOrgan', {pi_id:pi_id,eo_Ids:su_Ids.join(','),pid:pid}, function(j) {
			if(j.success){
				window.$("#organPerson_data").append(str);
				window.autoTree();
				window.postChild(pid);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.layer.closeAll();
		});
	}else{
		parent.layer.closeAll();
	}
	
}
</script>
</body>
</html>