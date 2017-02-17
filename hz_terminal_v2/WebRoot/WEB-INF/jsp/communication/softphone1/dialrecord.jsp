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
    $.lauvan.dataGrid('callGrid_${voice}', {
    	 fitColumns : true,
	     idField : "CALL_ID",
	     frozenColumns:[[]],
	     pageSize:8,
	     pageList:[8,16,24],
         url : '<%=basePath %>Main/softphone/getCallRecord'
    });
});

function call_numberFmt(val, row, index) {
	return tel_link(row.TEL_NUMBER, row.EVENTID);
}

function call_answeredFmt(val, row, index) {
	return row.ANSWERED == 'Y'? '已接听' : '未接听';
}


function call_search() {
    var form = $('#callForm_${voice}');
    $('#callGrid_${voice}').datagrid('load', {
        tel_number : $("#tel_number").val(),
        dateTime : $("#dateTime").datebox('getValue'),
    });
}

   
    function voice(val, row, index){
      var act = "<a class='voice-btn blue' href=\"javascript:void(0);\" onclick=call_recdplay('"+val+"') >播放</a>";
	 return act;		
    }
    
    function typeFmt(val, row, index){
    	return row.CALLER == 'N'? '呼入' : '呼出';
    }

</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="padding: 5px; background: #f7f7f7;">
		<form id="callForm_${voice}">
		<c:if test="${voice=='Y'}">
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
	<div data-options="region:'center',border:false">
		<table id="callGrid_${voice}" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
				    <c:if test="${voice=='N'}">
					<th field="CONTACT_NAME" width="21%" sortable="true">联系人</th>
					</c:if>		
					<th field="TEL_NUMBER" width="25%" formatter="call_numberFmt" sortable="true">电话号码</th>
					<th field="CALLER" width="15%" formatter="typeFmt">类型</th>
					<th field="DATETIME" width="23%" sortable="true">通话时间</th>		
					<c:if test="${voice=='Y'}">
					<th field="CALL_ID" width="20%" formatter="voice">录音</th>
					</c:if>				
					<th field="ANSWERED" formatter="call_answeredFmt" sortable="true">状态</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
