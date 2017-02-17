<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  </script>
	 
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">上级栏目</td>
			    	<td >
			    		<c:choose>
			    		<c:when test="${empty pchannel}">顶级栏目</c:when>
			    		<c:otherwise>
			    			${pchannel.channelname}
			    		</c:otherwise>
			    		</c:choose>
			    	</td>
			    	<td class="sp-td1">是否单页</td>
			    	<td >
			    		<c:choose>
			    			<c:when test="${c.issinglepage == '1' }">
			    				是
			    			</c:when>
			    			<c:otherwise>
			    				否
			    			</c:otherwise>
			    		</c:choose>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">栏目名称</td>
			    	<td >
			    		${c.channelname}
			    	</td>
		    			<td class="sp-td1">访问路径</td>
			    	<td >
			    		${c.channelpath}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">meta标题</td>
			    	<td >
			    		${c.metatitle}
			    	</td>
		    		<td class="sp-td1">meta关键字</td>
			    	<td >
			    		${c.metakeywords}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">meta描述</td>
		    		<td colspan="3">
			    		${c.metadesc}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">栏目模板</td>
		    		<td>
		    			${c.channeltpl}
		    		</td>
		    		<td class="sp-td1">是否显示</td>
		    		<td>
		    			<c:choose>
		    			 <c:when test="${c.isdisplay == '1' }">是</c:when>
		    			 <c:otherwise>
		    			 否
		    			 </c:otherwise>
		    			 </c:choose>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">外部链接</td>
		    		<td>
		    			${c.outlink}
		    		</td>
		    		<td class="sp-td1">排列顺序</td>
		    		<td>
		    			${c.priority}
		    		</td>
		    	</tr>
		    	
		    	<tr <c:if test="${c.issinglepage == '0'}">style="display:none;"</c:if> >
		    		<td class="sp-td1">内容</td>
		    		<td colspan="3">
		    			${c.content}
		    		</td>
		    	</tr>
	    </table>
    </form>
