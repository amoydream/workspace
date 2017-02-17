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
		<form id="faxEditForm" class="form-horizontal" role="form">
			<input type="hidden" name="fr_Id" value="${fax.fr_Id}" /> 
			<input type="hidden" name="fr_Filename" value="${fax.fr_Filename}">
			<input type="hidden" name="fr_Status" value="${fax.fr_Status}">
			<fieldset>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="fr_Title">任务标题</label>
					<div class="col-sm-4">
						<input class="form-control" id="fr_Title" name="fr_Title"
							type="text" value="${fax.fr_Title}" />
					</div>
					<label class="col-sm-2 control-label" for="fr_Dealman">处理人</label>
					<div class="col-sm-4">
						<input class="form-control" id="fr_Dealman" name="fr_Dealman"
							type="text" placeholder="必填项" value="${fax.fr_Dealman}" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="fr_Faxnum"><span
						style="color:red">* </span>传真号码</label>
					<div class="col-sm-4">
						<input class="form-control" id="fr_Faxnum" name="fr_Faxnum"
							type="text" placeholder="必填项" value="${fax.fr_Faxnum}"
							readonly="true" />

					</div>
					<label class="col-sm-2 control-label" for="fr_Filename"><span
						style="color:red">* </span>传真文件：</label>
					<div class="col-sm-4">
						<input class="form-control" id="fr_Path" name="fr_Path"
							type="text" placeholder="必填项" value="${fax.fr_Path}"
							readonly="true" />
					</div>
				</div>
	</div>
	</fieldset>
	</form>
	</div>
	<script type="text/javascript">
	function rEditSubmitForm(index,p) {
		$('#faxEditForm').bootstrapValidator('validate');
		if($('#faxEditForm').data('bootstrapValidator').isValid()){
			$.post('dutymanage/fax/redit',$('#faxEditForm').serialize(), function(j) {
				if(j.success){
					parent.layer.msg("编辑传真成功");
					parent.layer.close(index);
				}else{
					parent.layer.tips(j.msg, '.layui-layer-btn0',{
					    tips: 1
					});
				}
			}, 'json');
		}
	}
	function fileSelect(){
		parent.layer.open({
		    type: 2,
		    title:'选择文件上传',
		    area:['500px','300px'],
		    scrollbar: false,
		    content: 'jsp/dutymanage/fax/fax_fileupload.jsp',
		    btn:['确认','取消'],
		    yes:function(index,layero){
		    	 layero.find('iframe')[0].contentWindow.fileUpload(index,window);
		    }
		    
		});
	}
	function fileUpload() {
		$('#fileUpload').ajaxSubmit({
			type : "POST",
			url : "dutymanage/fax/fileUpload",
			dataType : "json",
			success : function(data) {
				if (data.success) {
					parent.layer.msg("上传成功，可以发送");
					$('#FileName').val(data.obj.fr_Filename);
				} else {
					parent.layer.tips(j.msg, '.layui-layer-btn0', {
						tips : 1
					});
				}
			}
		})
	}
	</script>

</body>
</html>