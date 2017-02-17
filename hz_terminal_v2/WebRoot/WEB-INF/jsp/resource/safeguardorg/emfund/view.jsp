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
			    		${fund.fundname}
			    	</td>
			    	<td class="sp-td1">类型代码</td>
			    	<td>
			    		${str:translate(fund.firmtypecode, 'YJCLBZ')}
			    	</td>
			    	<td class="sp-td1">级别代码</td>
			    	<td>
			    		${str:translate(fund.levelcode, 'ZDFHJBDM')}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">密级代码</td>
			    	<td>
			    		${str:translate(fund.classcode, 'ZDFHMJDM')}
			    	</td>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		${fund.dutytel}
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		${fund.fax}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		${fund.respper}
			    	</td>
			    	<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		${fund.respotel}
			    	</td>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		${fund.respmtel}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		${fund.resphtel}
			    	</td>
			    	<td class="sp-td1">联系人</td>
			    	<td>
			    		${fund.contactper}
			    	</td>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		${fund.contactotel}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		${fund.contactmtel}
			    	</td>
			    	<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		${fund.contacthtel}
			    	</td>
		    		<td class="sp-td1">联系人电子邮箱</td>
			    	<td>
			    		${fund.contactemail}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">主管单位</td>
			    	<td>
			    		${fund.chargedept}
			    	</td>
			    	<td class="sp-td1">主管单位地址</td>
			    	<td colspan="3">
			    		${fund.cdeptaddress}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">资金来源代码</td>
			    	<td>
			    		${str:translate(fund.fundsourcecode, 'FUNDCOME')}
			    	</td>
			    	<td class="sp-td1">资金金额（万）</td>
			    	<td>
			    		${fund.amount}
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		${str:translate(fund.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最新更新时间</td>
		    		<td colspan="5">
			    		${fund.updatetime}
			    	</td>
			    </tr>
		    	<tr>
		    		<td class="sp-td1">资金用途</td>
			    	<td colspan="5">
			    		${fund.purpose}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    	${fund.notes}
			    	</td>
		    	</tr>
	    </table>
