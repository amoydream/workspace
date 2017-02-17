<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>预案基本信息管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" type="text/css"></link>
</head>

<body>
<div class="container-fluid"
		style="padding-left: 0px;margin-left: 15px;">
		<div class="row-fluid">
      <legend>预案原文<button type="button" class="btn btn-primary btn-sm" onclick="planinfo_uploaddoc(${planInfo.pi_id });">添加</button></legend>
      
         <table class="table table-bordered">
			<tr>
				<th>名称</th>
				<th>操作</th>
			</tr>
			<tbody id="plandoc_uploads">
			<c:forEach items="${plandocs }" var="entry" varStatus="statu">
			<c:choose>
			<c:when test="${statu.index % 2 ==0}">
			<tr id="plandoc${entry.pdoc_id}" style="background-color: #ebf8ff;">
               <td>${entry.pdoc_name}</td>
               <td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='plandoc_delete(${entry.pdoc_id})'>删除</a>
               <a href='javascript:void(0);' class='btn btn-warning btn-xs' onclick="plandoc_report('${entry.pdoc_name}')">查看</a></td>
              </tr>
			</c:when>
			<c:otherwise>
			<tr id="plandoc${entry.pdoc_id}">
               <td>${entry.pdoc_name}</td>
               <td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='plandoc_report(${entry.pdoc_id})'>删除</a></td>
              </tr>
			</c:otherwise>
			</c:choose>
            </c:forEach>
			</tbody>
		</table>
      
      <legend>相关法律法规<button type="button" class="btn btn-primary btn-sm" onclick="planinfo_legal_select(${planInfo.pi_id });">添加</button></legend>
         <table class="table table-bordered">
			<tr>
				<th>名称</th>
				<th>操作</th>
			</tr>
			<tbody id="planinfo_legals">
			<c:forEach items="${planLegalVos }" var="entry" varStatus="statu">
			<input type="hidden" name="le_ids" value="${entry.le_id}"/>
			<c:choose>
			<c:when test="${statu.index % 2 ==0}">
			<tr id="planLagal${entry.le_id}" style="background-color: #ebf8ff;">
               <td>${entry.le_Name}</td>
               <td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='planLagal_delete(${entry.le_id})'>删除</a>
               <a href='javascript:void(0);' class='btn btn-warning btn-xs' onclick="planLagal_viewdoc(${entry.le_id})">查看</a></td>
              </tr>
			</c:when>
			<c:otherwise>
			<tr id="planLagal${entry.le_id}">
               <td>${entry.le_Name}</td>
               <td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='planLagal_delete(${entry.le_id})'>删除</a>
               <a href='javascript:void(0);' class='btn btn-warning btn-xs' onclick="planLagal_viewdoc(${entry.le_id})">查看</a></td>
              </tr>
			</c:otherwise>
			</c:choose>
            </c:forEach>
			</tbody>
		</table>
      <legend>基本信息</legend>
         <form id="planinfo_editform" class="form-horizontal" role="form">
	<input type="hidden" name="pi_id" value="${planInfo.pi_id }"/>
	<input type="hidden" name="pi_del" value="${planInfo.pi_del }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="pi_name">预案名称</label>
				<div class="col-sm-9 input-message">
					<input class="form-control" id="pi_name" name="pi_name" value="${planInfo.pi_name }" type="text"
						placeholder="输入预案名称" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="pi_createDate">发布日期</label>
				<div class="col-sm-3">
					<div class='input-group'>
						<input class="form-control" id="pi_createDate" name="pi_createDate" value="${planInfo.pi_createDate }" type="text"
						placeholder="输入发布日期" />
					</div>
				</div>
				<label class="col-sm-1 control-label" for="eventTypeId">分类</label>
				<div class="col-sm-3">
					<div class='input-group'>
					<input type="hidden" id="eventTypeId" name="eventTypeId" value="${planInfo.eventType.et_id }"/>
						<input class="form-control" id="eventTypeName" name="eventTypeName" value="${planInfo.eventType.et_name }" type="text"
						placeholder="选择分类" onclick="selectEventType();"/>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="pi_subOrgan">所属机构</label>
				<div class="col-sm-3">
					<div class='input-group'>
						<input class="form-control" id="pi_subOrgan" name="pi_subOrgan" value="${planInfo.pi_subOrgan }" type="text"
						placeholder="输入所属机构" />
					</div>
				</div>
				<label class="col-sm-1 control-label" for="pi_issOrgan">发布机构</label>
				<div class="col-sm-3">
					<div class='input-group'>
						<input class="form-control" id="pi_issOrgan" name="pi_issOrgan" value="${planInfo.pi_issOrgan }" type="text"
						placeholder="输入发布机构" />
					</div>
				</div>
				<label class="col-sm-1 control-label" for="pi_estOrgan">编制机构</label>
				<div class="col-sm-3">
				<div class='input-group'>
					<input class="form-control" id="pi_estOrgan" name="pi_estOrgan"
						type="text" value="${planInfo.pi_estOrgan }" placeholder="输入编制机构" />
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="pi_appOrgan">审批机构</label>
				<div class="col-sm-3">
				<div class='input-group'>
					<input class="form-control" id="pi_appOrgan" name="pi_appOrgan"
						type="text" value="${planInfo.pi_appOrgan }" placeholder="输入审批机构" />
						</div>
				</div>
				<label class="col-sm-1 control-label" for="pi_no">版本号</label>
				<div class="col-sm-3">
				<div class='input-group'>
					<input class="form-control" id="pi_no" name="pi_no"
						type="text" value="${planInfo.pi_no }" placeholder="输入版本号" />
						</div>
				</div>
				<label class="col-sm-1 control-label" for="pi_level">层级</label>
				<div class="col-sm-3">
				<div class='input-group'>
					<select class="form-control" id="pi_level" name="pi_level">
						<option value="1" <c:if test="${planInfo.pi_level=='1' }">selected="selected"</c:if>>省</option>
						<option value="2" <c:if test="${planInfo.pi_level=='2' }">selected="selected"</c:if>>地市</option>
						<option value="3" <c:if test="${planInfo.pi_level=='3' }">selected="selected"</c:if>>区县</option>
						<option value="4" <c:if test="${planInfo.pi_level=='4' }">selected="selected"</c:if>>部门</option>
						<option value="5" <c:if test="${planInfo.pi_level=='5' }">selected="selected"</c:if>>企业</option>
						</select>
						</div>
				</div>
			</div>

			<div class="form-group">
				<label for="pt_remark" class="col-sm-1 control-label">说明</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pi_note" name="pi_note">${planInfo.pi_note }</textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="pt_remark" class="col-sm-1 control-label">描述</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pi_desc" name="pi_desc">${planInfo.pi_desc }</textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="pt_remark" class="col-sm-1 control-label">适用范围</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pi_scope" name="pi_scope">${planInfo.pi_scope }</textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="pt_remark" class="col-sm-1 control-label">备注</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pi_remark" name="pi_remark">${planInfo.pi_remark }</textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-6 control-label"></label>
				<div class="col-sm-6">
					<button type="button" id="planinfoBtnEdit" class="btn btn-success" onclick="eventinfo_editUI();">提交</button>
				</div>
			</div>
		</fieldset>
	</form>
   </div>
