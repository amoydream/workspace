<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
function planLawClick(lrid){
	$(document.body).append("<div id='planlawDialog'></div>");
	$("#planlawDialog").dialog({
		title : '法律法规详情',
		width : 800,
		height : 500,
		cache : false,
		modal : true,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href : '<%=basePath%>Main/lawrul/view/' + lrid,
		buttons : []
	});
}
</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">预案名称：</td>
		    	<td >
		    	${p.preschname}
				</td>
		    	
		    	<td class="sp-td1">所属机构：</td>
		    	<td >
		    		${p.preschdeptname}
		    	</td>
		    	
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">预案分类：</td>
		    	<td >
		    	${str:translate(p.preschtype,'YAFL')}
		  		</td>
		  		<td class="sp-td1">级别：</td>
		    	<td >
		    	${str:translate(p.preschclass,'ZDFHJBDM')}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">编制机构：</td>
		    	<td >
		    		${p.preschworkdept}
		    	</td>
		    	<td class="sp-td1">审批机构：</td>
		    	<td >
		    		${p.preschexamdept}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">发布机构：</td>
		    	<td >
		    	${p.preschpubdept}
		    	</td>
		    	<td class="sp-td1">发布日期：</td>
		    	<td >
		    	${p.preschpubdate}
		    	</td>
		    	</tr>
		    	
		    	
		    	<tr>
		  		<td class="sp-td1">密级：</td>
		    	<td >
		    	${str:translate(p.classcode,'ZDFHMJDM')}
		    	<td class="sp-td1">版本号：</td>
		    	<td >
		    	${p.preschversion}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">是否模板：</td>
		    	<td >
		    	 <c:if test="${p.type==0}">否</c:if>
		    	 <c:if test="${p.type==1}">是</c:if>
		    	<td class="sp-td1">审批状态：</td>
		    	<td >
		    	 <c:if test="${p.isverify=='00A'}">未审批</c:if>
		    	 <c:if test="${p.isverify=='00S'}">已审批</c:if>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">审批日期：</td>
		    	<td >
		    	${p.verifytime}
		    	</td>
		    	<td class="sp-td1">电子文档：</td>
		    	<td >
		    	<c:if test="${!empty p.preschdocid}">
		    	<a title="请点击打开" target="_blank" href="<%=basePath%>Main/plan/getDoc/${p.id}">${p.preschdocname}<a/> 
		    	</c:if>
		    	</div>
		    	</td>
		    	</tr>
		    	<c:if test="${flag=='view'}"> 
		    	<tr>
		  		<td class="sp-td1">法律法规：</td>
		    	<td colspan="3">
		    	<c:if test="${!empty laws}">
		    		<c:forEach items="${laws}" var="law">
		    		<div  style='height:25px;line-height:25px;font-size:12px;'>
		    			<a title="请点击打开"  href="javascript:void(0);" onclick="planLawClick('${law.lr_id}')" >${law.lr_title}</a>
		    		</div>
		    		</c:forEach>
		    	</c:if>
		    	</td>
		    	<%-- <td class="sp-td1">电子文档：</td>
		    	<td >
		    	<c:if test="${!empty p.preschdocid}">
		    	<a title="请点击打开" target="_blank" href="<%=basePath%>Main/plan/getDoc/${p.id}">${p.preschdocname}<a/> 
		    	</c:if>
		    	</div>
		    	</td> --%>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">适用范围：</td>
		    	<td colspan="3">
		    		${preschscale}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">说明：</td>
		    	<td colspan="3">
		    		${incidenttypenote}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">描述：</td>
		    	<td colspan="3">
		    		${preschdetail}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		    	<td colspan="3">
		    		${note}
		    	</td>
		    	</tr> 
		    	</c:if>
	    </table>
   </div>
   </div>