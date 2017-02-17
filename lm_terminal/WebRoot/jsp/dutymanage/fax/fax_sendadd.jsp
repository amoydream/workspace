<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>传真添加</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<script type="text/javascript" src="js/jquery.form.min.js"></script>
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
</head>
<body>
	<div class="modal-body">
		<form id="faxAddForm" class="form-horizontal" role="form">
			<fieldset>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="fs_Title">任务标题</label>
					<div class="col-sm-4">
						<input class="form-control" id="fs_Title" name="fs_Title"
							type="text" />
					</div>
					<label class="col-sm-2 control-label" for="fs_Faxnum"><span
						style="color:red">* </span>传真号码</label>
					<div class="col-sm-4">
						<input class="form-control" id="fs_Faxnum" name="fs_Faxnum"
							type="text" placeholder="必填项" data-bv-trigger="keyup"
							required="required" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="fs_Dealman">处理人</label>
					<div class="col-sm-4">
						<input class="form-control" id="fs_Dealman" name="fs_Dealman"
							type="text" />
					</div>
					<label class="col-sm-2 control-label" for="fs_Filename"><span
						style="color:red">* </span>传真文件</label>
					<div class="col-sm-4">
						<input type="hidden" id="filePath" name="fs_Path"> <input
							class="form-control" id="fileName" name="fs_Filename" type="text"
							onclick="fileSelect();" />
					</div>
				</div>
	</div>
	</fieldset>
	</form>
	</div>
	<script type="text/javascript" src="jsp/dutymanage/fax/js/fax_cu.js"></script>
	<script type="text/javascript">
		function sAddSubmitForm(index, p) {
			$('#faxAddForm').bootstrapValidator('validate');
			if ($('#faxAddForm').data('bootstrapValidator').isValid()) {
				$.post('dutymanage/fax/sendadd', $('#faxAddForm').serialize(),
						function(j) {
							if (j.success) {
								parent.layer.msg("新建传真成功");
								parent.refresh('tab_fax_iframe');
								//window.location.reload();
								parent.layer.close(index);
							} else {
								parent.layer.tips(j.msg, '.layui-layer-btn0', {
									tips : 1
								});
							}
						}, 'json');
			}
		}
		function fileSelect() {
			parent.layer.open({
				type : 2,
				title : '选择文件上传',
				area : [ '500px', '300px' ],
				scrollbar : false,
				content : 'jsp/dutymanage/fax/fax_fileupload.jsp',
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