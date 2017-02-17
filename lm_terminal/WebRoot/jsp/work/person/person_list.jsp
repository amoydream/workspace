<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>机构人员管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>
<body>
	<div class="container-fluid" style="margin-top: 10px; margin-left: 10px; padding-left: 0px;">
		<div class="row-fluid">
			<div class="well col-md-3">
				<div id="person_treeview" style="overflow-y: auto; height: 780px; OVERFLOW-X: hidden;">
					<ul id="treeDemo" class="ztree"></ul>
				</div>
			</div>
			<div id="page-wrapper" class="col-md-9" style="padding-left: 10px;">
				<form id="serachForm" class="form-inline" method="post">
					<input type="hidden" id="or_id" name="or_id">
					<input type="hidden" name="page" id="page" />
					<div class="form-group">
						<label for="or_name">部门</label>
						<input type="text" name="or_name" class="form-control" id="or_name" placeholder="输入部门名称">
					</div>
					<div class="form-group">
						<label for="personName">姓名</label>
						<input type="email" name="pe_name" class="form-control" id="pe_name" placeholder="输入姓名">
					</div>
					<button type="button" style="margin-left: 5px;" class="btn btn-primary"
						onclick="$('#or_id').val('');searchPersons('1');">
						<span class="glyphicon glyphicon-search"></span>
						搜索
					</button>
					<lauvanpt:permission privilege="personAdd">
						<button type="button" style="margin-left: 5px;" class="btn btn-primary"
							onclick="person_addUI();">
							<span class="glyphicon glyphicon-plus"></span>
							添加
						</button>
					</lauvanpt:permission>
					<button style="float: right; margin-left: 5px;" type="button"
						class="btn btn-primary" onclick="inportPerson();">
						<span class="glyphicon glyphicon-export"></span> 导入机构人员
					</button>
					<button style="float: right; margin-left: 5px;" type="button"
						class="btn btn-primary" onclick="exportPerson();">
						<span class="glyphicon glyphicon-export"></span> 导出机构人员
					</button>
				</form>
				<div style="margin-top: 10px;">
					<table class="table table-bordered table-hover table-condensed">
						<tr class="info">
							<th width="8%">姓名</th>
							<th width="10%">部门</th>
							<th width="13%">岗位</th>
							<th width="5%">应急人员</th>
							<th width="8%">办公电话</th>
							<th width="8%">住宅电话</th>
							<th width="10%">手机</th>
							<th width="8%">传真</th>
							<th width="10%">邮箱</th>
							<th width="20%">操作</th>
						</tr>
						<tbody id="person_data">
						</tbody>
						<tr>
							<th id="personDataNav" scope="col" colspan="10" align="right"></th>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function inportPerson() {
			parent.layer.open({
				type : 2,
				title : '上传excel文件并导入',
				area : [ '500px', '300px' ],
				scrollbar : false,
				content : 'jsp/work/person/person_inport.jsp',
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.fileUpload(index,
							window);
				}
			});
		}
	    
		function exportPerson() {
	        $.post('work/person/export', {}, function(result) {
		        parent.layer.msg(result.msg, {
		            offset : 300,
		            shift : 6
		        });
	        });
	    }
	
		var setting = {
            data : {
	            simpleData : {
		            enable : true
	            }
            },
            callback : {
	            onClick : zTreeOnClick
            }
        };
        
        $(function() {
	        init();
        });
        
        function init() {
	        $.post('work/organ/tree2', {}, function(j) {
		        zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		        //zTree.expandAll(true);
		        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		        var nodes = treeObj.getNodes();
		        treeObj.expandNode(nodes[0], true);
	        });
	        
	        searchPersons('1');
        }
        function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	        $("#or_id").val(treeNode.id);
	        $('#or_name').val('');
	        $('#pe_name').val('');
	        searchPersons('1');
        }

        function postChild(or_id) {
	        $("#or_id").val(or_id);
	        $('#or_name').val('');
	        $('#pe_name').val('');
	        searchPersons('1');
        }

        function searchPersons(page) {
	        $('#page').val(page);
	        $.post('work/person/list', $('#serachForm').serialize(), function(result) {
		        if(result.success) {
			        datas(result.obj.records);
			        paginationNav('personDataNav', result.obj, 'searchPersons');
		        } else {
			        parent.layer.msg(result.msg, {
			            offset : 0,
			            shift : 6
			        });
		        }
	        });
        }

        function datas(j) {
	        $("#person_data").empty();
	        var str = '';
	        for(var i = 0; i < j.length; i++) {
		        if(i % 2 == 0) {
			        str += "<tr id='remove_"+j[i].pe_id+"' style='background-color: #ebf8ff;'>";
			        
		        } else {
			        str += "<tr id='remove_"+j[i].pe_id+"'>";
		        }
		        str += "<td>" + $.trim(j[i].pe_name) + "</td>";
			    str += "<td>" + $.trim(j[i].or_name) + "</td>";
		        str += "<td>" + $.trim(j[i].pe_jobs) + "</td>";
		        
		        if(j[i].pe_type == '1') {
			        str += "<td>是</td>";
		        } else {
			        str += "<td>否</td>";
		        }
		        str += "<td>" + $.trim(j[i].officephone) + "</td>";
		        str += "<td>" + $.trim(j[i].homephone) + "</td>";
		        str += "<td>" + $.trim(j[i].mobilephone) + "</td>";
		        str += "<td>" + $.trim(j[i].fax) + "</td>";
		        str += "<td>" + $.trim(j[i].email) + "</td>";
		        str += "<td><lauvanpt:permission privilege='personEditip'><button type='button' class='btn btn-primary btn-xs' onclick='person_editUI("
		               + j[i].pe_id
		               + ");'><span class='glyphicon glyphicon-pencil'></span> 编辑</button>&nbsp;</lauvanpt:permission>";
		        str += "<lauvanpt:permission privilege='personDelup'><button type='button' class='btn btn-danger btn-xs' onclick='person_delete("
		               + j[i].pe_id
		               + ");'><span class='glyphicon glyphicon-remove'></span> 删除</button>&nbsp;</lauvanpt:permission>";
		        str += "<button type='button' class='btn btn-warning btn-xs' onclick='person_books(" + j[i].pe_id
		               + ");'><span class='glyphicon glyphicon-user'></span> 通讯录</button></td>";
		        str += "</tr>";
	        }
	        $("#person_data").append(str);
        }

        function person_addUI() {
	        var or_id = $("#or_id").val();
	        if(or_id == null || or_id == '') {
		        parent.layer.msg('没有选择所属机构', {
		            offset : 0,
		            shift : 6
		        });
		        return;
	        }
	        parent.layer.open({
	            type : 2,
	            title : '添加组织机构人员',
	            area : ['800px', '600px'],
	            scrollbar : false,
	            content : ['jsp/work/person/person_add.jsp?or_id=' + or_id, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.personAdd_submitForm(index, window, or_id);
	            }
	        });
        }
        function person_editUI(id) {
	        var or_id = $("#or_id").val();
	        parent.layer.open({
	            type : 2,
	            title : '组织机构人员信息修改',
	            area : ['800px', '650px'],
	            scrollbar : false,
	            content : ['work/person/editip?id=' + id, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.personEdit_submitForm(index, window, or_id);
	            }
	        });
        }
        function person_delete(id) {
	        parent.layer.confirm('您确定要删除么？', function(index) {
		        $.post('work/person/delete', {
			        id : id
		        }, function(j) {
			        if(j.success) {
				        parent.layer.close(index);
				        $("#remove_" + id).remove();
			        }
			        parent.layer.msg(j.msg, {
			            offset : 0,
			            shift : 6
			        });
		        }, 'json');
	        });
        }
        function person_books(id) {
	        var or_id = $("#or_id").val();
	        parent.layer.open({
	            type : 2,
	            title : '添加通讯录',
	            area : ['800px', '500px'],
	            scrollbar : false,
	            content : ['jsp/work/books/books_add.jsp?pid=' + id + '&contact_type=P', 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.organAddBooks_submitForm(index, window, or_id);
	            }
	        });
        }
	</script>
</body>
</html>