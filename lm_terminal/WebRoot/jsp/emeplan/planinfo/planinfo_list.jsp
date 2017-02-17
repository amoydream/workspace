<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="lauvanpt" uri="http://java.lauvan.com/lauvan/permission"%>   
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案基本信息管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
<script src="js/bootstrap-tabs.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="well col-md-3">
		<div id="planinfo_treeview" style="overflow-y:auto; height:570px; OVERFLOW-X:hidden;">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-md-9" style="padding-left: 10px;">
		<form id="serachPlaninfoForm" class="form-inline" method="post">
					<div class="form-group">
						<label for="pi_name">预案名称</label>
						<input type="text" name="pi_name" class="form-control" id="pi_name" placeholder="输入预案名称">
					</div>
					<button type="button" class="btn btn-default" onclick="searchPlaninfos();">
						<i class="icon-search"></i>搜索
					</button>
					&nbsp;
					<lauvanpt:permission privilege="planAdd">
		<a id="add_planinfo" href="javascript:void(0);" class="btn btn-primary" tab_id="planInfoAdd" 
url="jsp/emeplan/planinfo/planinfo_add.jsp" onclick="planInfo_addUI(this);" param="" title="预案本信息添加" class='thumbnail'>添加</a>
        </lauvanpt:permission>
				</form>
		
		<input type="hidden" id="etId" value=""/>
		<table class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
				<th>名称</th>
				<th>层级</th>
				<th>版本号</th>
				<th>发布日期</th>
				<th>操作</th>
			</tr>
			<tbody id="planinfo_data">
			
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
	$.post('event/eventtype/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getNodes();
		treeObj.expandNode(nodes[0], true);
	});
});

function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#add_planinfo").attr("param",treeNode.id);
	$("#etId").val(treeNode.id);
	$.post('emeplan/planinfo/list', {etId:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#planinfo_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		if (i % 2 == 0) {
			str += "<tr style='background-color: #ebf8ff;'>";
			str +="<td>"+j[i].pi_name+"</td>";
			if(j[i].pi_level=='1'){
				str +="<td>省</td>";
			}else if(j[i].pi_level=='2'){
				str +="<td>地市</td>";
			}else if(j[i].pi_level=='3'){
				str +="<td>区县</td>";
			}else if(j[i].pi_level=='4'){
				str +="<td>部门</td>";
			}else if(j[i].pi_level=='5'){
				str +="<td>企业</td>";
			}
			if (j[i].pi_no == undefined || j[i].pi_no == '') {
			str +="<td></td>";
			}else{
			str +="<td>"+j[i].pi_no+"</td>";
			}
			str +="<td>"+formatDatebox(j[i].pi_createDate)+"</td>";
			
			str +="<td><lauvanpt:permission privilege='planEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs main_tabs' addtabs='parentAddtabs' url='emeplan/planinfo/editip?id="+j[i].pi_id+"' title='预案基本信息修改' class='thumbnail'>修改</a></lauvanpt:permission>";
			str +="<lauvanpt:permission privilege='planDelup'><button type='button' class='btn btn-danger btn-xs' onclick='planinfo_delete("+j[i].pi_id+");'>删除</button></lauvanpt:permission>";
			str +="<button type='button' class='btn btn-warning btn-xs' onclick='planinfo_uploaddoc("+j[i].pi_id+");'>上传附件</button></td>";
			str +="</tr>";
		}else{
			str +="<tr>";
			str +="<td>"+j[i].pi_name+"</td>";
			if(j[i].pi_level=='1'){
				str +="<td>省</td>";
			}else if(j[i].pi_level=='2'){
				str +="<td>地市</td>";
			}else if(j[i].pi_level=='3'){
				str +="<td>区县</td>";
			}else if(j[i].pi_level=='4'){
				str +="<td>部门</td>";
			}else if(j[i].pi_level=='5'){
				str +="<td>企业</td>";
			}
			
			if (j[i].pi_no == undefined || j[i].pi_no == '') {
				str +="<td></td>";
				}else{
				str +="<td>"+j[i].pi_no+"</td>";
				}
			str +="<td>"+formatDatebox(j[i].pi_createDate)+"</td>";
			
			str +="<td><lauvanpt:permission privilege='planEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs main_tabs' addtabs='parentAddtabs' url='emeplan/planinfo/editip?id="+j[i].pi_id+"' title='预案基本信息修改' class='thumbnail'>修改</a></lauvanpt:permission>";
			str +="<lauvanpt:permission privilege='planDelup'><button type='button' class='btn btn-danger btn-xs' onclick='planinfo_delete("+j[i].pi_id+");'>删除</button></lauvanpt:permission>";
			str +="<button type='button' class='btn btn-warning btn-xs' onclick='planinfo_uploaddoc("+j[i].pi_id+");'>上传附件</button></td>";
			str +="</tr>";
		}
	}
	$("#planinfo_data").append(str);
	tabs_init2("main_tabs");
}
function postChild(id){
	$.post('emeplan/planinfo/list', {etId:id}, function(j) {
		datas(j);
	});
}

function planInfo_addUI(the){
	parent.tabs_open(the);
}

function planinfo_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/planinfo/delup',{id:id}, function(j) {
			if(j.success){
				var etId = $("#etId").val();
				postChild(etId);
				parent.layer.close(index);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
		}, 'json');
	});
}
function planinfo_uploaddoc(id){
	parent.layer.open({
        type : 2,
        title : '预案附件上传',
        area : ['550px', '400px'],
        scrollbar : false,
        content : ['jsp/emeplan/planinfo/planinfo_upload.jsp?piId='+id, 'no']
    });
}

function searchPlaninfos() {
    $.post('emeplan/planinfo/search', $('#serachPlaninfoForm').serialize(), function(j) {
        datas(j);
    });
}
</script>
</body>
</html>