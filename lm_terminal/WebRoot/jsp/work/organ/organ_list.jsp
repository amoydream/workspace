<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="lauvanpt" uri="http://java.lauvan.com/lauvan/permission"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>组织机构管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>
<body>
	<div class="container-fluid" style="margin-top: 10px; margin-left: 10px; padding-left: 0px;">
		<div class="row-fluid">
			<div class="well col-sm-3">
				<div id="organ_treeview" style="overflow-y: auto; height: 780px; OVERFLOW-X: hidden;">
					<ul id="treeDemo" class="ztree"></ul>
				</div>
			</div>
			<div id="page-wrapper" class="col-sm-9" style="padding-left: 10px;">
				<form id="serachForm" class="form-inline" method="post">
					<input type="hidden" id="pid" name="pid" value="${pid }" />
					<input type="hidden" name="page" id="page" />
					<div class="form-group">
						<label for="or_name">机构名称</label>
						<input type="text" name="or_name" class="form-control" id="or_name" placeholder="输入机构名称">
					</div>
					<button type="button" style="margin-left: 5px;" class="btn btn-primary"
						onclick="$('#pid').val('');searchOrgans('1');">
						<span class="glyphicon glyphicon-search"></span>
						搜索
					</button>
					<lauvanpt:permission privilege="organAdd">
						<button type="button" style="margin-left: 5px;" class="btn btn-primary"
							onclick="organ_addUI();">
							<span class="glyphicon glyphicon-plus"></span>
							添加
						</button>
					</lauvanpt:permission>
					<button style="float: right; margin-left: 5px;" type="button"
						class="btn btn-primary" onclick="excelIn();">
						<span class="glyphicon glyphicon-import"></span> 导入excel
					</button>
				</form>
				<div style="margin-top: 10px;">
					<table class="table table-bordered table-hover table-condensed">
						<tr class="info">
							<th width="15%">机构名称</th>
							<th width="20%">地址</th>
							<th width="10%">应急机构</th>
							<th width="10%">办公电话</th>
							<th width="10%">传真</th>
							<th width="15%">邮箱</th>
							<th width="20%">操作</th>
						</tr>
						<tbody id="organ_data">
						</tbody>
						<tr>
							<th id="organDataNav" scope="col" colspan="7" align="right"></th>
						</tr>
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
                beforeClick : zTreeOnClick,
                onDrop : zTreeOnDrop
            }
        };
        
        $(function() {
	        $.post('work/organ/tree2', {}, function(j) {
		        var zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		        //zTree.expandAll(true);
		        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		        var nodes = treeObj.getNodes();
		        treeObj.expandNode(nodes[0], true);
	        });
	        $.post('work/organ/list', {}, function(j) {
		        datas(j);
	        });
	        
	        searchOrgans("1");
        });
        
        function zTreeOnClick(treeId, treeNode, clickFlag) {
	        $("#pid").val(treeNode.id);
	        /*  $.post('work/organ/list', {
	             id : treeNode.id
	         }, function(j) {
	             datas(j);
	         }); */
	        $("#pid").val(treeNode.id);
	        $('#or_name').val('');
	        searchOrgans("1");
        }

        function searchOrgans(page) {
	        $('#page').val(page);
	        $.post('work/organ/search', $('#serachForm').serialize(), function(result) {
		        if(result.success) {
			        datas(result.obj.records);
			        paginationNav('organDataNav', result.obj, 'searchOrgans');
		        } else {
			        parent.layer.msg(result.msg, {
			            offset : 300,
			            shift : 6
			        });
		        }
	        });
        }

        function datas(j) {
	        $("#organ_data").empty();
	        var str = '';
	        for(var i = 0; i < j.length; i++) {
		        if(i % 2 == 0) {
			        str += "<tr id='removeID_"+j[i].or_id+"'style='background-color: #ebf8ff;'>";
		        } else {
			        str += "<tr id='removeID_"+j[i].or_id+"'>";
		        }
		        str += "<td>" + $.trim(j[i].or_name) + "</td>";
		        str += "<td>" + $.trim(j[i].or_address) + "</td>";
		        if(j[i].or_type == '1') {
			        str += "<td>是</td>";
		        } else {
			        str += "<td>否</td>";
		        }
		        str += "<td>" + $.trim(j[i].officephone) + "</td>";
		        str += "<td>" + $.trim(j[i].fax) + "</td>";
		        str += "<td>" + $.trim(j[i].email) + "</td>";
		        str += "<td><lauvanpt:permission privilege='organEditip'><button type='button' class='btn btn-primary btn-xs' onclick='organ_editUI("
		               + j[i].or_id
		               + ");'><span class='glyphicon glyphicon-pencil'></span> 编辑</button>&nbsp;</lauvanpt:permission>";
		        str += "<lauvanpt:permission privilege='organDelete'><button type='button' class='btn btn-danger btn-xs' onclick='organ_delete("
		               + j[i].or_id
		               + ");'><span class='glyphicon glyphicon-remove'></span> 删除</button>&nbsp;</lauvanpt:permission>";
		        str += "<button type='button' class='btn btn-warning btn-xs' onclick='organ_books(" + j[i].or_id
		               + ");'><span class='glyphicon glyphicon-user'></span> 通讯录</button></td>";
		        str += "</tr>";
	        }
	        $("#organ_data").append(str);
        }
        function postChild(pid) {
	        /* $.post('work/organ/list', {
	            id : pid
	        }, function(j) {
	            datas(j);
	        }); */

	        $("#pid").val(pid);
	        $('#or_name').val('');
	        searchOrgans("1");
        }
        function organ_addUI() {
	        var pid = $("#pid").val();
	        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	        parent.layer.open({
	            type : 2,
	            title : '添加组织机构',
	            area : ['800px', '500px'],
	            scrollbar : false,
	            content : ['jsp/work/organ/organ_add.jsp?pid=' + pid, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.organAdd_submitForm(index, window, treeObj);
	            }
	        });
        }
        function organ_editUI(id) {
	        var pid = $("#pid").val();
	        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	        parent.layer.open({
	            type : 2,
	            title : '修改组织机构',
	            area : ['800px', '500px'],
	            scrollbar : false,
	            content : ['work/organ/editip?id=' + id, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.organEdit_submitForm(index, window, treeObj, pid);
	            }
	        });
        }
        function organ_delete(id) {
	        parent.layer.confirm('该部门下属部门、人员、通讯录都将被删除   ,  确定要删除么?', function(index) {
		        $.post('work/organ/delete', {
			        id : id
		        }, function(j) {
			        if(j.success) {
				        $("#removeID_" + id).remove();
				        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				        var node = treeObj.getNodeByParam("id", id, null);
				        if(node) {
					        treeObj.removeNode(node);
				        }
				        ;
				        parent.layer.close(index);
			        }
			        parent.layer.msg(j.msg, {
			            offset : 0,
			            shift : 6
			        });
		        }, 'json');
	        });
        }
        function organ_books(id) {
	        parent.layer.open({
	            type : 2,
	            title : '添加通讯录',
	            area : ['800px', '500px'],
	            scrollbar : false,
	            content : ['jsp/work/books/books_add.jsp?orid=' + id, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.organAddBooks_submitForm(index, window);
	            }
	        });
        }
        /**
         * 
         * moveType  指定移动到目标节点的相对位置
         * "inner"：成为子节点，"prev"：成为同级前一个节点，"next"：成为同级后一个节点
         */
        function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
	        if(moveType == 'inner') {
		        parent.layer.confirm('您确定要移动么？', function(index) {
			        var ids = [];
			        for(i = 0; i < treeNodes.length; i++) {
				        ids[i] = treeNodes[i].id;
			        }
			        $.post('work/organ/drop', {
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
        
        function excelIn() {
			parent.layer.open({
				type : 2,
				title : '上传excel文件并导入',
				area : [ '500px', '250px' ],
				scrollbar : false,
				content : 'jsp/work/organ/import.jsp',
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.fileUpload(index,
							window);
				}
			});
		}
	</script>
</body>
</html>