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
<title>组织管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
	<div class="modal-body">
		<form id="organ_editform" class="form-horizontal" role="form">
			<input type="hidden" id="or_id" name="or_id" value="${organ.or_id }" />
			<fieldset>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="or_name">
						<span style="color: red;">* </span>
						机构名称
					</label>
					<div class="col-sm-4 input-message">
						<input class="form-control" id="or_name" name="or_name" value="${organ.or_name }" type="text"
							placeholder="输入机构名称" data-bv-trigger="keyup" required="required" />
					</div>
					<label class="col-sm-2 control-label" for="or_sname">
						<span style="color: red;">* </span>
						机构简称
					</label>
					<div class="col-sm-4 input-message">
						<input class="form-control" id="or_sname" name="or_sname" value="${organ.or_sname }"
							type="text" placeholder="输入机构简称" data-bv-trigger="keyup" required="required" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="or_englishname">英文名称</label>
					<div class="col-sm-4">
						<input class="form-control" id="or_englishname" name="or_englishname"
							value="${organ.or_englishname }" type="text" placeholder="输入英文名称" />
					</div>
					<label class="col-sm-2 control-label" for="or_no">序号</label>
					<div class="col-sm-4">
						<input class="form-control" id="or_no" name="or_no" value="${organ.or_no }" type="text"
							placeholder="输入序号" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="or_address">地址</label>
					<div class="col-sm-4">
						<input class="form-control" id="or_address" name="or_address" type="text"
							value="${organ.or_address }" placeholder="输入地址" />
					</div>
					<label class="col-sm-2 control-label" for="or_zipcode">邮编</label>
					<div class="col-sm-4">
						<input class="form-control" id="or_zipcode" name="or_zipcode" type="text"
							value="${organ.or_zipcode }" placeholder="输入邮编" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="or_longitude">经度</label>
					<div class="col-sm-4">
						<div class="input-group">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button" onclick="getMap()">
									<span class="glyphicon glyphicon-globe"></span>
								</button>
							</span>
							<input id="longitude" class="form-control" name="or_longitude" value="${organ.or_longitude }"
								type="text" placeholder="纬度" />
						</div>
					</div>
					<label class="col-sm-2 control-label" for="or_latitude">纬度</label>
					<div class="col-sm-4">
						<div class="input-group">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button" onclick="getMap()">
									<span class="glyphicon glyphicon-globe"></span>
								</button>
							</span>
							<input id="latitude" class="form-control" name="da_latitude" value="${organ.or_latitude }"
								type="text" placeholder="纬度" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">是否应急部门</label>
					<div class="col-sm-4">
						<input type="radio" name="or_type" value="0"
							<c:if test="${organ.or_type=='0' }">checked="checked"</c:if> />
						否
						<input type="radio" name="or_type" value="1"
							<c:if test="${organ.or_type=='1' }">checked="checked"</c:if> />
						是
					</div>
					<label class="col-sm-2 control-label" for="or_sort">排序</label>
					<div class="col-sm-4">
						<input type="hidden" id="or_sort_old" name="or_sort_old" value="${organ.or_sort_old }" />
						<select class="form-control" id="or_sort" name="or_sort" value="${organ.or_sort }">
						</select>
					</div>
				</div>
			</fieldset>
			<span id="msgdemo2" style="margin-left: 30px;"></span>
		</form>
	</div>
	<script type="text/javascript">
		$('#organ_editform').bootstrapValidator();
        function organEdit_submitForm(index, window, treeObj, pid) {
	        $('#organ_editform').bootstrapValidator('validate');
	        if($('#organ_editform').data('bootstrapValidator').isValid()) {
		        $.post('work/organ/edit', $('#organ_editform').serialize(), function(j) {
			        if(j.success) {
				        var orId = $("#or_id").val();
				        var orName = $("#or_name").val();
				        var node = treeObj.getNodeByParam("id", orId, null);
				        node.name = orName;
				        // 更新根节点中第i个节点的名称	        
				        treeObj.updateNode(node);
				        window.postChild(pid);
				        
				        parent.layer.close(index);
			        }
			        parent.layer.msg(j.msg, {
			            offset : 0,
			            shift : 6
			        });
		        }, 'json');
	        } else {
		        parent.layer.msg('红色输入框必填', {
		            offset : 0,
		            shift : 6
		        });
	        }
        }
        function getMap() {
	        parent.layer.open({
	            type : 2,
	            title : '地点选择',
	            area : ['800px', '500px'],
	            content : 'include/map.jsp',
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            var iframeWin = layero.find('iframe')[0].contentWindow.getResult(index, window);
	            },
	        });
        }

        $(function() {
	        var html = '<option id="0" value="0">---选择排序---</option>';
	        for(var i = 1; i < 101; i++) {
		        if('${organ.or_sort}' == i) {
			        html += '<option id="'+ i + '" value="' + i + '" selected="true">' + i + '</option>';
		        } else {
			        html += '<option id="' + i + '" value="' + i + '">' + i + '</option>';
		        }
	        }
	        document.getElementById('or_sort').innerHTML = html;
        });
	</script>
</body>
</html>