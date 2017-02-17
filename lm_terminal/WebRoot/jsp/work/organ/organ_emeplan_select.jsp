<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>组织机构管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
	<div class="container-fluid" style="margin-top:15px;margin-left:10px;padding-left: 0px;">
		<div class="row-fluid">
			<div class="col-sm-3">
				<div id="organ_treeview" style="overflow:scroll; height:390px; OVERFLOW-X:hidden;">
					<ul id="treeDemo" class="ztree"></ul>
				</div>
			</div>
			<div id="page-wrapper" class="col-sm-9" style="padding-left: 0px;">
				<input type="hidden" id="pid" value="${pid }" />
				<table class="table table-bordered table-hover table-condensed">
					<tr>
						<th>机构名称</th>
						<th>应急机构</th>
						<th>操作</th>
					</tr>
					<tbody id="organ_data">

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
			beforeClick: zTreeOnClick
		}
};

$(function(){
	$.post('work/organ/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
	});
	$.post('work/organ/list', {}, function(j) {
		datas(j);
	});
});

function zTreeOnClick(treeId, treeNode, clickFlag) {
	$("#pid").val(treeNode.id);
	$.post('work/organ/list', {id:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#organ_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		str +="<tr>";
		str +="<td>"+j[i].or_name+"</td>";
		if(j[i].or_type=='1'){
			str +="<td>是</td>";
		}else{
			str +="<td>否</td>";
		}
		
		str +="<td><input type='checkbox' name='selectOrgans' value='"+j[i].or_id+","+j[i].or_name+"'/></td>";
		str +="</tr>";
	}
	$("#organ_data").append(str);
}

function select_emeOrgan(index,window,pi_id,pid,index1){
	
	var spps = $("input[name='selectOrgans']:checked");
	var str = '',su_Ids=[];
	for(var i=0;i<spps.length;i++){
		var vv = spps[i].value;
		var vs = vv.split(",");
		str += "<tr>";
		str += "<td>"+vs[1]+"</td>";
		str += "<td></td>";
		str += "<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='organ_delete("+ vs[0] + ")'>删除</a></td>";
		str += "</tr>";
		su_Ids[i]=vs[0];
	}
	
	
	if(su_Ids.length>0){
		$.post('emeplan/planOrgan/add', {pi_id:pi_id,or_Ids:su_Ids.join(','),pid:pid}, function(j) {
			if(j.success){
				window.$("#organPerson_data").append(str);
				window.autoTree1();
				window.postChild(pid);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.parent.parent.layer.close(index1);
			parent.parent.parent.layer.close(index);
		});
	}else{
		parent.parent.parent.layer.close(index1);
		parent.parent.parent.layer.close(index);
	}
	
}
</script>
</body>
</html>