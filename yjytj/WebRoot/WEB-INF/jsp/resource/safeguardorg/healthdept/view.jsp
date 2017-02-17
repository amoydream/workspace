<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
  <script>


  </script>
	 
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td>
			    		${hdept.deptname}
			    	</td>
			    	<td class="sp-td1">类型</td>
			    	<td>
			    		${str:translate(hdept.depttypecode, 'YLWSZY')}
			    	</td>
			    	<td class="sp-td1">单位等级</td>
			    	<td>
			    		${str:translate(hdept.deptgradecode, 'YLDWGRADE')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">级别</td>
			    	<td>
			    		${str:translate(hdept.levelcode, 'ZDFHJBDM')}
			    	</td>
			    	<td class="sp-td1">密级</td>
			    	<td>
			    		${str:translate(hdept.classcode, 'ZDFHMJDM')}
			    	</td>
			    	<td class="sp-td1">行政区域</td>
			    	<td>
			    		${str:translate(hdept.districtcode, 'EVQY')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">邮编</td>
			    	<td>
			    		${hdept.postcode}
			    	</td>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		${hdept.dutytel}
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		${hdept.fax}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		${hdept.respper}
			    	</td>
			    	<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		${hdept.respotel}
			    	</td>
			    	<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		${hdept.respmtel}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		${hdept.resphtel}
			    	</td>
			    	<td class="sp-td1">联系人</td>
			    	<td>
			    		${hdept.contactper}
			    	</td>
			    	<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		${hdept.contactotel}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		${hdept.contactmtel}
			    	</td>
			    	<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		${hdept.contacthtel}
			    	</td>
			    	<td class="sp-td1">联系人电子邮件</td>
			    	<td>
			    		${hdept.contactemail}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">病床数</td>
			    	<td>
			    		${hdept.bednum}
			    	</td>
			    	<td class="sp-td1">医生数</td>
			    	<td>
			    		${hdept.doctornum}
			    	</td>
			    	<td class="sp-td1">护士数</td>
			    	<td>
			    		${hdept.nursenum}
			    	</td>
		    	</tr>
		    	<tr>
		    		
			    	<td class="sp-td1">急救车辆数量</td>
			    	<td>
			    		${hdept.ambulancenum}
			    	</td>
			    	<td class="sp-td1">经度</td>
			    	<td>
			    		${hdept.lng}
			    	</td>
			    	<td class="sp-td1">维度</td>
			    	<td>
			    		${hdept.lat}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主管单位</td>
			    	<td>
			    		${hdept.chargedept}
			    	</td>
			    	<td class="sp-td1">主管单位地址</td>
			    	<td colspan="3">
			    		${hdept.cdeptaddress}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">坐标系统代码</td>
			    	<td>
			    		${str:translate(hdept.coordsyscode, 'ZDFHZBXT')}
			    	</td>
			    	<td class="sp-td1">高程基准代码代码</td>
			    	<td>
			    		${str:translate(hdept.elevadatumcode, 'ZDFHGCJZ')}
			    	</td>
			    	<td class="sp-td1">高程</td>
			    	<td>
			    		${hdept.elevation}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		${str:translate(hdept.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
			    	<td class="sp-td1">最新更新时间</td>
			    	<td colspan="3">
			    		${hdept.updatetime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">地址</td>
			    	<td colspan="5">
			    		${hdept.address}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">抗震设防烈度</td>
			    	<td colspan="5">
			    		${hdept.aseisinten}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急通信方式</td>
			    	<td colspan="5">
			    		${hdept.commtype}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主要医疗装备</td>
			    	<td colspan="5">
			    		${hdept.equipdesc}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">特色</td>
			    	<td colspan="5">
			    		${hdept.mainfeature}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		${hdept.notes}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty hdept.fjname}">
		    							<div id="fj_${hdept.fjid}">
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${hdept.fjid}">${hdept.fjname}</a>（${hdept.m_size}）
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
