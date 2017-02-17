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
    var layerIndex = -1;
    var opener = null;
    $selectedPersons = [];
    
    function setOpener(index, window) {
	    layerIndex = index;
	    opener = window;
    }

    function returnPerson(pe_id) {
	    $.post('work/person/select/' + pe_id, {}, function(result) {
		    opener.setSelectedPerson(result);
		    parent.layer.close(layerIndex);
	    });
    }

    function setSelectedPersons(selectedPersons) {
	    $selectedPersons = selectedPersons;
	    $.each($selectedPersons, function(i, pe) {
		    $('#tagsinput').tagsinput('add', {
		        pe_id : pe.pe_id,
		        pe_name : pe.pe_name
		    });
	    });
	    
	    updateCheckboxes();
    }

    function searchPerson(page) {
	    $('#userSearchPage').val(page);
	    $.post('work/person/search', $('#personSearchForm').serialize(), function(result) {
		    if(result.success) {
			    showResult(result.obj.records);
			    paginationNav('personDataNav', result.obj, 'searchPerson');
		    }
	    });
    }

    function showResult(persons) {
	    $("#person_data").empty();
	    var str = '';
	    for(var i = 0; i < persons.length && i < 8; i++) {
		    var p = persons[i];
		    if(i % 2 == 1) {
			    str += '<tr class="warning"'
		    } else {
			    str += '<tr'
		    }
		    if($operationType == 'singleSel') {
			    str += ' onclick="returnPerson(' + p.pe_id + ');"';
		    }
		    str += '><td>' + p.pe_name + '</td>';
		    str += '<td>' + p.pe_jobs + '</td>';
		    if(p.pe_mobilephone == undefined) {
			    str += '<td></td>';
		    } else {
			    str += '<td>' + p.pe_mobilephone + '</td>';
		    }
		    str += '<td>';
		    if($operationType == 'singleSel') {
			    str += '<a class="btn btn-xs btn-primary" onclick="returnPerson(' + p.pe_id
			           + ');"><i class="icon-ok"></i>&nbsp;选择</a>';
		    } else {
			    if($operationType == 'multiSel') {
				    str += '<input type="checkbox" class="cb_select" style="float:right;" name="' + p.pe_name
				           + '" id="' + p.pe_id
				           + '" value="" onclick="updateCheckAll(this);updateSelectedPersons(this);">';
			    } else {
				    str += '<a class="btn btn-xs btn-primary" onclick="parent.callOut(${userVo.voice},'
				           + p.pe_mobilephone + ');"><i class="icon-phone"></i>&nbsp;拨号</a>&nbsp;';
				    str += '<a class="btn btn-xs btn-success" onclick="promptSMSForm(' + p.pe_id
				           + ');"><i class="icon-comments"></i>&nbsp;短信</a>&nbsp;';
				    str += '<a class="btn btn-xs btn-info" onclick=";"><i class="icon-envelope"></i>&nbsp;传真</a>';
				    str += '<input type="checkbox" class="cb_select" style="float:right;" name="' + p.pe_name
				           + '" id="' + p.pe_id
				           + '" value="" onclick="updateCheckAll(this);updateSelectedPersons(this);">';
			    }
		    }
		    str += '</td>';
		    str += '</tr>';
	    }
	    $("#person_data").html(str);
	    if($operationType != 'singleSel') {
		    updateCheckboxes();
	    }
    }

    function checkAll() {
	    $.each($('.cb_select'), function(i, cb) {
		    var checkall = $('#cb_checkall').is(':checked');
		    $(cb).prop('checked', checkall);
		    updateSelectedPersons(cb);
	    });
    }

    function updateSelectedPersons(cb) {
	    var pe = {
	        pe_id : $(cb).attr('id'),
	        pe_name : $(cb).attr('name')
	    };
	    
	    var i = -1;
	    $.each($selectedPersons, function(index, pe_i) {
		    if(pe_i.pe_id == pe.pe_id) {
			    i = index;
			    return;
		    }
	    });
	    
	    if($(cb).is(':checked')) {
		    if(i == -1) {
			    $selectedPersons.push(pe);
		    }
		    $('#tagsinput').tagsinput('add', pe);
	    } else {
		    if(i != -1) {
			    $selectedPersons.splice(i, 1);
			    $('#tagsinput').tagsinput('remove', pe);
		    }
	    }
    }

    function clearSelected() {
	    $('#tagsinput').tagsinput('removeAll');
	    $selectedPersons = [];
	    updateCheckboxes();
    }

    function removeTag(tag) {
	    $.each($('.cb_select'), function(i, cb) {
		    if($(cb).attr('id') == tag.pe_id) {
			    $(cb).prop('checked', false);
			    $('#cb_checkall').prop('checked', false);
			    return;
		    }
	    });
	    
	    $.each($selectedPersons, function(i, pe_i) {
		    if(pe_i.pe_id == tag.pe_id) {
			    $selectedPersons.splice(i, 1);
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
		    if($selectedPersons == null || $selectedPersons.length == 0) {
			    $(cb).prop('checked', false);
		    } else {
			    $.each($selectedPersons, function(j, pe) {
				    if($(cb).attr('id') == pe.pe_id) {
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
	    $.post('work/organ/tree', {}, function(treeData) {
		    $('#person_treeview').treeview({
		        data : [{
			        text : '常用联系人'
		        }, treeData[0]],
		        multiSelect : $('#chk-select-multi').is(':checked'),
		        onNodeSelected : function(event, node) {
			        if(node.text == '常用联系人') {
				        getContactFavorites('1');
			        } else {
				        $('#personSearchForm')[0].reset();
				        $('#or_id').val(node.href);
				        searchPerson('1');
			        }
		        }
		    });
	    });
	    
	    searchPerson('1');
	    
	    if($operationType != 'singleSel') {
		    $('#tagsinput').tagsinput({
		        itemValue : function(pe) {
			        return pe.pe_id
		        },
		        itemText : function(pe) {
			        return pe.pe_name
		        }
		    });
		    
		    $('.bootstrap-tagsinput').css("width", "100%");
		    $('.bootstrap-tagsinput').children('input').last().attr("readonly", "readonly");
		    $('.bootstrap-tagsinput')
		        .append('<a class="btn icon-remove" style="float:right;margin-right:-5px;" onclick="clearSelected();"/>');
		    $('#tagsinput').on('itemRemoved', function(e) {
			    removeTag(e.item);
		    });
	    } else {
		    $('#th_tagsinput').hide();
	    }
    });
</script>
<div class="col-md-3">
	<div id="person_treeview"></div>
</div>
<div id="page-wrapper" class="col-md-9" style="padding-left: 0px;">
	<div style="margin-bottom: 15px;">
		<form id="personSearchForm" class="form-inline" action="work/person/search" method="post">
			<div class="form-group">
				<label for="pe_name">姓名</label>
				<input type="text" id="pe_name" name="pe_name" class="form-control" placeholder="机构人员名称">
			</div>
			<div class="form-group">
				<label for="pe_jobs">岗位</label>
				<input type="text" id="pe_jobs" name="pe_jobs" class="form-control" placeholder="岗位名称">
			</div>
			<div class="form-group">
				<label for="pe_mobilephone">电话号码</label>
				<input type="tel" id="pe_mobilephone" name="pe_mobilephone" class="form-control" placeholder="电话号码">
			</div>
			<input type="hidden" id="or_id" name="or_id">
			<input type="hidden" id="userSearchPage" name="page">
			<a class="btn btn-primary" onclick="$('#or_id').val(''); searchPerson('1');">
				<i class="icon-search"></i>&nbsp;搜索
			</a>
		</form>
	</div>
	<table id="dataTable" class="table table-bordered">
		<thead id="th_tagsinput">
			<tr>
				<th colspan="4" style="font-size: 1.2em;"><input type="text" id="tagsinput" /></th>
			</tr>
		</thead>
		<tr class="info">
			<th width="25%">姓名</th>
			<th width="25%">岗位</th>
			<th width="25%">电话</th>
			<th id='operation'><c:choose>
					<c:when test="${param.operationType eq 'singleSel'}">
						选择
					</c:when>
					<c:when test="${param.operationType eq 'multiSel'}">
						选择<input type="checkbox" id="cb_checkall" style="float: right;" onclick="checkAll();">
					</c:when>
					<c:otherwise>
						<a class="btn btn-xs btn-success" onclick="promptSMSForm();">
							<i class="icon-comments"></i>&nbsp;短信
						</a>
						<a class="btn btn-xs btn-info" onclick="promptSMSForm();">
							<i class="icon-comments"></i>&nbsp;传真
						</a>
						<span style="float: right;">
							选择&nbsp;
							<input type="checkbox" id="cb_checkall" onclick="checkAll();">
						</span>
					</c:otherwise>
				</c:choose></th>
		</tr>
		<tbody id="person_data">
		</tbody>
		<tr>
			<th id="personDataNav" scope="col" colspan="4" align="right"></th>
		</tr>
	</table>
</div>
