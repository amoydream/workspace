<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

	  <div data-options="region:'north',border:false" >
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">编号：</td>
		    	<td >${model.sto_code }</td>
		    	 
		  		<td class="sp-td1">物资名称：</td>
				<td >${materialname}</td>
		    	
		    	<tr>
		  		<td class="sp-td1">存放数量：</td>
		    	<td >${model.num }</td>
		    	
		  		<td class="sp-td1">所在仓库：</td>
		    	<td >${repertoryname}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">所属单位：</td>
		    	<td >${organ}</td>
		    	
		    	<td class="sp-td1">级别：</td>
		  		<td >${str:translate(model.levelcode,'MALEVE')}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">存放地点：</td>
		    	<td >${model.depositplace }</td>
		    	 
		    	<td class="sp-td1">负责人：</td>
		    	<td>${model.master }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">负责人电话：</td>
		    	<td>${model.mastertel }</td>
		    	
		    	<td class="sp-td1">负责人手机：</td>
		    	<td>${model.masterphone }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">联系人：</td>
		    	<td>${model.linkman }</td>
		    	
		    	<td class="sp-td1">联系人电话：</td>
		    	<td>${model.linkmantel }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">联系人手机：</td>
		    	<td>${model.linkmanphone }</td>
		    	
		    	<td class="sp-td1">联系人邮箱：</td>
		    	<td>${model.linkmanemail}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">计量单位 ：</td>
		    	<td >${str:translate(model.measureunit,'MAUNIT')}</td>
		    	
		    	<td class="sp-td1">保质期：</td>
		    	<td >${model.quaguaperiod}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">需要更换日期：</td>
		    	<td >${model.renewtime}</td>
		    	
		    	<td class="sp-td1">最近更新日期：</td>
		    	<td >${model.updatetime}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">物资描述：</td>
		    	<td colspan="3">${model.materialdesc}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">备注：</td>
		    	<td colspan="3">${model.remark}</td>
		    	</tr>
		    	
	    </table>
	    </div>
    </form>
