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
                'script': '<%=basePath%>Main/attachment/save/gwfj--${userid}',
                'cancelImg': '<%=basePath %>plugins/uploadify/cancel.png',
                'auto'           : true, //是否自动开始     
	            'multi'          : true, //是否支持多文件上传
	            fileDataName   : 'file',
	            fileQueue     :  'fileQueue',
	 	        onComplete:onComplete,	
	 	       /*onSelect:function(event,queueId,fileObj){
	 	    	  allname+=fileObj.name;
	 	      },
	 	     onSelectOnce: function(event,data){
	 	    		totalSize += data.allBytesTotal;
	 	    		if (/.*[\u4e00-\u9fa5]+.*$/.test(allname)) {
		 				 alert("上传的文件名字中存在中文字符，请检查！");
		 				$('#uploadify').uploadifyClearQueue();
	 		 			totalSize-=data.allBytesTotal;
	 		 			allname="";
		 			}else if(totalSize>1024*1024){
	 		 			  alert("附件总大小超出1M，请重新选择文件！");	 		 			
	 		 			$('#uploadify').uploadifyClearQueue();
	 		 			totalSize-=data.allBytesTotal;
	 		 			allname="";
	 		 			  }
	 	    	},
                 'fileDesc'       : '支持格式:jpg/gif/png/bmp.', //如果配置了以下的'fileExt'属性，那么这个属性是必须的    
 	            'fileExt'        : '*.jpg;*.gif;*.png;*.bmp',//允许的格式      */
 	           onError: function(event, queueID, fileObj) {     
 	               alert("文件:" + fileObj.name + "上传失败");     
 	            }	            
            });
        });
var htmlHead="<dl style='width: 500px;height:auto;'><dt style='width: 100px; text-align: right;'>已上传的附件：</dt><dd id='fileHtmlBody' style='width: 380px;'>";
var htmlBody="";
var htmlFoot="</dd></dl>";
function onComplete(event, queueId, fileObj, response, data){
	var obj = eval( "(" + response + ")" );//转换后的JSON对象
	htmlBody+="<div id='file_"+obj.id+"' style='height:25px;line-height:25px;font-size:12px;'>";
	htmlBody+="<span style='display:none'><input type='checkbox' name='fjid' value='"+obj.id+"' checked/></span>";	
	if(obj.type=='xls'||obj.type=='xlsx'||obj.type=='doc'||obj.type=='docx'||obj.type=='ppt'||obj.type=='pptx'){
	htmlBody+="<a class='btnAttach' title='请点击打开'></a><a title='请点击打开' target='_blank'";
	htmlBody+="href='<%=basePath%>Main/document/getfileview/"+obj.id+"-"+obj.type+"'";
	}else if(obj.type=='pdf'){
	htmlBody+="<a class='btnAttach' title='请点击打开'></a><a title='请点击打开' target='_blank'";
	htmlBody+="href='<%=basePath%>Main/document/getpdfview?id="+obj.id+"&title="+obj.name+"'";	
	}else if(obj.type=='jpg'||obj.type=='gif'||obj.type=='png'){
		htmlBody+="<a class='btnAttach' title='请点击打开'></a><a title='请点击打开' target='_blank'";	
		htmlBody+="href='<%=basePath%>Main/document/getjpgview?id="+obj.id+"'";
	}else{
	htmlBody+="<a class='btnAttach' title='请点击另存为'></a><a title='请点击另存为' target='_blank'";	
	htmlBody+="href='<%=basePath%>Main/attachment/downloadFJ/"+obj.id+"'";
	}
	htmlBody+=">"+obj.name+"<a/> （"+obj.size+"）<a href='javascript:deleteFile("+obj.id+","+obj.tempsize+");'><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
	htmlBody+="</div>";
	$("#fileList").html(htmlHead+htmlBody+htmlFoot);
}
//删除文件ajax请求
function deleteFile(id,size){
	$("#file_"+id).load("<%=basePath%>Main/attachment/delete/"+id);
	$("#file_"+id).remove();
	htmlBody=$("#fileHtmlBody").html();
}
</script>
<form id="doc_form" method="post" action="<%=basePath%>Main/document/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">公文编号：</td>
		    <td>
		    <input name="t_Receive_Doc.code" type="text" class="easyui-textbox" style="width: 500px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">公文标题：</td>
		    <td>
		    <input id="doctitle" name="t_Receive_Doc.name" type="text" class="easyui-textbox" data-options="required:true"  style="width: 500px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">接收人：</td>
		    <td>
		    <input  type="hidden" id="receiveid" name="receiveid"/>
		    <input  type="hidden" id="receivetype" name="receivetype"/>
		    <input id="rname" name="t_Receive_Doc.receivename" type="text" readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 500px;"/><a id="btn1" onclick="findreceive()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a></td>
		    </tr>
		    <tr>
			<td class="sp-td1">公文内容：</td>
			<td><textarea id="doccontent" name="t_Receive_Doc.content" class="textarea" data-options="validType:'length[0,1000]'"
					style="width: 500px; height: 50px;"></textarea></td>
		    </tr>
		    <tr>
			<td class="sp-td1">备注：</td>
			<td><textarea name="t_Receive_Doc.note" class="textarea" data-options="validType:'length[0,1000]'"
					style="width: 500px; height: 50px;"></textarea></td>
		    </tr>
		    <tr>
			<td class="sp-td1">附件：</td>
			<td>
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
