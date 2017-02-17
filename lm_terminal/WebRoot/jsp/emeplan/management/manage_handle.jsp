<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案综合管理-预案应急处置</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-sm-3">
		<div id="disposalStage_treeview">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-sm-9" style="padding-left: 0px;">
		
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
	$.post('emeplan/disposalStage/tree2', {pi_id:${param.piId }}, function(j) {
		var zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
	});
	
	$.post('emeplan/disposalStage/list', {pi_id:${param.piId }}, function(j) {
		datas(j,"",0);
	});
});
function autoTree1(){
	$.post('emeplan/disposalStage/tree2', {pi_id:${param.piId}}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		zTree.expandAll(true);
	});
}
function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	if(treeNode.level==0){
		$.post('emeplan/disposalStage/list', {pi_id:${param.piId }}, function(j) {
			datas(j,"",0);
		});
	}else if(treeNode.level==1){
		postChild(treeNode.id,1);
	}else if(treeNode.level==2){
		postChild2(treeNode.id);
	}else if(treeNode.level==3){
		postChild3(treeNode.id);
	}
}

function datas(j,id,level){
	$("#page-wrapper").empty();
	var str = '';
	
	str +="<button type='button' class='btn btn-primary' onclick='disposalStage_addUI("+level+");'>添加</button>-流程设置";
	str +="<input type='hidden' id='pid' value='"+id+"'/>";
	str +="<table class='table table-bordered'>";
	str +="	<tr>";
	str +="		<th>名称</th>";
	str +="		<th>执行顺序</th>";
	str +="		<th>任务说明</th>";
	str +="		<th>操作</th>";
	str +="	</tr>";
	str +="	<tbody>";
	
	for(var i=0;i<j.length;i++){
		str +="<tr id='disposalStageListsDel"+j[i].eds_id+"'>";
		str +="<td>"+j[i].eds_name+"</td>";
		str +="<td>"+j[i].eds_index+"</td>";
		str +="<td>"+j[i].eds_task+"</td>";
		
		str +="<td><button type='button' class='btn btn-primary btn-sm' onclick='disposalStage_editUI("+j[i].eds_id+","+level+");'>编辑</button>";
		str +="<button type='button' class='btn btn-danger btn-sm' onclick='disposalStage_delete("+j[i].eds_id+","+level+");'>删除</button></td>";
		str +="</tr>";
	}
	str +="	</tbody>";
	str +="	<tbody id='disposalStageLists_data'></tbody>";
	str +="</table>";
	$("#page-wrapper").append(str);
}
function datas2(j,id){
	$("#page-wrapper").empty();
	var str = '';
	
	str +="<button type='button' class='btn btn-primary' onclick='actionList_addUI();'>添加</button>-行动清单设置";
	str +="<input type='hidden' id='pid' value='"+id+"'/>";
	str +="<table class='table table-bordered'>";
	str +="	<tr>";
	str +="		<th>代号</th>";
	str +="		<th>名称</th>";
	str +="		<th>操作</th>";
	str +="	</tr>";
	str +="	<tbody>";
	
	for(var i=0;i<j.length;i++){
		str +="<tr id='actionListsDel"+j[i].eal_id+"'>";
		str +="<td>"+j[i].eal_no+"</td>";
		str +="<td>"+j[i].eal_name+"</td>";
		
		str +="<td><button type='button' class='btn btn-primary btn-sm' onclick='actionList_editUI("+j[i].eal_id+");'>编辑</button>";
		str +="<button type='button' class='btn btn-danger btn-sm' onclick='actionList_delete("+j[i].eal_id+");'>删除</button></td>";
		str +="</tr>";
	}
	
	str +="	</tbody>";
	str +="	<tbody id='actionLists_data'></tbody>";
	str +="</table>";
	$("#page-wrapper").append(str);
}
function datas3(j,id){
	$("#page-wrapper").empty();
	var str = '';
	
	str +="<button type='button' class='btn btn-primary' onclick='actionDeps_addUI();'>添加</button>-执行部门人员设置";
	str +="<input type='hidden' id='pid' value='"+id+"'/>";
	str +="<table class='table table-bordered'>";
	str +="	<tr>";
	str +="		<th>执行部门名称</th>";
	str +="		<th>联系人</th>";
	str +="		<th>联系电话</th>";
	str +="		<th>任务说明</th>";
	str +="		<th>操作</th>";
	str +="	</tr>";
	str +="	<tbody>";
	
	for(var i=0;i<j.length;i++){
		str +="<tr id='actionDepsListsDel"+j[i].ead_id+"'>";
		if(j[i].aBooks.organ==undefined){
			if(j[i].aBooks.person==undefined){
				str +="<td></td>";
			}else{
				str +="<td>"+j[i].aBooks.person.organ.or_name+"</td>";
			}
		}else{
			str +="<td>"+j[i].aBooks.organ.or_name+"</td>";
		}
		if(j[i].aBooks.person==undefined){
			str +="<td></td>";
		}else{
			str +="<td>"+j[i].aBooks.person.pe_name+"</td>";
		}
		
		str +="<td>"+j[i].aBooks.bo_number+"</td>";
		if(j[i].ead_remark!=undefined){
			str +="<td>"+j[i].ead_remark+"</td>";
		}else{
			str +="<td></td>";
		}
		
		str +="<td><button type='button' class='btn btn-primary btn-sm' onclick='actionDeps_editUI("+j[i].ead_id+");'>编辑</button>";
		str +="<button type='button' class='btn btn-danger btn-sm' onclick='actionDeps_delete("+j[i].ead_id+");'>删除</button></td>";
		str +="</tr>";
	}
	
	str +="	</tbody>";
	str +="	<tbody id='actionDepsLists_data'></tbody>";
	str +="</table>";
	$("#page-wrapper").append(str);
}
//流程设置
function postChild(id,level){
	$.post('emeplan/disposalStage/list', {eds_id:id}, function(j) {
		datas(j,id,level);
	}).complete(function(XMLHttpRequest,textStatus) {
		var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); //通过XMLHttpRequest取得响应头，sessionstatus，  
        if(sessionstatus=="timeout"){
        	parent.parent.parent.$('#main-msg-show').html('您还没有登录或登录已超时，请重新登录！');
        	parent.parent.parent.$('#main_msgModal').modal('show');
        	parent.parent.parent.$('#main_msgModal').on('hide.bs.modal', function () {
      		  top.location.href="login.jsp"
      	  });
        }
     }
	);
}
//行动清单设置
function postChild2(id){
	$.post('emeplan/actionList/list', {eds_id:id}, function(j) {
		datas2(j,id);
	});
}
//执行部门设置
function postChild3(id){
	$.post('emeplan/actionDepartment/list', {eal_id:id}, function(j) {
		datas3(j,id);
	});
}
/* function disposalStage_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/disposalStage/delete',{id:id}, function(j) {
			if(j.success){
				autoTree1();
				$("#disposalStageListsDel"+id).remove();
				parent.layer.close(index);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
		}, 'json');
	});
} */

