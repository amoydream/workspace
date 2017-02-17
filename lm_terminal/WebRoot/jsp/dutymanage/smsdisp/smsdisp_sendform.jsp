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
<title>发送短信</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp" />
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<link rel="stylesheet" href="lauvanUI/bootstrap-tagsinput/bootstrap-tagsinput.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap-tagsinput/angular.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-tagsinput/bootstrap-tagsinput.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-tagsinput/bootstrap-tagsinput-angular.min.js"></script>
<link rel="stylesheet" href="lauvanUI/layer/skin/layer.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
<style type="text/css">
.bootstrap-tagsinput span {
	padding-top: 2px;
}
</style>
<script type="text/javascript">
	$selectedContacts = [];

    $selectedSmsTmpl = "";

    $selectEnabled = true;

    function send() {
	    var tel_mobile_arr = '';
	    $.each($selectedContacts, function(i, c) {
		    if($.trim(c.tel_mobile) != '') {
			    tel_mobile_arr += $.trim(c.tel_mobile) + ',';
			    return;
		    }
	    });
	    if(tel_mobile_arr != '') {
		    tel_mobile_arr = tel_mobile_arr.substr(0, tel_mobile_arr.length - 1);
	    }
	    $('#tel_mobile_arr').val(tel_mobile_arr);
	    if($('#tel_mobile_arr').val() == '') {
		    parent.parent.layer.msg("请选择收件人", {
		        offset : 300,
		        shift : 6
		    });
		    return;
	    }
	    if($('#content').val().trim() == '') {
		    parent.parent.layer.msg("请输入短信内容", {
		        offset : 300,
		        shift : 6
		    });
		    return;
	    }

	    parent.parent.layer.confirm('按【确定】发送', function() {
		    $.post('dutymanage/smsdisp/send', $('#smsForm').serialize(), function(result) {
			    parent.parent.layer.msg(result.msg, {
			        offset : 300,
			        shift : 6
			    });
		    });
	    });
    }

    function selectContacts() {
	    parent.parent.layer.open({
	        type : 2,
	        title : '选择联系人',
	        area : ['1080px', '720px'],
	        scrollbar : false,
	        content : ['jsp/common/contact/contact_smsdisp.jsp', 'yes'],
	        btn : ['确定', '取消'],
	        yes : function(index, layero) {
		        $selectedContacts = layero.find('iframe')[0].contentWindow.$selectedContacts;
		        setSelectedContacts();
		        parent.parent.layer.close(index);
	        },
	        success : function(layero, index) {
		        var popup = layero.find('iframe')[0].contentWindow;
		        popup.$(function() {
			        popup.setSelectedContacts($selectedContacts);
		        });
	        }
	    });

    }

    function clearSelected() {
	    $('#tagsinput').tagsinput('removeAll');
	    $selectedContacts = [];
    }

    function setSelectedContacts() {
	    if($('.bootstrap-tagsinput') == null || $('.bootstrap-tagsinput').length == 0) {

	    }

	    $('#tagsinput').tagsinput('removeAll');

	    $.each($selectedContacts, function(i, c) {
		    $('#tagsinput').tagsinput('add', {
		        contact_id : c.contact_id,
		        pe_name : c.pe_name
		    });
	    });
    }

    function removeTag(tag) {
	    $.each($selectedContacts, function(i, c) {
		    if(c.contact_id == tag.contact_id) {
			    $selectedContacts.splice(i, 1);
			    return;
		    }
	    });
    }

    function selectTemplate() {
	    parent.parent.layer.open({
	        type : 2,
	        title : '选择短信模板',
	        area : ['1024px', '768px'],
	        scrollbar : false,
	        content : ['jsp/dutymanage/smsdisp/smsdisp_selecttmpl.jsp', 'yes'],
	        btn : ['取消'],
	        yes : function(index, layero) {
		        parent.parent.layer.close(index);
	        },
	        success : function(layero, index) {
		        layero.find('iframe')[0].contentWindow.setOpener(index, window);
	        }
	    });
    }

    $(function() {
	    $('#smsForm').bootstrapValidator();
	    if($selectEnabled) {
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
		    $('#tagsinput').on('itemRemoved', function(e) {
			    try {
				    removeTag(e.item);
			    } catch(e) {
				    console.log(e);
			    }
		    });
		    $('.bootstrap-tagsinput').append('<a class="btn" style="float:right;margin-right:-5px;" onclick="clearSelected();"><i class="glyphicon glyphicon-remove"/></a>');
		    $('.bootstrap-tagsinput').append('<a class="btn" style="float:right;margin-right:-10px;" onclick="selectContacts();"><i class="glyphicon glyphicon-plus"/></a>');
	    }
	    setSelectedContacts();
    });
</script>
</head>
<body>
	<div style="margin-top: 10px; margin-left: 10px; margin-right: 10px;">
		<form id="smsForm" action="dutymanage/smsdisp/send" method="post">
			<input type="hidden" name="us_Id" value="${userVo.us_Id}" />
			<input type="hidden" name="ev_id" value="${smsVo.ev_id}" />
			<div class="form-group">
				<input type="hidden" id="tel_mobile_arr" name="tel_mobile_arr">
				<label for="tagsinput">接收人</label>
				<span style="font-size: 1.2em;"> <input type="text" id="tagsinput" />
				</span>
			</div>
			<div class="form-group">
				<label for="msg">短信内容</label>
				<a style="float: right; margin-bottom: 3px;" class="btn btn-primary" onclick="selectTemplate();"><span
					class="glyphicon glyphicon-envelope"></span> 选择模板 </a>
				<textarea rows="10" id="content" name="content" class="form-control" placeholder="短信内容">${smsVo.content}</textarea>
				<a style="float: right; margin-top: 5px;" class="btn btn-primary" onclick="send();"> <span
					class="glyphicon glyphicon-send"></span> 发送
				</a>
			</div>
		</form>
	</div>
</body>
</html>
