<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

	<table id="table" class="sp-table" width="100%" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="sp-td1">编号：</td>
			<td>${model.code}</td>

			<td class="sp-td1">要素标题：</td>
			<td>${model.content}</td>

		</tr>
		<tr>
			<td class="sp-td1">数据来源单位：</td>
			<td>${organ}</td>

			<td class="sp-td1">最近更新：</td>
			<td>${model.updatetime}</td>

		</tr>
		<tr>
			<td class="sp-td1">内容描述：</td>
			<td colspan="3">${model.elementdesc}</td>

		</tr>
		<tr>
			<td class="sp-td1">备注：</td>
			<td colspan="3">${model.remark}</td>
		</tr>
		<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty model.fjname}">
		    							<div id="fj_${model.fjid}">
		    								<input type="hidden" value="${model.fjid}" name="fjid" />
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${model.fjid}">${model.fjname}</a>（${model.m_size}）
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		</td>
		    	</tr>
	</table>
</form>
