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
<title>群发传真</title>
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
    $arrlength = 0;
    function send() {
	    var fax_number_arr = '';
	    $.each($selectedContacts, function(i, c) {
		    if($.trim(c.fax_number) != '') {
			    fax_number_arr += $.trim(c.fax_number) + ',';
			    return;
		    }
	    });
	    if(fax_number_arr != '') {
		    fax_number_arr = fax_number_arr.substr(0, fax_number_arr.length - 1);
	    }
	    $('#fax_number_arr').val(fax_number_arr);
	    if($('#fax_number_arr').val() == '') {
		    parent.parent.layer.msg("请选择收件人", {
		        offset : 300,
		        shift : 6
		    });
		    return;
	    }
	    if($('#filePath').val().trim() == '') {
		    parent.parent.layer.msg("请选择传真文件", {
		        offset : 300,
		        shift : 6
		    });
		    return;
	    }

	    arrlength = $selectedContacts.length;
	    var timer = null;

	    timer = window.setInterval('setStatus()', 1000);
    }

    var i = 0;
    function setStatus() {
	    if(arrlength > 0) {
		    if(parent.parent.$status = 0) {
			    parent.parent.$status = 1;
			    arrlength = arrlength - 1;
			    i++;
			    var faxNum = $selectedContacts[i].fax_number;
			    parent.parent.CtiCallSendFax("99" + faxNum, fileName);
		    }
	    } else {
		    window.clearInterval(timer);
	    }
    }

    function fileSelect() {
	    parent.layer.open({
	        type : 2,
	        title : '选择文件上传',
	        area : ['500px', '300px'],
	        scrollbar : false,
	        content : 'jsp/dutymanage/fax/fax_fileupload.jsp',
	        btn : ['确认', '取消'],
	        yes : function(index, layero) {
		        layero.find('iframe')[0].contentWindow.fileUpload(index, window);
	        }

	    });
    }

    function selectContacts() {
	    parent.parent.layer.open({
	        type : 2,
	        title : '选择机构人员',
	        area : ['1080px', '720px'],
	        scrollbar : false,
	        content : ['jsp/common/contact/contact_faxdisp.jsp', 'yes'],
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
		    $('.bootstrap-tagsinput')
		        .append(
		                '<a class="btn" style="float:right;margin-right:-5px;" onclick="clearSelected();"><i class="glyphicon glyphicon-remove"/></a>');
		    $('.bootstrap-tagsinput')
		        .append(
		                '<a class="btn" style="float:right;margin-right:-10px;" onclick="selectContacts();"><i class="glyphicon glyphicon-plus"/></a>');
	    }
	    setSelectedContacts();
    });
</script>
</head>
<body>
	<div style="margin-top: 10px; margin-left: 10px; margin-right: 10px;">
		<form id="smsForm" action="dutymanage/smsdisp/send" method="post">
			<div class="form-group">
				<input type="hidden" id="fax_number_arr" name="fax_number_arr">
				<label for="tagsinput">接收人：</label>
				<span style="font-size: 1.2em;">
					<input type="text" id="tagsinput" />
				</span>
			</div>
			<div class="form-group">
				</label>
				传真文件
				</label>
				<input type="hidden" id="filePath" name="fs_Path">
				<input class="form-control" id="fileName" name="fs_Filename" type="text" onclick="fileSelect();" />
				<a style="float: left margin-top: 2px;" class="btn btn-xs btn-primary" onclick="send();"> <i
					class="icon-share-alt"></i>&nbsp;发送
				</a>
			</div>
		</form>
	</div>
</body>
</html>