</div>
</div>

<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript">
$(function(){
	$("#pi_createDate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd',minView:'month',autoclose:true});
});
$('#planinfo_editform').bootstrapValidator();
function eventinfo_editUI() {
	$('#planinfo_editform').bootstrapValidator('validate');
	if($('#planinfo_editform').data('bootstrapValidator').isValid()){
		$("#planinfoBtnEdit").html("正在提交中...");
		$("#planinfoBtnEdit").attr("disabled","disabled");
		$.post('emeplan/planinfo/edit', $('#planinfo_editform').serialize(), function(j) {	
			if (j.success) {
				var etId = $("#eventTypeId").val();
				parent.document.getElementById('tab_planinfo_iframe').contentWindow.postChild(etId);
				parent.closeTab("tab_parentAddtabs");
			}else{
				$("#planinfoBtnEdit").html("修改");
	    		$("#planinfoBtnEdit").attr("disabled",false);
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
function planinfo_legal_select(id){
	var ids = $("input[name='le_ids']");
	parent.layer.open({
		type : 2,
		title : '选择法律法规',
		area : [ '800px', '500px' ],
		scrollbar : false,
		content : [ 'jsp/resource/legal/legal_planinfo_select.jsp', 'no' ],
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			layero.find('iframe')[0].contentWindow.select_Legals(index, window,${planInfo.pi_id },ids);
		}
	});
}
function selectEventType(){
	parent.layer.open({
		type : 2,
		title : '选择分类',
		area : [ '500px', '500px' ],
		scrollbar : false,
		content : 'jsp/event/eventtype/eventtype_planinfo_select.jsp',
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			layero.find('iframe')[0].contentWindow.selectType(index, window);
		}
	});
}
function planLagal_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/planinfo/deleteLegal',{id:id,pi_id:${planInfo.pi_id }}, function(j) {
			if(j.success){
				$("#planLagal"+id).remove();
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	});
}
function planinfo_uploaddoc(id){
	parent.layer.open({
        type : 2,
        title : '预案附件上传',
        area : ['550px', '400px'],
        scrollbar : false,
        content : ['jsp/emeplan/planinfo/planinfo_upload.jsp?piId='+id, 'no']
    });
}

function plandoc_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('emeplan/plandoc/delete',{id:id}, function(j) {
			if(j.success){
				$("#plandoc"+id).remove();
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	});
}

function plandoc_report(docName){
	window.open("<%=basePath%>emeplan/plandoc/view?docName="+docName);
}

function planLagal_viewdoc(le_Id){
	window.open("<%=basePath%>resource/legal/viewdoc?leId="+le_Id);			
}
</script>
</body>
</html>