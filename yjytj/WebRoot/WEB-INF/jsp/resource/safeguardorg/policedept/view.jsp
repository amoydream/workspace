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
			    		${poldept.deptname}
			    	</td>
			    	<td class="sp-td1">行政区域代码</td>
			    	<td>
			    		${str:translate(poldept.districtcode, 'EVQY')}
			    	</td>
			    	<td class="sp-td1">级别代码</td>
			    	<td>
			    		${str:translate(poldept.levelcode, 'ZDFHJBDM')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">邮编</td>
			    	<td>
			    		${poldept.postcode}
			    	</td>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		${poldept.dutytel}
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		${poldept.fax}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">警员人数</td>
			    	<td>
			    		${poldept.policenum}
			    	</td>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		${poldept.respper}
			    	</td>
			    	<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		${poldept.respotel}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		${poldept.respmtel}
			    	</td>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		${poldept.resphtel}
			    	</td>
			    	<td class="sp-td1">联系人</td>
			    	<td>
			    		${poldept.contactper}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		${poldept.contactotel}
			    	</td>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		${poldept.contactmtel}
			    	</td>
			    	<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		${poldept.contacthtel}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人电子邮件</td>
			    	<td>
			    		${poldept.contactemail}
			    	</td>
			    	<td class="sp-td1">管辖范围</td>
			    	<td colspan="3">
			    		${poldept.dominscope}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">坐标系统代码</td>
			    	<td>
			    		${str:translate(poldept.coordsyscode, 'ZDFHZBXT')}
			    	</td>
			    	<td class="sp-td1">高程基准代码代码</td>
			    	<td>
			    		${str:translate(poldept.elevadatumcode, 'ZDFHGCJZ')}
			    	</td>
			    	<td class="sp-td1">高程</td>
			    	<td>
			    		${poldept.elevation}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">经度</td>
			    	<td>
			    		${poldept.lng}
			    	</td>
			    	<td class="sp-td1">维度</td>
			    	<td>
			    		${poldept.lat}
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		${str:translate(poldept.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最新更新时间</td>
			    	<td colspan="5">
			    		${poldept.updatetime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">地址</td>
			    	<td colspan="5">
			    		${poldept.address}
			    	</td>
			    	
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		${poldept.notes}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty poldept.fjid}">
		    							<div id="fj_${poldept.fjid}">
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${poldept.fjid}">${poldept.fjname}</a>（${poldept.m_size}）
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
