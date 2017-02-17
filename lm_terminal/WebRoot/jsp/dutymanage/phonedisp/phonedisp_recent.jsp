<%@ page language="java" pageEncoding="UTF-8"%>
<%
	request.setAttribute("voicePath", com.lauvan.configure.SystemSet.VOICE_PATH);
%>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<div style="margin-bottom: 15px;">
	<form id="searchForm" class="form-inline">
		<div class="form-group">
			<label for="pe_name">联系人</label>
			<input type="text" id="pe_name" name="pe_name" class="form-control" placeholder="输入联系人名称">
		</div>
		<div class="form-group">
			<label for="vo_time_start">电话号码</label>
			<input type="tel" id="vo_thatNo" name="vo_thatNo" class="form-control" placeholder="输入电话号码">
		</div>
		<div class="form-group">
			<label for="vo_time_start">日期</label>
			<input type="text" id="vo_time_start" name="vo_time_start" class="form-control" placeholder="开始日期">
			-
			<input type="text" id="vo_time_end" name="vo_time_end" class="form-control" placeholder="结束日期">
		</div>
		<input type="hidden" id="page" name="page" />
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
<script type="text/javascript">
	function search(page) {
	    $('#page').val(page);
	    $.post('dutymanage/phonedisp/recent', $('#searchForm').serialize(), function(result) {
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
			        str += '<td><a class="btn btn-xs btn-link" onclick="showHistory(\'' + r.vo_thatNo + '\');">'
			               + r.pe_name_ne + '&nbsp;<span class="badge">'
			               + (r.grp_count < 100 ? r.grp_count : '99+') + '</span></a><i class="'
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

    function showHistory(vo_thatNo) {
	    parent.layer.open({
	        type : 2,
	        title : '通话记录',
	        area : ['960px', '720px'],
	        scrollbar : false,
	        content : ['jsp/dutymanage/phonedisp/phonedisp_history.jsp', 'no'],
	        btn : ['关闭'],
	        yes : function(index, layero) {
		        parent.layer.close(index);
	        },
	        success : function(layero, index) {
		        var iframe = layero.find('iframe')[0].contentWindow;
		        iframe.init({
			        vo_thatNo : vo_thatNo
		        });
	        }
	    });
    }

    $(function() {
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
    });
</script>