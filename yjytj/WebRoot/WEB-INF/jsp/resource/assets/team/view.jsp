<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<style>
.call-td{ background:#F1F7FF; color:#FF5809;border-right:1px solid #B9CDE3;text-align:left;font-size:15px;}
</style>
  <script>
  </script>
	 
	<div id="teamtabs" class="easyui-tabs" style="width:100%;" data-options="fit:true">
		<div title="队伍详情" style="padding:20px;" >
		    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
			    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td >
			    		${team.name}
			    	</td>
			    	
			    	<td class="sp-td1">队伍类型：</td>
			    	<td>${str:translate(team.type,'YJDW')}</td>
            
			    	
			    </tr>
		    	<tr>	
			    	<td class="sp-td1">人员数</td>
			    	<td >${team.membernum}</td>
			    
			        <td class="sp-td1">所属单位：</td>
		    	    <td >${organ}
		    	    </td>
		    	    
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人</td>
			    	<td >${team.master}</td>
			    	
		    	<td class="sp-td1">负责人电话</td>
			    <td class="call-td">		    		
		        <ul class="specil_button">
		        <li><span>${team.mastertel}</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="callout(${team.mastertel},null);"><span></span>拨打</a></li></ul>
		    	</td>
			    	
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">负责人手机</td>	
			    <td class="call-td">		    		
		        <ul class="specil_button">
		        <li><span>${team.masterphone}</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="callout(${team.masterphone},null);"><span></span>拨打</a></li></ul>
		    	</td>
			    	
		    		<td class="sp-td1">负责人邮箱</td>
			    	<td >${team.masteremail}</td>
			    	
			    </tr>
		    	<tr>
		    		<td class="sp-td1">联系人</td>
			    	<td >${team.linkman}</td>
			    	
		    		<td class="sp-td1">联系人电话</td>			 
			    <td class="call-td">		    		
		        <ul class="specil_button">
		        <li><span>${team.linkmantel}</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="callout(${team.linkmantel},null);"><span></span>拨打</a></li></ul>
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">联系人手机</td>
			    <td class="call-td">		    		
		        <ul class="specil_button">
		        <li><span>${team.linkmanphone}</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="callout(${team.linkmanphone},null);"><span></span>拨打</a></li></ul>
		    	</td>
			    	
			    	
			    	<td class="sp-td1">值班电话</td>
			    <td class="call-td">		    		
		        <ul class="specil_button">
		        <li><span>${team.dutytel}</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="callout(${team.dutytel},null);"><span></span>拨打</a></li></ul>
		    	</td>
			    	
		    	</tr>
		    	<tr>   
		  		    <td  class="sp-td1" >经度：</td>
		    	    <td >${team.tea_longitude}</td>
		    	    
			    	<td  class="sp-td1" >纬度：</td>
			    	<td >${team.tea_latitude}</td>
			    
			    </tr>
		    	<tr> 	
			    	<td class="sp-td1">最近更新时间</td>
			    	<td colspan="3">${team.updatetime}</td>
		    	    </td>
			    	
			    </tr>
		    	<tr>
		    	    <td class="sp-td1">所在地址：</td>
		    	    <td colspan="3">${team.address}</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">装备描述</td>
			    	<td colspan="3">${team.equipdesc}</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">队伍职责</td>
			    	<td colspan="3">${team.teamjob}</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">备注</td>
			    	<td colspan="3">${team.remark}</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty team.fjname}">
		    							<div id="fj_${team.fjid}">
		    								<input type="hidden" value="${team.fjid}" name="fjid" />
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${team.fjid}">${team.fjname}</a>（${team.m_size}）
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		</td>
		    	</tr>
		    </table>
		    </div>
		    <div title="人员信息" data-options="" style="padding:0px;">
				<c:import url="../team/person/main.jsp"></c:import>
		    </div>
		    
		    <div title="装备信息" data-options="" style="padding:0px;">
				<c:import url="../team/equip/main.jsp"></c:import>
		    </div>
		    
   </div>
