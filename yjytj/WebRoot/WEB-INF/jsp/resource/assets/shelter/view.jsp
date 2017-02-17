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
		    	 
		  		<td class="sp-td1">避难场所名称：</td>
		    	<td>${model.name }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">类别：</td>
		    	<td >${str:translate(model.type,'SHTYPE')}</td>
		    	
		  		<td class="sp-td1">所属单位：</td>
		    	<td >${organ}</td>
		  		</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">面积：</td>
		    	<td>${model.area }</td>
		    	
		    	<td class="sp-td1">容纳人数：</td>
		    	<td >${model.galleryful }</td></tr>
		    	
		    	<tr>
		    	<td class="sp-td1">经度：</td>
		    	<td>${model.longitude}</td>
		  		
		  		<td class="sp-td1">纬度：</td>
		    	<td >${model.latitude }</td>
		    	 </tr>
		    	
		    	<tr>
		    	<td class="sp-td1">联系人：</td>
		    	<td>${model.linkman }</td>
		    	
		  		<td class="sp-td1">联系人电话：</td>
		    	<td>${model.linkmantel }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">避难所电话：</td>
		    	<td>${model.sheltertel }</td>
		    	
		  		<td class="sp-td1">传真：</td>
		    	<td >${model.fax}</td>
		    	 </tr>
		    	 
		    	<tr>
		    	<td class="sp-td1">所在地址：</td>
		    	<td colspan="3">${model.address }</td>
		    	</tr>

		    	<tr>
		    	<td class="sp-td1">用途：</td>
		    	<td colspan="3">${model.use }</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">备注</td>
		    	<td colspan="3">${model.remark }</td>
		    	</tr>
		    	
	    </table>
	    </div>
    </form>
