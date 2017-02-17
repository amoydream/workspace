<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>选择机构人员</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<link rel="stylesheet" href="lauvanUI/layer/skin/layer.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script src="lauvanUI/layer/layer.js"></script>
<style type="text/css">
.bootstrap-tagsinput span {
	padding-top: 2px;
}
</style>
<script type="text/javascript">
	$groupContacts = [];

    function createGroup() {
	    if($('#group_name').val() == null || $('#group_name').val().trim() == '') {
		    parent.parent.layer.msg("请输入分组名称", {
		        offset : 300,
		        shift : 6
		    });
		    return;
	    }
	    $.post('contact/creategroup/' + $('#group_name').val(), {}, function(result) {
		    if(result.success) {
			    $groupContacts = [];
			    showResult();
			    $('#group_id').val(result.obj);
			    $('#cb_checkall').prop('checked', false);
			    getGroupTree();
		    }
		    parent.parent.layer.msg(result.msg, {
		        offset : 300,
		        shift : 6
		    });
	    });
    }

    function deleteGroup() {
	    if(!checkGroup()) {
		    return;
	    }
	    parent.layer.confirm('按【确定】删除分组', function() {
		    $.post('contact/deletegroup/' + $('#group_id').val(), {}, function(result) {
			    if(result.success) {
				    getGroupTree();
				    $('#group_id').val('');
				    $('#group_name').val('');
				    $('#contactIds').val('');
				    $groupContacts = [];
				    $('#cb_checkall').prop('checked', false);
				    $('#contact_data').html('');
				    $('#contactDataNav').html('');
			    }

			    parent.parent.layer.msg(result.msg, {
			        offset : 300,
			        shift : 6
			    });
		    });
	    });
    }

    function deleteContacts() {
	    if(!checkGroup()) {
		    return;
	    }
	    var contactIds = '';
	    if($('.cb_select') != null && $('.cb_select').length > 0) {
		    $.each($('.cb_select'), function(i, cb) {
			    if($(cb).is(':checked')) {
				    contactIds += $(cb).attr('id') + ','
			    }
		    });
		    if(contactIds != '') {
			    contactIds = contactIds.substr(0, contactIds.length - 1);
		    } else {
			    parent.parent.layer.msg('请选择联系人', {
			        offset : 300,
			        shift : 6
			    });
			    return;
		    }
		    $.post('contact/deletecontacts', {
		        group_id : $('#group_id').val(),
		        contactIds : contactIds
		    }, function(result) {
			    if(result.success) {
				    if($('.cb_select') != null && $('.cb_select').length > 0) {
					    searchContacts($('#page').val());
				    } else {
					    if($('#page').val() > 1) {
						    searchContacts($('#page').val() - 1);
					    } else {
						    searchContacts('1');
					    }
				    }
			    }

			    parent.parent.layer.msg(result.msg, {
			        offset : 300,
			        shift : 6
			    });
		    });
	    } else {
		    parent.parent.layer.msg('请选择联系人', {
		        offset : 300,
		        shift : 6
		    });
	    }

    }

    function searchContacts(page) {
	    $('#page').val(page);
	    $.post('contact/groupsearch/' + $('#group_id').val() + '/' + page, {}, function(result) {
		    if(result.success) {
			    $('#cb_checkall').prop('checked', false);
			    $groupContacts = result.obj.records;
			    showResult();
			    paginationNav('contactDataNav', result.obj, 'searchContacts');
		    }
	    });
    }

    function selectContacts() {
	    if(!checkGroup()) {
		    return;
	    }
	    parent.parent.layer.open({
	        type : 2,
	        title : '选择联系人',
	        area : ['1080px', '720px'],
	        scrollbar : false,
	        content : ['jsp/common/contact/contact_multisel.jsp', 'yes'],
	        btn : ['确定', '取消'],
	        yes : function(index, layero) {
		        $groupContacts = layero.find('iframe')[0].contentWindow.$selectedContacts;
		        setGroupContacts();
		        $('#cb_checkall').prop('checked', false);
		        parent.parent.layer.close(index);
	        },
	        success : function(layero, index) {
		        var popup = layero.find('iframe')[0].contentWindow;
		        popup.$(function() {
			        popup.setSelectedContacts($groupContacts);
		        });
	        }
	    });
    }

    function setGroupContacts() {
	    var contactIds = '';
	    if($groupContacts != null && $groupContacts.length > 0) {
		    $.each($groupContacts, function(i, c) {
			    if($.trim(c.contact_id) != '') {
				    contactIds += $.trim(c.contact_id) + ',';
			    }
		    });
	    }
	    if(contactIds != '') {
		    contactIds = contactIds.substr(0, contactIds.length - 1);
	    }
	    $('#contactIds').val(contactIds);
	    $.post('contact/savegroup', $('#groupForm').serialize(), function(result) {
		    if(result.success) {
			    searchContacts('1');
		    }
	    });
    }

    function showResult() {
	    $("#contact_data").empty();
	    var str = '';
	    for(var i = 0; i < $groupContacts.length && i < 8; i++) {
		    var c = $groupContacts[i];
		    if(i % 2 == 1) {
			    str += '<tr class="warning">'
		    } else {
			    str += '<tr>'
		    }
		    str += '<td>' + $.trim(c.pe_name) + '</td>';
		    str += '<td>' + $.trim(c.or_name) + '</td>';
		    str += '<td>' + $.trim(c.p_names) + '</td>';
		    str += '<td>' + $.trim(c.tel_home) + '</td>';
		    str += '<td>' + $.trim(c.tel_office) + '</td>';
		    str += '<td>' + $.trim(c.tel_mobile) + '</td>';
		    str += '<td>' + $.trim(c.fax_number) + '</td>';
		    str += '<td>' + $.trim(c.email) + '</td>';
		    str += '<td>';
		    str += '<input type="checkbox" class="cb_select" style="float: right;" id="' + c.contact_id + '" value="" onclick="updateCheckAll(this);">';
		    str += '</td>';
		    str += '</tr>';
	    }
	    $("#contact_data").html(str);
    }

    function checkGroup() {
	    if($('#group_id').val() == null || $('#group_id').val() == '') {
		    parent.parent.layer.msg("请选择分组", {
		        offset : 300,
		        shift : 6
		    });
		    return false;
	    }
	    return true;
    }

    function toggleCheckAll() {
	    $.each($('.cb_select'), function(i, cb) {
		    var checkall = $('#cb_checkall').is(':checked');
		    $(cb).prop('checked', checkall);
	    });
    }

    function updateCheckAll(cb) {
	    var checkAll = $(cb).is(':checked');
	    if($(cb).is(':checked')) {
		    for(var i = 0; i < $('.cb_select').length; i++) {
			    if(!$($('.cb_select')[i]).is(':checked')) {
				    checkAll = false;
				    break;
			    }
		    }
	    }
	    $('#cb_checkall').prop('checked', checkAll);
    }

    $grouptree = null;

    function getGroupTree() {
	    $.post('contact/grouptree', {}, function(grouptree) {
		    $grouptree = $('#group_treeview').treeview({
		        data : [grouptree],
		        multiSelect : false,
		        onNodeSelected : function(event, node) {
			        $('#group_id').val(node.href);
			        $('#group_name').val(node.text);
			        searchContacts('1');
		        }
		    });
	    });
    }

    $(function() {
	    getGroupTree();
    });
