<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>应急组织机构管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
	<form id="emeOrgan_editform" class="form-horizontal" role="form">
	<input type="hidden" name="eo_id" value="${emeOrgan.eo_id }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="eo_name">机构名称</label>
				<div class="col-sm-4 input-message">
				    <div class='input-group date'>
					<input class="form-control" id="eo_name" name="eo_name" value="${emeOrgan.eo_name }" type="text"
						placeholder="输入机构名称" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="eo_sname">机构简称</label>
				<div class="col-sm-4 input-message">
				<div class='input-group date'>
					<input class="form-control" id="eo_sname" name="eo_sname" value="${emeOrgan.eo_sname }" type="text"
						placeholder="输入机构简称" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="eo_englishname">英文名称</label>
				<div class="col-sm-4">
					<div class='input-group date'>
						<input class="form-control" id="eo_englishname" name="eo_englishname" value="${emeOrgan.eo_englishname }" type="text"
						placeholder="输入英文名称" />
					</div>
				</div>
				<label class="col-sm-2 control-label" for="eo_no">序号</label>
				<div class="col-sm-4">
					<div class='input-group date'>
						<input class="form-control" id="eo_no" name="eo_no" value="${emeOrgan.eo_no }" type="text"
						placeholder="输入序号" />
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="eo_address">地址</label>
				<div class="col-sm-4">
				<div class='input-group date'>
					<input class="form-control" id="eo_address" name="eo_address"
						type="text" value="${emeOrgan.eo_address }" placeholder="输入地址" />
						</div>
				</div>
				<label class="col-sm-2 control-label" for="eo_zipcode">邮编</label>
				<div class="col-sm-4">
				<div class='input-group date'>
					<input class="form-control" id="eo_zipcode" name="eo_zipcode"
						type="text" value="${emeOrgan.eo_zipcode }" placeholder="输入邮编" />
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="eo_longitude">经度</label>
				<div class="col-sm-4">
				<div class='input-group date'>
					<input class="form-control" id="longitude" name="eo_longitude"
						type="text" value="${emeOrgan.eo_longitude }" placeholder="输入经度" />
						</div>
				</div>
				<label class="col-sm-2 control-label" for="eo_latitude">纬度</label>
				<div class="col-sm-4">
				<div class='input-group date'>
					<input class="form-control" id="latitude" name="eo_latitude"
						type="text" value="${emeOrgan.eo_latitude }" placeholder="输入纬度" />
						<span class="input-group-btn ">
        <button class="btn btn-default" type="button" onclick="getMap();">
        <span class="glyphicon glyphicon-globe"></span>
        </button>
      </span>
						</div>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>

<script type="text/javascript">
$('#emeOrgan_editform').bootstrapValidator();
function emeOrganEdit_submitForm(index,window) {
	$('#emeOrgan_editform').bootstrapValidator('validate');
	if($('#emeOrgan_editform').data('bootstrapValidator').isValid()){
		$.post('emeplan/emeOrgan/edit', $('#emeOrgan_editform').serialize(), function(j) {	
			if(j.success){
				parent.layer.close(index);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}
function getMap(){
	parent.layer.open({
		type : 2,
		title : '地点选择',
		area : [ '800px', '500px' ],
		content : 'include/map.jsp',
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow
					.getResult(index,window);
		},
	});
}
</script>
</body>
</html>