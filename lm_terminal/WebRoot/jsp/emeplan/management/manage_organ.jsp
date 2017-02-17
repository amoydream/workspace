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
<title>预案综合管理-预案应急机构</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>
<body>
	<div class="container-fluid" style="margin-top: 15px; padding-left: 0px;">
		<div class="row-fluid">
			<div class="col-xs-3">
				<div id="planinfo_treeview">
				<ul id="treeDemo" class="ztree"></ul>
				</div>
			</div>
			<div id="page-wrapper" class="col-xs-9" style="padding-left: 0px;">
			<button type="button" class="btn btn-primary" onclick="emeOrgan_selectUI(${param.piId });">选择机构</button>
			<button type="button" class="btn btn-primary" onclick="emePerson_selectUI(${param.piId });">选择人员</button>
			<input type="hidden" id="pid" value="${pid }"/>
				<table class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
						<th>机构(人员)名称</th>
						<th>职务(职责)</th>
						<th>操作</th>
					</tr>
					<tbody id="organPerson_data">
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
	autoTree();
});
function autoTree(){
	$.post('emeplan/planOrgan/tree2', {pi_id:${param.piId}}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
	});
}
function autoTree1(){
	$.post('emeplan/planOrgan/tree2', {pi_id:${param.piId}}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		zTree.expandAll(true);
	});
}
function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#pid").val(treeNode.id);
	$.post('emeplan/planOrgan/list', {pi_id:${param.piId},or_id:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#organPerson_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		if (i % 2 == 0) {
			str += "<tr style='background-color: #ebf8ff;'>";
			if(j[i].eppId != undefined){
				str +="<input type='hidden' name='op_ids' value='"+j[i].eppId+"'/>";
			}else if(j[i].eoId != undefined){
				str +="<input type='hidden' name='op_ids' value='"+j[i].eoId+"'/>";
			}
			str +="<td>"+j[i].name+"</td>";
			if(j[i].job!=undefined){
				str +="<td>"+j[i].job+"</td>";
			}else{
				str +="<td></td>";
			}
			if(j[i].eppId != undefined){
				str +="<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='person_delete("+ j[i].pp_id + ")'>删除</a></td>";
			}else if(j[i].eoId != undefined){
				str +="<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='organ_delete("+ j[i].eoId + ")'>删除</a></td>";
			}
			str +="</tr>";
		}else{
			str +="<tr>";
			if(j[i].eppId != undefined){
				str +="<input type='hidden' name='op_ids' value='"+j[i].eppId+"'/>";
			}else if(j[i].eoId != undefined){
				str +="<input type='hidden' name='op_ids' value='"+j[i].eoId+"'/>";
			}
			str +="<td>"+j[i].name+"</td>";
			if(j[i].job!=undefined){
				str +="<td>"+j[i].job+"</td>";
			}else{
				str +="<td></td>";
			}
			if(j[i].eppId != undefined){
				str +="<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='person_delete("+ j[i].pp_id + ")'>删除</a></td>";
			}else if(j[i].eoId != undefined){
				str +="<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='organ_delete("+ j[i].eoId + ")'>删除</a></td>";
			}
			str +="</tr>";
		}
		
	}
	$("#organPerson_data").append(str);
}
function postChild(id){
	$.post('emeplan/planOrgan/list', {pi_id:${param.piId},or_id:id}, function(j) {
		datas(j);
	});
}
function organ_delete(id){
	parent.parent.parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/planOrgan/deleteOrgan',{pi_id:${param.piId },or_Id:id}, function(j) {
			if(j.success){
				window.autoTree1();
				window.postChild($("#pid").val());
				parent.parent.parent.layer.close(index);
			}else{
				parent.parent.parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
		}, 'json');
	});
}
function person_delete(id){
	parent.parent.parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/planOrgan/deletePerson',{pp_id:id}, function(j) {
			if(j.success){
				parent.parent.parent.layer.close(index);
				window.postChild($("#pid").val());
			}else{
				parent.parent.parent.layer.tips(j.msg, '.layui-layer-btn0',{
				    tips: 1
				});
			}
		}, 'json');
	});
}

function emeOrgan_selectUI(pi_id){
	var pid = $("#pid").val();
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'选择机构',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: 'jsp/work/organ/organ_emeplan_select.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	var index1 = parent.parent.parent.layer.load(1);
	    	layero.find('iframe')[0].contentWindow.select_emeOrgan(index,window,pi_id,pid,index1);
	    }
	});
}
function emePerson_selectUI(pi_id){
	var pid = $("#pid").val();
	var ids = $("input[name='op_ids']");
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'选择机构人员',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: 'jsp/work/person/person_emeplan_select.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	var index1 = parent.parent.parent.layer.load(1);
	    	layero.find('iframe')[0].contentWindow.select_emePerson(index,window,pi_id,pid,ids,index1);
	    }
	});
}
</script>
</body>
</html>