</script>
</head>
<body>
	<div class="col-md-3" style="margin-top: 10px;">
		<div id="group_treeview"></div>
	</div>
	<div id="page-wrapper" class="col-md-9" style="margin-top: 10px;">
		<div style="margin-bottom: 10px;">
			<div class="form-inline">
				<div class="form-group">
					<label for="group_name">分组名称</label>
					<input type="text" id="group_name" name="name" class="form-control" placeholder="分组名称">
				</div>
				<button type="button" class="btn btn-primary" style="margin-left: 5px; margin-right: 5px;" onclick="createGroup();">
					<span class="glyphicon glyphicon-plus"></span>
					新建
				</button>
				<button type="button" class="btn btn-primary" onclick="selectContacts();">
					<span class="glyphicon glyphicon-user"></span>
					联系人
				</button>
				<button style="float: right;" type="button" class="btn btn-danger" onclick="deleteGroup();">
					<span class="glyphicon glyphicon-remove"></span>
					删除
				</button>
			</div>
			<form id="groupForm">
				<input type="hidden" id="page" name="page">
				<input type="hidden" id="group_id" name="group_id">
				<input type="hidden" id="contactIds" name="contactIds">
			</form>
		</div>
		<table id="dataTable" class="table table-bordered">
			<tr class="info">
				<th width="10%">姓名</th>
				<th width="10%">机构</th>
				<th width="15%">岗位</th>
				<th width="10%">住宅电话</th>
				<th width="10%">办公电话</th>
				<th width="10%">手机号码</th>
				<th width="10%">传真号码</th>
				<th width="10%">电子邮箱</th>
				<th id='operation' width="15px"><button type="button" class="btn btn-xs btn-danger" onclick="deleteContacts();">
						<span class="glyphicon glyphicon-remove"></span>
						删除
					</button> <input type="checkbox" id="cb_checkall" style="float: right;" onclick="toggleCheckAll();"></th>
			</tr>
			<tbody id="contact_data">
			</tbody>
			<tr>
				<th id="contactDataNav" scope="col" colspan="9" align="right"></th>
			</tr>
		</table>
	</div>
</body>
</html>