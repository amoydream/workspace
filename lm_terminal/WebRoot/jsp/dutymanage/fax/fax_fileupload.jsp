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
<script type="text/javascript" src="js/upload2.js"></script>
</head>
<body>
    <div class="modal-body">
	<input type="hidden" id="FileName">
	<input type="hidden" id="FileNamePath">
		<form id="fileUploadForm" enctype="multipart/form-data">
			<input type="file" name="file" id="file" accept=".docx,.doc,.txt,.pdf,.jpg,.bmp"/>
		</form>
	</div>
<script type="text/javascript">
function fileUpload(index,window) {
    $('#file').upload({
      url: 'dutymanage/fax/fileUpload',
      dataType:'text',
      onComplate: function (data) {
        if(data=="1"){
        	alert(上传文件失败);
        }
        if(data=="3"){
        	alert(转换文件失败);
        }
        if(data.length> 3){
        	var fileArr=data.split(",");
        	parent.layer.msg("上传转换成功");
			parent.layer.close(index);
			window.$("#fileName").val(fileArr[0]+".tif");
			window.$("#filePath").val(fileArr[1]+"\\"+fileArr[0]+".tif");
        }
      }
    });
    $('#file').upload("ajaxSubmit")
  }


</script>
	
</body>
</html>