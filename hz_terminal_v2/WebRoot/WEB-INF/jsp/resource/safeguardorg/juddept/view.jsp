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
			    		${juddept.deptname}
			    	</td>
			    	<td class="sp-td1">行政区域</td>
			    	<td>
			    		${str:translate(juddept.districtcode, 'EVQY')}
			    	</td>
			    	<td class="sp-td1">级别</td>
			    	<td>
			    		${str:translate(juddept.levelcode, 'ZDFHJBDM')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">邮编</td>
			    	<td>
			    		${juddept.postcode}
			    	</td>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		${juddept.dutytel}
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		${juddept.fax}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">警员人数</td>
			    	<td>
			    		${juddept.policenum}
			    	</td>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		${juddept.respper}
			    	</td>
			    	<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		${juddept.respotel}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		${juddept.respmtel}
			    	</td>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		${juddept.resphtel}
			    	</td>
			    	<td class="sp-td1">联系人</td>
			    	<td>
			    		${juddept.contactper}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		${juddept.contactotel}
			    	</td>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		${juddept.contactmtel}
			    	</td>
			    	<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		${juddept.contacthtel}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人电子邮件</td>
			    	<td>
			    		${juddept.contactemail}
			    	</td>
			    	<td class="sp-td1">经度</td>
			    	<td>
			    		${juddept.lng}
			    	</td>
			    	<td class="sp-td1">维度</td>
			    	<td>
			    		${juddept.lat}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">坐标系统</td>
			    	<td>
			    		${str:translate(juddept.coordsyscode, 'ZDFHZBXT')}
			    	</td>
			    	<td class="sp-td1">高程基准</td>
			    	<td>
			    		${str:translate(juddept.elevadatumcode, 'ZDFHGCJZ')}
			    	</td>
			    	<td class="sp-td1">高程</td>
			    	<td>
			    		${juddept.elevation}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		${str:translate(juddept.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
			    	<td class="sp-td1">地址</td>
			    	<td colspan="3">
			    		${juddept.address}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最新更新时间</td>
		    		<td colspan="5">
			    		${juddept.updatetime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		${juddept.notes}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty juddept.fjname}">
		    							<div id="fj_${juddept.fjid}">
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${juddept.fjid}">${juddept.fjname}</a>
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
