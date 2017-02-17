<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案综合管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="well col-md-3">
		<div id="planinfo_treeview" style="overflow-y:auto; height:570px; OVERFLOW-X:hidden;">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-md-9" style="padding-left: 0px;">
		
		<ul role="tablist" id="maintab" class="nav nav-tabs">
   <li class="active"><a href="#manage1" data-toggle="tab">预案基本信息</a></li>
   <li><a a href="#manage2" data-toggle="tab">预案应急机构</a></li>
   <li><a a href="#manage3" data-toggle="tab">应急资源配置</a></li>
   <li><a href="#manage4" data-toggle="tab">事件分类分级</a></li>
   <li><a href="#manage5" data-toggle="tab">预案应急处置</a></li>
</ul>
<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="manage1" >
         <iframe id="iframepage0" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="emeplan/planinfo/view?id=${pi_id }"></iframe>
      </div>
      <div class="tab-pane fade" id="manage2" >
         <iframe id="iframepage0" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="jsp/emeplan/management/manage_organ.jsp?piId=${pi_id }"></iframe>
      </div>
      <div class="tab-pane fade" id="manage3" >
         <iframe id="iframepage1" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="jsp/emeplan/management/manage_resource.jsp?piId=${pi_id }"></iframe>
      </div>
      <div class="tab-pane fade" id="manage4" >
         <iframe id="iframepage3" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="jsp/emeplan/management/manage_event.jsp?piId=${pi_id }"></iframe>
      </div>
      <div class="tab-pane fade" id="manage5" >
         <iframe id="iframepage4" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="99%" height="550px" src="jsp/emeplan/management/manage_handle.jsp?piId=${pi_id }"></iframe>
      </div>
   </div>
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
var hg;
$(function(){
	$.post('emeplan/manage/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getNodes();
		treeObj.expandNode(nodes[0], true);
	});
	hg = $(document).height()-90;
});

function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#page-wrapper").empty("");
	var content = "<iframe src='jsp/emeplan/management/manage_list.jsp?piId="+treeNode.id+"&hg="+hg+"' width='99%' height='600px' id='iframepage' frameborder='no' border='0' marginwidth='0' marginheight='0' allowtransparency='yes'></iframe>";
	$("#page-wrapper").append(content);
}

function datas(j){
	$("#planinfo_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
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
		
		str +="<td>"+j[i].pi_no+"</td>";
		str +="<td>"+formatDatebox(j[i].pi_createDate)+"</td>";
		
		str +="<td><a href='javascript:void(0);' class='btn btn-warning main_tabs' addtabs='parentAddtabs' url='emeplan/planinfo/editip?id="+j[i].pi_id+"' title='预案基本信息修改' class='thumbnail'>修改</a>";
		str +="<button type='button' class='btn btn-danger btn-sm' onclick='planinfo_delete("+j[i].pi_id+");'>删除</button></td>";
		str +="</tr>";
	}
	$("#planinfo_data").append(str);
	tabs_init2("main_tabs");
}
function postChild(id){
	$.post('system/planinfoinfo/list', {id:id}, function(j) {
		datas(j);
	});
}
function planinfo_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/planinfo/delete',{id:id}, function(j) {
			if(j.success){
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
</script>
</body>
</html>