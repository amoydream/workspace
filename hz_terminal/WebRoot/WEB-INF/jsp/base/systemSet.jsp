<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
    $(function() {
	    $("#smsnoticvoice").uploadify({
	        buttonText : "短信提示音", //按钮上的文字 
	        uploader : basePath + "plugins/uploadify/scripts/uploadify.swf",
	        script : basePath + "Main/smsMg/uploadvoice/smsvoice?fileName=sms_notice.mp3",
	        cancelImg : basePath + "plugins/uploadify/cancel.png",
	        auto : true, //是否自动开始     
	        multi : false, //是否支持多文件上传
	        fileDataName : 'file',
	        fileQueue : 'fileQueue',
	        fileDesc : '*.mp3;',
	        fileExt : '*.mp3;',
	        onComplete : _smsvoiceonComplete
	    });
	    
	    $("#faxNoticeFile").uploadify({
	        buttonText : "传真提示音", //按钮上的文字 
	        uploader : basePath + "plugins/uploadify/scripts/uploadify.swf",
	        script : basePath + "Main/communication/ccms/fax/uploadNotice?fileName=faxnotice.mp3",
	        cancelImg : basePath + "plugins/uploadify/cancel.png",
	        auto : true, //是否自动开始
	        multi : false, //是否支持多文件上传
	        fileDataName : 'file',
	        fileQueue : 'fileQueue',
	        fileDesc : '*.mp3;',
	        fileExt : '*.mp3;',
	        onComplete : _faxNoticeUploaded
	    });
    });

    function _smsvoiceonComplete(event, queueId, fileObj, response, data) {
	    var obj = eval("(" + response + ")");//转换后的JSON对象
	    var htmlBody = "";
	    htmlBody += "<div style='height:50px;line-height:25px;font-size:12px;'>";
	    htmlBody += "<span style='display:none'><input type='checkbox' name='sysvoice' value='"+obj.url+"' checked/></span>";
	    htmlBody += '<audio style="max-width: 300px; max-height: 40px;" controls="playbutton" src="'+obj.url+'"/>';
	    htmlBody += "</div>";
	    $("#smsnoticvoidList").html(htmlBody);
    }
    
    function _faxNoticeUploaded(event, queueId, fileObj, response, data) {
	    var obj = eval("(" + response + ")");//转换后的JSON对象
	    var htmlBody = "<div style='height:50px;line-height:25px;font-size:12px;'>";
	    htmlBody += "<span style='display:none'><input type='checkbox' name='faxNotice' value='" + obj.url + "' checked/></span>";
		htmlBody += '<audio style="max-width: 300px; max-height: 40px;" controls="playbutton" src="'+obj.url+'"/>';
	    htmlBody += "</div>";
	    $("#faxNoticeDiv").html(htmlBody);
    }
