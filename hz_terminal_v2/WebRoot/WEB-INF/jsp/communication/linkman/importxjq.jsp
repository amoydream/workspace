<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$(document).ready(function()
        {
            $("#uploadify").uploadify({
            	'buttonText'     : '上传附件', //按钮上的文字 
                'uploader': '<%=basePath %>plugins/uploadify/scripts/uploadify.swf',
                'script': '<%=basePath%>Main/attachment/save/linkman--${userid}',
                'cancelImg': '<%=basePath %>plugins/uploadify/cancel.png',
                'auto'           : true, //是否自动开始     
	            'multi'          : false, //是否支持多文件上传
	            fileDataName   : 'file',
	            fileQueue     :  'fileQueue',
		        fileExt:'*.xls;',
		        fileDesc:'*.xls;',
	 	        onComplete:onComplete,	
 	           onError: function(event, queueID, fileObj) {     
 	               alert("文件:" + fileObj.name + "上传失败");     
 	            }	            
            });
        });
var htmlHead="<dl style='width: 200px;height:auto;'><dt style='width: 100px; text-align: right;'>已上传的附件：</dt><dd id='fileHtmlBody' style='width: 380px;'>";
var htmlBody="";
var htmlFoot="</dd></dl>";
function onComplete(event, queueId, fileObj, response, data){
	var obj = eval( "(" + response + ")" );//转换后的JSON对象
	htmlBody+="<div id='file_"+obj.id+"' style='height:25px;line-height:25px;font-size:12px;'>";
	htmlBody+="<span style='display:none'><input type='checkbox' name='fjid' value='"+obj.id+"' checked/></span>";	
	htmlBody+="<a class='btnAttach' title='请点击另存为'></a><a title='请点击另存为' target='_blank'";	
	htmlBody+="href='<%=basePath%>Main/attachment/downloadFJ/"+obj.id+"'";
	htmlBody+=">"+obj.name+"<a/> （"+obj.size+"）<a href='javascript:deleteFile("+obj.id+","+obj.tempsize+");'><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
	htmlBody+="</div>";
	$("#fileList").html(htmlHead+htmlBody+htmlFoot);
	htmlBody="";
}
//删除文件ajax请求
function deleteFile(id,size){
	$("#file_"+id).load("<%=basePath%>Main/attachment/delete/"+id);
	$("#file_"+id).remove();
	htmlBody=$("#fileHtmlBody").html();
}
</script>
<form id="linkmanq_form" method="post" action="<%=basePath%>Main/linkman/importxjqSave"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
 	<input type="hidden" name="qid" value="${qun.id }"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
	        <td class="sp-td1">上级群组名称：</td>
			<td>
			<input  type="hidden" name="t_Bus_Linkman_Qun.pid" value="${qun.id }"/>
			<input  value="${qun.name }" type="text" class="easyui-textbox" readonly="readonly" style="width: 200px;"/>
			</td>
			<td class="sp-td1">群组名称：</td>
			<td>
			<input type="text" id="qunname" name="t_Bus_Linkman_Qun.name" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/>
			</td>
		    </tr>
	        <tr>
		    <td class="sp-td1">名称列数：</td>
		    <td>
		    <input id="namenum" name="namenum" value="1" type="text" class="easyui-textbox"  data-options="required:true" style="width: 200px;"/></td>
		    <td class="sp-td1">电话列数：</td>
		    <td>
		    <input id="telnum" name="telnum" value="2" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">单位列数：</td>
		    <td>
		    <input id="deptnum" name="deptnum" value="6" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/></td>
			<td class="sp-td1">职位列数：</td>
			<td>
			<input id="positionnum" name="positionnum" value="8" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/>
			</td>
		    </tr>
		    <tr>
			<td class="sp-td1">备注列数：</td>
			<td colspan="3">
			<input id="remarknum" name="remarknum" value="11" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/>
			</td>
		    </tr>
		    
		    <tr>
			<td class="sp-td1">附件：</td>
			<td colspan="3">
			<div style="float: left;"> 	
		    	<input type="file" name="uploadify" id="uploadify" />
		    	</div>
		    	<div style="clear: both;"></div>
		    	<div id="fileQueue"> 		    	
					<div id="fileList" style="width: 450px;"></div>
					</div>
            </td>
		    </tr>
    </table>
</form>
