<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){		
		$("#smsfile").uploadify({
			buttonText: "上传", //按钮上的文字 
	        uploader: basePath+"plugins/uploadify/scripts/uploadify.swf",
	        script:  basePath+"Main/smsMg/getMobileImportSave",
	        cancelImg: basePath+"plugins/uploadify/cancel.png",
	        auto: true, //是否自动开始     
	        multi: false, //是否支持多文件上传
	        fileDataName:'file',
	        fileQueue:'fileQueue',
	        fileDesc:'*.xls;',
	        fileExt:'*.xls;',
	        onComplete:_smsFileonComplete
	        });
	});

	function _smsFileonComplete(event, queueId, fileObj, response, data){	
	var obj = eval( "(" + response + ")" );//转换后的JSON对象
	var htmlBody="";
	htmlBody+="<div id='smsfileDIV' style='height:25px;line-height:25px;font-size:12px;'>";
	htmlBody+="<span style='display:none'><input type='checkbox' id='_smsimpfile' name='_smsimpfile' value='"+obj.id+"' checked/></span>";
	htmlBody+=obj.name+" （号码个数："+obj.size+"）";
	htmlBody+="</div>";
	$("#smsfileList").html(htmlBody);
	}
	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table class="sp-table" width="100%" cellpadding="0" cellspacing="0"> 
			    <tr>
				  <td class="sp-td1" >导入文件说明：</td>
				  <td>文件内容只能有手机号码一列</td>
				</tr>
				<tr>
				  <td class="sp-td1" >号码文件：</td>
				  <td>
				  		<input  id="smsfile"  type="file" name="file"/>
		    			<div id="smsfileList" style="width: 200px;"></div>
				  </td>
				</tr>
			</table> 
		</div>
	</div>

