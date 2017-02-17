<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	var editor;
	KindEditor.options.imageTabIndex = 1;
	editor= KindEditor.create('#contentviewid',{
		filePostName:'file',
		allowFileManager:true,
		items: ['fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'cut', 'copy', 'paste','plainpaste', 'wordpaste','|', 
				'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist'],
		afterBlur: function(){ editor.sync(); }
	});   
 });   
</script>
  <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
   	<tr>
   	<td class="sp-td1">标题：</td>
   	<td >${lawrul.lr_title}</td>	    
   	<td class="sp-td1">编号：</td>
   	<td >${lawrul.lr_code}</td>	    
       </tr>
   	<tr>
   	<td class="sp-td1">类别：</td>
   	<td >
   	${str:translate(lawrul.lr_type,'YJLAWRUL')}
   	</td>	    
   	<td class="sp-td1">副标题：</td>
   	<td >${lawrul.lr_subtitle}</td>	    
       </tr>
   	 <tr> 
   	 <td class="sp-td1">范围：</td>
   	 <td >${lawrul.lr_applyrang}</td>	 
   	 <td class="sp-td1">部门：</td>
   	 <td >${lawrul.lr_publishdept}</td>	 
       </tr>	
   	 <tr>
   	  <td class="sp-td1">创建日期：</td>
   	 <td >${lawrul.lr_publishdate}</td>	 
   	 <td class="sp-td1">生效日期：</td>
   	 <td >${lawrul.lr_startdate}</td>	 
       </tr>	
   	 <tr>
   	 <td class="sp-td1">有效日期：</td>
   	 <td >${lawrul.lr_effectivedate}</td>	 
   	 <td class="sp-td1">状态：</td>
   	 <td >${lawrul.lr_state}</td>	 
       </tr>	
   	 <tr>
   	 <td class="sp-td1">存档路径：</td>
   	 <td >${lawrul.lr_directory}</td>	 
   	 <td class="sp-td1">文档格式：</td>
   	 <td >${lawrul.lr_format}</td>	 		    	 
       </tr>	
   	 <tr>
   	 <td class="sp-td1">摘要内容：</td>
   	 <td colspan="3">${lawrul.lr_abstract}</td>	
       </tr>	
       <tr>
    <td class="sp-td1">内容：</td>
    <td colspan="5">
   		<textarea id="contentviewid" class="textarea" 
   		style="width: 680px;height: 200px;" >${lawrul.lr_content }</textarea>
   	</td>		 
       </tr>	
       <tr>
	<td class="sp-td1">附件信息：</td>
	<td colspan="3">
    	<div> 
	    <c:if test="${!empty fileList}">	           
	    <c:forEach items="${fileList}" var="list">
		<div id="existfile_${list.id}" style="height:25px;font-size:12px;line-height:25px;">
		<span style="display:none"><input type="checkbox" name="existfileids" value="${list.id}" checked/></span>
		<c:choose> 
		<c:when test="${list.m_type=='xls'||list.m_type=='xlsx'||list.m_type=='doc'||list.m_type=='docx'||list.m_type=='ppt'||list.m_type=='pptx'}">
		<a class="btnAttach" title="请点击打开"></a><a title="请点击打开" target="_blank" href="<%=basePath%>Main/document/getfileview/${list.id}-${list.m_type}">${list.name}<a/> （${list.m_size}）
		</c:when>
		<c:when test="${list.m_type=='pdf'}">
		<a class="btnAttach" title="请点击打开"></a><a title="请点击打开" target="_blank" href="<%=basePath%>Main/document/getpdfview?id=${list.id}&title=${list.name}">${list.name}<a/> （${list.m_size}）		
		</c:when>
		<c:when test="${list.m_type=='jpg'||list.m_type=='gif'||list.m_type=='png' }">
		<a class="btnAttach" title="请点击打开"></a><a title="请点击打开" target="_blank" href="<%=basePath%>${list.url}">${list.name}<a/> （${list.m_size}）
		</c:when>
		<c:otherwise>
		<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${list.id}">${list.name}<a/> （${list.m_size}）
		</c:otherwise>
		</c:choose>					
	   </div>
    </c:forEach>
        
           </c:if>		    	
	</div>
          </td>
    </tr>    
  </table>