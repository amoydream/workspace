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
<title>模块管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="well col-md-3">
		<div id="module_treeview" style="overflow:scroll; height:616px; OVERFLOW-X:hidden;">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-md-9" style="padding-left: 0px;">
		<lauvanpt:permission privilege="moduleAddip">
		<button type="button" class="btn btn-primary" onclick="module_addUI();">添加</button>
		</lauvanpt:permission>
		<input type="hidden" id="pid" value="${pid }"/>
		<table class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
				<th style="text-align:center">模块名称</th>
				<th style="text-align:center">模块编码</th>
				<th style="text-align:center">模块路径</th>
				<th style="text-align:center">级别</th>
				<th style="text-align:center">图标</th>
				<th style="text-align:center">颜色</th>
				<th style="text-align:center">备注</th>
				<th style="text-align:center">操作</th>
			</tr>
			<tbody id="module_data">
			
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
	$.post('system/moduleinfo/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getNodes();
		treeObj.expandNode(nodes[0], true);
	});
	$.post('system/moduleinfo/list', { }, function(j) {
		datas(j);
	});
});

function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#pid").val(treeNode.id);
	$.post('system/moduleinfo/list', {id:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#module_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		if (i % 2 == 0) {
			str += "<tr style='background-color: #ebf8ff;'>";
			str +="<td style='text-align:center'>"+j[i].mo_Name+"</td>";
			str +="<td style='text-align:center'>"+j[i].mo_Code+"</td>";
	        if(j[i].mo_Url==undefined || j[i].mo_Url==''){
	        	str +="<td></td>";
			}else{
				str +="<td style='text-align:center'>"+j[i].mo_Url+"</td>";
			}
	        if(j[i].mo_Step=='1'){
	        	str +="<td style='text-align:center'>菜单</td>";
	        }else if(j[i].mo_Step=='2'){
	        	str +="<td style='text-align:center'>功能</td>";
	        }else{
	        	
	        }
			
			str +="<td style='text-align:center'>"+j[i].mo_Icon+"</td>";
			str +="<td style='text-align:center'>"+j[i].mo_Class+"</td>";
			if(j[i].mo_Remark==undefined || j[i].mo_Remark==''){
				str +="<td></td>";
			}else{
				str +="<td style='text-align:center'>"+j[i].mo_Remark+"</td>";
			}
			str +="<td style='text-align:center'><lauvanpt:permission privilege='moduleEditip'><button type='button' class='btn btn-primary btn-sm' onclick='module_editUI("+j[i].mo_Id+");'>编辑</button></lauvanpt:permission><lauvanpt:permission privilege='moduleDelete'><button type='button' class='btn btn-danger btn-sm' onclick='module_delete("+j[i].mo_Id+");'>删除</button></lauvanpt:permission></td>";
			str +="</tr>";
		}else{
			str +="<tr>";
			str +="<td style='text-align:center'>"+j[i].mo_Name+"</td>";
			str +="<td style='text-align:center'>"+j[i].mo_Code+"</td>";
	        if(j[i].mo_Url==undefined || j[i].mo_Url==''){
	        	str +="<td></td>";
			}else{
				str +="<td style='text-align:center'>"+j[i].mo_Url+"</td>";
			}
	        if(j[i].mo_Step=='1'){
	        	str +="<td style='text-align:center'>菜单</td>";
	        }else if(j[i].mo_Step=='2'){
	        	str +="<td style='text-align:center'>功能</td>";
	        }else{
	        	
	        }
			
			str +="<td style='text-align:center'>"+j[i].mo_Icon+"</td>";
			str +="<td style='text-align:center'>"+j[i].mo_Class+"</td>";
			if(j[i].mo_Remark==undefined || j[i].mo_Remark==''){
				str +="<td></td>";
			}else{
				str +="<td style='text-align:center'>"+j[i].mo_Remark+"</td>";
			}
			str +="<td style='text-align:center'><lauvanpt:permission privilege='moduleEditip'><button type='button' class='btn btn-primary btn-sm' onclick='module_editUI("+j[i].mo_Id+");'>编辑</button></lauvanpt:permission><lauvanpt:permission privilege='moduleDelete'><button type='button' class='btn btn-danger btn-sm' onclick='module_delete("+j[i].mo_Id+");'>删除</button></lauvanpt:permission></td>";
			str +="</tr>";
		}
		
	}
	$("#module_data").append(str);
}
function postChild(id){
	$.post('system/moduleinfo/list', {id:id}, function(j) {
		datas(j);
	});
}
function module_addUI(){
	var pid = $("#pid").val();
	parent.layer.open({
	    type: 2,
	    title:'添加模块菜单',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/system/moduleinfo/module_add.jsp?pid='+pid,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.moduleAdd_submitForm(index,window);
	    }
	});
}
function module_editUI(id){
	parent.layer.open({
	    type: 2,
	    title:'修改模块菜单',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['system/moduleinfo/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.moduleEdit_submitForm(index,window);
	    }
	});
}
function module_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('system/moduleinfo/delete',{id:id}, function(j) {
			if(j.success){
				parent.layer.close(index);
				postChild($("#pid").val());
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	});
}
</script>
</body>
</html>