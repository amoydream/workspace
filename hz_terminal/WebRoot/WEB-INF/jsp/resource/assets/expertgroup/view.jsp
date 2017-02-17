<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  </script>
	 
	<div id="exgrouptabs" class="easyui-tabs" style="width:100%;" data-options="fit:true">
		<div title="基本信息" style="padding:20px;" >
		    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    <tr>
				<td class="sp-td1">专家组名称：</td>
				<td>${exgroup.eg_name}</td>

				<td class="sp-td1">专家组类型：</td>
				<td>${str:translate(exgroup.egtype,'EGTYPE')}</td>
			</tr>
			    <td class="sp-td1">组建单位：</td>
				<td>${buildorganname}</td>
	
				<td class="sp-td1">人员数</td>
				<td>${exgroup.num}</td>
			<tr>
				<td class="sp-td1">负责人</td>
				<td>${exgroup.master}</td>

				<td class="sp-td1">负责人电话</td>
				<td>${exgroup.mastertel}</td>

			</tr>
			<tr>
				<td class="sp-td1">负责人手机</td>
				<td>${exgroup.masterphone}</td>

				<td class="sp-td1">负责人邮箱</td>
				<td>${exgroup.masteremail}</td>
		    </tr>
			<tr>
				<td class="sp-td1">最近更新时间</td>
				<td colspan="3">${exgroup.updatetime}</td>

			</tr>
			<tr>
				<td class="sp-td1">队伍描述</td>
				<td colspan="3">${exgroup.egdesc}</td>
			</tr>
			<tr>
				<td class="sp-td1">备注</td>
				<td colspan="3">${exgroup.remark}</td>
			</tr>
			<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty exgroup.fjname}">
		    							<div id="fj_${exgroup.fjid}">
		    								<input type="hidden" value="${exgroup.fjid}" name="fjid" />
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${exgroup.fjid}">${exgroup.fjname}</a>（${exgroup.m_size}）
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		</td>
		    	</tr>
			    	
		    </table>
		    </div>
		    <div title="组成员" data-options="" style="padding:0px;">
				<c:import url="../expertgroup/per/main.jsp"></c:import>
		    </div>
   </div>
