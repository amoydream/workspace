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
			  		<td class="sp-td1">标题</td>
			    	<td colspan="3">
			    		${kno.knotitle}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主题词</td>
			    	<td colspan="3">
			    		${kno.knokeyword}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">类型</td>
			    	<td >
			    		${str:translate(kno.typecode, 'GENEKNO')}
			    	</td>
		    		<td class="sp-td1">数据来源单位</td>
			    	<td >
			    		${str:translate(kno.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急常识来源</td>
		    		<td colspan="3">
						${kno.knosource}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最新更新日期</td>
		    		<td colspan="3">
			    		${kno.updatetime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急常识摘要</td>
		    		<td colspan="3">
			    	${kno.knoabstract}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		${kno.notes}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="3">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty kno.fjid}">
			    						<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${kno.fjid}">${kno.fjname}</a>（${kno.m_size}）
			    					</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
