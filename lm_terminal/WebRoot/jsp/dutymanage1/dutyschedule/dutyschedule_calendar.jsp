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
<title>值班排班</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="js/fullcalendar/fullcalendar.min.css" />
<link rel="stylesheet" href="lauvanUI/bootstrap-fileinput/css/fileinput.min.css" />
<link rel="stylesheet" href="lauvanUI/layer/skin/layer.css" type="text/css"></link>
<script src="js/fullcalendar/jquery-ui.custom.min.js"></script>
<script src="js/fullcalendar/moment.min.js"></script>
<script src="js/fullcalendar/fullcalendar.min.js"></script>
<script src="js/fullcalendar/lang-all.js"></script>
<!--[if lt IE 9]>
	<script src="js/html5shiv.min.js"></script>
<![endif]-->
<script src="lauvanUI/layer/layer.js"></script>
<style type="text/css">
.external-event {
	height: 35px; vertical-align: baseline; padding-top: 7px; padding-right: 10px; padding-top: 7px;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 25px;">
			<div class="page-content">
				<div class="row">
					<div class="col-sm-3">
						<div class="widget-box transparent">
							<div class="widget-header">
								上级领导<input type="radio" name="duty_ifleader" value="0" checked="checked"/>否<input type="radio" name="duty_ifleader" value="1"/>是
								<button type="button" class="btn btn-primary" onclick="scheduleReport();">导出报表</button>
							</div>
							<div class="widget-body">
								<label class="control-label">
									<h4>排班模板</h4>
								</label>
								<div class="widget-main no-padding">
									<div id="external-events"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-9">
						<div id="calendar"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
var calendar;
$(function() {
    setScheduleTemplates();
    calendar = $('#calendar').fullCalendar({
        lang : 'zh-cn',
        defaultDate: new Date(),
        aspectRatio : 1.65,
        editable : true,
        droppable : true,
        selectable : true,
        selectHelper : true,
        
        header : {
            left : 'prevYear, prev, today, next, nextYear',
            center : 'title',
            right : 'month, agendaWeek, agendaDay'
        },
        events : function(start, end, timezone, callback) {
	        $.post("dutymanage/dutyschedule1/list",{start:new Date(start).format('yyyy-MM-dd'),end:new Date(end).format('yyyy-MM-dd')}, function(result) {
		        if(result) {
			        var schedules = [];
			        for(var i = 0; i < result.length; i++) {
				        var vo = result[i],prop="",color='',leader='';
				        if(vo.duty_prop=='1'){
				        	prop = "带班领导";
				        	color = '#257e4a';
				        }else if(vo.duty_prop=='2'){
				        	prop = "值班领导";
				        	color = '#D8BFD8';
				        }else{
				        	prop = "值班干部";
				        }
				        
				        if(vo.duty_ifleader == '1'){
				        	leader = "上级";
				        	color = "#FFB6C1";
				        }
				        schedules.push({
				        	duty_id : vo.duty_id,
				            pe_id : vo.person.pe_id,
				            duty_prop : vo.duty_prop,
				            duty_type : vo.duty_type,
				            title : vo.person.pe_name+' '+prop+' '+leader,
				            start : formatDatebox(vo.duty_date),
				            className : 'label-success',
				            color: color
				        });
			        }
			        callback(schedules);
		        }
	        });
        },
        eventDrop : function(event,dayDelta,minuteDelta,allDay,revertFunc) {
	        $.post('dutymanage/dutyschedule1/edit', {
	        	duty_id : event.duty_id,
	        	days : dayDelta._days
	        }, function(j) {
		        if(!j.success) {
			        revertFunc();
			        parent.layer.msg(j.msg, {
					    offset: 0,
					    shift: 6
					});
		        }
	        });
        },
        
        select : function(start, end, resource) {
	        promptAddForm(new Date(start).format("yyyy-MM-dd"));
        },
        
        eventClick : function(calEvent, jsEvent, view) {
	        promptEditForm(calEvent.duty_id);
        },
        drop : function(date, jsEvent, ui, resourceId) {
	        var _eventObj = $(this).data('eventObject');
	        
	        var $eventClass = $(this).attr('data-class');
	        var eventObj = $.extend({}, _eventObj);
	        
	        eventObj.start = date;
	        if($eventClass) {
		        eventObj.className = [$eventClass];
	        }
	        $.post('dutymanage/dutyschedule1/addDrop', {
	        	duty_id : eventObj.duty_id,
	            duty_date : formatDatebox(date)
	        }, function(j) {
		        if(j.success) {
			        calendar.fullCalendar('refetchEvents');
		        } else {
			        parent.layer.msg(result.msg, {
					    offset: 0,
					    shift: 6
					});
		        }
	        });
        }
    });
});

function scheduleReport(){
	var view = calendar.fullCalendar('getView');
	console.info(view);
	console.info(new Date(view.start).format('yyyy-MM-dd'));
	console.info(new Date(view.end).format('yyyy-MM-dd'));
	var duty_ifleader = $("input[name='duty_ifleader']:checked").val();
	console.info(duty_ifleader);
	window.open('<%=basePath%>'+"dutymanage/dutyschedule1/reportOut?start="+new Date(view.start).format('yyyy-MM-dd')+"&end="
			+new Date(view.end).format('yyyy-MM-dd')+"&duty_ifleader="+duty_ifleader);
}
	function promptAddForm(duty_date) {
	    parent.layer.open({
	        type : 2,
	        title : '新增值班排班',
	        area:['800px','300px'],
	        scrollbar : false,
	        content : ['jsp/dutymanage1/dutyschedule/dutyschedule_add.jsp?duty_date=' + duty_date, 'no'],
	        btn : ['保存', '取消'],
	        yes : function(index, layero) {
		        layero.find('iframe')[0].contentWindow.dutyScheduleSave(index, window);
	        }
	    });
    }

    function promptEditForm(duty_id) {
	    parent.layer.open({
	        type : 2,
	        title : '修改值班排班',
	        area:['800px','300px'],
	        scrollbar : false,
	        content : ['dutymanage/dutyschedule1/editip?id='+duty_id, 'no'],
	        btn : ['保存', '取消', '删除'],
	        yes : function(index, layero) {
		        layero.find('iframe')[0].contentWindow.dutyScheduleEdit(index, window);
	        },
	        btn3 : function(index, layero) {
		        return layero.find('iframe')[0].contentWindow.dutyScheduleDelete(index, window);
	        }
	    });
    }

    function deleteScheduleTemp(id) {
	    parent.layer.confirm('您确定要取消该模板么？', function(index){
			$.post('dutymanage/dutyschedule1/tempoff',{id:id}, function(j) {
				if(j.success){
					$("#tempDelete"+id).remove();
				}
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
				parent.layer.close(index);
			}, 'json');
		});
    }

    function setScheduleTemplates() {
	    $.post("dutymanage/dutyschedule1/listtemp", {}, function(result) {
		        if(result) {
			        var tmplHtml = '';
			        for(var i = 0; i < result.length; i++) {
				        var vo = result[i],prop="",color='',leader='';
				        if(vo.duty_prop=='1'){
				        	prop = "带班领导";
				        }else if(vo.duty_prop=='2'){
				        	prop = "值班领导";
				        }else{
				        	prop = "值班干部";
				        }
				        if(vo.duty_ifleader == '1'){
				        	leader = "(上级)";
				        	color = "#FFB6C1";
				        }
				        tmplHtml += '<div style="background-color: '+color+'" id="tempDelete'+ vo.duty_id+ '" prop="'+ vo.duty_id+ '" class="external-event label-success" data-class="label-success"><i class="icon-flag"></i> '
				                    + vo.person.pe_name + ' (' + prop + ')'+ leader
				                    + ' <a href="javascript:void(0);" onclick="deleteScheduleTemp('+ vo.duty_id+ ');"><i style="float:right;cursor: pointer;" class="icon-trash"></i></a></div><br>';
			        }
			        
			        $("#external-events").html(tmplHtml);
			        
			        $('#external-events .external-event').each(function(i, div) {
				        var ss = $(div).attr("prop");
				        var eventObject = {
				            title : $.trim($(this).text()),
				            duty_id : ss
				        };
				        $(this).data('eventObject', eventObject);
				        $(this).draggable({
				            zIndex : 999,
				            revert : true,
				            revertDuration : 0
				        });
			        });
		        }
	        });
    }

    
</script>