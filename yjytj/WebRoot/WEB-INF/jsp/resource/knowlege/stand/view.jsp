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
			  		<td class="sp-td1">名称</td>
			    	<td colspan="3">
			    		${s.standname}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">标准号</td>
			    	<td>
			    		${s.fileno}
			    	</td>
			    	<td class="sp-td1">类型</td>
			    	<td >
			    		${str:translate(s.standtypecode, 'GENEKNO')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主题词</td>
		    		<td colspan="3">
			    		${s.standkeyword}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">适用等级</td>
		    		<td>
			    		${str:translate(s.standlevelcode, 'SYLEVEL')}
			    	</td>
			    	<td class="sp-td1">法律效力</td>
		    		<td>
			    		${str:translate(s.lawforce, 'LAWPOWER')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">发布时间</td>
		    		<td>
		    			${s.pubdate}
		    		</td>
		    		<td class="sp-td1">生效时间</td>
		    		<td>
		    			${s.effdate}
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">制定单位</td>
			    	<td>
			    		${s.createorg}
			    	</td>
		    		<td class="sp-td1">数据来源单位</td>
			    	<td >
			    		${str:translate(s.sourcedeptcode,'ZDFHSJLYDW')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最新更新时间</td>
		    		<td colspan="3">
			    		${s.updatetime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">摘要</td>
		    		<td colspan="3">
			    		${s.standabstract}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		${s.notes}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="3">
    					<div id="filebox" style="width:450px;">
    						<c:if test="${! empty s.fjid}">
    							<div id="fj_${s.fjid}">
    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${s.fjid}">${s.fjname}</a>（${s.m_size}）
    							</div>
    						</c:if>
    					</div>
		    		
		    		</td>
		    	</tr>
	    </table>
