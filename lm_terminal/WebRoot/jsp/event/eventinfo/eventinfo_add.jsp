<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>事件管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" type="text/css"></link>
<style type="text/css">
.col-sm-3{
width: 200px;
}
.phcolor{ color:#999;}
</style>
</head>

<body>
    <div class="container-fluid" style="margin-top: 15px;">
	<div class="row-fluid">
	<form id="eventinfo_addform" class="form-horizontal" role="form">
	<input type="hidden" name="ev_status" value="1"/>
	<input type="hidden" name="ev_del" value="0"/>
	<input type="hidden" name="CallID" value="${param.CallID }"/>
		<fieldset>
		    <div class="form-group">
				<label for="ev_name" class="col-sm-1 control-label"><span style="color: red;">*</span>事件名称</label>
				<div class="col-sm-9 input-message">
					<input class="form-control" id="ev_name" name="ev_name" type="text" value="${param.be_name }" placeholder="输入事件名称" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
		    <div class="form-group">
		    <label class="col-sm-1 control-label" for="ev_address_town">事件区域</label>
				<div class="col-sm-2 input-message">
				<div class='input-group'>
						<select class="form-control" id="ev_address_town" name="ev_address_town" placeholder="输入事件区域">
						<option value="龙城街道">龙城街道</option>
						<option value="麻榨镇">麻榨镇</option>
						<option value="永汉镇">永汉镇</option>
						<option value="龙华镇">龙华镇</option>
						<option value="龙江镇">龙江镇</option>
						<option value="平陵镇">平陵镇</option>
						<option value="龙田镇">龙田镇</option>
						<option value="地派镇">地派镇</option>
						<option value="龙潭镇">龙潭镇</option>
						<option value="蓝田瑶族乡">蓝田瑶族乡</option>
						</select>
						</div>
				</div>
				<label for="ev_address" class="col-sm-1 control-label"><span style="color: red;">*</span>事发地点</label>
				<div class="col-sm-6 input-message">
					<input class="form-control" id="ev_address" name="ev_address" type="text" value="${param.be_address }" placeholder="输入事发地点" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ev_date"><span style="color: red;">*</span>事发时间</label>
				<div class="col-sm-3 input-message">
				    <div class='input-group'>
					<input class="form-control" id="ev_date" name="ev_date" type="text" placeholder="输入事发时间"  value="${param.be_date }" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_reportDate"><span style="color: red;">*</span>接报时间</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_reportDate" name="ev_reportDate" value="${param.be_reportDate }" type="text" placeholder="输入接报时间" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
				<label class="col-sm-1 control-label" for="eventTypeName"><span style="color: red;">*</span>事件类型</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'><input type="hidden" id="eventTypeid" name="eventTypeId" value="${param.eventTypeId }"/>
					<input class="form-control" id="eventTypeName" name="eventTypeName" value="${param.eventTypeName }" type="text" placeholder="输入事件类型"  onclick="select_eventType();" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="organid">事发单位</label>
				<div class="col-sm-3 input-message">
				    <div class='input-group'><input type="hidden" id="organId" name="organId" value="${param.organId }"/>
					<input class="form-control" id="organName" name="organName" value="${param.organName }" type="text"
						placeholder="输入事发单位" onclick="select_organ();"/>
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_level">事件级别</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
						<select class="form-control" id="ev_level" name="ev_level" placeholder="输入事件级别">
						<option value="1">Ⅰ级事件(特别重大)</option>
						<option value="2">Ⅱ级事件(重大)</option>
						<option value="3">Ⅲ级事件(较大)</option>
						<option value="4">Ⅳ级事件(一般)</option>
						<option value="5">Ⅳ级以下事件</option>
						</select>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ev_reportMode">接报方式</label>
				<div class="col-sm-3 input-message">
				    <div class='input-group'>
						<select class="form-control" id="ev_reportMode" name="ev_reportMode" placeholder="输入事件级别">
						<option value="1">电话</option>
						<option value="2">传真</option>
						<option value="3">邮件</option>
						<option value="4">网络</option>
						<option value="5">视频</option>
						<option value="6">其他</option>
						</select>
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_affectedArea">受灾面积(㎡)</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" type="text" name="ev_affectedArea" pattern="^[0-9]+\.{0,1}[0-9]{0,2}$" placeholder="小数点保留两位"/>
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_participationNumber">参与（受灾）人数</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_participationNumber" name="ev_participationNumber" type="text" pattern="^\+?[1-9][0-9]*$" placeholder="正整数"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ev_injuredPeople">受伤人数</label>
				<div class="col-sm-3 input-message">
				    <div class='input-group'>
					<input class="form-control" id="ev_injuredPeople" name="ev_injuredPeople" type="text" pattern="^\+?[1-9][0-9]*$" placeholder="正整数"/>
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_deathToll">死亡人数</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" type="text" name="ev_deathToll" pattern="^\+?[1-9][0-9]*$" placeholder="正整数"/>
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_economicLoss">经济损失(万元)</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_economicLoss" name="ev_economicLoss" type="text" pattern="^[0-9]+\.{0,1}[0-9]{0,2}$" placeholder="小数点保留两位"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ev_longitude">经度</label>
				<div class="col-sm-3 input-message">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <div class="input-group"><input id="longitude" readonly="readonly" class="form-control" name="ev_longitude" type="text" pattern="^[0-9]+\.{0,1}[0-9]{0,6}$" placeholder="小数点保留六位"/></div>
					
					</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_latitude">纬度</label>
				<div class="col-sm-3 input-message">
					<div class="input-group">
						<input id="latitude" readonly="readonly" class="form-control" name="ev_latitude" type="text" pattern="^[0-9]+\.{0,1}[0-9]{0,6}$" placeholder="小数点保留六位"/>
					</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_reportName"><span style="color: red;">*</span>报告人姓名</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_reportName" name="ev_reportName" type="text" placeholder="必填项" value="${param.be_reportName }" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ev_reportPost">报告人职务</label>
				<div class="col-sm-3 input-message">
				    <div class='input-group'>
					<input class="form-control" id="ev_reportPost" name="ev_reportPost" type="text"
						placeholder="输入报告人职务" />
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_reportUnit">报告人单位</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" type="text" name="ev_reportUnit" placeholder="输入报告人单位"/>
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_reportPhone"><span style="color: red;">*</span>报告人电话</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_reportPhone" name="ev_reportPhone" type="text" placeholder="必填项" value="${param.be_reportPhone }" pattern="^(13|15|18)\d{9}$" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ev_reportAddress">报告人地址</label>
				<div class="col-sm-3 input-message">
				    <div class='input-group'>
					<input class="form-control" id="ev_reportAddress" name="ev_reportAddress" type="text"
						placeholder="输入报告人地址" />
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_relatedPersonnel">相关人员</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" type="text" name="ev_relatedPersonnel" placeholder="输入相关人员"/>
						</div>
				</div>
				<label class="col-sm-1 control-label" for="ev_endDate">结束时间</label>
				<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_endDate" name="ev_endDate" type="text"
						placeholder="结束时间"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-1 control-label">事件起因、性质</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="ev_cause" rows="3"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-1 control-label">影响范围、发展趋势</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="ev_influenceScope" rows="3"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-1 control-label">先期处置情况</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="ev_advancedDisposal" rows="3"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-1 control-label">事件基本情况</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="ev_basicSituation" rows="3">${param.be_basicSituation }</textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-1 control-label">拟采取的措施和 下一步工作建议</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="ev_nextStep" rows="3"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-6 control-label"></label>
				<div class="col-sm-6">
					<button type="button" id="eventinfoBtnAdd" class="btn btn-success" onclick="eventinfo_addUI();">添加</button>
				</div>
			</div>
		</fieldset>
		
	</form>
	</div>
</div>	
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript">
$(function(){
	$("#ev_date").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}).on('changeDate', function(ev){
		$('#eventinfo_addform').data('bootstrapValidator').updateStatus('ev_date', 'NOT_VALIDATED', null);
	});
	$("#ev_reportDate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}).on('changeDate', function(ev){
		$('#eventinfo_addform').data('bootstrapValidator').updateStatus('ev_reportDate', 'NOT_VALIDATED', null);
	});
	$("#ev_endDate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true});
	$('#eventinfo_addform').bootstrapValidator();
	
});

