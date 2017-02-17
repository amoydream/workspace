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
			  		<td class="sp-td1">名称</td>
			    	<td>
			    		${firm.firmname}
			    	</td>
			    	<td class="sp-td1">类型代码</td>
			    	<td>
			    		${str:translate(firm.firmtypecode, 'TXBZJG')}
			    	</td>
			    	<td class="sp-td1">级别代码</td>
			    	<td>
			    		${str:translate(firm.levelcode, 'ZDFHJBDM')}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">密级代码</td>
			    	<td>
			    		${str:translate(firm.classcode, 'ZDFHMJDM')}
			    	</td>
			    	<td class="sp-td1">行政区域代码</td>
			    	<td>
			    		${str:translate(firm.districtcode, 'EVQY')}
			    	</td>
			    	<td class="sp-td1">邮编</td>
			    	<td>
			    		${firm.postcode}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		${firm.dutytel}
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		${firm.fax}
			    	</td>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		${firm.respper}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		${firm.respotel}
			    	</td>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		${firm.respmtel}
			    	</td>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		${firm.resphtel}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人</td>
			    	<td>
			    		${firm.contactper}
			    	</td>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		${firm.contactotel}
			    	</td>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		${firm.contactmtel}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		${firm.contacthtel}
			    	</td>
		    		<td class="sp-td1">联系人电子邮箱</td>
			    	<td>
			    		${firm.contactemail}
			    	</td>
			    	<td class="sp-td1">应急通信车数</td>
			    	<td>
			    		${firm.commvehnum}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急发电车数</td>
			    	<td>
			    		${firm.powervehnum}
			    	</td>
		    		<td class="sp-td1">卫星电话数</td>
			    	<td>
			    		${firm.sattelnum}
			    	</td>
			    	<td class="sp-td1">基站总数</td>
			    	<td>
			    		${firm.basestationnum}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主管单位</td>
			    	<td>
			    		${firm.chargedept}
			    	</td>
			    	<td class="sp-td1">主管单位地址</td>
			    	<td colspan="3">
			    		${firm.cdeptaddress}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">坐标系统代码</td>
			    	<td>
			    		${str:translate(firm.coordsyscode, 'ZDFHZBXT')}
			    	</td>
			    	<td class="sp-td1">高程基准代码代码</td>
			    	<td>
			    		${str:translate(firm.elevadatumcode, 'ZDFHGCJZ')}
			    	</td>
			    	<td class="sp-td1">高程</td>
			    	<td>
			    		${firm.elevation}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">经度</td>
			    	<td>
			    		${firm.lng}
			    	</td>
			    	<td class="sp-td1">维度</td>
			    	<td>
			    		${firm.lat}
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		${str:translate(firm.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最新更新时间</td>
			    	<td colspan="5">
			    		${firm.updatetime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">地址</td>
			    	<td colspan="5">
			    		${firm.address}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">机构基本情况</td>
			    	<td colspan="5">
			    		${firm.firmdesc}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急能力描述</td>
			    	<td colspan="5">
			    		${firm.emcapdesc}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急通信方式</td>
			    	<td colspan="5">
			    		${firm.commtype}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		${firm.notes}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty firm.fjname}">
		    							<div id="fj_${firm.fjid}">
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${firm.fjid}">${firm.fjname}</a>（${firm.m_size}）
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
