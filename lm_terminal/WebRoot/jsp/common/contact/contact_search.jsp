<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<link rel="stylesheet" href="lauvanUI/layer/skin/layer.css" type="text/css"></link>
<link rel="stylesheet" href="lauvanUI/bootstrap-tagsinput/bootstrap-tagsinput.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script src="lauvanUI/layer/layer.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-tagsinput/angular.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-tagsinput/bootstrap-tagsinput.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-tagsinput/bootstrap-tagsinput-angular.js"></script>
<style type="text/css">
.bootstrap-tagsinput span {
	padding-top: 2px;
}
</style>
<script type="text/javascript">
	$operationType = '${param.operationType}';
    $numberType = '${param.numberType}';
    var layerIndex = -1;
    var opener = null;
    $selectedContacts = [];
    $contactRecords = null;

    function setOpener(index, window) {
	    layerIndex = index;
	    opener = window;
    }

    function returnContact(i) {
	    $.post('contact/select/' + $contactRecords[i].contact_id, {}, function(result) {
		    opener.setSelectedContacts(result);
		    parent.layer.close(layerIndex);
	    });
    }

    function setSelectedContacts(selectedContacts) {
	    $selectedContacts = selectedContacts;
	    $.each($selectedContacts, function(i, c) {
		    $('#tagsinput').tagsinput('add', {
		        contact_id : c.contact_id,
		        pe_name : c.pe_name
		    });
	    });

	    updateCheckboxes();
    }

    function searchContacts(page) {
	    $('#contactPage').val(page);
	    $.post('contact/search', $('#contactSearchForm').serialize(), function(result) {
		    if(result.success) {
			    $contactRecords = result.obj.records;
			    showResult();
			    paginationNav('contactDataNav', result.obj, 'searchContacts');
		    }
	    });
    }

    function showResult() {
	    $("#contact_data").empty();
	    var str = '';
	    for(var i = 0; i < $contactRecords.length && i < 8; i++) {
		    var c = $contactRecords[i];
		    if(i % 2 == 1) {
			    str += '<tr class="warning"'
		    } else {
			    str += '<tr'
		    }
		    if($operationType == 'singlesel') {
			    str += ' onclick="returnContact(' + i + ');"';
		    }
		    str += '>';
		    str += '<td>' + $.trim(c.pe_name) + '</td>';
		    str += '<td>' + $.trim(c.or_name) + '</td>';
		    str += '<td>' + $.trim(c.p_names) + '</td>';
		    str += '<td>';
		    if($operationType == 'callout') {
			    str += telNoBtn($.trim(c.tel_home));
		    } else {
			    str += $.trim(c.tel_home);
		    }
		    str += '</td>';
		    str += '<td>';
		    if($operationType == 'callout') {
			    str += telNoBtn($.trim(c.tel_office));
		    } else {
			    str += $.trim(c.tel_office);
		    }
		    str += '</td>';
		    str += '<td>';
		    if($operationType == 'callout') {
			    str += telNoBtn($.trim(c.tel_mobile));
		    } else {
			    str += $.trim(c.tel_mobile);
		    }
		    str += '</td>';
		    str += '<td>' + $.trim(c.fax_number) + '</td>';
		    str += '<td>' + $.trim(c.fax_number) + '</td>';
		    if($operationType != 'callout') {
			    str += '<td>';
			    if($operationType == 'singlesel') {
				    str += '<a class="btn btn-xs btn-primary" onclick="returnContact(' + i + ');"><i class="icon-ok"></i>&nbsp;选择</a>';
			    } else {
				    str += '<input type="checkbox" class="cb_select" style="float: right;" id="' + i + '" value="" onclick="updateCheckAll(this);updateSelectedContacts(this);">';
			    }
			    str += '</td>';
		    }
		    str += '</tr>';
	    }
	    $("#contact_data").html(str);
	    if($operationType != 'singlesel') {
		    updateCheckboxes();
	    }
    }

    function checkAll() {
	    $.each($('.cb_select'), function(i, cb) {
		    var checkall = $('#cb_checkall').is(':checked');
		    $(cb).prop('checked', checkall);
		    updateSelectedContacts(cb);
	    });
    }

    function updateSelectedContacts(cb) {
	    var c = $contactRecords[$(cb).attr('id')];

	    var i = -1;
	    $.each($selectedContacts, function(index, c_i) {
		    if(c_i.contact_id == c.contact_id) {
			    i = index;
			    return;
		    }
	    });

	    if($(cb).is(':checked')) {
		    if(i == -1) {
			    $selectedContacts.push(c);
		    }
		    $('#tagsinput').tagsinput('add', c);
	    } else {
		    if(i != -1) {
			    $selectedContacts.splice(i, 1);
			    $('#tagsinput').tagsinput('remove', c);
		    }
	    }
    }

    function clearSelected() {
	    $('#tagsinput').tagsinput('removeAll');
	    $selectedContacts = [];
	    updateCheckboxes();
    }

    function removeTag(tag) {
	    $.each($('.cb_select'), function(i, cb) {
		    if($contactRecords[$(cb).attr('id')].contact_id == tag.contact_id) {
			    $(cb).prop('checked', false);
			    $('#cb_checkall').prop('checked', false);
			    return;
		    }
	    });

	    $.each($selectedContacts, function(i, c_i) {
		    if(c_i.contact_id == tag.contact_id) {
			    $selectedContacts.splice(i, 1);
			    return;
		    }
	    });
    }

    function updateCheckAll(cb) {
	    var checkAll = $(cb).is(':checked');
	    if($(cb).is(':checked')) {
		    $.each($('.cb_select'), function(i, cb) {
			    if(!$(cb).is(':checked')) {
				    checkAll = false;
			    }
		    });
	    }
	    $('#cb_checkall').prop('checked', checkAll);
    }

    function updateCheckboxes() {
	    var checkAll = $('.cb_select') && $('.cb_select').length > 0;
	    $.each($('.cb_select'), function(i, cb) {
		    if($selectedContacts == null || $selectedContacts.length == 0) {
			    $(cb).prop('checked', false);
		    } else {
			    $.each($selectedContacts, function(j, c) {
				    if($contactRecords[$(cb).attr('id')].contact_id == c.contact_id) {
					    $(cb).prop('checked', true);
					    return;
				    }
			    });
		    }
		    if(!$(cb).is(':checked')) {
			    checkAll = false;
		    }
	    });

	    $('#cb_checkall').prop('checked', checkAll);
    }

    $(function() {
	    $.post('contact/contactree', {}, function(organTree) {
		    $('#contact_treeview').treeview({
		        data : [organTree[0], organTree[1][0]],
		        multiSelect : false,
		        onNodeSelected : function(event, node) {
			        $('#contactSearchForm')[0].reset();
			        if(node.name == 'group') {
				        $('#or_id').val('');
				        $('#group_id').val(node.href);
			        } else if(node.name == 'organ') {
				        $('#or_id').val(node.href);
				        $('#group_id').val('');
			        }

			        searchContacts('1');
		        }
		    });
	    });

	    searchContacts('1');

	    if($operationType != 'singlesel') {
		    $('#tagsinput').tagsinput({
		        itemValue : function(c) {
			        return c.contact_id
		        },
		        itemText : function(c) {
			        return c.pe_name
		        }
		    });

		    $('.bootstrap-tagsinput').css("width", "100%");
		    $('.bootstrap-tagsinput').children('input').last().attr("readonly", "readonly");
		    $('.bootstrap-tagsinput').append('<a class="btn" style="float:right;margin-right:-5px;" onclick="clearSelected();"><i class="glyphicon glyphicon-remove"/></a>');
		    $('#tagsinput').on('itemRemoved', function(e) {
			    removeTag(e.item);
		    });
	    } else {
		    $('#th_tagsinput').hide();
	    }
    });