function eventinfo_addUI(){
	$('#eventinfo_addform').bootstrapValidator('validate');
	if($('#eventinfo_addform').data('bootstrapValidator').isValid()){
	    $("#eventinfoBtnAdd").attr("disabled","disabled");
	    $("#eventinfoBtnAdd").html("正在提交中...");
		$.post('event/eventinfo/add', $('#eventinfo_addform').serialize(), function(j) {	
			if(j.success){
				parent.refresh('tab_eventinfo_iframe');
				parent.closeTab("tab_eventinfoAdd");
			}else{
				$("#eventinfoBtnAdd").html("添加");
	    		$("#eventinfoBtnAdd").attr("disabled",false);
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}

function select_eventType(){
	parent.layer.open({
	    type: 2,
	    title:'添加事件类型',
	    area:['500px','500px'],
	    scrollbar: false,
	    content: 'jsp/event/eventinfo/eventinfo_type.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.selectType(index,window,'eventinfo_addform');
	    }
	});
}
function getMap(){
	parent.layer.open({
		type : 2,
		title : '地点选择',
		area : [ '800px', '500px' ],
		content : 'gismap/common/map2.jsp',
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow
					.getResult(index,window);
		},
	});
}
function select_organ(){
	parent.layer.open({
	    type: 2,
	    title:'添加单位',
	    area:['500px','500px'],
	    scrollbar: false,
	    content: 'jsp/event/eventinfo/eventinfo_organ.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.selectOrgan(index,window);
	    }
	});
}
</script>
</body>
</html>