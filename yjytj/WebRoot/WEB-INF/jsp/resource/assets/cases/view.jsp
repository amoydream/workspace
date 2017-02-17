<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  </script>
	 
	<div id="casestabs" class="easyui-tabs" style="width:100%;" data-options="fit:true">
		<div title="基本信息" style="padding:20px;" >
		    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    <tr>
		        <td class="sp-td1">编号：</td>
				<td >${cases.code}</td>
				
				<td class="sp-td1">案例标题：</td>
				<input type="hidden" name="t_Bus_Cases.cas_id" value="${cases.cas_id }"/>
				<td >${cases.title}</td>
			</tr>
			<tr>
			
				<td class="sp-td1">地址：</td>
				<td colspan="3">${cases.address}</td>
			</tr>
			<tr>
				<td class="sp-td1">主题词：</td>
				<td >${cases.keyword}</td>
				
				<td class="sp-td1">相关危险源：</td>
				<td >${dangername}</td>
			</tr>
			<tr>
			    <td class="sp-td1">事件类型：</td>
		    	<td >${str:translate(cases.type,'EVTP')}</td>
			
				<td class="sp-td1">事件等级：</td> 
				<td>${str:translate(cases.eventlevelcode,'EVLV')}</td>
            
            </tr>
			<tr>
		    	<td class="sp-td1">开始时间：</td>
		        <td>${cases.starttime}</td>
			 
			    <td class="sp-td1">结束时间：</td>
		        <td>${cases.endtime}</td>
		    	
		    </tr>
		    <tr>    
			   
			    <td class="sp-td1">事发经度：</td>
		        <td>${cases.cas_longitude}</td>
		    	
		    	<td class="sp-td1">事发纬度：</td>
		        <td>${cases.cas_latitude}</td>
			        
		    </tr>
			<tr>
		    	<td class="sp-td1">数据来源单位：</td>
		        <td>${sourcedeptname}</td>
			 
			    <td class="sp-td1">最近更新时间：</td>
		        <td>${cases.updatetime}</td>
		    	
		    </tr>
			<tr>	
		    	
		    	<td class="sp-td1">摘要</td>
				<td colspan="3">${cases.caseabstract}</td>
		    	
		    </tr>
			<tr>
		    	
				<td class="sp-td1">备注</td>
				<td colspan="3">${cases.remark}</td>
			</tr>
			<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty cases.fjname}">
		    							<div id="fj_${cases.fjid}">
		    								<input type="hidden" value="${cases.fjid}" name="fjid" />
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${cases.fjid}">${cases.fjname}</a>（${cases.m_size}）
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		</td>
		    	</tr>
			    	
		    </table>
		    </div>
		    <div title="要素内容" data-options="" style="padding:0px;">
				<c:import url="../cases/element/main.jsp"></c:import>
		    </div>
   </div>
