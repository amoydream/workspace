<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  </script>
  
  <div id="colldepttabs" class="easyui-tabs" style="width:100%;" data-options="fit:true">
	 	<div title="募捐机构详情信息" style="padding:20px;" >
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td>
			    		${dept.deptname}
			    	</td>
			    	<td class="sp-td1">类型代码</td>
			    	<td>
			    		${str:translate(dept.depttypecode, 'YJJG')}
			    	</td>
			    	<td class="sp-td1">行政区域代码</td>
			    	<td>
			    		${str:translate(dept.districtcode, 'EVQY')}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">邮编</td>
			    	<td>
			    		${dept.postcode}
			    	</td>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		${dept.dutytel}
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		${dept.fax}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		${dept.respper}
			    	</td>
			    	<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		${dept.respotel}
			    	</td>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		${dept.respmtel}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		${dept.resphtel}
			    	</td>
			    	<td class="sp-td1">联系人</td>
			    	<td>
			    		${dept.contactper}
			    	</td>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		${dept.contactotel}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		${dept.contactmtel}
			    	</td>
			    	<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		${dept.contacthtel}
			    	</td>
		    		<td class="sp-td1">联系人电子邮箱</td>
			    	<td>
			    		${dept.contactemail}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主管单位</td>
			    	<td>
			    		${dept.chargedept}
			    	</td>
			    	<td class="sp-td1">主管单位地址</td>
			    	<td colspan="3">
			    		${dept.cdeptaddress}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">捐赠热线电话</td>
			    	<td>
			    		${dept.contacttel}
			    	</td>
			    	<td class="sp-td1">开户行</td>
			    	<td>
			    		${dept.openaccbank}
			    	</td>
			    	<td class="sp-td1">账户名称</td>
			    	<td>
			    		${dept.accountname}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">账户</td>
			    	<td>
			    		${dept.accounts}
			    	</td>
		    		<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		${str:translate(dept.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
			    	<td class="sp-td1">最新更新时间</td>
		    		<td colspan="5">
			    		${dept.updatetime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">地址</td>
			    	<td colspan="5">
			    		${dept.address}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">机构基本情况</td>
			    	<td colspan="5">
			    		${dept.deptdesc}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		${dept.notes}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty dept.fjname}">
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${dept.fjid}">${dept.fjname}</a>（${dept.m_size}）
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
    	</form>
	   </div>
	   
	   <div title="现存资金" style="padding:0px;">
	   	<c:import url="../collfund/main.jsp"></c:import>
	   </div>
	   
	   	 <div title="分项资金" style="padding:0px;">
	   		<c:import url="../subcollfund/main.jsp"></c:import>
	   </div>
</div>