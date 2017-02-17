<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/inc.jsp"%>
<style type="text/css">
table.gridtable {
	font-family: verdana,arial,sans-serif;
	font-size:14px;
	color:#333333;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
	margin: 0 auto;
	
}
table.gridtable th {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #dedede;
}
table.gridtable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}
table.gridtable .ss td{border:0;margin: 0px;padding: 0px;}
</style>

		<div id="${cdivID}">
			 <table class="gridtable" width="100%" cellpadding="0" cellspacing="0">
	    	<c:if test="${!empty alist}">
			<tr style="height:auto; width:100%;">
				<th colspan="4" style="height:auto; text-align:center; font-size: 150%;">${f.fname}</th>
			</tr>
			<c:forEach items="${alist}" var="attr" varStatus="status">
			<c:if test="${attr.seq % 2==1 ||   attr.sqltype=='005'}"><tr style="height: auto;width: 100%;"></c:if>
				<c:if test="${attr.sqltype=='001'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 ${r[attr.acode]}
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='011'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 ${r[attr.acode]}
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='002'||attr.sqltype=='004'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					  ${r[attr.acode]}
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='003'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
						  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
							<c:if test="${attr.acode=='001'}">是</c:if> 
							<c:if test="${attr.acode=='002'}">否</c:if>
						  </td>
				</c:if>
				<c:if test="${attr.sqltype=='005'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
					  <td colspan="3" style="text-align: left;line-height: 21px;">
					 	${fn:replace(r[attr.acode],'\\r\\n', '</br>')}
					 	
					  </td>
					  </tr>
				</c:if>
				<c:if test="${attr.sqltype=='006'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 	<c:choose>
					 		<c:when test="${fn:startsWith(r[attr.acode],'qt')}">其他（请说明）${fn:replace(r[attr.acode],'qt:','')}</c:when>
					 		<c:otherwise>
					 			<c:forEach items="${fn:split(attr.selcontent,',')}" var="slist" varStatus="slv">
									<c:if test="${r[attr.acode]==slv.index}">${slist}</c:if> 
								</c:forEach>
					 		</c:otherwise>
					 	</c:choose>
					 	 
					  </td>
				</c:if>
				<c:if test="${attr.seq %2 ==0 || status.last ||  (status.last == false && alist[status.index+1].sqltype=='005')}"></tr></c:if>
			</c:forEach>
			</c:if>
			
	    		<c:if test="${!empty _hlist}">
	    			<c:forEach items="${_hlist}" var="hlist">
	    			<c:if test="${!empty hlist.content}">
	    				<tr>
	    					<td style="width: 100px;text-align: right;">${hlist.pname}</td>
	    					<td colspan="3">
	    						<table style="height:auto; width:100%;" class="ss" >
									<tr>
										<td style="text-align: left;line-height: 21px;" colspan="2">
											${hlist.content}
										</td>
									</tr>
									<tr >	
										<td style="text-align: right;">签名：<font style="color:blue;">${hlist.checkname}</font></td>
										<td style="text-align: center;" width="25%">日期：${hlist.marktime}</td>
									</tr>
								</table>
	    					</td>
	    				</tr>
	    				</c:if>
	    			</c:forEach>
	    		</c:if>
	    
		    </table>
			
		</div>
        
		
	