</script>
<form id="sysSet_form" method="post" action="<%=basePath%>Main/systemSetSave" style="width: 100%;">
	<input type="hidden" name="dept" value="${dept}" />
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td class="sp-td1">组织机构：</td>
			<td>${deptname}</td>
		</tr>
		<tr>
			<td class="sp-td1">导航标题：</td>
			<td>
				<input name="sysname" type="text" class="easyui-textbox" data-options="required:true" style="width: 200px;"
					value="${sysname}" />
			</td>
		</tr>
		<tr>
			<td class="sp-td1">导航条背景：</td>
			<td>
				<!--<div style="margin-top:2px;">
			            <ul id="skinlist">
			            <li  id="s1"><input type="radio" name="syscolor" value="default" <c:if test="${sysjpg=='default'}">checked="checked"</c:if>/></li>
			            <li  id="s2"><input type="radio" name="syscolor" value="black" <c:if test="${sysjpg=='black'}">checked="checked"</c:if> /></li>
			            <li  id="s3"><input type="radio" name="syscolor" value="ui-pepper-grinder" <c:if test="${sysjpg=='ui-pepper-grinder'}">checked="checked"</c:if> /></li>
			            <li  id="s4"><input type="radio" name="syscolor" value="ui-sunny"  <c:if test="${sysjpg=='ui-sunny'}">checked="checked"</c:if> /></li>
			          </ul>		
			        </div>color-->
				<input type="radio" name="syscolor" value="default" style="width: 20px;"
					<c:if test="${sysjpg=='default'}">checked="checked"</c:if> />
				默认
				<input type="radio" name="syscolor" value="black" style="width: 20px;"
					<c:if test="${sysjpg=='black'}">checked="checked"</c:if> />
				现代
				<input type="radio" name="syscolor" value="ui-pepper-grinder" style="width: 20px;"
					<c:if test="${sysjpg=='ui-pepper-grinder'}">checked="checked"</c:if> />
				简约
				<input type="radio" name="syscolor" value="ui-sunny" style="width: 20px;"
					<c:if test="${sysjpg=='ui-sunny'}">checked="checked"</c:if> />
				几何
			</td>
		</tr>
		<tr>
			<td class="sp-td1">主菜单背景：</td>
			<td>
				<input type="radio" name="syscebian" value="1" style="width: 20px;"
					<c:if test="${syscebian=='1'}">checked="checked"</c:if> />
				空白
				<input type="radio" name="syscebian" value="2" style="width: 20px;"
					<c:if test="${syscebian=='2'}">checked="checked"</c:if> />
				斑点
				<input type="radio" name="syscebian" value="3" style="width: 20px;"
					<c:if test="${syscebian=='3'}">checked="checked"</c:if> />
				建筑
				<input type="radio" name="syscebian" value="4" style="width: 20px;"
					<c:if test="${syscebian=='4'}">checked="checked"</c:if> />
				几何
			</td>
		</tr>
		<tr>
			<td class="sp-td1">导航布局：</td>
			<td>
				<input type="radio" name="sysMenu" value="0" style="width: 20px;"
					<c:if test="${sysMenu=='0'}">checked="checked"</c:if> />
				纵向布局
				<input type="radio" name="sysMenu" value="1" style="width: 20px;"
					<c:if test="${sysMenu=='1'}">checked="checked"</c:if> />
				横纵布局
			</td>
		</tr>
		<tr>
			<td class="sp-td1">窗口数：</td>
			<td>
				<input type="radio" name="sysWin" value="0" style="width: 20px;"
					<c:if test="${sysWin=='0'}">checked="checked"</c:if> />
				多个
				<input type="radio" name="sysWin" value="1" style="width: 20px;"
					<c:if test="${sysWin=='1'}">checked="checked"</c:if> />
				单个
			</td>
		</tr>
		<tr>
			<td class="sp-td1">默认首页：</td>
			<td>
				<input class="easyui-combotree" name="sysTab" style="width: 180px;"
					data-options="url:'<%=basePath%>Main/service/getModelTree',method:'get',required:true<c:if test="${!empty sysTab}">,value:${sysTab}</c:if>">
			</td>
		</tr>
		<tr style="height: auto;">
			<td class="sp-td1">传真提示音：</td>
			<td>
				<input id="faxNoticeFile" type="file" name="faxNoticeFile" />
				<div id="faxNoticeDiv" style="width: 300px;">
					<div style="width: 300px; height: 50px; line-height: 25px; font-size: 12px;">
						<span style="display: none">
							<input type="checkbox" name="faxNotice" value="sound/faxnotice.mp3" checked />
						</span>
						<audio style="max-width: 300px; max-height: 40px;" controls="playbutton" src="sound/faxnotice.mp3" />
					</div>
				</div>
			</td>
		</tr>
		<tr style="height: auto;">
			<td class="sp-td1">短信提示音：</td>
			<td>
				<input id="smsnoticvoice" type="file" name="file" />
				<div id="smsnoticvoidList" style="width: 300px;">
					<div style="width: 300px; height: 50px; line-height: 25px; font-size: 12px;">
						<span style="display: none">
							<input type="checkbox" name="sysvoice" value="sound/sms_notice.mp3" checked />
						</span>
						<audio style="max-width: 300px; max-height: 40px;" controls="playbutton" src="sound/sms_notice.mp3" />
					</div>
				</div>
			</td>
		</tr>
	</table>
</form>
