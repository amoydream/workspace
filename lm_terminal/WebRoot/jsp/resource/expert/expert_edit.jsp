<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>专家信息编辑</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<script type="text/javascript">
$(function() {
	var ex_Nationality1 = $("#ex_Nationality1").val();
	var ex_Nationality = $("#ex_Nationality");
	var racials = {
		head : [ {
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
		} ]
	};
	ex_Nationality.empty();
	for (var i = 0, h = racials.head.length; i < h; i++) {
		if(racials.head[i].id == ex_Nationality1){
			$("<option value='" + racials.head[i].id + "' selected='selected'>" + racials.head[i].text + "</option>").appendTo(ex_Nationality);
		}else{
			$("<option value='" + racials.head[i].id + "'>" + racials.head[i].text + "</option>").appendTo(ex_Nationality);
		}
	}
	
	var politicalstatus = {
			head : [ {
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
			} ]
		};
	var ex_Politicalstatus1 = $("#ex_Politicalstatus1").val();
	var ex_Politicalstatus = $("#ex_Politicalstatus");
	$("<option value=''>请选择</option>").appendTo(ex_Politicalstatus);
	for (var i = 0, h = politicalstatus.head.length; i < h; i++) {
		if(politicalstatus.head[i].id == ex_Politicalstatus1){
			$("<option value='" + politicalstatus.head[i].id + "' selected='selected'>" + politicalstatus.head[i].text + "</option>").appendTo(ex_Politicalstatus);
		}else{
			$("<option value='" + politicalstatus.head[i].id + "'>" + politicalstatus.head[i].text + "</option>").appendTo(ex_Politicalstatus);
		}
	}

		var professional = {
				head : [ {
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
		var ex_Professional1 = $("#ex_Professional1").val();
		var ex_Professional = $("#ex_Professional");
		$("<option value=''>请选择</option>").appendTo(ex_Professional);
		for (var i = 0, h = professional.head.length; i < h; i++) {
			if(professional.head[i].id == ex_Professional1){
				$("<option value='" + professional.head[i].id + "' selected='selected'>" + professional.head[i].text + "</option>").appendTo(ex_Professional);
			}else{
				$("<option value='" + professional.head[i].id + "'>" + professional.head[i].text + "</option>").appendTo(ex_Professional);
			}
		}
		
		var degree = {
				head : [ {
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
		var ex_Degree1 = $("#ex_Degree1").val();
		var ex_Degree = $("#ex_Degree");
		$("<option value=''>请选择</option>").appendTo(ex_Degree);
		for (var i = 0, h = degree.head.length; i < h; i++) {
			if(degree.head[i].id == ex_Degree1){
				$("<option value='" + degree.head[i].id + "' selected='selected'>" + degree.head[i].text + "</option>").appendTo(ex_Degree);
			}else{
				$("<option value='" + degree.head[i].id + "'>" + degree.head[i].text + "</option>").appendTo(ex_Degree);
			}
		}
		
		var foreignlanguage = {
				head : [ {
					text : "英语",
					id : "英语"
				}, {
					text : "法语",
					id : "法语"
				}, {
					text : "俄语",
					id : "俄语"
				}, {
					text : "德语",
					id : "德语"
				}, {
					text : "日语",
					id : "日语"
				}, {
					text : "韩语",
					id : "韩语"
				}]
			};
		var ex_Foreignlanguage1 = $("#ex_Foreignlanguage1").val();
		var ex_Foreignlanguage = $("#ex_Foreignlanguage");
		$("<option value=''>请选择</option>").appendTo(ex_Foreignlanguage);
		for (var i = 0, h = foreignlanguage.head.length; i < h; i++) {
			if(foreignlanguage.head[i].id == ex_Foreignlanguage1){
				$("<option value='" + foreignlanguage.head[i].id + "' selected='selected'>" + foreignlanguage.head[i].text + "</option>").appendTo(ex_Foreignlanguage);
			}else{
				$("<option value='" + foreignlanguage.head[i].id + "'>" + foreignlanguage.head[i].text + "</option>").appendTo(ex_Foreignlanguage);
			}
		}
		
		var job = {
				head : [ {
					text : "教育",
					id : "教育"
				}, {
					text : "石油化工",
					id : "石油化工"
				}, {
					text : "石化设计",
					id : "石化设计"
				}, {
					text : "化工机械",
					id : "化工机械"
				}, {
					text : "特种设备",
					id : "特种设备"
				}, {
					text : "化工",
					id : "化工"
				}, {
					text : "电气安全",
					id : "电气安全"
				}, {
					text : "职业卫生",
					id : "职业卫生"
				}, {
					text : "安全工程",
					id : "安全工程"
				}, {
					text : "机械",
					id : "机械"
				}, {
					text : "海事",
					id : "海事"
				}, {
					text : "港口安全",
					id : "港口安全"
				}, {
					text : "船舶机械",
					id : "船舶机械"
				}, {
					text : "气象",
					id : "气象"
				}, {
					text : "气候预测",
					id : "气候预测"
				}, {
					text : "防雷",
					id : "防雷"
				}, {
					text : "中医",
					id : "中医"
				}, {
					text : "外科",
					id : "外科"
				}, {
					text : "中西医结合",
					id : "中西医结合"
				}, {
					text : "普外科",
					id : "普外科"
				}, {
					text : "应急管理",
					id : "应急管理"
				}, {
					text : "石化规划",
					id : "石化规划"
				}, {
					text : "土木建筑",
					id : "土木建筑"
				}, {
					text : "通讯类",
					id : "通讯类"
				}, {
					text : "兽医",
					id : "兽医"
				}, {
					text : "医疗",
					id : "医疗"
				}, {
					text : "石油储运",
					id : "石油储运"
				}, {
					text : "危化运输",
					id : "危化运输"
				}, {
					text : "皮肤科",
					id : "皮肤科"
				}, {
					text : "消化内",
					id : "消化内"
				}, {
					text : "呼吸内",
					id : "呼吸内"
				}, {
					text : "骨外科",
					id : "骨外科"
				}, {
					text : "心内科",
					id : "心内科"
				}, {
					text : "内分泌",
					id : "内分泌"
				}, {
					text : "泌尿外",
					id : "泌尿外"
				}, {
					text : "急诊内",
					id : "急诊内"
				}, {
					text : "眼科",
					id : "眼科"
				}, {
					text : "妇产科",
					id : "妇产科"
				}, {
					text : "护理",
					id : "护理"
				}, {
					text : "临床医学",
					id : "临床医学"
				}, {
					text : "岩土",
					id : "岩土"
				}]
			};
		var ex_Job1 = $("#ex_Job1").val();
		var ex_Job = $("#ex_Job");
		$("<option value=''>请选择</option>").appendTo(ex_Job);
		for (var i = 0, h = job.head.length; i < h; i++) {
			if(job.head[i].id == ex_Job1){
				$("<option value='" + job.head[i].id + "' selected='selected'>" + job.head[i].text + "</option>").appendTo(ex_Job);
			}else{
				$("<option value='" + job.head[i].id + "'>" + job.head[i].text + "</option>").appendTo(ex_Job);
			}
		}
		
		var jobtitle = {
				head : [ {
					text : "无",
					id : "无"
				}, {
					text : "初级",
					id : "初级"
				}, {
					text : "中级",
					id : "中级"
				}, {
					text : "高级",
					id : "高级"
				}, {
					text : "助理工程师",
					id : "助理工程师"
				}, {
					text : "工程师",
					id : "工程师"
				}, {
					text : "高级工程师",
					id : "高级工程师"
				}, {
					text : "高级工程师",
					id : "高级工程师"
				}, {
					text : "讲师",
					id : "讲师"
				}, {
					text : "副教授",
					id : "副教授"
				}, {
					text : "教授",
					id : "教授"
				}, {
					text : "博士",
					id : "博士"
				}, {
					text : "副主任医师",
					id : "副主任医师"
				}, {
					text : "主治医师",
					id : "主治医师"
				}, {
					text : "主管医师",
					id : "主管医师"
				}, {
					text : "研究员",
					id : "研究员"
				}, {
					text : "教高",
					id : "教高"
				}, {
					text : "副高",
					id : "副高"
				}, {
					text : "正科",
					id : "正科"
				}, {
					text : "技术员",
					id : "技术员"
				}, {
					text : "兽医师",
					id : "兽医师"
				}, {
					text : "高级兽医师",
					id : "高级兽医师"
				}, {
					text : "副主任护师",
					id : "副主任护师"
				}, {
					text : "主管护师",
					id : "主管护师"
				}, {
					text : "技师",
					id : "技师"
				}, {
					text : "高级农艺师",
					id : "高级农艺师"
				}, {
					text : "药师",
					id : "药师"
				}, {
					text : "卫生主管技师",
					id : "卫生主管技师"
				}]
			};
		var ex_Jobtitle1 = $("#ex_Jobtitle1").val();
		var ex_Jobtitle = $("#ex_Jobtitle");
		$("<option value=''>请选择</option>").appendTo(ex_Jobtitle);
		for (var i = 0, h = jobtitle.head.length; i < h; i++) {
			if(jobtitle.head[i].id == ex_Jobtitle1){
				$("<option value='" + jobtitle.head[i].id + "' selected='selected'>" + jobtitle.head[i].text + "</option>").appendTo(ex_Jobtitle);
			}else{
				$("<option value='" + jobtitle.head[i].id + "'>" + jobtitle.head[i].text + "</option>").appendTo(ex_Jobtitle);
			}
		}
		
		var position = {
				head : [ {
					text : "副所长",
					id : "副所长"
				}, {
					text : "所长",
					id : "所长"
				}, {
					text : "副经理",
					id : "副经理"
				}, {
					text : "经理",
					id : "经理"
				}, {
					text : "副总经理",
					id : "副总经理"
				}, {
					text : "总经理助理",
					id : "总经理助理"
				}, {
					text : "总经理",
					id : "总经理"
				}, {
					text : "工程师",
					id : "工程师"
				}, {
					text : "副总工程师",
					id : "副总工程师"
				}, {
					text : "总工程师",
					id : "总工程师"
				}, {
					text : "常务副会长",
					id : "常务副会长"
				}, {
					text : "安全员",
					id : "安全员"
				}, {
					text : "安全总监",
					id : "安全总监"
				}, {
					text : "副院长",
					id : "副院长"
				}, {
					text : "院长助理",
					id : "院长助理"
				}, {
					text : "院长",
					id : "院长"
				}, {
					text : "科主任",
					id : "科主任"
				}, {
					text : "系主任",
					id : "系主任"
				}, {
					text : "副理事长",
					id : "副理事长"
				}, {
					text : "理事长",
					id : "理事长"
				}, {
					text : "副主席",
					id : "副主席"
				}, {
					text : "主席",
					id : "主席"
				}, {
					text : "副教授",
					id : "副教授"
				}, {
					text : "教授",
					id : "教授"
				}, {
					text : "党委书记",
					id : "党委书记"
				}, {
					text : "科长",
					id : "科长"
				}, {
					text : "处长",
					id : "处长"
				}, {
					text : "部长",
					id : "部长"
				}, {
					text : "副台长",
					id : "副台长"
				}, {
					text : "台长",
					id : "台长"
				}, {
					text : "副局长",
					id : "副局长"
				}, {
					text : "局长",
					id : "局长"
				}, {
					text : "安全环保主管",
					id : "安全环保主管"
				}, {
					text : "保全员",
					id : "保全员"
				}, {
					text : "保安队副队长",
					id : "保安队副队长"
				}, {
					text : "保安队队长",
					id : "保安队队长"
				}, {
					text : "循环水、灌装工段长",
					id : "循环水、灌装工段长"
				}, {
					text : "消防员",
					id : "消防员"
				}, {
					text : "消防队长",
					id : "消防队长"
				}, {
					text : "维修工",
					id : "维修工"
				}, {
					text : "技术员",
					id : "技术员"
				}, {
					text : "第一替补组长",
					id : "第一替补组长"
				}, {
					text : "班长",
					id : "班长"
				}, {
					text : "处长助理",
					id : "处长助理"
				}, {
					text : "监管科科长",
					id : "监管科科长"
				}, {
					text : "执法大队副队长",
					id : "执法大队副队长"
				}, {
					text : "执法大队队长",
					id : "执法大队队长"
				}, {
					text : "小组长",
					id : "小组长"
				}, {
					text : "科员",
					id : "科员"
				}, {
					text : "总监",
					id : "总监"
				}, {
					text : "副队长",
					id : "副队长"
				}, {
					text : "队长",
					id : "队长"
				}, {
					text : "副大队长",
					id : "副大队长"
				}, {
					text : "大队长",
					id : "大队长"
				}, {
					text : "副主任",
					id : "副主任"
				}, {
					text : "主任",
					id : "主任"
				}, {
					text : "副站长",
					id : "副站长"
				}, {
					text : "站长",
					id : "站长"
				}, {
					text : "评价员",
					id : "评价员"
				}, {
					text : "生产主管",
					id : "生产主管"
				}, {
					text : "医师",
					id : "医师"
				}, {
					text : "副主任医师",
					id : "副主任医师"
				}, {
					text : "主任医师",
					id : "主任医师"
				}, {
					text : "律师",
					id : "律师"
				}, {
					text : "副调研员",
					id : "副调研员"
				}, {
					text : "调研员",
					id : "调研员"
				}, {
					text : "护师",
					id : "护师"
				}, {
					text : "监察大队队长",
					id : "监察大队队长"
				}, {
					text : "股长",
					id : "股长"
				}, {
					text : "干部",
					id : "干部"
				}, {
					text : "党组成员",
					id : "党组成员"
				}, {
					text : "副主任科员",
					id : "副主任科员"
				}, {
					text : "墙改办主任",
					id : "墙改办主任"
				}, {
					text : "预报股长",
					id : "预报股长"
				}]
			};
		var ex_Position1 = $("#ex_Position1").val();
		var ex_Position = $("#ex_Position");
		$("<option value=''>请选择</option>").appendTo(ex_Position);
		for (var i = 0, h = position.head.length; i < h; i++) {
			if(position.head[i].id == ex_Position1){
				$("<option value='" + position.head[i].id + "' selected='selected'>" + position.head[i].text + "</option>").appendTo(ex_Position);
			}else{
				$("<option value='" + position.head[i].id + "'>" + position.head[i].text + "</option>").appendTo(ex_Position);
			}
		}
		
		
	
	
});
	
</script>
</head>
<style type="text/css">
textarea {
	resize: none;
}
</style>
<body>
<form id="expertEditForm" class="form-horizontal" role="form">
<input type="hidden" name="ex_Id" value="${expert.ex_Id }"/>
		<fieldset style="margin-top: 15px">
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Typeid"><span style="color:red">* </span>专家类型</label>
				<div class="col-sm-2 input-message">
					<input type="hidden" id="typeId" name="ex_Typeid" value="${expert.ex_Typeid.ext_Id}"/> <input
						class="form-control" name="typeName" id="typeName" type="text" value="${expert.ex_Typeid.ext_Name}"
						onclick="select_type();" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-1 control-label" for="ex_Name"><span style="color:red">* </span>专家姓名</label>
				<div class="col-sm-2 input-message">
					<input class="form-control" id="ex_Name" name="ex_Name" type="text" value="${expert.ex_Name}" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-1 control-label" for="ex_Sex">性别</label>
				<div class="col-sm-2">
					<input type="radio" name="ex_Sex" value="1" <c:if test="${expert.ex_Sex=='1' }">checked="checked"</c:if>/>男
				    <input type="radio" name="ex_Sex" value="0" <c:if test="${expert.ex_Sex=='0' }">checked="checked"</c:if>/>女
				</div>
				<label class="col-sm-1 control-label" for="ex_Borndate">出生日期</label>
				<div class="col-sm-2">
					<div class='input-group'>
						<input class="form-control" id="ex_Borndate" name="ex_Borndate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${expert.ex_Borndate}"/>"
							type="text" /><span
							class="input-group-addon"> <span
							class="glyphicon glyphicon-calendar"></span>
						</span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Nativeplace">籍贯</label>
				<div class="col-sm-2">
					<input class="form-control" id="ex_Nativeplace"
						name="ex_Nativeplace" type="text" value="${expert.ex_Nativeplace}"/>
				</div>
				<label class="col-sm-1 control-label" for="ex_Nationality">民族</label>
				<div class="col-sm-2">
					<input type="hidden" id="ex_Nationality1" value="${expert.ex_Nationality }"/>
						<select class="form-control" id="ex_Nationality" name="ex_Nationality"></select> 
				</div>
				<label class="col-sm-1 control-label" for="ex_Idcard">身份证号</label>
				<div class="col-sm-2">
					<input class="form-control" id="ex_Idcard" name="ex_Idcard"
						type="text" value="${expert.ex_Idcard}"/>
				</div>
				<label class="col-sm-1 control-label" for="ex_Politicalstatus">政治面貌</label>
				<div class="col-sm-2">
					<input type="hidden" id="ex_Politicalstatus1" value="${expert.ex_Politicalstatus }"/>
						<select class="form-control" id="ex_Politicalstatus" name="ex_Politicalstatus"></select> 
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Graduateschool">毕业院校</label>
				<div class="col-sm-2">
					<input class="form-control" id="ex_Graduateschool"
						name="ex_Graduateschool" type="text" value="${expert.ex_Graduateschool}"/>
				</div>
				<label class="col-sm-1 control-label" for="ex_Graduatetime">毕业时间</label>
				<div class="col-sm-2">
					<div class='input-group'>
						<input class="form-control" id="ex_Graduatetime" name="ex_Graduatetime" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${expert.ex_Graduatetime}"/>"
							type="text" /><span
							class="input-group-addon"> <span
							class="glyphicon glyphicon-calendar"></span>
						</span>
					</div>
				</div>
				<label class="col-sm-1 control-label" for="ex_Professional">毕业专业</label>
				<div class="col-sm-2">
					<input type="hidden" id="ex_Professional1" value="${expert.ex_Professional }"/>
						<select class="form-control" id="ex_Professional" name="ex_Professional"></select> 
				</div>
				<label class="col-sm-1 control-label" for="ex_Degree">最高学历</label>
				<div class="col-sm-2">
					<input type="hidden" id="ex_Degree1" value="${expert.ex_Degree }"/>
						<select class="form-control" id="ex_Degree" name="ex_Degree"></select> 
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Workdate">参加工作日期</label>
				<div class="col-sm-2">
					<div class='input-group'>
						<input class="form-control" id="ex_Workdate" name="ex_Workdate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${expert.ex_Workdate}"/>"
							type="text" /><span
							class="input-group-addon"> <span
							class="glyphicon glyphicon-calendar"></span>
						</span>
					</div>
				</div>
				<label class="col-sm-1 control-label" for="ex_Foreignlanguage">外语</label>
				<div class="col-sm-2">
					<input type="hidden" id="ex_Foreignlanguage1" value="${expert.ex_Foreignlanguage }"/>
						<select class="form-control" id="ex_Foreignlanguage" name="ex_Foreignlanguage"></select> 
				</div>
				<label class="col-sm-1 control-label" for="ex_Maritalstatus">婚姻状态</label>
				<div class="col-sm-2">
					<select class="form-control" name="ex_Maritalstatus" id="ex_Maritalstatus"
						value="${expert.ex_Maritalstatus}">
						<option value="0"
							<c:if test="${expert.ex_Maritalstatus=='0' }">selected="selected"</c:if>>未婚</option>
						<option value="1"
							<c:if test="${expert.ex_Maritalstatus=='1' }">selected="selected"</c:if>>已婚</option>
						<option value="2"
							<c:if test="${expert.ex_Maritalstatus=='2' }">selected="selected"</c:if>>离异</option>
					</select>
				</div>
				<label class="col-sm-1 control-label" for="ex_Healthstatus">健康状态</label>
				<div class="col-sm-2">
					<input class="form-control" id="ex_Healthstatus"
						name="ex_Healthstatus" type="text" value="${expert.ex_Healthstatus}"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Deptid"><span style="color:red">* </span>所属单位</label>
				<div class="col-sm-2 input-message">
					<input type="hidden" id="organId" name="ex_Deptid" value="${expert.ex_Deptid.or_id}"/> <input
						class="form-control" name="organName" id="organName" type="text" value="${expert.ex_Deptid.or_name}"
						onclick="select_organ();" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-1 control-label" for="ex_Depttype">单位性质</label>
				<div class="col-sm-2">
					<select class="form-control" name="ex_Depttype" id="ex_Depttype"
						value="${expert.ex_Depttype}">
						<option value="0"
							<c:if test="${expert.ex_Depttype=='0' }">selected="selected"</c:if>>国营</option>
						<option value="1"
							<c:if test="${expert.ex_Depttype=='1' }">selected="selected"</c:if>>民营</option>
						<option value="2"
							<c:if test="${expert.ex_Depttype=='2' }">selected="selected"</c:if>>合资</option>
						<option value="2"
							<c:if test="${expert.ex_Depttype=='3' }">selected="selected"</c:if>>集体</option>
					</select>
				</div>
				<label class="col-sm-1 control-label" for="ex_Job">从事职业</label>
				<div class="col-sm-2">
					<input type="hidden" id="ex_Job1" value="${expert.ex_Job }"/>
						<select class="form-control" id="ex_Job" name="ex_Job"></select> 
				</div>
				<label class="col-sm-1 control-label" for="ex_Jobtitle">职称</label>
				<div class="col-sm-2">
					<input type="hidden" id="ex_Jobtitle1" value="${expert.ex_Jobtitle }"/>
						<select class="form-control" id="ex_Jobtitle" name="ex_Jobtitle"></select> 
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Position">职位</label>
				<div class="col-sm-2">
						<input type="hidden" id="ex_Position1" value="${expert.ex_Position }"/>
						<select class="form-control" id="ex_Position" name="ex_Position"></select> 
				</div>
				<label class="col-sm-1 control-label" for="ex_Email">Email</label>
				<div class="col-sm-2">
					<input class="form-control" id="ex_Email" name="ex_Email"
						type="text" value="${expert.ex_Email}"/>
				</div>
				<label class="col-sm-1 control-label" for="ex_Registeplace">户口所在地</label>
				<div class="col-sm-2">
					<input class="form-control" id="ex_Registeplace"
						name="ex_Registeplace" type="text" value="${expert.ex_Registeplace}"/>
				</div>
				<label class="col-sm-1 control-label" for="ex_Postcode">邮编</label>
				<div class="col-sm-2">
					<input class="form-control" id="ex_Postcode" name="ex_Postcode"
						type="text" value="${expert.ex_Postcode}"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Longitude">经度</label>
				<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="ex_Longitude"
							value="${expert.ex_Longitude}" type="text" placeholder="经度" />
					</div>
				</div>
				<label class="col-sm-1 control-label" for="ex_Latitude">纬度</label>
				<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="ex_Latitude"
							value="${expert.ex_Latitude}" type="text" placeholder="纬度" />
					</div>
				</div>
				<label class="col-sm-1 control-label" for="ex_Linkaddress">联系地址</label>
				<div class="col-sm-5">
					<input class="form-control" id="ex_Linkaddress"
						name="ex_Linkaddress" type="text" value="${expert.ex_Linkaddress}"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Familyaddress">家庭住址</label>
				<div class="col-sm-5 ">
					<input class="form-control" id="ex_Familyaddress"
						name="ex_Familyaddress" type="text" value="${expert.ex_Familyaddress}"/>
				</div>
				<label class="col-sm-1 control-label" for="ex_Speciality">特长</label>
				<div class="col-sm-5">
					<input class="form-control" id="ex_Speciality" name="ex_Speciality"
						type="text" value="${expert.ex_Speciality}"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Describe">个人描述</label>
				<div class="col-sm-5">
					<textarea class="form-control" rows="3" id="ex_Describe"
						name="ex_Describe" value="${expert.ex_Describe}"/></textarea>
				</div>
				<label class="col-sm-1 control-label" for="ex_Rewardpunish">奖惩情况</label>
				<div class="col-sm-5">
					<textarea class="form-control" rows="3" id="ex_Rewardpunish"
						name="ex_Rewardpunish" value="${expert.ex_Rewardpunish}"/></textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="ex_Achievement">技术成果</label>
				<div class="col-sm-5">
					<textarea class="form-control" rows="3" id="ex_Achievement"
						name="ex_Achievement" value="${expert.ex_Achievement}"/></textarea>
				</div>
				<label class="col-sm-1 control-label" for="ex_Remark">备注</label>
				<div class="col-sm-5">
					<textarea class="form-control" rows="3" id="ex_Remark"
						name="ex_Remark" value="${expert.ex_Remark}"/></textarea>
				</div>
			</div>
		</fieldset>
	</form>

	<div class="modal-footer">
		<button type="button" class="btn btn-default" onclick="back();">返回</button>
		<button type="submit" class="btn btn-primary" id="expertEditBtn" onclick="edit();">编辑</button>
	</div>
	<span id="msgdemo2" style="margin-left:30px;"></span>
	<script type="text/javascript"
		src="jsp/resource/expert/js/expert_cu.js"></script>
</body>
</html>