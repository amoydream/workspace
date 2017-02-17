<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  </script>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">单位名称</td>
			    	<td>
			    		${firedept.deptname}
			    	</td>
			    	<td class="sp-td1">行政区域</td>
			    	<td>
			    		${str:translate(firedept.districtcode, 'EVQY')}
			    	</td>
			    	<td class="sp-td1">级别</td>
			    	<td>
			    		${str:translate(firedept.levelcode, 'ZDFHJBDM')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">邮编</td>
			    	<td>
			    		${firedept.postcode}
			    	</td>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		${firedept.dutytel}
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		${firedept.fax}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">消防员人数</td>
			    	<td>
			    		${firedept.firernum}
			    	</td>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		${firedept.respper}
			    	</td>
			    	<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		${firedept.respotel}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		${firedept.respmtel}
			    	</td>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		${firedept.resphtel}
			    	</td>
			    	<td class="sp-td1">联系人</td>
			    	<td>
			    		${firedept.contactper}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		${firedept.contactotel}
			    	</td>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		${firedept.contactmtel}
			    	</td>
			    	<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		${firedept.contacthtel}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人电子邮件</td>
			    	<td>
			    		${firedept.contactemail}
			    	</td>
			    	<td class="sp-td1">消防范围</td>
			    	<td colspan="3">
			    		${firedept.dominscope}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">坐标系统</td>
			    	<td>
			    		${str:translate(firedept.coordsyscode, 'ZDFHZBXT')}
			    	</td>
			    	<td class="sp-td1">高程基准</td>
			    	<td>
			    		${str:translate(firedept.elevadatumcode, 'ZDFHGCJZ')}
			    	</td>
			    	<td class="sp-td1">高程</td>
			    	<td>
			    		${firedept.elevation}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">经度</td>
			    	<td>
			    		${firedept.lng}
			    	</td>
			    	<td class="sp-td1">维度</td>
			    	<td>
			    		${firedept.lat}
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		${str:translate(firedept.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">地址</td>
			    	<td colspan="5">
			    		${firedept.address}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
		    			${firedept.notes}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty firedept.fjname}">
		    							<div id="fj_${firedept.fjid}">
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${firedept.fjid}">${firedept.fjname}</a>
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
