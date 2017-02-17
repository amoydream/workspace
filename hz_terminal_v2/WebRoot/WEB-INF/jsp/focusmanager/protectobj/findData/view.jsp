<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
$(function(){
	$.parser.parse($("#_formviewID"));
});
</script>
<style type="text/css">
th { 
font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
color: #4f6b72; 
border-right: 1px solid #C1DAD7; 
border-bottom: 1px solid #C1DAD7; 
border-top: 1px solid #C1DAD7; 
letter-spacing: 2px; 
text-transform: uppercase; 
text-align: left; 
padding: 6px 6px 6px 12px; 
background: #CAE8EA  no-repeat; 
}
</style>
<div id="_formviewID">
	    <table class="sp-table"  width="100%" cellpadding="0" cellspacing="0">
	    	<c:if test="${!empty alist}">
			<tr style="height:auto; width:100%;">
				<th colspan="4"  style="height:auto; text-align:center; font-size: 150%;">${fname}</th>
			</tr>
			<c:forEach items="${alist}" var="attr" varStatus="status">
			<c:if test="${attr.seq % 2==1 ||   attr.sqltype=='005'}"><tr style="height: auto;width: 100%;"></c:if>
				<c:if test="${attr.sqltype=='001'}">
					 <td class="sp-td1" style="width: 150px;text-align: right;">${attr.remark}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 <input type="text" id="${attr.acode}" name="${attr.acode}" style="width:180px;" class="easyui-datetimebox"    />
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='011'}">
					 <td class="sp-td1" style="width: 150px;text-align: right;">${attr.remark}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 <input type="text"  class="easyui-datebox" <c:if test="${attr.isnull=='1'}">data-options="required:true"</c:if> style="width:180px;"  id="${attr.acode}"  name="${attr.acode}"    />
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='002'||attr.sqltype=='004'}">
					 <td class="sp-td1" style="width: 150px;text-align: right;">${attr.remark}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					  <input name="${attr.acode}" id="${attr.acode}"  type="text" class="easyui-textbox" style="width:180px;" <c:if test="${attr.isnull=='1'}">data-options="required:true"</c:if>  <c:if test="${attr.defvalue=='001' ||attr.defvalue=='002'}">disabled="disabled"</c:if>   />
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='003'}">
					 <td class="sp-td1" style="width: 150px;text-align: right;">${attr.remark}</td>
						  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
						 <select id="${attr.acode}"  name="${attr.acode}" <c:if test="${attr.isnull=='1'}">data-options="required:true"</c:if> class="easyui-combobox" panelHeight="auto" style="width:180px;" >
													<option value="">请选择</option>
												    <option <c:if test="${attr.acode=='001'}">selected</c:if> 
													    value="001" >是</option>
												    <option <c:if test="${attr.acode=='002'}">selected</c:if>
													    value="002">否</option>
											</select>
						  </td>
				</c:if>
				<c:if test="${attr.sqltype=='005'}">
					 <td class="sp-td1" style="width: 150px;text-align: right;">${attr.remark}</td>
					  <td colspan="3" style="text-align: left;line-height: 21px;">
					 	<textarea id="${attr.acode}"  rows="5" data-options="validType:'length[0,${attr.attrsize }]'" <c:if test="${attr.isnull=='1'}">data-options="required:true"</c:if> cols="85" name="${attr.acode}" class="textarea" >
					 	</textarea>
					  </td>
					  </tr>
				</c:if>
				<c:if test="${attr.sqltype=='006'}">
					 <td class="sp-td1" style="width: 150px;text-align: right;">${attr.remark}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 	<c:choose>
					  	<c:when test="${attr.selfalg==1}">
					  		 <select id="${attr.acode}" data-options="editable:false<c:if test="${attr.isnull=='1'}">,required:true</c:if>" name="${attr.acode}" class="easyui-combobox" code="${attr.selcontent}" style="width:180px;" panelHeight="auto"></select>
					  	</c:when>
					  	<c:otherwise>
					  		<select id="${attr.acode}" data-options="editable:false<c:if test="${attr.isnull=='1'}">,required:true</c:if>" name="${attr.acode}" class="easyui-combobox" panelHeight="auto" style="width:180px;" >
					  		<option value="">请选择</option>
					  		<c:set var="array" value="${fn:split(attr.selvalue,',')}"/>
								<c:forEach items="${fn:split(attr.selcontent,',')}" var="slist" varStatus="slv">
									<option  value="${array[slv.index]}" >${slist}</option>
								</c:forEach>
						</select>
					  	</c:otherwise>
					  </c:choose>
					 
								
						<div id="_busattr_${attr.acode}_div" style="display: none;">
							<input name="_busattr_${attr.acode}" type="text" size="30"   value=""  />
						</div>
					 	
					  </td>
				</c:if>
				<c:if test="${attr.seq %2 ==0 || status.last ||  (status.last == false && alist[status.index+1].sqltype=='005')}"></tr></c:if>
			</c:forEach>
			
			</c:if>
	    
	    
		    </table>
</div>	    