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
<title>导入excel</title>
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
			<input type="file" name="file" id="file" accept="*"/>
		</form>
		<br>
		<br>
		<p>excel表头顺序：
        <br>机构名称|上级机构名称|办公电话|传真
        <br>注意：excel表中上级机构的记录顺序必须在子机构之上</br></p>
	</div>
<script type="text/javascript">
function fileUpload(index,window) {
    $('#file').upload({
      url: 'work/organ/excelin',
      dataType:'text',
      onComplate: function (result) {
    	    parent.layer.msg(result, {
	            offset : 300,
	            shift : 6
	        });
			parent.layer.close(index);
			
      }
    });
    $('#file').upload("ajaxSubmit")
  }

</script>
	
</body>
</html>