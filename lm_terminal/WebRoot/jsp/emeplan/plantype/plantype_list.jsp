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
<title>预案分类管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-md-3">
		<div id="plantype_treeview" style="overflow-y:auto; height:570px; OVERFLOW-X:hidden;">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-md-9" style="padding-left: 0px;">
		<lauvanpt:permission privilege="planTypeAdd">
		<button type="button" class="btn btn-primary" onclick="plantype_addUI();">添加</button>
		</lauvanpt:permission>
		<input type="hidden" id="pid" value="${pid }"/>
		<table
					class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
				<th>名称</th>
				<th>描述</th>
				<th>备注</th>
				<th>记录人</th>
				<th>记录日期</th>
				<th>操作</th>
			</tr>
			<tbody id="plantype_data">
			
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
	$.post('emeplan/plantype/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getNodes();
		treeObj.expandNode(nodes[0], true);
	});
	$.post('emeplan/plantype/list', {}, function(j) {
		datas(j);
	});
});

function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#pid").val(treeNode.id);
	$.post('emeplan/plantype/list', {id:treeNode.id}, function(j) {
		datas(j);
	});
}

/* $(function(){
	$.post('emeplan/plantype/tree', {}, function(j) {
		var initSelectableTree = function() {
	        return $('#plantype_treeview').treeview({
	          data: j,
	          multiSelect: $('#chk-select-multi').is(':checked'),
	          onNodeSelected: function(event, node) {
	        	  $("#pid").val(node.href);
					$.post('emeplan/plantype/list', {id:node.href}, function(j) {
						datas(j);
					});
	          },
	          onNodeUnselected: function (event, node) {
	          }
	        });
	      };
	      var $selectableTree = initSelectableTree();
	});
	$.post('emeplan/plantype/list', {}, function(j) {
		datas(j);
	});
	
}); */
function datas(j){
	$("#plantype_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		if (i % 2 == 0) {
			str += "<tr style='background-color: #ebf8ff;'>";
			str +="<td>"+j[i].pt_name+"</td>";
			str +="<td>"+j[i].pt_desc+"</td>";
			str +="<td>"+j[i].pt_remark+"</td>";
			str +="<td>"+j[i].user.us_Name+"</td>";
			str +="<td>"+formatDateBoxFull(j[i].pt_createDate)+"</td>";
			
			str +="<td><lauvanpt:permission privilege='planTypeEditip'><button type='button' class='btn btn-warning btn-sm' onclick='plantype_editUI("+j[i].pt_id+");'>修改</button></lauvanpt:permission>";
			str +="<lauvanpt:permission privilege='planTypeDelete'><button type='button' class='btn btn-danger btn-sm' onclick='plantype_delete("+j[i].pt_id+");'>删除</button></lauvanpt:permission></td>";
			str +="</tr>";
		}else{
			str +="<tr>";
			str +="<td>"+j[i].pt_name+"</td>";
			str +="<td>"+j[i].pt_desc+"</td>";
			str +="<td>"+j[i].pt_remark+"</td>";
			str +="<td>"+j[i].user.us_Name+"</td>";
			str +="<td>"+formatDateBoxFull(j[i].pt_createDate)+"</td>";
			
			str +="<td><lauvanpt:permission privilege='planTypeEditip'><button type='button' class='btn btn-warning btn-sm' onclick='plantype_editUI("+j[i].pt_id+");'>修改</button></lauvanpt:permission>";
			str +="<lauvanpt:permission privilege='planTypeDelete'><button type='button' class='btn btn-danger btn-sm' onclick='plantype_delete("+j[i].pt_id+");'>删除</button></lauvanpt:permission></td>";
			str +="</tr>";
		}
		
	}
	$("#plantype_data").append(str);
}
function postChild(id){
	$.post('system/plantypeinfo/list', {id:id}, function(j) {
		datas(j);
	});
}
function plantype_addUI(){
	var pid = $("#pid").val();
	parent.layer.open({
	    type: 2,
	    title:'添加预案分类',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/emeplan/plantype/plantype_add.jsp?pid='+pid,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.plantypeAdd_submitForm(index,window);
	    }
	});
}
function plantype_editUI(id){
	parent.layer.open({
	    type: 2,
	    title:'修改预案分类',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['emeplan/plantype/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.plantypeEdit_submitForm(index,window);
	    }
	});
}
function plantype_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/plantype/delete',{id:id}, function(j) {
			if(j.success){
				parent.layer.close(index);
				window.location.reload();
			}else{
				parent.layer.tips(j.msg, '.layui-layer-btn0',{
				    tips: 1
				});
			}
		}, 'json');
	});
}
</script>
</body>
</html>