<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
            $("#uploadify").uploadify({
            	'buttonText'     : '上传附件', //按钮上的文字 
                'uploader': '<%=basePath %>plugins/uploadify/scripts/uploadify.swf',
                'script': '<%=basePath%>Main/attachment/save/lawrul--${userid}',
                'cancelImg': '<%=basePath %>plugins/uploadify/cancel.png',
                'auto'           : true, //是否自动开始     
	            'multi'          : true, //是否支持多文件上传
	            fileDataName   : 'file',
	            fileQueue     :  'fileQueue',
	 	        onComplete:onComplete,		 	    
 	           onError: function(event, queueID, fileObj) {     
 	               alert("文件:" + fileObj.name + "上传失败");     
 	            }	            
            });
            var editor;
    		KindEditor.options.imageTabIndex = 1;
    		editor= KindEditor.create('#contentid',{
    			filePostName:'file',
    			allowFileManager:true,
    			items: ['fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
    					'removeformat', '|', 'cut', 'copy', 'paste','plainpaste', 'wordpaste','|', 
    					'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
    					'insertunorderedlist'],
    			afterBlur: function(){ editor.sync(); }
    		});            
       });
var htmlHead="<dl style='width: 500px;height:auto;'><dt style='width: 100px; text-align: right;'>已上传的附件：</dt><dd id='fileHtmlBody' style='width: 380px;'>";
var htmlBody="";
var htmlFoot="</dd></dl>";
function onComplete(event, queueId, fileObj, response, data){
	var obj = eval( "(" + response + ")" );//转换后的JSON对象
	console.info(obj);
	htmlBody+="<div id='file_"+obj.id+"' style='height:25px;line-height:25px;font-size:12px;'>";
	htmlBody+="<span style='display:none'><input id='rlfileid' type='checkbox' name='existfileids' value='"+obj.id+"' checked/></span>";	
	if(obj.type=='xls'||obj.type=='xlsx'||obj.type=='doc'||obj.type=='docx'||obj.type=='ppt'||obj.type=='pptx'){
	htmlBody+="<a class='btnAttach' title='请点击打开'></a><a title='请点击打开' target='_blank'";
	htmlBody+="href='<%=basePath%>Main/document/getfileview/"+obj.id+"-"+obj.type+"'";
	}else if(obj.type=='pdf'){
	htmlBody+="<a class='btnAttach' title='请点击打开'></a><a title='请点击打开' target='_blank'";
	htmlBody+="href='<%=basePath%>Main/document/getpdfview?id="+obj.id+"&title="+obj.name+"'";	
	}else if(obj.type=='jpg'||obj.type=='gif'||obj.type=='png'){
		htmlBody+="<a class='btnAttach' title='请点击打开'></a><a title='请点击打开' target='_blank'";	
		htmlBody+="href='<%=basePath%>"+obj.url+"'";
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


	  <form id="lawrulAdd" name="lawrulAdd" method="post" action="<%=basePath%>Main/lawrul/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input id="actid" type="hidden" name="act" value="add"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">标题：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_title" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入标题',required:true,icons:iconClear"  style="width:180px;"/>  </td>
		  		
		  		<td class="sp-td1">编号：</td>
		    	<td >
		    	<input name="t_Bus_LawRegulation.lr_code" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入编号',required:true,icons:iconClear"  style="width:180px;"/>
		  		</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">类别：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_LawRegulation.lr_type"
			        panelHeight="auto" code="YJLAWRUL" style="width: 180px;"
			        data-options="editable:false,value:'${lr_type}'"></select>
		    	</td>
		  		
		  		<td class="sp-td1">副标题：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_subtitle" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入副标题',required:true,icons:iconClear"  style="width:180px;"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">内容摘要：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_abstract" data-options="prompt:'请输入摘要内容',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		  		
		  		<td class="sp-td1">范围：</td>
		    	<td ><input name="t_Bus_LawRegulation.lr_applyrang" data-options="prompt:'请输入范围',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">部门：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_publishdept" data-options="prompt:'请输入部门',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		  		
		  		<td class="sp-td1">创建日期：</td>
		    	<td ><input type="text"  name="t_Bus_LawRegulation.lr_publishdate"  class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,icons:iconClear,value:'${nowdate}'"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">生效日期：</td>
		    	<td ><input type="text"  name="t_Bus_LawRegulation.lr_startdate"  class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,icons:iconClear"/></td>
		  		
		  		<td class="sp-td1">有效日期：</td>
		    	<td ><input type="text"  name="t_Bus_LawRegulation.lr_effectivedate"  class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,icons:iconClear"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">状态：</td>
		    	<td ><input name="t_Bus_LawRegulation.lr_state" data-options="prompt:'请输入状态',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		  		
		  		<td class="sp-td1">存档路径：</td>
		    	<td ><input name="t_Bus_LawRegulation.lr_directory" data-options="prompt:'请输入存档路径',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">文档格式：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_format" data-options="prompt:'请输入文档格式',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td  class="sp-td1" >内容：</td>
		    	<td colspan="5">
		    		<textarea id="contentid" name="t_Bus_LawRegulation.lr_content" class="textarea" 
		    		  style="width: 680px;height: 200px;" ></textarea>
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
						<div id="fileList" style="width: 180px;"></div>
						</div>
	            </td>
			    </tr>
	    </table>
	    </div>
    </form>
