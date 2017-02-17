<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String includePage = request.getParameter("includePage");
%>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script type="text/javascript">
	var pageForm = null;
    
    $(function() {
	    $.post('work/organ/tree', {}, function(treeData) {
		    var initSelectableTree = function() {
			    return $('#person_treeview').treeview({
			        data : treeData,
			        multiSelect : $('#chk-select-multi').is(':checked'),
			        onNodeSelected : function(event, node) {
				        toggleDiv(true);
				        $("#or_id").val(node.href);
				        $("#page").val('1');
				        searchPerson();
			        }
			    });
		    };
		    var $selectableTree = initSelectableTree();
	    });
    });
    
    function toggleDiv(flag) {
    }

    function searchPerson() {
	    $.post('work/person/search', $('#personSearchForm').serialize(), function(data) {
		    show(data.obj.records);
		    nav(data.obj);
	    });
    }

    function nav(pageView) {
	    var currentpage = pageView.currentpage;
	    var startindex = pageView.pageindex.startindex;
	    var endindex = pageView.pageindex.endindex;
	    var totalpage = pageView.totalpage;
	    var pageHtml = "";
	    $("#pagination").empty();
	    $("#page").val(currentpage);
	    pageHtml += "<li><a href=\"javascript:topage(1)\">首页</a></li>";
	    if(currentpage > 1) {
		    pageHtml += "<li><a href=\"javascript:topage('" + (currentpage - 1) + "')\">上一页</a></li>";
	    }
	    
	    for(var i = startindex; i <= endindex; i++) {
		    if(i == currentpage) {
			    pageHtml += "<li class=\"active\"><a href=\"javascript:topage('" + i + "')\">" + i + "</a></li>";
		    } else {
			    pageHtml += "<li><a href=\"javascript:topage('" + i + "')\">" + i + "</a></li>";
		    }
	    }
	    if(currentpage < totalpage) {
		    pageHtml += "<li><a href=\"javascript:topage('" + (currentpage + 1) + "')\">下一页</a></li>";
		    +"<li><a href=\"javascript:topage('" + totalpage + "')\">末页</a></li>";
	    }
	    
	    $("#pagination").append(pageHtml);
    }

    function show(persons) {
	    $("#person_data").empty();
	    $('#cb_checkall').prop('checked', false);
	    var str = '';
	    for(var i = 0; i < persons.length; i++) {
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
		    str += "<input type='button' class='btn btn-success' value='拨号' onclick='parent.callOut(${userVo.voice },"
		           + persons[i].pe_mobilephone + ")'>&nbsp;";
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
	<div id="contactsDiv">
		<div style="margin-bottom: 15px;">
			<form id="personSearchForm" class="form-inline" action="work/person/search" method="post">
				<div class="form-group">
					<label for="pe_name">姓名</label>
					<input type="text" id="pe_name" name="pe_name" class="form-control" placeholder="机构人员名称">
				</div>
				<div class="form-group">
					<label for="pe_mobilephone">电话号码</label>
					<input type="tel" id="pe_mobilephone" name="pe_mobilephone" class="form-control" placeholder="电话号码">
				</div>
				<input type="hidden" id="page" name="page" value="1" />
				<input type="hidden" id="or_id" name="or_id" />
				<input type="button" class="btn btn-success" value="搜索"
					onclick="$('#page').val('1'); $('#or_id').val(''); searchPerson();">
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
					<th width="30%">操作<input type="checkbox" id="cb_checkall" style="float: right;" onclick="checkAll();"></th>
				</tr>
				<tbody id="person_data">
				</tbody>
				<tr>
					<th scope="col" colspan="5">
						<nav>
							<ul id="pagination" class="pagination">
							</ul>
						</nav>
					</th>
				</tr>
			</table>
		</form>
	</div>
	<div id="includePageDiv">
		<%
			if(includePage != null) {
		%>
		<jsp:include page="<%=includePage%>" />
		<%
			}
		%>
	</div>
</div>
