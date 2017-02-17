<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>

  </script><%--
  		<div id="transfirmtabs" class="easyui-tabs" style="width:100%" data-options="fit:true">
  		<div title="运输企业详情" style="padding:20px;">
	    --%><table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td>
			    		${firm.firmname}
			    	</td>
			    	<td class="sp-td1">类型</td>
			    	<td>
			    		${str:translate(firm.firmtypecode, 'YSBZJG')}
			    	</td>
			    	<td class="sp-td1">级别</td>
			    	<td>
			    		${str:translate(firm.levelcode, 'ZDFHJBDM')}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">密级</td>
			    	<td>
			    		${str:translate(firm.classcode, 'ZDFHMJDM')}
			    	</td>
			    	<td class="sp-td1">行政区域</td>
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
			    	<td class="sp-td1">主管单位</td>
			    	<td>
			    		${firm.chargedept}
			    	</td>
		    	</tr>
		    	<tr>
		    		
			    	<td class="sp-td1">主管单位地址</td>
			    	<td colspan="5">
			    		${firm.cdeptaddress}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">坐标系统</td>
			    	<td>
			    		${str:translate(firm.coordsyscode, 'ZDFHZBXT')}
			    	</td>
			    	<td class="sp-td1">高程基准</td>
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
		    		<td class="sp-td1">客运能力</td>
			    	<td colspan="5">
			    		${firm.passcap}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">货运能力</td>
			    	<td colspan="5">
			    		${firm.frecap}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急通信方式</td>
			    	<td colspan="5">
			    		${firm.commtype}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">企业基本情况</td>
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
	 </div><%--
	 <div title="运输工具" style="padding:0px;">
	 	<c:import url="../transtool/main.jsp"></c:import>
	 </div>
</div>--%>