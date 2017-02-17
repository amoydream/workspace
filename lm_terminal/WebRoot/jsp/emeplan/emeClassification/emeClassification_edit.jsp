<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案综合管理-事件分类分级-事件分级</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<form id="emeClassification_addform" class="form-horizontal" role="form">
<input type="hidden" name="pi_id" value="${classification.pi_id }"/>
<input type="hidden" name="eec_id" value="${classification.eec_id }"/>
		<fieldset>
		    <div class="form-group">
				<label for="eec_name" class="col-sm-2 control-label"><span style="color: red;">* </span>名称</label>
				<div class="col-sm-3 input-message">
				    <input class="form-control" id="eec_name" name="eec_name" value="${classification.eec_name }" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
				<label for="eec_type" class="col-sm-2 control-label">事件级别</label>
				<div class="col-sm-3">
				    <select class="form-control" id="eec_type" name="eec_type" value="${classification.eec_type }" placeholder="输入事件级别">
						<option value="1" <c:if test="${classification.eec_type=='1' }">selected="selected"</c:if>>Ⅰ级事件(特别重大)</option>
						<option value="2" <c:if test="${classification.eec_type=='2' }">selected="selected"</c:if>>Ⅱ级事件(重大)</option>
						<option value="3" <c:if test="${classification.eec_type=='3' }">selected="selected"</c:if>>Ⅲ级事件(较大)</option>
						<option value="4" <c:if test="${classification.eec_type=='4' }">selected="selected"</c:if>>Ⅳ级事件(一般)</option>
						<option value="5" <c:if test="${classification.eec_type=='5' }">selected="selected"</c:if>>Ⅳ级以下事件</option>
						</select>
				</div>
			</div>
			<div class="form-group">
				<label for="eec_desc" class="col-sm-2 control-label">描述</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="2" id="eec_desc" name="eec_desc">${classification.eec_desc }</textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="eec_remark" class="col-sm-2 control-label">备注</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="2" id="eec_remark" name="eec_remark">${classification.eec_remark }</textarea>
				</div>
			</div>
		</fieldset>
	</form>
<script type="text/javascript">
$('#emeClassification_addform').bootstrapValidator();
function emeClassificationEdit_submitForm(index, window,id) {
	$('#emeClassification_addform').bootstrapValidator('validate');
	if($('#emeClassification_addform').data('bootstrapValidator').isValid()){
		$.post('emeplan/classification/edit', $('#emeClassification_addform').serialize(), function(j) {	
			if(j.success){
				window.$("#emeClassification"+id).remove();
				var str = '';
				str +="<tr id='emeClassification"+j.obj.eec_id+"'>";
				str +="<td>"+j.obj.eec_name+"</td>";
				if(j.obj.eec_type=='1'){
					str +="<td>Ⅰ级事件(特别重大)</td>";
				}else if(j.obj.eec_type=='2'){
					str +="<td>Ⅱ级事件(重大)</td>";
				}else if(j.obj.eec_type=='3'){
					str +="<td>Ⅲ级事件(较大)</td>";
				}else if(j.obj.eec_type=='4'){
					str +="<td>Ⅳ级事件(一般)</td>";
				}else if(j.obj.eec_type=='5'){
					str +="<td>Ⅳ级以下事件</td>";
				}
				
				str +="<td>"+j.obj.eec_desc+"</td>";
				str +="<td>"+j.obj.eec_remark+"</td>";
				str +="<td><a href='javascript:void(0);' class='btn btn-primary btn-xs' onclick='emeClassification_edit("+j.obj.eec_id+")'>编辑</a>  ";
				str +="<a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='emeClassification_delete("+j.obj.eec_id+")'>删除</a></td>";
				str +="</tr>";
				window.$("#selected_emeClassifications").append(str);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.layer.close(index);
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}
</script>
</body>
</html>