function disposalStage_addUI(level){
	var pid = $("#pid").val();
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'添加预案应急处置阶段流程',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/emeplan/disposalStage/disposalStage_add.jsp?pid='+pid+'&pi_id=${param.piId }','no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.disposalStageAdd_submitForm(index,window,level);
	    }
	});
}
function disposalStage_editUI(id,level){
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'修改预案应急处置阶段流程',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['emeplan/disposalStage/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.disposalStageEdit_submitForm(index,window,id,level);
	    }
	});
}
function disposalStage_delete(id,level){
	parent.parent.parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/disposalStage/delete',{id:id,level:level}, function(j) {
			if(j.success){
				autoTree1();
				$("#disposalStageListsDel"+id).remove();
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
function actionList_addUI(){
	var pid = $("#pid").val();
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'行动清单添加',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/emeplan/actionlist/actionlist_add.jsp?pid='+pid+'&pi_id=${param.piId }','no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.actionlistAdd_submitForm(index,window);
	    }
	});
}
function actionList_editUI(id){
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'行动清单修改',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['emeplan/actionList/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.actionlistEdit_submitForm(index,window,id);
	    }
	});
}
function actionList_delete(id){
	parent.parent.parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/actionList/delete',{id:id}, function(j) {
			if(j.success){
				autoTree1();
				$("#actionListsDel"+id).remove();
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
function actionDeps_addUI(){
	var pid = $("#pid").val();
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'行动人员添加',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/emeplan/actiondepartment/actiondepartment_add.jsp?pid='+pid+'&pi_id=${param.piId }','no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.actiondepAdd_submitForm(index,window);
	    }
	});
}
function actionDeps_editUI(id){
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'行动人员修改',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['emeplan/actionDepartment/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.actiondepEdit_submitForm(index,window,id);
	    }
	});
}
function actionDeps_delete(id){
	parent.parent.parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/actionDepartment/delete',{id:id}, function(j) {
			if(j.success){
				//autoTree1();
				$("#actionDepsListsDel"+id).remove();
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
</script>
</body>
</html>