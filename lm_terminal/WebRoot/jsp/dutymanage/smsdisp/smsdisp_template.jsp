<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>已发送短信</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/layer/skin/layer.css" type="text/css"></link>
<script src="lauvanUI/layer/layer.js"></script>
<div style="margin-top: 10px; margin-left: 10px; margin-right: 10px;">
	<input type="hidden" id="page" name="page">
	<table class="table table-bordered">
		<tr class="info">
			<th>短信模板</th>
			<th>操作<a class="btn btn-xs btn-primary" style="float: right;" data-toggle="modal"
				data-target="#addTmplModal"> <span class="glyphicon glyphicon-plus"></span> 新建
			</a></th>
		</tr>
		<tbody id="result">
		</tbody>
		<tr>
			<th id="navbar" scope="col" colspan="2"></th>
		</tr>
		<div class="modal fade" id="addTmplModal" tabindex="-1" role="dialog"
			aria-labelledby="addTmplModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="addTmplModalLabel">新建短信模板</h4>
					</div>
					<div class="modal-body">
						<textarea id="ta_add_tmpl" rows="5" style="width: 100%"></textarea>
					</div>
					<div class="modal-footer">
						<a id="saveBtn" class="btn btn-primary" onclick="addTmpl();"> <span
								class="glyphicon glyphicon-ok"></span> 保存
						</a> <a class="btn btn-danger" data-dismiss="modal"> <span class="glyphicon glyphicon-remove"></span>
							取消
						</a>
					</div>
				</div>
			</div>
		</div>
	</table>
</div>
<script type="text/javascript">
	$smsTmpls = [];
    function searchTemplate(page) {
	    $('#page').val(page);
	    $.post('dutymanage/smsdisp/template/' + page, {}, function(result) {
		    if(result.success) {
			    var str = '';
			    if(result.obj && result.obj.records) {
				    $smsTmpls = result.obj.records;
				    for(var i = 0; i < $smsTmpls.length; i++) {
					    var r = $smsTmpls[i];
					    if(i % 2 == 1) {
						    str += '<tr class="warning" id="tr_' + r.tmpl_id + '">';
					    } else {
						    str += '<tr>';
					    }
					    str += '<td><span id="sp_edit_' + i + '"></span><span id="sp_tmpl_' + i + '">' + r.content
					           + '</span></td>';
					    str += '<td width="20%">';
					    str += '<a class="btn btn-xs btn-primary" onclick="editTemplate(' + i
					           + ');"><span class="glyphicon glyphicon-pencil"></span> 编辑</a>&nbsp;';
					    str += '<a class="btn btn-xs btn-danger" onclick="deleteTemplate($(this).parent().parent(), '
					           + r.tmpl_id + ');"><span class="glyphicon glyphicon-remove"></span> 删除</a>';
					    str += '</td>';
					    str += '</tr>';
				    }
				    paginationNav('navbar', result.obj, 'searchTemplate');
			    }
			    $('#result').html(str);
		    }
	    });
    }

    function addTmpl() {
	    $.post('dutymanage/smsdisp/template/save', {
		    content : $('#ta_add_tmpl').val()
	    }, function(result) {
		    if(result.success) {
			    searchTemplate('1');
			    $('#addTmplModal').modal('toggle');
			    $('#ta_add_tmpl').val('');
		    } else {
			    layer.tips(result.msg, '#saveBtn', {
			        tips : 1,
			        time : 1000
			    });
		    }
	    });
    }

    function editTemplate(i) {
	    var tmpl = $smsTmpls[i];
	    $('#sp_edit_' + i).popover({
	        html : true,
	        trigger : 'focus',
	        content : '<textarea rows="4" cols="30" id="ta_tmpl_' + i + '">' + $('#sp_tmpl_' + i).html()
	                  + '</textarea><br><a class="btn btn-xs btn-primary" onclick="updateTemplate(' + i
	                  + ');"><span class="glyphicon glyphicon-ok"></span> 保存</i></a>&nbsp;'
	                  + '<a class="btn btn-xs btn-danger" onclick="cancelEdit(' + i
	                  + ');"><span class="glyphicon glyphicon-remove"></span> 取消</i></a>',
	        placement : 'right'
	    });
	    $('#sp_edit_' + i).popover('toggle');
    }

    function updateTemplate(i) {
	    $.post('dutymanage/smsdisp/template/save', {
	        tmpl_id : $smsTmpls[i].tmpl_id,
	        content : $('#ta_tmpl_' + i).val()
	    }, function(result) {
		    if(result.success) {
			    $('#sp_tmpl_' + i).html($('#ta_tmpl_' + i).val());
			    $('#sp_edit_' + i).popover('destroy');
		    } else {
			    layer.tips(result.msg, '#ta_tmpl_' + i, {
			        tips : 1,
			        time : 500
			    });
		    }
	    });
    }

    function deleteTemplate(tr, tmpl_id) {
	    parent.parent.layer.confirm('按【确定】删除', function() {
		    $.post('dutymanage/smsdisp/template/delete/' + tmpl_id, {}, function(result) {
			    if(result.success) {
				    $(tr).remove();
				    if($('#result') != null && $('#result').find('tr') != null && $('#result').find('td').length > 0) {
					    searchTemplate($('#page').val());
				    } else {
					    if($('#page').val() > 1) {
						    searchTemplate($('#page').val() - 1);
					    } else {
						    searchTemplate('1');
					    }
				    }
			    }
			    parent.parent.layer.msg(result.msg, {
			        offset : 300,
			        shift : 6
			    });
		    });
	    });
    }

    function cancelEdit(i) {
	    $('#sp_edit_' + i).popover('destroy');
    }

    $(function() {
	    searchTemplate('1');
    });
</script>
</head>
</html>