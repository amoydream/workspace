<%@ page language='java' import='java.util.*' pageEncoding='utf-8'%>
<%@ include file='/include/inc.jsp'%>
<script type="text/javascript">
	function save_setting() {
	    var WS_LOCATION = $('#WS_LOCATION').val().trim();
	    var TEL_NUMBER = $('#TEL_NUMBER').val().trim();
	    var FAX_NUMBER = $('#FAX_NUMBER').val().trim();
	    var MFAX_SHPATH = $('#MFAX_SHPATH').val().trim();
	    var MFAX_PATH = $('#MFAX_PATH').val().trim();
	    var MSEQ_PATH = $('#MSEQ_PATH').val().trim();
	    var MSEQ_SHPATH = $('#MSEQ_SHPATH').val().trim();
	    var VOCR_PATH = $('#VOCR_PATH').val().trim();
	    var VOCR_SHPATH = $('#VOCR_SHPATH').val().trim();
	    var VOCR_URL = $('#VOCR_URL').val().trim();
	    var FAXR_PATH = $('#FAXR_PATH').val().trim();
	    var FAXR_SHPATH = $('#FAXR_SHPATH').val().trim();
	    var FAXR_URL = $('#FAXR_URL').val().trim();
	    var FAXS_PATH = $('#FAXS_PATH').val().trim();
	    var FAXS_SHPATH = $('#FAXS_SHPATH').val().trim();
	    var FAXS_URL = $('#FAXS_URL').val().trim();
	    var PRINT_LOCATION = $('#PRINT_LOCATION').val().trim();
	    var CONV_LOCATION = $('#CONV_LOCATION').val().trim();
	    var AUTO_PRINT = $('#AUTO_PRINT').val().trim();
	    if(WS_LOCATION == '' || TEL_NUMBER == '' || FAX_NUMBER == '' || MFAX_SHPATH == '' || MFAX_PATH == '' || MSEQ_PATH == '' || MSEQ_SHPATH == '' || VOCR_PATH == '' || VOCR_SHPATH == '' || VOCR_URL == '' || FAXR_PATH == '' || FAXR_SHPATH == '' || FAXR_URL == '' || FAXS_PATH == '' || FAXS_SHPATH == '' || FAXS_URL == '' || PRINT_LOCATION == '' || CONV_LOCATION == '' || AUTO_PRINT == '') {
		    alert('配置信息不完整');
	    } else {
		    $.post('Main/communication/ccms/save_setting', {
		        WS_LOCATION : WS_LOCATION,
		        TEL_NUMBER : TEL_NUMBER,
		        FAX_NUMBER : FAX_NUMBER,
		        MFAX_SHPATH : MFAX_SHPATH,
		        MFAX_PATH : MFAX_PATH,
		        MSEQ_PATH : MSEQ_PATH,
		        MSEQ_SHPATH : MSEQ_SHPATH,
		        VOCR_PATH : VOCR_PATH,
		        VOCR_SHPATH : VOCR_SHPATH,
		        VOCR_URL : VOCR_URL,
		        FAXR_PATH : FAXR_PATH,
		        FAXR_SHPATH : FAXR_SHPATH,
		        FAXR_URL : FAXR_URL,
		        FAXS_PATH : FAXS_PATH,
		        FAXS_SHPATH : FAXS_SHPATH,
		        FAXS_URL : FAXS_URL,
		        PRINT_LOCATION : PRINT_LOCATION,
		        CONV_LOCATION : CONV_LOCATION,
		        AUTO_PRINT : AUTO_PRINT
		    }, function(result) {
			    if(result.success) {
				    if(confirm('配置已更改, 刷新页面生效')) {
					    window.location.reload();
				    }
			    } else {
				    alert('配置失败');
			    }
		    });
	    }
    }
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',border:false">
		<div style="width: 100%;">
			<table id="table" class="sp-table" width="100%" cellpadding="0"
				cellspacing="0">
				<tr>
					<td class="sp-td1">WebSocket服务地址</td>
					<td><input type="text" name="WS_LOCATION" id="WS_LOCATION"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.WS_LOCATION}" data-options="required:true" />
						ws://{hostname|ip}:8600/</td>
				</tr>
				<tr>
					<td class="sp-td1">电话号码</td>
					<td><input type="text" name="TEL_NUMBER" id="TEL_NUMBER"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.TEL_NUMBER}" data-options="required:true" />
						{1234567}[,87654321,...]</td>
				</tr>
				<tr>
					<td class="sp-td1">传真号码</td>
					<td><input type="text" name="FAX_NUMBER" id="FAX_NUMBER"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.FAX_NUMBER}" data-options="required:true" />
						{1234567}[,87654321,...]</td>
				</tr>
				<tr>
					<td class="sp-td1">CCMS MSEQ目录</td>
					<td><input type="text" name="MSEQ_PATH" id="MSEQ_PATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.MSEQ_PATH}" data-options="required:true" />
						{drive:}\CCMS\MSEQ</td>
				</tr>
				<tr>
					<td class="sp-td1">CCMS MSEQ共享目录</td>
					<td><input type="text" name="MSEQ_SHPATH" id="MSEQ_SHPATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.MSEQ_SHPATH}" data-options="required:true" />
						\\{hostname|ip}\mseq</td>
				</tr>
				<tr>
					<td class="sp-td1">CCMS MFAX目录</td>
					<td><input type="text" name="MFAX_PATH" id="MFAX_PATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.MFAX_PATH}" data-options="required:true" />
						{drive:}\CCMS\MFAX</td>
				</tr>
				<tr>
					<td class="sp-td1">CCMS MFAX共享目录</td>
					<td><input type="text" name="MFAX_SHPATH" id="MFAX_SHPATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.MFAX_SHPATH}" data-options="required:true" />
						\\{hostname|ip}\mfax</td>
				</tr>
				<tr>
					<td class="sp-td1">录音记录目录</td>
					<td><input type="text" name="VOCR_PATH" id="VOCR_PATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.VOCR_PATH}" data-options="required:true" />
						{drive:}\CCMSRECD\WAVS</td>
				</tr>
				<tr>
					<td class="sp-td1">录音共享目录</td>
					<td><input type="text" name="VOCR_SHPATH" id="VOCR_SHPATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.VOCR_SHPATH}" data-options="required:true" />
						\\{hostname|ip}\vocrecd</td>
				</tr>
				<tr>
					<td class="sp-td1">录音播放地址</td>
					<td><input type="text" name="VOCR_URL" id="VOCR_URL"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.VOCR_URL}" data-options="required:true" />
						http://{hostname|ip}[:port]/vocrecd</td>
				</tr>
				<tr>
					<td class="sp-td1">传真接收目录</td>
					<td><input type="text" name="FAXR_PATH" id="FAXR_PATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.FAXR_PATH}" data-options="required:true" />
						{drive:}\CCMSRECD\FAXR</td>
				</tr>
				<tr>
					<td class="sp-td1">传真接收共享目录</td>
					<td><input type="text" name="FAXR_SHPATH" id="FAXR_SHPATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.FAXR_SHPATH}" data-options="required:true" />
						\\{hostname|ip}\faxrecv</td>
				</tr>
				<tr>
					<td class="sp-td1">传真接收下载地址</td>
					<td><input type="text" name="FAXR_URL" id="FAXR_URL"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.FAXR_URL}" data-options="required:true" />
						http://{hostname|ip}[:port]/faxrecv</td>
				</tr>
				<tr>
					<td class="sp-td1">传真发送目录</td>
					<td><input type="text" name="FAXS_PATH" id="FAXS_PATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.FAXS_PATH}" data-options="required:true" />
						{drive:}\CCMSRECD\FAXS</td>
				</tr>
				<tr>
					<td class="sp-td1">传真发送共享目录</td>
					<td><input type="text" name="FAXS_SHPATH" id="FAXS_SHPATH"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.FAXS_SHPATH}" data-options="required:true" />
						\\{hostname|ip}\faxsend</td>
				</tr>
				<tr>
					<td class="sp-td1">传真发送下载地址</td>
					<td><input type="text" name="FAXS_URL" id="FAXS_URL"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.FAXS_URL}" data-options="required:true" />
						http://{hostname|ip}[:port]/faxsend</td>
				</tr>
				<tr>
					<td class="sp-td1">传真自动打印</td>
					<td><input type="text" name="AUTO_PRINT" id="AUTO_PRINT"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.AUTO_PRINT}" data-options="required:true" />
						Y(YES)|N(NO)</td>
				</tr>
				<tr>
					<td class="sp-td1">传真打印地址</td>
					<td><input type="text" name="PRINT_LOCATION"
						id="PRINT_LOCATION" class="easyui-textbox" style="width: 480px;"
						value="${setting.PRINT_LOCATION}" data-options="required:true" />
						http://{hostname|ip}[:port]/printserver?filename=</td>
				</tr>
				<tr>
					<td class="sp-td1">传真格式转换WSDL地址</td>
					<td><input type="text" name="CONV_LOCATION" id="CONV_LOCATION"
						class="easyui-textbox" style="width: 480px;"
						value="${setting.CONV_LOCATION}" data-options="required:true" />
						http://{hostname|ip}:7991/convprinserv?wsdl</td>
				</tr>
				<c:if test="${loginModel.isAdmin}">
					<tr>
						<td colspan="2">
							<button class="easyui-linkbutton"
								data-options="iconCls:'icon-save'" onclick="save_setting();">保存配置</button>
						</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>