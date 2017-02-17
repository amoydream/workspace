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
<script src="lauvanUI/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="lauvanUI/bootstrap-fileinput/js/fileinput_locale_zh.js"></script>
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
								<input type="file" id="dutyScheduleFile" name="dutyScheduleFile">
							</div>
							<!-- <div class="widget-header">
                        <h4>排班模板</h4>
                     </div> -->
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
	function promptAddForm(duty_date) {
	    parent.layer.open({
	        type : 2,
	        title : '新增值班排班',
	        area : ['480px', '640px'],
	        scrollbar : false,
	        content : ['dutymanage/dutyschedule/addform/' + duty_date, 'no'],
	        btn : ['保存', '取消'],
	        yes : function(index, layero) {
		        layero.find('iframe')[0].contentWindow.dutyScheduleSave(index, window);
	        }
	    });
    }

    function promptEditForm(duty_sch_id) {
	    parent.layer.open({
	        type : 2,
	        title : '修改值班排班',
	        area : ['480px', '640px'],
	        scrollbar : false,
	        content : ['dutymanage/dutyschedule/editform/' + duty_sch_id, 'no'],
	        btn : ['保存', '取消', '删除'],
	        yes : function(index, layero) {
		        layero.find('iframe')[0].contentWindow.dutyScheduleUpdate(index, window);
	        },
	        btn3 : function(index, layero) {
		        return layero.find('iframe')[0].contentWindow.dutyScheduleDelete(index, window);
	        }
	    });
    }

    function deleteScheduleTmpl(i) {
	    var div = $(i).parent()[0];
	    var tmpl_id = div.id.split('-')[0];
	    $.post("dutymanage/dutyschedule/deletetmpl/" + tmpl_id, {}, function(result) {
		    if(result.success) {
			    $(div).remove();
		    }
	    });
    }

    function setScheduleTemplates() {
	    $.post("dutymanage/dutyschedule/templates", {}, function(result) {
		        if(result) {
			        var tmplHtml = '';
			        for(var i = 0; i < result.length; i++) {
				        var vo = result[i];
				        tmplHtml += '<div id="'
				                    + [vo.duty_sch_tmpl_id, vo.pe_id, vo.duty_prop, vo.duty_type].join('-')
				                    + '" class="external-event label-success" data-class="label-success"><i class="icon-flag"></i> '
				                    + vo.pe_name
				                    + ' ('
				                    + vo.duty_prop_desc
				                    + ')'
				                    + ' <i style="float:right;" class="icon-trash" onclick="deleteScheduleTmpl(this);"></i></div><br>';
			        }
			        
			        $("#external-events").html(tmplHtml);
			        
			        $('#external-events div.external-event').each(function(i, div) {
				        var ss = div.id.split('-');
				        var eventObject = {
				            title : $.trim($(this).text()),
				            pe_id : ss[1],
				            duty_prop : ss[2],
				            duty_type : ss[3]
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

    $(function() {
	    $("#dutyScheduleFile").fileinput({
	        showPreview : false,
	        initialCaption : "导入值班排班",
	        allowedFileExtensions : ["xls", "xlsx"],
	        maxFileSize : 1024,
	        browseClass : "btn btn-success",
	        browseLabel : "浏览",
	        browseIcon : "<i class=\"icon-excel\"></i> ",
	        removeClass : "btn btn-danger",
	        removeLabel : "清除",
	        removeIcon : "<i class=\"icon-trash\"></i> ",
	        uploadClass : "btn btn-info",
	        uploadLabel : "导入",
	        uploadIcon : "<i class=\"icon-upload\"></i> ",
	    });
	    
	    setScheduleTemplates();
	    
	    var date = new Date();
	    var dd = date.getDate();
	    var mm = date.getMonth();
	    var yyyy = date.getFullYear();
	    
	    var calendar = $('#calendar').fullCalendar({
	        lang : 'zh-cn',
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
		        $.post("dutymanage/dutyschedule/retrieve", {
		            duty_date_start : new Date(start).format('yyyy-MM-dd'),
		            duty_date_end : new Date(end).format('yyyy-MM-dd')
		        }, function(result) {
			        if(result) {
				        var schedules = [];
				        for(var i = 0; i < result.length; i++) {
					        var vo = result[i];
					        schedules.push({
					            duty_sch_id : vo.duty_sch_id,
					            pe_id : vo.pe_id,
					            duty_prop : vo.duty_prop,
					            duty_type : vo.duty_type,
					            title : vo.pe_name + ' ' + vo.duty_prop_desc,
					            start : vo.duty_date_str,
					            className : 'label-success'
					        });
				        }
				        callback(schedules);
			        }
		        });
	        },
	        
	        drop : function(date, jsEvent, ui, resourceId) {
		        var _eventObj = $(this).data('eventObject');
		        
		        var $eventClass = $(this).attr('data-class');
		        var eventObj = $.extend({}, _eventObj);
		        
		        eventObj.start = date;
		        if($eventClass) {
			        eventObj.className = [$eventClass];
		        }
		        
		        $.post('dutymanage/dutyschedule/save', {
		            pe_id : eventObj.pe_id,
		            duty_date : new Date(date).format('yyyy-MM-dd'),
		            duty_prop : eventObj.duty_prop,
		            duty_type : eventObj.duty_type
		        }, function(result) {
			        if(result.success) {
				        eventObj.duty_sch_id = result.obj;
				        $('#calendar').fullCalendar('refetchEvents', eventObj, true);
			        } else {
				        layer.tips(result.msg, '#calendar', {
				            tips : 4,
				            time : 1000
				        });
			        }
		        });
	        },
	        eventDrop : function(event, delta, revertFunc, jsEvent, ui, view) {
		        var me = this;
		        $.post('dutymanage/dutyschedule/save', {
		            duty_sch_id : event.duty_sch_id,
		            pe_id : event.pe_id,
		            duty_prop : event.duty_prop,
		            duty_type : event.duty_type,
		            duty_date : new Date(event.start).format('yyyy-MM-dd')
		        }, function(result) {
			        if(!result.success) {
				        revertFunc();
				        layer.tips(result.msg, '#calendar', {
				            tips : 4,
				            time : 1000
				        });
			        }
		        });
	        },
	        
	        select : function(start, end, resource) {
		        promptAddForm(new Date(start).format("yyyy-MM-dd"));
	        },
	        
	        eventClick : function(calEvent, jsEvent, view) {
		        promptEditForm(calEvent.duty_sch_id);
	        }
	    });
    });
</script>