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
<title>处置过程</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 10px;">
			<div>
				<button name="btn-disposal" class="btn btn-primary" onclick="disposal1(this);">1、需报对象</button>
				&nbsp;→&nbsp;
				<button name="btn-disposal" class="btn btn-defalut" onclick="disposal2(this);">2、通知对象</button>
				&nbsp;→&nbsp;
				<button name="btn-disposal" class="btn btn-defalut" onclick="disposal3(this);">3、通报对象</button>
				&nbsp;→&nbsp;
				<button name="btn-disposal" class="btn btn-defalut" onclick="disposal4(this);">4、选择预案</button>
			</div>
			<div id="disposalLoad">
			
			<table class="table table-bordered">
				<tr>
					<th>姓名</th>
					<th>岗位</th>
					<th>应急人员</th>
					<th>办公电话</th>
					<th>手机</th>
					<th>住宅电话</th>
					<th>邮箱</th>
					<th>操作</th>
				</tr>
				<tbody id="person_data">

				</tbody>
			</table>
			</div>
			
			<div>
			<form id="event_backinfoform" class="form-horizontal" role="form">
			<input type="hidden" name="eventId" value="${param.evId}"/>
			<textarea id="backContent" name="content" rows="4" cols="100"></textarea>
			<input type="button" id="event_backinfoBtnAdd" class="btn btn-primary" value="反馈保存" onclick="event_backinfoSave();"/>
			</form>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$(function() {
		disposal1('');
    });
	function disposal1(the){
		disposalcss(the);
		$("#disposalLoad").empty();
		var str = '';
		str +="<table class='table table-bordered'>";
		str +="<tr>";
		str +="	<th>姓名</th>";
		str +="	<th>岗位</th>";
		str +="	<th>应急人员</th>";
		str +="	<th>办公电话</th>";
		str +="	<th>手机</th>";
		str +="	<th>住宅电话</th>";
		str +="	<th>邮箱</th>";
		str +="	<th>操作</th>";
		str +="</tr>";
		str +="<tbody id='person_data'></tbody></table>";
		$("#disposalLoad").append(str);
		$.post('work/person/getLeader', {}, function(j) {
			datas(j);
		});
	}
	function disposalcss(the){
		if(the!=''){
			$("button[name='btn-disposal']").each(function (){
				if($(this)[0]==the){
					$(this).attr('class', 'btn btn-primary');
				}else{
					$(this).attr('class', 'btn btn-defalut');
				}
			});
		}
	}
	
	var setting = {
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onClick: zTreeOnClick
			}
	};
	function init(){
		$.post('work/organ/tree2', {}, function(j) {
			zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = treeObj.getNodes();
			treeObj.expandNode(nodes[0], true);
		});
	}
	function zTreeOnClick(event, treeId, treeNode, clickFlag) {
		$("#orid").val(treeNode.id);
		$.post('work/person/list', {orId:treeNode.id}, function(j) {
			datas(j);
		});
	}
	function datas(j){
		$("#person_data").empty();
		var str = '';
		for(var i=0;i<j.length;i++){
			str +="<tr>";
			str +="<td>"+j[i].pe_name+"</td>";
			if(j[i].pe_jobs!=undefined){
				str +="<td>"+j[i].pe_jobs+"</td>";
			}else{
				str +="<td></td>";
			}
			
			if(j[i].pe_type=='1'){
				str +="<td>是</td>";
			}else{
				str +="<td>否</td>";
			}
			if(j[i].officephone==undefined){
				str +="<td></td>";
			}else{
				//str +="<td><a onclick='parent.parent.callOut("+j[i].officephone+");' class='btn btn-link btn-xs'><i class='icon-phone'></i>"+j[i].officephone+"</td>";
				str +='<td><a onclick="parent.parent.callOut(\''+j[i].officephone+'\',${param.evId});" class="btn btn-link btn-xs"><i class="icon-phone"></i>'+j[i].officephone+'</td>';
			}
			if(j[i].mobilephone==undefined){
				str +="<td></td>";
			}else{
				//str +="<td>"+j[i].mobilephone+"</td>";
				str +='<td><a onclick="parent.parent.callOut(\''+j[i].mobilephone+'\',${param.evId});" class="btn btn-link btn-xs"><i class="icon-phone"></i>'+j[i].mobilephone+'</td>';
			}
			if(j[i].homephone==undefined){
				str +="<td></td>";
			}else{
				//str +="<td>"+j[i].homephone+"</td>";
				str +='<td><a onclick="parent.parent.callOut(\''+j[i].homephone+'\',${param.evId});" class="btn btn-link btn-xs"><i class="icon-phone"></i>'+j[i].homephone+'</td>';
			}
			if(j[i].email==undefined){
				str +="<td></td>";
			}else{
				str +="<td>"+j[i].email+"</td>";
			}
			str +="<td><input type='checkbox' name='selectPersons' value='"+j[i].pe_id+","+j[i].mobilephone+","+j[i].email+"'/></td>";
			str +="</tr>";
		}
		$("#person_data").append(str);
	}
	
	function disposalload(){
		$("#disposalLoad").empty();
		var str = '';
		str +="<div class='col-md-3'>";
		str +="<div id='person_treeview'>";
		str +="<ul id='treeDemo' class='ztree'></ul>";
		str +="</div>";
		str +="</div>";
		str +="<div id='page-wrapper' class='col-md-9' style='padding-left: 0px;'>";
		str +="<input type='hidden' id='orid'/>";
		str +="<table class='table table-bordered'>";
		str +="	<tr>";
		str +="		<th>姓名</th>";
		str +="		<th>岗位</th>";
		str +="		<th>应急人员</th>";
		str +="		<th>办公电话</th>";
		str +="		<th>手机</th>";
		str +="		<th>住宅电话</th>";
		str +="		<th>邮箱</th>";
		str +="		<th>操作</th>";
		str +="	</tr>";
		str +="	<tbody id='person_data'>";
		str +="	</tbody>";
		str +="</table>";
		str +="</div>";
		$("#disposalLoad").append(str);
	}
	function disposal2(the){
		disposalcss(the);
		disposalload();
		init();
	}
	function disposal3(the){
		disposalcss(the);
		disposalload();
		init();
	}
	function disposal4(the){
		disposalcss(the);
		$("#disposalLoad").empty();
		
		$.post('emeplan/planinfo/getplanByEvent', {eventTypeId:${param.eventTypeId},ev_level:${param.ev_level}}, function(j) {
			var str = '';
			str +="<table class='table table-bordered table-striped table-hover table-condensed'>";
			str +="<tr class='info'>";
			str +="	<th>名称</th>";
			str +="	<th>层级</th>";
			str +="	<th>版本号</th>";
			str +="	<th>发布日期</th>";
			str +="	<th>操作</th>";
			str +="</tr>";
			str +="<tbody>";
			
			for(var i=0;i<j.length;i++){
				if (i % 2 == 0) {
					str += "<tr style='background-color: #ebf8ff;'>";
					str +="<td>"+j[i].pi_name+"</td>";
					if(j[i].pi_level=='1'){
						str +="<td>省</td>";
					}else if(j[i].pi_level=='2'){
						str +="<td>地市</td>";
					}else if(j[i].pi_level=='3'){
						str +="<td>区县</td>";
					}else if(j[i].pi_level=='4'){
						str +="<td>部门</td>";
					}else if(j[i].pi_level=='5'){
						str +="<td>企业</td>";
					}
					
					str +="<td>"+j[i].pi_no+"</td>";
					str +="<td>"+formatDatebox(j[i].pi_createDate)+"</td>";
					
					str +="<td><a href='javascript:void(0);' class='btn btn-primary btn-xs main_tabs' onclick='openPlanManage(this);' url='emeplan/manage/main?pi_id="+j[i].pi_id+"' title='预案综合' class='thumbnail'>查看</a></td>";
					str +="</tr>";
				}else{
					str +="<tr>";
					str +="<td>"+j[i].pi_name+"</td>";
					if(j[i].pi_level=='1'){
						str +="<td>省</td>";
					}else if(j[i].pi_level=='2'){
						str +="<td>地市</td>";
					}else if(j[i].pi_level=='3'){
						str +="<td>区县</td>";
					}else if(j[i].pi_level=='4'){
						str +="<td>部门</td>";
					}else if(j[i].pi_level=='5'){
						str +="<td>企业</td>";
					}
					
					str +="<td>"+j[i].pi_no+"</td>";
					str +="<td>"+formatDatebox(j[i].pi_createDate)+"</td>";
					
					str +="<td><a href='javascript:void(0);' class='btn btn-primary btn-xs main_tabs' onclick='openPlanManage(this);' url='emeplan/manage/main?pi_id="+j[i].pi_id+"' title='预案综合' class='thumbnail'>查看</a></td>";
					str +="</tr>";
				}
			}
			
			str +="</tbody>";
			str +="</table>";
			$("#disposalLoad").append(str);
		});
	}
	
	function openPlanManage(the){
		parent.tabs_open(the);
	}
    function save(index, window) {
	    $.post('event/eventproc/save', $('#eventProcessForm').serialize(), function(result) {
		    if(result.success) {
			    parent.layer.close(index);
		    } else {
		    	parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
		    }
	    });
    }
    function event_backinfoSave() {
    	$("#event_backinfoBtnAdd").html("正在提交中。。。");
		$("#event_backinfoBtnAdd").attr("disabled","disabled");
	    $.post('event/eventinfo/backinfo', $('#event_backinfoform').serialize(), function(j) {
		    if(j.success) {
			    $("#backContent").val("");
		    }
		    $("#event_backinfoBtnAdd").html("反馈保存");
    		$("#event_backinfoBtnAdd").attr("disabled",false);
		    parent.layer.msg(j.msg, {
				offset : 0,
				shift : 6
			});
	    });
    }

    function promptSMSForm(pe_id) {
	    $("#pe_id").val(pe_id);
	    $.post('event/eventproc/smsform', $('#organPersonForm').serialize() + '&'
	                                         + $('#eventProcessForm').serialize(), function(result) {
		        if(result.success) {
			        parent.layer.open({
			            type : 2,
			            title : '发送短信',
			            area : ['600px', '480px'],
			            scrollbar : false,
			            content : ['jsp/event/eventproc/eventproc_smsform.jsp', 'no'],
			            btn : ['发送', '取消'],
			            yes : function(index, layero) {
				            //layero.find('iframe')[0].contentWindow.reply(index, window);
			            }
			        });
		        } else {
		        	parent.layer.msg(j.msg, {
					    offset: 0,
					    shift: 6
					});
		        }
	        });
    }
    
    function forwardTo(url) {
    	url = "<%=request.getContextPath()%>" + "/" + url;
	    window.location.href = url;
    }
</script>
</body>
</html>