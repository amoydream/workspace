<%@ page language='java' import='java.util.*' pageEncoding='utf-8'%>
<%@ include file='/include/inc.jsp'%>
<%@ include file="js/console.jsp"%>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',border:true" style="width: 200px; padding: 5px; background: #F1F7FF; color: #5E74AF;">
		<input id="contact_filter" name="contact_filter" type="text" class="easyui-textbox"
			data-options="prompt:'搜索',icons:[{iconCls:'icon-clear',handler:clear_filter},{iconCls:'icon-arrowrefresh',handler:refresh_contact}]"">
		<ul id="contact_tree" class="ztree"></ul>
	</div>
	<div data-options="region:'center',border:true">
		<div id="contact_info" data-options="border:true"
			style="height: 30px; font-size: 14px; font-weight: bold; background: #F1F7FF; color: #5E74AF; padding-top: 8px;
	padding-left: 5px; margin-bottom: 10px;"></div>
		<div data-options="border:false" style="padding: 5px;">
			<span style="font-weight: bold;">手机号码：</span>
			<input style="height: 26px;" type="text" id="tel_mobile" name="tel_mobile" class="easyui-textbox easyui-validatebox"
				data-options="icons:[{iconCls:'icon-phonereceived',handler:call_mobile}], validType:'checkTel'" />
			<button class="easyui-linkbutton" data-options="iconCls:'icon-group'" onclick="add_member('tel_mobile');">加入会议</button>
		</div>
		<div data-options="border:false" style="padding: 5px;">
			<span style="font-weight: bold;">办公电话：</span>
			<input style="height: 26px;" type="text" id="tel_office" name="tel_office" class="easyui-textbox easyui-validatebox"
				data-options="icons:[{iconCls:'icon-phonereceived',handler:call_office}], validType:'checkTel'" />
			<button class="easyui-linkbutton" data-options="iconCls:'icon-group'" onclick="add_member('tel_office');">加入会议</button>
		</div>
		<div data-options="border:false" style="padding: 5px;">
			<span style="font-weight: bold;">住宅电话：</span>
			<input style="height: 26px;" type="text" id="tel_home" name="tel_home" class="easyui-textbox easyui-validatebox"
				data-options="icons:[{iconCls:'icon-phonereceived',handler:call_home}], validType:'checkTel'" />
			<button class="easyui-linkbutton" data-options="iconCls:'icon-group'" onclick="add_member('tel_home');">加入会议</button>
		</div>
		<div data-options="border:false" style="padding: 5px;">
			<span style="font-weight: bold; margin-bottom: 5px;">电话会议：</span>
		</div>
		<div data-options="border:false" style="padding: 5px;">
			<select id="member_tagger" style="width: 403px;" />
		</div>
		<div data-options="border:false" style="padding: 5px;">
			<button style="float: right;" class="easyui-linkbutton" data-options="iconCls:'icon-phonereceived'"
				onclick="meeting_call();">开始会议</button>
		</div>
	</div>
</div>