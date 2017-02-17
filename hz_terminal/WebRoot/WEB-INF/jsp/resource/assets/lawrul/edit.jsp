<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
    		editor= KindEditor.create('#contenteditid',{
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
	htmlBody+="<span style='display:none'><input type='checkbox' name='addfileids' value='"+obj.id+"' checked/></span>";	
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
 
//删除文件ajax请求
function deleteExistFile(id){
	$.messager.confirm('删除','您确定要删除此附件吗？',function(y){
		if(y){		
			$("#existfile_"+id).load("<%=basePath%>Main/attachment/delete/"+id);
			$("#existfile_"+id).remove();			
		}
	});
}
</script>
    
    
 <form id="lawrulEdit" method="post" action="<%=basePath%>Main/lawrul/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input type="hidden" name="act" value="update"/>
	  <input type="hidden" id="lrattids" name="t_Bus_LawRegulation.lr_attachmentid" value="${lawrul.lr_attachmentid }"/>	  
	  <input type="hidden" name="t_Bus_LawRegulation.lr_id" value="${lawrul.lr_id }"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">标题：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_title" value="${lawrul.lr_title }" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入标题',required:true,icons:iconClear"  style="width:180px;"/>  </td>
		  		
		  		<td class="sp-td1">编号：</td>
		    	<td >
		    	<input name="t_Bus_LawRegulation.lr_code" value="${lawrul.lr_code }" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入编号',required:true,icons:iconClear"  style="width:180px;"/>
		  		</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">类别：</td>
		    	<td >
		    	<select class="easyui-combobox"
					name="t_Bus_LawRegulation.lr_type" panelHeight="auto" code="YJLAWRUL"
					style="width: 180px;"
					data-options="editable:false,value:'${lawrul.lr_type}'"></select>
		    	</td>
		  		
		  		<td class="sp-td1">副标题：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_subtitle" value="${lawrul.lr_subtitle }" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入副标题',required:true,icons:iconClear"  style="width:180px;"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">摘要内容：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_abstract" value="${lawrul.lr_abstract }" data-options="prompt:'请输入内容',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		  		
		  		<td class="sp-td1">范围：</td>
		    	<td ><input name="t_Bus_LawRegulation.lr_applyrang" value="${lawrul.lr_applyrang }" data-options="prompt:'请输入范围',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">部门：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_publishdept" value="${lawrul.lr_publishdept }" data-options="prompt:'请输入部门',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		  		
		  		<td class="sp-td1">创建日期：</td>
		    	<td ><input type="text"  name="t_Bus_LawRegulation.lr_publishdate" class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,icons:iconClear,value:'${lawrul.lr_publishdate }'"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">生效日期：</td>
		    	<td ><input type="text"  name="t_Bus_LawRegulation.lr_startdate" class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,icons:iconClear,value:'${lawrul.lr_startdate }'"/></td>
		  		
		  		<td class="sp-td1">有效日期：</td>
		    	<td ><input type="text"  name="t_Bus_LawRegulation.lr_effectivedate" value="${lawrul.lr_effectivedate }" class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,icons:iconClear,value:'${lawrul.lr_effectivedate }'"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">状态：</td>
		    	<td ><input name="t_Bus_LawRegulation.lr_state" value="${lawrul.lr_state }" data-options="prompt:'请输入状态',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		  		
		  		<td class="sp-td1">存档路径：</td>
		    	<td ><input name="t_Bus_LawRegulation.lr_directory" value="${lawrul.lr_directory }" data-options="prompt:'请输入存档路径',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">文档格式：</td>
		    	<td><input name="t_Bus_LawRegulation.lr_format" value="${lawrul.lr_format }" data-options="prompt:'请输入文档格式',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td  class="sp-td1" >内容：</td>
		    	<td colspan="5">
		    		<textarea id="contenteditid" name="t_Bus_LawRegulation.lr_content" class="textarea" 
		    		style="width: 680px;height: 200px;" >${lawrul.lr_content }</textarea>
		    	</td>		  		 	
		    	</tr>
		    	 <tr>
				<td class="sp-td1">已上传附件：</td>
				<td colspan="3">
			    	<div> 
				    <c:if test="${!empty fileList}">	           
				    <c:forEach items="${fileList}" var="list">
					<div id="existfile_${list.id}" style="height:25px;font-size:12px;line-height:25px;">
					<span style="display:none"><input type="checkbox" name="existfileids" value="${list.id}" checked/></span>
					<c:choose> 
					<c:when test="${list.m_type=='xls'||list.m_type=='xlsx'||list.m_type=='doc'||list.m_type=='docx'||list.m_type=='ppt'||list.m_type=='pptx'}">
					<a class="btnAttach" title="请点击打开"></a><a title="请点击打开" target="_blank" href="<%=basePath%>Main/document/getfileview/${list.id}-${list.m_type}">${list.name}<a/> （${list.m_size}）
					<a href="javascript:deleteExistFile(${list.id});"><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a>
					</c:when>
					<c:when test="${list.m_type=='pdf'}">
					<a class="btnAttach" title="请点击打开"></a><a title="请点击打开" target="_blank" href="<%=basePath%>Main/document/getpdfview?id=${list.id}&title=${list.name}">${list.name}<a/> （${list.m_size}）
					<a href="javascript:deleteExistFile(${list.id});"><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a>
					</c:when>
					<c:when test="${list.m_type=='jpg'||list.m_type=='gif'||list.m_type=='png' }">
					<a class="btnAttach" title="请点击打开"></a><a title="请点击打开" target="_blank" href="<%=basePath%>${list.url}">${list.name}<a/> （${list.m_size}）
					<a href="javascript:deleteExistFile(${list.id});"><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a>
					</c:when>
					<c:otherwise>
					<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${list.id}">${list.name}<a/> （${list.m_size}）
					<a href="javascript:deleteExistFile(${list.id});"><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a>
					</c:otherwise>
					</c:choose>					
				   </div>
			    </c:forEach>
           
	             </c:if>		    	
				</div>
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