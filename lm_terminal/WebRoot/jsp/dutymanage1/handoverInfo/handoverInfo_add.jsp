<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>交接班管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
	<form id="handover_addform" class="form-horizontal" role="form">
	<input type="hidden" id="us_Overid" name="us_Overid"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="us_Overid">接班人</label>
				<div class="col-sm-4 input-message">
				    <div class='input-group'>
					<input type="tel" id="us_OverName" name="us_OverName" class="form-control" placeholder="点击选择接班人"
						 readonly="readonly" data-bv-trigger="keyup" required="required" onclick="user_select();">
						</div>
				</div>
			</div>
			<div class="form-group">
				<label for="ha_Content" class="col-sm-1 control-label">交接事宜</label>
				<div class="col-sm-10">
					<textarea rows="8" cols="100" class="form-control" name="ha_Content" placeholder="交接事宜"></textarea>
				</div>
			</div>
		</fieldset>
	</form>
<script type="text/javascript">
$(function(){
	$('#handover_addform').bootstrapValidator();
});
function handoverAdd_submitForm(index,window) {
	$('#handover_addform').bootstrapValidator('validate');
	if($('#handover_addform').data('bootstrapValidator').isValid()){
		$.post('dutymanage/handoverInfo/add', $('#handover_addform').serialize(), function(j) {	
			if(j.success){
				var str = '';
				str += "<tr id='remove_handover"+j.obj.ha_Id+"'>";
				if(j.obj.us_Overer.us_Name!=undefined){
					str += "<td style='text-align:center'>"+j.obj.us_Overer.us_Name+"</td>";
				}else{
					str += "<td style='text-align:center'></td>";
				}
				
				str += "<td style='text-align:center'>"+formatDateBoxFull(j.obj.ha_Date)+"</td>";
				str += "<td style='text-align:center'>"+j.obj.ha_Content+"</td>";
				if(j.obj.ha_state=='0'){
					str += "<td style='text-align:center'>未完成</td>";
				}else{
					str += "<td style='text-align:center'>已完成</td>";
				}
				str += "<td style='text-align:center'>";
				str += "<button type='button' class='btn btn-primary btn-sm' onclick='handover_editUI("+j.obj.ha_Id+");'>编辑</button>";
				
				if(j.obj.ha_state=='0'){
					//str += "<button id='remove_handover_finishbtn"+j.obj.ha_Id+"' type='button' class='btn btn-warning btn-sm' onclick='handover_finish("+j.obj.ha_Id+",'1','已完成');'>未完成</button>";
					str += '<button id="remove_handover_finishbtn'+j.obj.ha_Id+'" type="button" class="btn btn-warning btn-sm" onclick="handover_finish('+j.obj.ha_Id+',1,\'已完成\');">未完成</button>';
				}else{
					//str += "<button id='remove_handover_finishbtn"+j.obj.ha_Id+"' type='button' class='btn btn-warning btn-sm' onclick='handover_finish("+j.obj.ha_Id+",'0','未完成');'>已完成</button>";
					str += '<button id="remove_handover_finishbtn'+j.obj.ha_Id+'" type="button" class="btn btn-warning btn-sm" onclick="handover_finish('+j.obj.ha_Id+',0,\'未完成\');">已完成</button>';
				}
				
				str += "</td>";
				str += "</tr>";
				window.$("#addHandOverInfo").append(str);
			}else{
				parent.parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.parent.layer.close(index);
		}, 'json');
	}else{
		parent.parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}
function user_select(){
	parent.parent.layer.open({
	    type: 2,
	    title:'选择用户',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: 'system/userinfo/handoverList',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.selectUsers(index,window);
	    }
	});
}
</script>
</body>
</html>