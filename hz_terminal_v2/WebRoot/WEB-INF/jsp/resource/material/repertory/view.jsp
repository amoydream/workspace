<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

	  <div data-options="region:'north',border:false" style="height:130px;">
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">编号：</td>
		    	<td >${model.code }</td>
		    	 
		  		<td class="sp-td1">名称：</td>
		    	<td>${model.name }</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">级别：</td>
		    	<td >${str:translate(model.levelcode,'MALEVE')}</td>
		    	
		    	<td class="sp-td1">值班电话：</td>
		    	<td >${model.dutytel }</td>
		    	</tr>
		  		
		    	<tr>
		    	<td class="sp-td1">地址：</td>
		    	<td colspan="3">${model.address }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">传真：</td>
		    	<td >${model.fax }</td>
		    	
		    	<td class="sp-td1">负责人：</td>
		    	<td >${model.master }</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">负责人电话：</td>
		    	<td>${model.mastertel }</td>
		    	
		    	<td class="sp-td1">负责人手机：</td>
		    	<td>${model.masterphone }</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">联系人：</td>
		    	<td >${model.linkman }</td>
		    	 
		    	<td class="sp-td1">联系人电话：</td>
		    	<td>${model.linkmantel }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">联系人手机：</td>
		    	<td>${model.linkmanphone }</td>
		    	
		    	<td class="sp-td1">联系人Email：</td>
		    	<td>${model.linkmanemail }</td>
		    	</tr>

			<tr>
				<td class="sp-td1">所属单位：</td>
				<td>${organ}</td>

				<td class="sp-td1">经度：</td>
				<td>${model.longitude}</td>
			</tr>

			<tr>
				<td class="sp-td1">纬度：</td>
				<td>${model.latitude}</td>

				<td class="sp-td1">面积：</td>
				<td>${model.area}</td>
			</tr>

			<tr>
		    	<td class="sp-td1">人数：</td>
		    	<td >${model.personnum }</td>
		    	 
		    	<td class="sp-td1">投入使用日期：</td>
		    	<td>${model.inusedate}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">设计使用年限：</td>
		    	<td >${model.useyearnum }</td>
		    	 
		    	<td class="sp-td1">防护等级：</td>
		    	<td >${str:translate(model.deflevelcode,'MADEFE')}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">可容纳人数：</td>
		    	<td >${model.maxpersonnum }</td>
		    	 
		    	<td class="sp-td1">库容：</td>
		    	<td >${model.capacity }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">监测方式：</td>
		    	<td>${model.monitmode }</td>
		    	
		    	<td class="sp-td1">最近更新日期：</td>
		    	<td>${model.updatetime}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">周边交通情况：</td>
		    	<td colspan="3">${model.traffic }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">受灾形式：</td>
		    	<td colspan="3">${model.disasterform }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">应急通讯方式：</td>
		    	<td colspan="3">${model.commtype }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">防护区域：</td>
		    	<td colspan="3">${model.defencearea }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">防护措施：</td>
		    	<td colspan="3">${model.defencestep }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">交通运输力量：</td>
		    	<td colspan="3">${model.trafficcap }</td>
		    	</tr>
		    	<tr>
		    	
		    	<tr>
		    	<td class="sp-td1">基本情况：</td>
		    	<td colspan="3">${model.description}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">储备物资：</td>
		    	<td colspan="3">${model.material}</td>
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
	    </div>
    </form>
