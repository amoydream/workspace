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
<title>事件类型管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="well col-md-3">
		<div id="eventtype_treeview" style="overflow:scroll; height:616px; OVERFLOW-X:hidden;">
		<ul id="treeDemo" class="ztree"></ul></div>
		</div>
		<div id="page-wrapper" class="col-md-9" style="padding-left: 10px;">
		<lauvanpt:permission privilege="eventTypeAdd">
		<button type="button" class="btn btn-primary" onclick="eventtype_addUI();">添加</button>
		</lauvanpt:permission>
		<div style="margin-top:10px;">
		<input type="hidden" id="pid" value="${pid }"/>
		<table class="table table-bordered table-striped table-hover table-condensed">
						<tr class="info">
				<th>编码</th>
				<th>名称</th>
				<th>操作</th>
			</tr>
			<tbody id="eventtype_data">
			
			</tbody>
		</table>
		</div>
	</div>
</div></div>
<script type="text/javascript">
var setting = {
		edit: {
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: zTreeOnClick,
			onDrop: zTreeOnDrop
		}
};

$(function(){
	$.post('event/eventtype/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getNodes();
		treeObj.expandNode(nodes[0], true);
	});
	$.post('event/eventtype/list', {}, function(j) {
		datas(j);
	});
});

function postChild(pid){	
	$.post('event/eventtype/list', {id:pid}, function(j) {
		datas(j);
	});
}

function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#pid").val(treeNode.id);
	$.post('event/eventtype/list', {id:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#eventtype_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		if(i% 2 ==0){
			str += "<tr id='removeET_"+j[i].et_id+"' style='background-color: #ebf8ff;'>";
			str +="<td>"+j[i].et_code+"</td>";
			str +="<td>"+j[i].et_name+"</td>";
			str +="<td><lauvanpt:permission privilege='eventTypeEditip'><button type='button' class='btn btn-primary btn-sm' onclick='eventtype_editUI("+j[i].et_id+");'>编辑</button></lauvanpt:permission>";
			str +="<lauvanpt:permission privilege='eventTypeDelete'><button type='button' class='btn btn-danger btn-sm' onclick='eventtype_delete("+j[i].et_id+");'>删除</button></lauvanpt:permission></td>";
			str +="</tr>";
		}else{
			str +="<tr id='removeET_"+j[i].et_id+"'>";
			str +="<td>"+j[i].et_code+"</td>";
			str +="<td>"+j[i].et_name+"</td>";
			str +="<td><lauvanpt:permission privilege='eventTypeEditip'><button type='button' class='btn btn-primary btn-sm' onclick='eventtype_editUI("+j[i].et_id+");'>编辑</button></lauvanpt:permission>";
			str +="<lauvanpt:permission privilege='eventTypeDelete'><button type='button' class='btn btn-danger btn-sm' onclick='eventtype_delete("+j[i].et_id+");'>删除</button></lauvanpt:permission></td>";
			str +="</tr>";
		}
		
	}
	$("#eventtype_data").append(str);
}
function postChild(id){
	$.post('event/eventtype/list', {id:id}, function(j) {
		datas(j);
	});
}
function eventtype_addUI(){
	var pid = $("#pid").val();
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	parent.layer.open({
	    type: 2,
	    title:'添加事件类型',
	    area:['800px','400px'],
	    scrollbar: false,
	    content: ['jsp/event/eventtype/eventtype_add.jsp?pid='+pid,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.eventtypeAdd_submitForm(index,window,treeObj);
	    }
	});
}
function eventtype_editUI(id){
	var pid = $("#pid").val();
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	parent.layer.open({
	    type: 2,
	    title:'修改事件类型',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['event/eventtype/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.eventtypeEdit_submitForm(index,window,treeObj,pid);
	    }
	});
}
function eventtype_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('event/eventtype/delete',{id:id}, function(j) {
			if(j.success){
				$("#removeET_"+id).remove();
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var node = treeObj.getNodeByParam("id", id, null);
				if(node){
				   treeObj.removeNode(node);
				};
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

function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
	if(moveType =='inner'){
		parent.layer.confirm('您确定要移动么？', function(index){
			var ids = [];
			for(i=0;i<treeNodes.length;i++){
				ids[i] = treeNodes[i].id;
			}
			$.post('event/eventtype/drop',{ids:ids.join(','),id:targetNode.id}, function(j) {
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
				parent.layer.close(index);
			}, 'json');
		});
	}
}
</script>
</body>
</html>