</script>
<div class="col-md-3">
	<div style="width: 100%; height: 800px; overflow: scroll;">
		<div id="contact_treeview"></div>
	</div>
</div>
<div id="page-wrapper" class="col-md-9" style="padding-left: 0px;">
	<div style="margin-bottom: 10px;">
		<form id="contactSearchForm" class="form-inline">
			<input type="hidden" id="numberType" name="numberType" value="${param.numberType}">
			<input type="hidden" id="group_id" name="group_id">
			<input type="hidden" id="or_id" name="or_id">
			<input type="hidden" id="contactPage" name="page">
			<div class="form-group">
				<label for="or_name">部门</label>
				<input type="text" id="or_name" name="or_name" class="form-control" placeholder="部门名称">
			</div>
			<div class="form-group">
				<label for="pe_name">姓名</label>
				<input type="text" id="pe_name" name="pe_name" class="form-control" placeholder="联系人名称">
			</div>
			<div class="form-group">
				<c:choose>
					<c:when test="${param.numberType eq 'SMS'}">
						<label for="tel_number">手机号码</label>
						<input type="tel" id="tel_number" name="tel_number" class="form-control" placeholder="通讯号码">
					</c:when>
					<c:when test="${param.numberType eq 'FAX'}">
						<label for="tel_number">传真号码</label>
						<input type="tel" id="tel_number" name="tel_number" class="form-control" placeholder="传真号码">
					</c:when>
					<c:otherwise>
						<label for="tel_number">电话号码</label>
						<input type="tel" id="tel_number" name="tel_number" class="form-control" placeholder="电话号码">
					</c:otherwise>
				</c:choose>
			</div>
			<a class="btn btn-primary" style="margin-left: 5px;" onclick="$('#or_id').val(''); searchContacts('1');"> <span
				class="glyphicon glyphicon-search"></span> 搜索
			</a>
		</form>
	</div>
	<table id="dataTable" class="table table-bordered">
		<c:if test="${param.operationType eq 'multisel'}">
			<thead id="th_tagsinput">
				<tr>
					<th colspan="9" style="font-size: 1.2em;"><input type="text" id="tagsinput" /></th>
				</tr>
			</thead>
		</c:if>
		<tr class="info">
			<th width="10%">姓名</th>
			<th width="10%">部门</th>
			<th width="15%">岗位</th>
			<th width="10%">住宅电话</th>
			<th width="10%">办公电话</th>
			<th width="10%">手机号码</th>
			<th width="10%">传真</th>
			<c:choose>
				<c:when test="${param.operationType eq 'callout'}">
					<th width="25%">电子邮箱</th>
				</c:when>
				<c:otherwise>
					<th width="10%">电子邮箱</th>
					<th id='operation' width="15px">选择 <c:choose>
							<c:when test="${param.operationType eq 'singlesel'}"></c:when>
							<c:otherwise>
								<input type="checkbox" id="cb_checkall" style="float: right;" onclick="checkAll();">
							</c:otherwise>
						</c:choose>
					</th>
				</c:otherwise>
			</c:choose>
		</tr>
		<tbody id="contact_data">
		</tbody>
		<tr>
			<c:choose>
				<c:when test="${param.operationType eq 'callout'}">
					<th id="contactDataNav" scope="col" colspan="8" align="right"></th>
				</c:when>
				<c:otherwise>
					<th id="contactDataNav" scope="col" colspan="9" align="right"></th>
				</c:otherwise>
			</c:choose>
		</tr>
	</table>
</div>
