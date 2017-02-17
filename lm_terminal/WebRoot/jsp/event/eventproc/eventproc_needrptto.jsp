<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script type="text/javascript">
	$(function() {
	    $('#person_treeview').treeview({
	        data : [{
	            text : "机构领导通讯录",
	            nodes : [{
		            text : "应急办领导",
		            href: '0'
	            }, {
		            text : "政府办领导",
		            href: '2'
	            }, {
		            text : "党委办领导",
		            href: '4'
	            }]
	        }],
	        multiSelect : false,
	        onNodeSelected : function(event, node) {
		        search();
	        }
	    });
    });
    
    function search() {
	    $.post('work/person/search', $('#searchForm').serialize(), function(result) {
		    show(result);
	    });
    }

    function show(persons) {
	    $("#person_data").empty();
	    $('#cb_checkall').prop('checked', false);
	    var str = '';
	    for(var i = 0; i < 3; i++) {
		    str += "<tr name='tr_peinfo'>";
		    str += "<td name='pe_name'>" + persons[i].pe_name + "</td>";
		    str += "<td name='or_name'>" + persons[i].or_name + "</td>";
		    str += "<td name='pe_jobs'>" + persons[i].pe_jobs + "</td>";
		    if(persons[i].pe_mobilephone == undefined) {
			    str += "<td name='pe_mobilephone'></td>";
		    } else {
			    str += "<td name='pe_mobilephone'>" + persons[i].pe_mobilephone + "</td>";
		    }
		    str += "<td name='select'>";
		    str += "<input type='button' class='btn btn-success' value='拨号' onclick=''>&nbsp;";
		    str += "<input type='button' class='btn btn-success' value='短信' onclick='promptSMSForm(" + persons[i].pe_id
		           + ");'>&nbsp;";
		    str += "<input type='button' class='btn btn-success' value='传真' onclick=''>";
		    str += "<input type='checkbox' style='float:right;' name='pe_id_arr' id='" + persons[i].pe_id
		           + "' value='' onclick='check(this);'>";
		    str += "</td></tr>";
	    }
	    $("#person_data").append(str);
    }

    function checkAll() {
	    $.each($("[name='pe_id_arr']"), function(i, elem) {
		    var checkall = $('#cb_checkall').is(':checked');
		    $(elem).prop('checked', checkall);
		    $(elem).val(checkall ? $(elem).attr('id') : "");
	    });
    }

    function check(elem) {
	    $(elem).val($(elem).is(':checked') ? $(elem).attr('id') : "");
    }
</script>
<div class="col-md-3">
	<div id="person_treeview"></div>
</div>
<div id="page-wrapper" class="col-md-9" style="padding-left: 0px;">
	<div style="margin-bottom: 15px;">
		<form id="searchForm" class="form-inline" action="work/person/search" method="post">
			<div class="form-group">
				<label for="pe_name">姓名</label>
				<input type="text" id="pe_name" name="pe_name" class="form-control" placeholder="机构人员名称"
					value="${organPersonVo.pe_name}">
			</div>
			<div class="form-group">
				<label for="pe_mobilephone">电话号码</label>
				<input type="tel" id="pe_mobilephone" name="pe_mobilephone" class="form-control"
					placeholder="电话号码" value="${organPersonVo.pe_mobilephone}">
			</div>
			<input type="button" class="btn btn-success" value="搜索" onclick="search();">
		</form>
	</div>
	<form id="organPersonForm" method="post">
		<input type="hidden" id="pe_id" name="pe_id">
		<table class="table table-bordered">
			<tr>
				<th>姓名</th>
				<th>部门</th>
				<th>岗位</th>
				<th>电话</th>
				<th width="30%">操作<input type="checkbox" id="cb_checkall" style="float: right;'"
						onclick="checkAll();"></th>
			</tr>
			<tbody id="person_data">
			</tbody>
		</table>
	</form>
	<form id="eventProcessForm" action="event/eventproc/save" method="post">
		<input type="hidden" name="ev_id" value="${eventInfoVo.ev_id}">
		<input type="hidden" name="us_Id" value="${sessionScope.userVo.us_Id}">
		<label for="rp_content">汇报内容</label>
		<p>
			<textarea rows="6" id="rp_content" name="rp_content" class="form-control" placeholder="汇报内容">
事件名称：${eventInfoVo.ev_name}
事发时间：${eventInfoVo.ev_date}
事发地点：${eventInfoVo.ev_address}
事件类型：${eventInfoVo.et_name}
事件内容：${eventInfoVo.ev_name}
		</textarea>
		</p>
		<label for="pr_content">处置反馈</label>
		<p>
			<textarea rows="6" id="pr_content" name="pr_content" class="form-control" placeholder="处置反馈"></textarea>
		</p>
	</form>
</div>