<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

	  <div data-options="region:'north',border:false">
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
	    <td class="sp-td1">编号：</td>
		<td>${model.code}</td>
	    
	    <td class="sp-td1">装备名称：</td>
		<td >${equipname}</td>
		
		</tr>
		<tr>
		<td class="sp-td1">数量：</td>
		<td>${model.equipnum}</td>
		
		<td class="sp-td1">主管单位：</td>
		<td>${organ}</td>
	    
	    </tr>
		<tr>
	    <td class="sp-td1">存放地址：</td>
		<td colspan="3">${model.address}</td>
		
		</tr>
		<tr>
		<td class="sp-td1">经度：</td>
		<td>${model.longitude}</td>
		
		<td class="sp-td1">纬度：</td>
		<td>${model.latitude}</td>
		</tr>
		<tr>
		
	    </tr>
		<tr>
		<td class="sp-td1">级别：</td>
		<td>${str:translate(model.levelcode,'MALEVE')}</td>
		
		<td class="sp-td1">联系人：</td>
		<td>${model.linkman}</td>
		
		</tr>
		<tr>
			
		<td class="sp-td1">联系人电话：</td>
		<td>${model.linkmantel}</td>
		
		<td class="sp-td1">联系人手机：</td>
		<td>${model.linkmanphone}</td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">联系人邮箱：</td>
		<td>${model.linkmanemail}</td>
		
		<td class="sp-td1">数据来源单位：</td>
		<td>${sourcedept}</td>
		
		</tr>
		<tr>
		<td class="sp-td1">保质期：</td>
		<td>${model.quaguaperiod}</td>
		
		<td class="sp-td1">最近更新日期：</td>
		<td >${model.updatetime}</td>
			
		</tr>
		<tr>
		<td class="sp-td1">运输方式：</td>
		<td colspan="3">${model.conveymode}</td>	
		
		</tr>
		<tr>
		
		<td class="sp-td1">日常使用情况：</td>
		<td colspan="3">${model.usedesc}</td>	
		
		</tr>
		<tr>
		
		<td class="sp-td1">装备描述：</td>
		<td colspan="3">${model.equipdesc}</td>	
		
		</tr>
		<tr>
		
		<td class="sp-td1">备注：</td>
		<td colspan="3">${model.remark}</td>		
		
		</tr>
		<tr>
		    	
	    </table>
	    </div>
    </form>
