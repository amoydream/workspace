<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

	  <div data-options="region:'north',border:false" style="height:130px;">
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
	    <td class="sp-td1">物资名称：</td>
		<td>${model.mn_name}</td>
		
		<td class="sp-td1">物资类型：</td>
		<td>${typename}</td>
		</tr>
		<tr>
		<td class="sp-td1">型号：</td>
		<td>${model.typeclass}</td>
			
		<td class="sp-td1">规格：</td>
		<td>${model.sizeclass}</td>
		
		</tr>
		<tr>
		<td class="sp-td1">计量单位：</td>
		<td colspan="3">${str:translate(model.measureunit,'MAUNIT')}</td></tr>
		<tr>
		
		<td class="sp-td1">备注：</td>
		<td colspan="3">${model.remark}</td>		
		
		</tr>
		<tr>
		    	
	    </table>
	    </div>
    </form>
