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
<title>机构人员管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	type="text/css"></link>
<script type="text/javascript">
	$(function() {
	    var pe_nationality1 = $("#pe_nationality1").val();
	    var pe_nationality = $("#pe_nationality");
	    var racials = {
		    head : [{
		        text : "汉族",
		        id : "汉族"
		    }, {
		        text : "壮族",
		        id : "壮族"
		    }, {
		        text : "苗族",
		        id : "苗族"
		    }, {
		        text : "满族",
		        id : "满族"
		    }, {
		        text : "土家族",
		        id : "土家族"
		    }, {
		        text : "藏族",
		        id : "藏族"
		    }, {
		        text : "蒙古族",
		        id : "蒙古族"
		    }, {
		        text : "维吾尔族",
		        id : "维吾尔族"
		    }, {
		        text : "土族",
		        id : "土族"
		    }, {
		        text : "回族",
		        id : "回族"
		    }, {
		        text : "阿昌族",
		        id : "阿昌族"
		    }, {
		        text : "白族",
		        id : "白族"
		    }, {
		        text : "黎族",
		        id : "黎族"
		    }, {
		        text : "彝族",
		        id : "彝族"
		    }, {
		        text : "仫佬族",
		        id : "仫佬族"
		    }, {
		        text : "保安族",
		        id : "保安族"
		    }, {
		        text : "布朗族",
		        id : "布朗族"
		    }, {
		        text : "布依族",
		        id : "布依族"
		    }, {
		        text : "朝鲜族",
		        id : "朝鲜族"
		    }, {
		        text : "达斡尔族",
		        id : "达斡尔族"
		    }, {
		        text : "维吾尔族",
		        id : "维吾尔族"
		    }, {
		        text : "傣族",
		        id : "傣族"
		    }, {
		        text : "德昂族",
		        id : "德昂族"
		    }, {
		        text : "东乡族",
		        id : "东乡族"
		    }, {
		        text : "侗族",
		        id : "侗族"
		    }, {
		        text : "独龙族",
		        id : "独龙族"
		    }, {
		        text : "俄罗斯族",
		        id : "俄罗斯族"
		    }, {
		        text : "鄂伦春族",
		        id : "鄂伦春族"
		    }, {
		        text : "怒族",
		        id : "怒族"
		    }, {
		        text : "撒拉族",
		        id : "撒拉族"
		    }, {
		        text : "羌族",
		        id : "羌族"
		    }]
	    };
	    pe_nationality.empty();
	    for(var i = 0, h = racials.head.length; i < h; i++) {
		    if(racials.head[i].id == pe_nationality1) {
			    $("<option value='" + racials.head[i].id + "' selected='selected'>" + racials.head[i].text
			      + "</option>").appendTo(pe_nationality);
		    } else {
			    $("<option value='" + racials.head[i].id + "'>" + racials.head[i].text + "</option>")
			        .appendTo(pe_nationality);
		    }
		    
	    }
	    var politicals = {
		    head : [{
		        text : "党员",
		        id : "党员"
		    }, {
		        text : "团员",
		        id : "团员"
		    }, {
		        text : "民主人士",
		        id : "民主人士"
		    }, {
		        text : "民盟",
		        id : "民盟"
		    }, {
		        text : "国民党",
		        id : "国民党"
		    }, {
		        text : "民革党",
		        id : "民革党"
		    }, {
		        text : "农工党",
		        id : "农工党"
		    }, {
		        text : "公民",
		        id : "公民"
		    }, {
		        text : "九三学社",
		        id : "九三学社"
		    }]
	    };
	    var pe_political1 = $("#pe_political1").val();
	    var pe_political = $("#pe_political");
	    $("<option value=''>请选择</option>").appendTo(pe_political);
	    for(var i = 0, h = politicals.head.length; i < h; i++) {
		    if(politicals.head[i].id == pe_political1) {
			    $("<option value='" + politicals.head[i].id + "' selected='selected'>" + politicals.head[i].text
			      + "</option>").appendTo(pe_political);
		    } else {
			    $("<option value='" + politicals.head[i].id + "'>" + politicals.head[i].text + "</option>")
			        .appendTo(pe_political);
		    }
		    
	    }
	    
	    var professions = {
		    head : [{
		        text : "中文",
		        id : "中文"
		    }, {
		        text : "外语",
		        id : "外语"
		    }, {
		        text : "数学",
		        id : "数学"
		    }, {
		        text : "理工",
		        id : "理工"
		    }, {
		        text : "化工",
		        id : "化工"
		    }]
	    };
	    var pe_profession1 = $("#pe_profession1").val();
	    var pe_profession = $("#pe_profession");
	    $("<option value=''>请选择</option>").appendTo(pe_profession);
	    for(var i = 0, h = professions.head.length; i < h; i++) {
		    if(professions.head[i].id == pe_profession1) {
			    $("<option value='" + professions.head[i].id + "' selected='selected'>" + professions.head[i].text
			      + "</option>").appendTo(pe_profession);
		    } else {
			    $("<option value='" + professions.head[i].id + "'>" + professions.head[i].text + "</option>")
			        .appendTo(pe_profession);
		    }
		    
	    }
	    var educationals = {
		    head : [{
		        text : "小学",
		        id : "小学"
		    }, {
		        text : "初中",
		        id : "初中"
		    }, {
		        text : "中专",
		        id : "中专"
		    }, {
		        text : "高中",
		        id : "高中"
		    }, {
		        text : "大专",
		        id : "大专"
		    }, {
		        text : "本科",
		        id : "本科"
		    }, {
		        text : "硕士",
		        id : "硕士"
		    }, {
		        text : "博士",
		        id : "博士"
		    }]
	    };
	    var pe_educational1 = $("#pe_educational1").val();
	    var pe_educational = $("#pe_educational");
	    $("<option value=''>请选择</option>").appendTo(pe_educational);
	    for(var i = 0, h = educationals.head.length; i < h; i++) {
		    if(educationals.head[i].id == pe_educational1) {
			    $("<option value='" + educationals.head[i].id + "' selected='selected'>" + educationals.head[i].text
			      + "</option>").appendTo(pe_educational);
		    } else {
			    $("<option value='" + educationals.head[i].id + "'>" + educationals.head[i].text + "</option>")
			        .appendTo(pe_educational);
		    }
	    }
    });
