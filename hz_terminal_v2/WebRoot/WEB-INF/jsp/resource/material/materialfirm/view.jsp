<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  </script>
	 
	<div id="mafirmtabs" class="easyui-tabs" style="width:100%;" data-options="fit:true">
		<div title="基本信息" style="padding:20px;" >
		    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    <tr>
				<td class="sp-td1">企业名称：</td>
				<td>${model.mf_name }</td>

				<td class="sp-td1">企业类型：</td>
				<td>${str:translate(model.mftype,'ORGA')}</td>
			</tr>

			<tr>
				<td class="sp-td1">所属单位：</td>
				<td>${organname}</td>

				<td class="sp-td1">值班电话：</td>
				<td>${model.dutytel }</td>
			</tr>

			<tr>
				<td class="sp-td1">经度：</td>
				<td>${model.longitude }</td>
				
				<td class="sp-td1">纬度：</td>
				<td>${model.latitude }</td>
			</tr>

			<tr>
				<td class="sp-td1">传真：</td>
				<td>${model.fax }</td>

				<td class="sp-td1">负责人</td>
				<td>${model.master }</td>
			</tr>

			<tr>
				<td class="sp-td1">负责人电话</td>
				<td>${model.mastertel }</td>

				<td class="sp-td1">负责人手机</td>
				<td>${model.masterphone }</td>
			</tr>

			<tr>
				<td class="sp-td1">联系人</td>
				<td>${model.linkman }</td>

				<td class="sp-td1">联系人电话</td>
				<td>${model.linkmantel }</td>
			</tr>

			<tr>
				<td class="sp-td1">联系人手机</td>
				<td>${model.linkmanphone }</td>

				<td class="sp-td1">最近更新时间</td>
				<td>${model.updatetime}</td>
			</tr>
			<tr>
				<td class="sp-td1">地址</td>
				<td colspan="3">${model.address}</td>
			</tr>
			<tr>
				<td class="sp-td1">生产物资</td>
				<td colspan="3">${model.materialdesc}</td>
			</tr>
			<tr>
				<td class="sp-td1">生产能力</td>
				<td colspan="3">${model.procap}</td>
			</tr>
			<tr>
				<td class="sp-td1">备注</td>
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
		    </div>
		    <div title="生产能力" data-options="" style="padding:0px;">
				<c:import url="../materialfirm/materialcap/main.jsp"></c:import>
		    </div>
   </div>
