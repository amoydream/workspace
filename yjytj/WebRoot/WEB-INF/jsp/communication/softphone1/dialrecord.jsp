<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/header.jsp"%>
<style>
#left-dialrecord-datagrid .datagrid-body {
	overflow-x: hidden;
}

.voice-btn {
    display: inline-block;
    text-decoration : none;
	-webkit-border-radius: .2em; 
	-moz-border-radius: .2em;
	border-radius: .2em;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	box-shadow: 0 1px 2px rgba(0,0,0,.2);
}

/* blue */
.blue {
	color: #d9eef7;
	border: solid 1px #0076a3;
	background: #0095cd;
	background: -webkit-gradient(linear, left top, left bottom, from(#00adee), to(#0078a5));
	background: -moz-linear-gradient(top,  #00adee,  #0078a5);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#00adee', endColorstr='#0078a5');
}
.blue:hover {
	background: #007ead;
	background: -webkit-gradient(linear, left top, left bottom, from(#0095cc), to(#00678e));
	background: -moz-linear-gradient(top,  #0095cc,  #00678e);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#0095cc', endColorstr='#00678e');
}
.blue:active {
	color: #80bed6;
	background: -webkit-gradient(linear, left top, left bottom, from(#0078a5), to(#00adee));
	background: -moz-linear-gradient(top,  #0078a5,  #00adee);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#0078a5', endColorstr='#00adee');
}
</style>
<script type="text/javascript">
	$(function() {
	    $.lauvan.dataGrid("callGrid_${answered}", {
	        fitColumns : true,
	        idField : "CALL_ID",
	        frozenColumns:[[]],
	        pageSize:8,
	        pageList:[8,16,24],
	        url : "<%=basePath %>Main/softphoneone/getCallRecord?answered=${answered}"
	    });
    });


    function tel_link(val, row, index) {
	    return "<a href=\"javascript:void(0);\" onclick=parent.callout('" + row.TEL_NUMBER + "','" + row.EVENTID + "') >" + row.TEL_NUMBER + "</a>";
    }
    
    function answer(val, row, index){
    	if(val=='Y'){
    		return '是';
    	}else{
    		return '否';
    	}
    }
    
    function voice(val, row, index){
      var act = "<a class='voice-btn blue' href=\"javascript:void(0);\" onclick=call_recdplay('"+val+"') >播放</a>";
	 return act;		
    }

    function call_recdplay(call_id) {
	    var vocrecdplay = window.parent.document.getElementById("vocrecdplay");
	    if(vocrecdplay != null) {
		    $("#vocrecdplay").dialog("close");
	    }

	    $.post("<%=basePath %>Main/communication/ccms/call/play", {
	        action : "check",
	        call_id : call_id
	    }, function(result) {
		    if(!result.success) {
			    $.lauvan.MsgShow({
				    msg : "录音文件不存在"
			    });
		    } else {
			    $.lauvan.openCustomDialog("vocrecdplay", {
			        title : "播放录音",
			        width : 320,
			        height : 120,
			        maximizable : false,
			        resizable : false,
			        modal : false,
			        href : "Main/communication/ccms/call/play?action=play&call_id=" + call_id,
			        buttons : []
			    });
		    }
	    })
    }

    function call_search() {
	    var form = $("#callForm_${answered}");
	    $("#callGrid_${answered}").datagrid("load", {
	        answered : form.find(":input[name='answered']").val(),
	        contact_name : form.find(":input[name='contact_name']").val(),
	        or_name : form.find(":input[name='or_name']").val(),
	        tel_number : form.find(":input[name='tel_number']").val(),
	        dateRange : form.find(":input[name='dateRange']").val(),
	        dateTime : form.find(":input[name='dateTime']").val(),
	        ev_name : "${answered}" == "Y" ? form.find(":input[name='ev_name']").val() : ""
	    });
    }
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="padding: 5px; background: #f7f7f7;">
		<form id="callForm_${answered}">
		<c:if test="${answered=='Y'}">
			 <input id="answered" name="answered" type="hidden" value="Y"> 
		</c:if>
			<div style="margin:2px 0;">
			<span>电话号码：</span>
			<input id="tel_number" name="tel_number" type="tel" class="easyui-textbox">
			</div>
			<!-- <span>联系人：</span>
			<input id="contact_name" name="contact_name" type="text" class="easyui-textbox">
			<span>部门：</span>
			<input id="or_name" name="or_name" type="text" class="easyui-textbox">
			<span>事件名称：</span>
			<input id="ev_name" name="ev_name" type="text" class="easyui-textbox"> -->
		    <span>通话日期：</span>
			<input id="dateTime" name="dateTime" type="text" class="easyui-datebox">
			<!-- <select class="easyui-combobox" name="dateRange" width="30px">
				<option selected="selected" value="D">按日</option>
				<option value="M">按月</option>
				<option value="Y">按年</option>
			</select> -->
			<a href="javascript:void(0);" class="easyui-linkbutton" onclick="call_search();"
				data-options="iconCls:'icon-search',plain:true">查询</a>
		</form>
	</div>
	<div id="left-dialrecord-datagrid" data-options="region:'center',border:false">
		<table id="callGrid_${answered}" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="CALLER" width="21%">主叫</th>
				<!-- 	<th field="OR_NAME" width="16%">部门</th> -->
					<th field="TEL_NUMBER" width="22%" formatter="tel_link">电话号码</th>
					<th field="DATETIME" width="22%">通话时间</th>
					<c:choose>
					<c:when test="${answered=='All'}">
				       <th field="ANSWERED" width="12%" formatter="answer">已接</th>
					</c:when>
					<c:otherwise>
					   <th field="CALL_ID" width="12%" formatter="voice">录音</th>
					 </c:otherwise>
					</c:choose>
					<th field="CALLEE" width="23%">被叫</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
