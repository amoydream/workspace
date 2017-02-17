<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案应急处置阶段流程管理-行动人员</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<form id="actiondep_editform" class="form-horizontal" role="form">
<input type="hidden" name="ead_id" value="${action_Department.ead_id }"/>
		<fieldset>
		    <div class="form-group">
				<label for="eal_name" class="col-sm-2 control-label">执行部门人员 </label>
				<div class="col-sm-9"><input type="hidden" id="bo_id" name="aBooksId" value="${action_Department.aBooks.bo_id }"/>
				    <input class="form-control" id="bo_name" value="${action_Department.aBooks.person.pe_name }" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required" onclick="select_books();"/>
				</div>
			</div>

			<div class="form-group">
				<label for="ead_remark" class="col-sm-2 control-label">任务说明</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="2" id="ead_remark" name="ead_remark">${action_Department.ead_remark }</textarea>
				</div>
			</div>
		</fieldset>
	</form>
<script type="text/javascript">
$('#actiondep_editform').bootstrapValidator();
function actiondepEdit_submitForm(index,window,id) {
	$('#actiondep_editform').bootstrapValidator('validate');
	if($('#actiondep_editform').data('bootstrapValidator').isValid()){
		$.post('emeplan/actionDepartment/edit', $('#actiondep_editform').serialize(), function(j) {	
			if(j.success){
				window.$("#actionDepsListsDel"+id).append(str);
				var str = '';
				str +="<tr id='actionDepsListsDel"+j.obj.ead_id+"'>";
				if(j.obj.aBooks.organ==undefined){
					if(j.obj.aBooks.person==undefined){
						str +="<td></td>";
					}else{
						str +="<td>"+j.obj.aBooks.person.organ.or_name+"</td>";
					}
				}else{
					str +="<td>"+j.obj.aBooks.organ.or_name+"</td>";
				}
				if(j.obj.aBooks.person==undefined){
					str +="<td></td>";
				}else{
					str +="<td>"+j.obj.aBooks.person.pe_name+"</td>";
				}
				
				str +="<td>"+j.obj.aBooks.bo_number+"</td>";
				if(j.obj.ead_remark!=undefined){
					str +="<td>"+j.obj.ead_remark+"</td>";
				}else{
					str +="<td></td>";
				}
				
				str +="<td><button type='button' class='btn btn-primary btn-sm' onclick='actionDeps_editUI("+j.obj.ead_id+");'>编辑</button>";
				str +="<button type='button' class='btn btn-danger btn-sm' onclick='actionDeps_delete("+j.obj.ead_id+");'>删除</button></td>";
				str +="</tr>";
				window.$("#actionDepsLists_data").append(str);
				//window.autoTree1();
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
function select_books(){
	parent.parent.parent.layer.open({
	    type: 2,
	    title:'添加通讯录',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/emeplan/emebooks/emebooks_select.jsp','no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.booksAdd_submitForm(index,window);
	    }
	});
}
</script>
</body>
</html>