</script>
</head>
<body>
	<div class="modal-body">
		<form id="person_editform" class="form-horizontal" role="form">
			<input type="hidden" name="pe_id" value="${person.pe_id }" />
			<input type="hidden" name="pe_del" value="${person.pe_del }" />
			<fieldset>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="pe_name">
						<span style="color: red;">* </span>
						姓名
					</label>
					<div class="col-sm-4 input-message">
						<input class="form-control" id="pe_name" name="pe_name" value="${person.pe_name }" type="text"
							placeholder="输入姓名" data-bv-trigger="keyup" required="required" />
					</div>
					<label class="col-sm-2 control-label" for="pe_jobs">
						岗位
					</label>
					<div class="col-sm-4 input-message">
						<input type="hidden" id="po_id" name="po_ids" value="${person.pe_poids }" />
						<div class="input-group">
							<input class="form-control" id="po_name" name="po_name" value="${person.pe_jobs }"
								type="text" placeholder="选择岗位" data-bv-trigger="keyup" onclick="selectJobs();" />
							<div class="input-group-addon">
								<a href="javascript:void(0);" onclick="clearPosition();"><span
										class="glyphicon glyphicon-remove"></span></a>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="pe_sex">性别</label>
					<div class="col-sm-4 input-message">
						<input type="radio" name="pe_sex" value="F"
							<c:if test="${person.pe_sex=='F' }">checked="checked"</c:if> />
						男
						<input type="radio" name="pe_sex" value="M"
							<c:if test="${person.pe_sex=='M' }">checked="checked"</c:if> />
						女
					</div>
					<label class="col-sm-2 control-label" for="pe_type">应急人员</label>
					<div class="col-sm-4">
						<input type="radio" name="pe_type" value="0"
							<c:if test="${person.pe_type=='0' }">checked="checked"</c:if> />
						否
						<input type="radio" name="pe_type" value="1"
							<c:if test="${person.pe_type=='1' }">checked="checked"</c:if> />
						是
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="pe_birthday">出生年月</label>
					<div class="col-sm-4">
						<input class="form-control" id="pe_birthday" name="pe_birthday" type="text"
							value="${person.pe_birthday }" placeholder="输入出生年月" />
					</div>
					<label class="col-sm-2 control-label" for="pe_educational">学历</label>
					<div class="col-sm-4">
						<input type="hidden" id="pe_educational1" value="${person.pe_educational }" />
						<select class="form-control" id="pe_educational" name="pe_educational"></select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="pe_nativeplace">籍贯</label>
					<div class="col-sm-4">
						<input class="form-control" id="pe_nativeplace" name="pe_nativeplace" type="text"
							value="${person.pe_nativeplace }" placeholder="输入籍贯" />
					</div>
					<label class="col-sm-2 control-label" for="pe_nationality">民族</label>
					<div class="col-sm-4">
						<input type="hidden" id="pe_nationality1" value="${person.pe_nationality }" />
						<select class="form-control" id="pe_nationality" name="pe_nationality"></select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="pe_political">政治面貌</label>
					<div class="col-sm-4">
						<input type="hidden" id="pe_political1" value="${person.pe_political }" />
						<select class="form-control" id="pe_political" name="pe_political"></select>
					</div>
					<label class="col-sm-2 control-label" for="pe_identity">身份证</label>
					<div class="col-sm-4 input-message">
						<input class="form-control" id="pe_identity" name="pe_identity" type="text"
							value="${person.pe_identity }" placeholder="输入身份证" pattern="(^\d{15}$)|(^\d{17}([0-9]|X)$)" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="pe_workdate">工作时间</label>
					<div class="col-sm-4">
						<input class="form-control" id="pe_workdate" name="pe_workdate" type="text"
							value="${person.pe_workdate }" placeholder="输入工作时间" />
					</div>
					<label class="col-sm-2 control-label" for="pe_profession">专业</label>
					<div class="col-sm-4">
						<input type="hidden" id="pe_profession1" value="${person.pe_profession }" />
						<select class="form-control" id="pe_profession" name="pe_profession"></select>
					</div>
				</div>
				<div class="form-group">
					<label for="disabledSelect" class="col-sm-2 control-label">家庭住址</label>
					<div class="col-sm-10">
						<input class="form-control" id="pe_homeaddress" name="pe_homeaddress"
							value="${person.pe_homeaddress }" type="text" placeholder="输入家庭住址" />
					</div>
				</div>
				<div class="form-group">
					<label for="disabledSelect" class="col-sm-2 control-label">现住住址</label>
					<div class="col-sm-10">
						<input class="form-control" id="pe_address" name="pe_address" value="${person.pe_address }"
							type="text" placeholder="输入现住住址" />
					</div>
				</div>
				<div class="form-group">
					<label for="disabledSelect" class="col-sm-2 control-label">备注</label>
					<div class="col-sm-10">
						<input class="form-control" id="pe_remark" name="pe_remark" type="text"
							value="${person.pe_remark }" placeholder="输入备注" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="pe_leader">需报领导</label>
					<div class="col-sm-4">
						<input type="radio" name="pe_leader" value="0"
							<c:if test="${person.pe_leader=='0' }">checked="checked"</c:if> />
						否
						<input type="radio" name="pe_leader" value="1"
							<c:if test="${person.pe_leader=='1' }">checked="checked"</c:if> />
						是
					</div>
					<label class="col-sm-2 control-label" for="pe_sort">排序</label>
					<div class="col-sm-4">
						<input type="hidden" id="pe_sort_old" name="pe_sort_old" value="${person.pe_sort_old }" />
						<select class="form-control" id="pe_sort" name="pe_sort" value="${person.pe_sort }">
						</select>
					</div>
				</div>	
				<div class="form-group">	
					<label class="col-sm-2 control-label" for="pe_jobs">岗位</label>
					<div class="col-sm-4 input-message">
						<input type="hidden" id="or_id" name="or_id" value="${person.or_id }" />
						<div class="input-group">
							<input class="form-control" id="or_name" name="or_name" value="${person.or_name }"
								type="text" placeholder="选择部门" data-bv-trigger="keyup" required="required"
								onclick="selectOrgan();" />
						</div>
					</div>
				</div>
	</div>
	</fieldset>
	<span id="msgdemo2" style="margin-left: 30px;"></span>
	</form>
	</div>
	<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
	<script type="text/javascript"
		src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript"
		src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
		charset="UTF-8"></script>
	<script type="text/javascript">
	if("${person.pe_jobs}".length>1){
		var positionids = "${person.pe_poids}".split(",");
		var ponames = "${person.pe_jobs }".split(",");
	}else{
		var positionids = [];
		var ponames =[];
	}
	
		$(function() {
	        $("#pe_birthday").datetimepicker({
	            language : 'zh-CN',
	            format : 'yyyy-mm-dd',
	            minView : 'month',
	            autoclose : true
	        });
	        $("#pe_workdate").datetimepicker({
	            language : 'zh-CN',
	            format : 'yyyy-mm-dd',
	            minView : 'month',
	            autoclose : true
	        });
        });
        $('#person_editform').bootstrapValidator();
        function personEdit_submitForm(index, window, orid) {
	        $('#person_editform').bootstrapValidator('validate');
	        if($('#person_editform').data('bootstrapValidator').isValid()) {
		        $.post('work/person/edit', $('#person_editform').serialize(), function(j) {
			        if(j.success) {
				        parent.layer.close(index);
				        window.postChild(orid);
			        } else {
				        parent.layer.msg(j.msg, {
				            offset : 0,
				            shift : 6
				        });
			        }
		        }, 'json');
	        } else {
		        parent.layer.msg('红色输入框必填', {
		            offset : 0,
		            shift : 6
		        });
	        }
        }
        function selectJobs() {
	        parent.layer.open({
	            type : 2,
	            title : '选择岗位',
	            area : ['800px', '600px'],
	            scrollbar : false,
	            content : ['jsp/work/position/position_select.jsp', 'yes'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.select_position(index, window);
	            }
	        });
        }
        function selectOrgan() {
	        parent.layer.open({
	            type : 2,
	            title : '选择部门',
	            area : ['400px', '600px'],
	            scrollbar : false,
	            content : ['jsp/work/person/organ_select.jsp', 'yes'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.select_organ(index, window);
	            }
	        });
        }
        function clearPosition() {
	        $("#po_id").val("");
	        $("#po_name").val("");
        }

        $(function() {
	        var html = '<option id="0" value="0">---选择排序---</option>';
	        for(var i = 1; i < 101; i++) {
		        if('${person.pe_sort}' == i) {
			        html += '<option id="'+ i + '" value="' + i + '" selected="true">' + i + '</option>';
		        } else {
			        html += '<option id="' + i + '" value="' + i + '">' + i + '</option>';
		        }
	        }
	        document.getElementById('pe_sort').innerHTML = html;
        });
        
        $(function() {
	        var html = '<option id="0" value="0">---选择排序---</option>';
	        for(var i = 1; i < 101; i++) {
		        if('${person.pe_sort}' == i) {
			        html += '<option id="'+ i + '" value="' + i + '" selected="true">' + i + '</option>';
		        } else {
			        html += '<option id="' + i + '" value="' + i + '">' + i + '</option>';
		        }
	        }
	        document.getElementById('pe_sort').innerHTML = html;
        });
	</script>
</body>
</html>