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
<title>岗位分类</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
<style type="text/css">
td,th {
	text-align: center;
}
</style>
</head>
<body>
	<div class="container-fluid" style="margin-top: 10px; margin-left: 10px; padding-left: 0px;">
		<div class="row-fluid">
			<div class="well col-sm-3">
				<div id="organ_treeview" style="overflow-y: auto; height: 616px; OVERFLOW-X: hidden;">
					<ul id="treeDemo" class="ztree"></ul>
				</div>
			</div>
			<div id="page-wrapper" class="col-md-9" style="padding-left: 10px;">
				<lauvanpt:permission privilege="positionTypeAdd">
					<button type="button" style="margin-left: 5px;" class="btn btn-primary"
						onclick="positionclassification_addUI();">
						<span class="glyphicon glyphicon-plus"></span>
						添加分类
					</button>
					<button type="button" style="margin-left: 5px;" class="btn btn-primary"
						onclick="position_addUI();">
						<span class="glyphicon glyphicon-plus"></span>
						添加岗位
					</button>
				</lauvanpt:permission>
				<div style="margin-top: 10px; overflow-y: auto; height: 570px; OVERFLOW-X: hidden;">
					<input type="hidden" id="pid" value="${pid}" />
					<input type="hidden" id="treeNode_pId" value="" />
					<table class="table table-bordered table-striped table-hover table-condensed">
						<tr id="trid" class="info">
							<th>岗位分类</th>
							<th>操作</th>
						</tr>
						<tbody id="position_data">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var setting = {
            edit : {
                enable : true,
                showRemoveBtn : false,
                showRenameBtn : false
            },
            data : {
	            simpleData : {
		            enable : true
	            }
            },
            callback : {
                onClick : zTreeOnClick,
                onDrop : zTreeOnDrop
            }
        };
        //初始化
        $(function() {
	        $.post('work/positionclassification/tree2', {}, function(j) {
		        zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		        var nodes = treeObj.getNodes();
		        treeObj.expandNode(nodes[0], true);
	        });
	        $.post('work/positionclassification/list', {}, function(j) {
		        datas(j);
	        });
        });
        
        //系统树点击
        function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	        $("#pid").val(treeNode.id);
	        $("#treeNode_pId").val(treeNode.pId);
	        if(treeNode.pId == null) {
		        $.post('work/positionclassification/list', {
			        id : treeNode.id
		        }, function(j) {
			        datas(j);
		        });
	        } else {
		        $.post('work/position/list', {
			        id : treeNode.id
		        }, function(j) {
			        datas2(j);
		        });
	        }
        }
        //岗位分类
        function postChild(pid) {
	        $.post('work/positionclassification/list', {
		        id : pid
	        }, function(j) {
		        datas(j);
	        });
        }

        //岗位修改返回
        function initPosition(id) {
	        $.post('work/position/list', {
		        id : id
	        }, function(j) {
		        datas2(j);
	        });
        }

        function datas(j) {
	        $("#trid").empty();
	        $("#position_data").empty();
	        var str = '';
	        var str1 = '';
	        str1 += "<th>岗位分类</th>";
	        str1 += "<th>操作</th>";
	        $("#trid").append(str1);
	        
	        for(var i = 0; i < j.length; i++) {
		        if(i % 2 == 0) {
			        str += "<tr id='pcID"+j[i].pc_id+"' style='background-color: #ebf8ff;'>";
			        str += "<td>" + j[i].pc_name + "</td>";
			        str += "<td><lauvanpt:permission privilege='positionTypeEditip'><button type='button' class='btn btn-primary btn-xs' onclick='positionclassification_editUI("
			               + j[i].pc_id
			               + ");'><span class='glyphicon glyphicon-pencil'></span> 编辑</button>&nbsp;</lauvanpt:permission>";
			        str += "<lauvanpt:permission privilege='positionTypeDelete'><button type='button' class='btn btn-danger btn-xs' onclick='positionclassification_delete("
			               + j[i].pc_id
			               + ");'><span class='glyphicon glyphicon-remove'></span> 删除</button></lauvanpt:permission></td>";
			        str += "</tr>";
		        } else {
			        str += "<tr id='pcID"+j[i].pc_id+"'>";
			        str += "<td>" + j[i].pc_name + "</td>";
			        str += "<td><lauvanpt:permission privilege='positionTypeEditip'><button type='button' class='btn btn-primary btn-xs' onclick='positionclassification_editUI("
			               + j[i].pc_id
			               + ");'><span class='glyphicon glyphicon-pencil'></span> 编辑</button>&nbsp;</lauvanpt:permission>";
			        str += "<lauvanpt:permission privilege='positionTypeDelete'><button type='button' class='btn btn-danger btn-xs' onclick='positionclassification_delete("
			               + j[i].pc_id
			               + ");'><span class='glyphicon glyphicon-remove'></span> 删除</button></lauvanpt:permission></td>";
			        str += "</tr>";
		        }
		        
	        }
	        $("#position_data").append(str);
        }

        function datas2(j) {
	        $("#trid").empty();
	        $("#position_data").empty();
	        var str = '';
	        var str1 = '';
	        str1 += "<th>岗位</th>";
	        str1 += "<th>操作</th>";
	        $("#trid").append(str1);
	        for(var i = 0; i < j.length; i++) {
		        if(i % 2 == 0) {
			        str += "<tr id='pID"+j[i].p_id+"' style='background-color: #ebf8ff;'>";
			        str += "<td>" + j[i].p_name + "</td>";
			        str += "<td><lauvanpt:permission privilege='positionEditip'><button type='button' class='btn btn-primary btn-sm' onclick='position_editUI("
			               + j[i].p_id + ");'>编辑</button></lauvanpt:permission>";
			        str += "<lauvanpt:permission privilege='positionDelete'><button type='button' class='btn btn-danger btn-sm' onclick='position_delete("
			               + j[i].p_id + ");'>删除</button></lauvanpt:permission></td>";
			        str += "</tr>";
		        } else {
			        str += "<tr id='pID"+j[i].p_id+"'>";
			        str += "<td>" + j[i].p_name + "</td>";
			        str += "<td><lauvanpt:permission privilege='positionEditip'><button type='button' class='btn btn-primary btn-sm' onclick='position_editUI("
			               + j[i].p_id + ");'>编辑</button></lauvanpt:permission>";
			        str += "<lauvanpt:permission privilege='positionDelete'><button type='button' class='btn btn-danger btn-sm' onclick='position_delete("
			               + j[i].p_id + ");'>删除</button></lauvanpt:permission></td>";
			        str += "</tr>";
		        }
		        
	        }
	        $("#position_data").append(str);
	        
        }

        function positionclassification_addUI() {
	        var pid = $("#pid").val();
	        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	        parent.layer.open({
	            type : 2,
	            title : '添加岗位分类',
	            area : ['800px', '500px'],
	            scrollbar : false,
	            content : ['jsp/work/positionclassification/positionclassification_add.jsp?pid=' + pid, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.classificationAdd_submitForm(index, window, treeObj);
	            }
	        });
        }

        function position_addUI() {
	        var pid = $("#pid").val();
	        var treeNode_pId = $("#treeNode_pId").val();
	        if(treeNode_pId == null || treeNode_pId == '') {
		        parent.layer.msg('请选择所属分类', {
		            offset : 0,
		            shift : 6
		        });
		        return;
	        }
	        
	        parent.layer.open({
	            type : 2,
	            title : '添加岗位',
	            area : ['800px', '500px'],
	            scrollbar : false,
	            content : ['jsp/work/position/position_add.jsp?pid=' + pid, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.positionAdd_submitForm(index, window, pid);
	            }
	        });
        }

        function positionclassification_editUI(id) {
	        var pid = $("#pid").val();
	        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	        parent.layer.open({
	            type : 2,
	            title : '修改岗位分类',
	            area : ['800px', '500px'],
	            scrollbar : false,
	            content : ['work/positionclassification/editip?id=' + id, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.classificationEdit_submitForm(index, window, treeObj, pid);
	            }
	        });
        }

        function position_editUI(id) {
	        var pid = $("#pid").val();
	        parent.layer.open({
	            type : 2,
	            title : '修改岗位',
	            area : ['800px', '500px'],
	            scrollbar : false,
	            content : ['work/position/editip?id=' + id, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.positionEdit_submitForm(index, window, pid);
	            }
	        });
        }

        function positionclassification_delete(id) {
	        parent.layer.confirm('您确定要删除么？', function(index) {
		        $.post('work/positionclassification/delete', {
			        id : id
		        }, function(j) {
			        if(j.success) {
				        $("#pcID" + id).remove();
				        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				        var node = treeObj.getNodeByParam("id", id, null);
				        if(node) {
					        treeObj.removeNode(node);
				        }
				        ;
				        parent.layer.close(index);
			        } else {
				        parent.layer.msg(j.msg, {
				            offset : 0,
				            shift : 6
				        });
			        }
		        }, 'json');
	        });
        }

        function position_delete(id) {
	        parent.layer.confirm('您确定要删除么？', function(index) {
		        $.post('work/position/delete', {
			        id : id
		        }, function(j) {
			        if(j.success) {
				        $("#pID" + id).remove();
				        parent.layer.close(index);
			        } else {
				        parent.layer.msg(j.msg, {
				            offset : 0,
				            shift : 6
				        });
			        }
		        }, 'json');
	        });
        }

        function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
	        if(moveType == 'inner') {
		        parent.layer.confirm('您确定要移动么？', function(index) {
			        var ids = [];
			        for(i = 0; i < treeNodes.length; i++) {
				        ids[i] = treeNodes[i].id;
			        }
			        $.post('work/positionclassification/drop', {
			            ids : ids.join(','),
			            id : targetNode.id
			        }, function(j) {
				        parent.layer.msg(j.msg, {
				            offset : 0,
				            shift : 6
				        });
				        parent.layer.close(index);
			        }, 'json');
		        });
	        }
        }
	</script>
</body>
</html>