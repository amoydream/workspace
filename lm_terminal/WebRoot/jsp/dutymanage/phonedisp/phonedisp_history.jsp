<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("voicePath", com.lauvan.configure.SystemSet.VOICE_PATH);
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>电话调度</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 10px; margin-bottom: 10px;">
			<form id="searchForm" class="form-inline">
				<input type="hidden" id="page" name="page" />
				<input type="hidden" id="vo_thatNo" name="vo_thatNo" />
				<input type="hidden" id="vo_state" name="vo_state" />
				<input type="hidden" id="vo_callerFlag" name="vo_callerFlag" />
				<input type="hidden" id="pe_id" name="pe_id" />
				<input type="hidden" id="ev_id" name="ev_id" />
				<input type="hidden" id="vo_time" name="vo_time" />
				<div class="form-group">
					<label for="vo_time_start">日期</label>
					<input type="text" id="vo_time_start" name="vo_time_start" class="form-control" placeholder="开始日期">
					-
					<input type="text" id="vo_time_end" name="vo_time_end" class="form-control" placeholder="结束日期">
				</div>
				<a class="btn btn-primary" onclick="search(1);">
					<i class="icon-search"></i>&nbsp;搜索
				</a>
			</form>
		</div>
		<table class="table table-bordered">
			<tr class="info">
				<th>联系人</th>
				<th>电话号码</th>
				<th>日期</th>
				<th>关联事件</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
			<tbody id="result">
			</tbody>
			<tr>
				<th id="navbar" scope="col" colspan="6"></th>
			</tr>
		</table>
	</div>
</body>
</html>
<script type="text/javascript">
	function search(page) {
	    $('#page').val(page);
	    $.post('dutymanage/phonedisp/history', $('#searchForm').serialize(), function(result) {
	        if(result.success) {
		        var records = result.obj.records;
		        var str = '';
		        for(var i = 0; i < records.length; i++) {
			        var r = records[i];
			        if(i % 2 == 1) {
				        str += '<tr class="warning">';
			        } else {
				        str += '<tr>';
			        }
			        str += '<td>' + r.pe_name_ne + '<i class="'
			               + (r.vo_callerFlag == '1' ? 'icon-reply' : 'icon-share-alt')
			               + '" style="float:right;"/></td>';
			        str += '<td>' + r.vo_thatNo + '</td>';
			        str += '<td>' + r.vo_time_str + '</td>';
			        str += '<td>' + $.trim(r.ev_name) + '</td>';
			        str += '<td>' + r.vo_state_desc + '</td>';
			        str += '<td>';
			        str += '<a class="btn btn-xs btn-primary" style="float:left" onclick="parent.callOut(\'${userVo.voice}\',\''
			               + r.vo_thatNo + '\');"><i class="icon-phone"/>&nbsp;拨号</a>';
			        if(r.vo_state == '1' && r.vo_voicepath != null) {
				        str += '<div class="dropdown" style="float:left;margin-left:3px;">';
				        str += '<a class="btn btn-xs btn-success" data-toggle="dropdown"><i class="icon-headphones"/>&nbsp;播放录音</a>';
				        str += '<ul class="dropdown-menu dropdown-menu-right">';
				        str += '<li>';
				        str += '<embed autostart="false" src="${voicePath}' + r.vo_voicepath + '"/>';
				        str += '</li>';
				        str += '</ul>';
				        str += '</div>';
			        }
			        str += '</td>';
			        str += '</tr>';
		        }
		        $('#result').html(str);
		        paginationNav('navbar', result.obj, 'search');
		        
		        $.each($('.dropdown'), function(i, el) {
			        var au = null;
			        try {
				        au = $(el).children('ul').first().children('li').first().children('embed').first().get(0);
			        } catch(e) {
				        console.log(e);
			        }
			        if(au != null) {
				        $(el).on('shown.bs.dropdown', function() {
				        	au.stop();
					        au.play();
				        });
				        $(el).on('hidden.bs.dropdown', function() {
					        au.stop();
				        });
			        }
		        });
	        }
        });
    }

    function init(arg) {
	    if(arg) {
		    if($.trim(arg.vo_thatNo) != '') {
			    $('#vo_thatNo').val($.trim(arg.vo_thatNo));
		    }
		    
		    if($.trim(arg.vo_state) != '') {
			    $('#vo_state').val($.trim(arg.vo_state));
		    }
		    
		    if($.trim(arg.pe_id) != '') {
			    $('#pe_id').val($.trim(arg.pe_id));
		    }
		    
		    if($.trim(arg.ev_id) != '') {
			    $('#ev_id').val($.trim(arg.ev_id));
		    }
		    
		    if($.trim(arg.vo_callerFlag) != '') {
			    $('#vo_callerFlag').val($.trim(arg.vo_callerFlag));
		    }
		    
		    if($.trim(arg.vo_time) != '') {
			    $('#vo_time').val($.trim(arg.vo_time));
		    }
	    }
	    
	    $('#vo_time_start').datetimepicker({
	        language : 'zh-CN',
	        format : 'yyyy-mm-dd',
	        minView : 'month',
	        autoclose : true
	    });
	    
	    $('#vo_time_end').datetimepicker({
	        language : 'zh-CN',
	        format : 'yyyy-mm-dd',
	        minView : 'month',
	        autoclose : true
	    });
	    
	    search('1');
    };
</script>