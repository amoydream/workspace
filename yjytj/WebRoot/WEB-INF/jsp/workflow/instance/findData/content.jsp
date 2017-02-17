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
<script type="text/javascript">
$(function(){
	var cdiv='${cdivID}';
	if(cdiv==null || cdiv==undefined || cdiv==''){
		cdiv = 'wf_content';
	}
	$.parser.parse($("#"+cdiv));
});
</script>
<c:if test="${empty cdivID}">
		<div id="wf_content">
</c:if>
<c:if test="${!empty cdivID}">
		<div id="${cdivID}">
</c:if>
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
					 <input type="text"  name="${attr.acode}"  class="easyui-datetimebox"   style="width: 200px;"  value="${r[attr.acode]}"/>
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='011'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 <input type="text"  class="easyui-datebox"  name="${attr.acode}"   style="width: 200px;"  value="${r[attr.acode]}"/>
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='002'||attr.sqltype=='004'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					  <input name="${attr.acode}" type="text" class="easyui-textbox"  
					  <c:if test="${attr.defvalue=='001' ||attr.defvalue=='002'}">disabled="disabled"</c:if>
					  <c:if test="${!empty r[attr.acode]}">value="${r[attr.acode]}"</c:if> 
					  <c:if test="${empty r[attr.acode]}">
					   <c:if test="${attr.defvalue=='001'}">value="${loginModel.userName}"</c:if> 
					   <c:if test="${attr.defvalue=='002'}">value="${loginModel.orgName}"</c:if>
					   </c:if>
					   style="width: 200px;"  />
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='003'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
						  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
						 <select name="${attr.acode}" class="easyui-combobox" panelHeight="auto" style="width: 200px;"  data-options="value:'${r[attr.acode]}'" >
													<option value="">请选择</option>
												    <option <c:if test="${attr.acode=='001'}">selected</c:if> 
													    value="001" >是</option>
												    <option <c:if test="${attr.acode=='002'}">selected</c:if>
													    value="002">否</option>
											</select>
						  </td>
				</c:if>
				<c:if test="${attr.sqltype=='005'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
					  <td colspan="3" style="text-align: left;line-height: 21px;">
					 	<textarea  name="${attr.acode}" class="textarea" data-options="validType:'length[0,200]'"  
					 	style="width: 640px;height: 50px;"  >${r[attr.acode]}</textarea>
					  </td>
					  </tr>
				</c:if>
				<c:if test="${attr.sqltype=='006'}">
					 <td style="width: 100px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 	<c:choose>
					  	<c:when test="${attr.selfalg==1}">
					  		 <select id="${attr.acode}"  name="${attr.acode}" class="selcombo easyui-combobox" panelHeight="auto"  style="width: 200px;" data-options="value:'${r[attr.acode]}'" >
					  	</c:when>
					  	<c:otherwise>
					  		<select id="${attr.acode}"  name="${attr.acode}" class="easyui-combobox" panelHeight="auto" style="width: 200px;" data-options="value:'${r[attr.acode]}'" >
					  	</c:otherwise>
					  </c:choose>
					 
								<option value="">请选择</option>
								<c:forEach items="${fn:split(attr.selcontent,',')}" var="slist" varStatus="slv">
									<option <c:if test="${attr.acode==slv.index}">selected</c:if> value="${slv.index}" >${slist}</option>
								</c:forEach>
								<c:if test="${attr.selfalg==1}"><option <c:if test="${attr.acode=='qt'}">selected</c:if> value="qt">其他（请说明）</option></c:if>
						</select>
						<div id="_wfattr_${attr.acode}_div" style="display: none;">
							<input name="_wfattr_${attr.acode}" type="text" size="30"   value=""  />
						</div>
					 	
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
										<td style="text-align: center;">日期：${hlist.marktime}</td>
									</tr>
								</table>
	    					</td>
	    				</tr>
	    				</c:if>
	    			</c:forEach>
	    		</c:if>
	    
		    </table>
			
		</div>
        
		
	