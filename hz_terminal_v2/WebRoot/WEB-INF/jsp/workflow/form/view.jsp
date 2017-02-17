<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script src="<%=basePath %>js/easyloader.js"></script>
<style type="text/css">
table.gridtable {
	font-family: verdana,arial,sans-serif;
	font-size:11px;
	color:#333333;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
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
</style>
<script type="text/javascript">
function wf_change(newValue, oldValue){
	
	//(this.value,this.id,'qt')
	//(value,id,_avalue);
	/*if(value==_avalue){
		$("#_wfattr_"+id+"_div").show();
	}else{
		$("#_wfattr_"+id+"_div").hide();
	}*/
}
$(function(){
	$(".selcombo").combobox({
		onChange: function (newValue, oldValue) {
		var id = this.id;
		if(newValue=='qt'){
			$("#_wfattr_"+id+"_div").show();
		}else{
			$("#_wfattr_"+id+"_div").hide();
		}
		}
	});
$.parser.parse("#_formviewID");
});
</script>
<div id="_formviewID">
	    <table  class="gridtable" width="100%" cellpadding="0" cellspacing="0">
	    	<c:if test="${!empty alist}">
			<tr style="height:auto; width:100%;">
				<th colspan="4" style="height:auto; text-align:center; font-size: 150%;">${fname}</th>
			</tr>
			<c:forEach items="${alist}" var="attr" varStatus="status">
			<c:if test="${attr.seq % 2==1 ||   attr.sqltype=='005'}"><tr style="height: auto;width: 100%;"></c:if>
				<c:if test="${attr.sqltype=='001'}">
					 <td style="width: 150px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 <input type="text"  name="${attr.acode}"  class="easyui-datetimebox"    />
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='011'}">
					 <td style="width: 150px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 <input type="text"  class="easyui-datebox"  name="${attr.acode}"    />
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='002'||attr.sqltype=='004'}">
					 <td style="width: 150px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					  <input name="${attr.acode}" type="text" class="easyui-textbox"  <c:if test="${attr.defvalue=='001' ||attr.defvalue=='002'}">disabled="disabled"</c:if>   />
					  </td>
				</c:if>
				<c:if test="${attr.sqltype=='003'}">
					 <td style="width: 150px;text-align: right;">${attr.attrname}</td>
						  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
						 <select name="${attr.acode}" class="easyui-combobox" panelHeight="auto" >
													<option value="">请选择</option>
												    <option <c:if test="${attr.acode=='001'}">selected</c:if> 
													    value="001" >是</option>
												    <option <c:if test="${attr.acode=='002'}">selected</c:if>
													    value="002">否</option>
											</select>
						  </td>
				</c:if>
				<c:if test="${attr.sqltype=='005'}">
					 <td style="width: 150px;text-align: right;">${attr.attrname}</td>
					  <td colspan="3" style="text-align: left;line-height: 21px;">
					 	<textarea rows="5" cols="85" name="${attr.acode}" class="textbox" >
					 	</textarea>
					  </td>
					  </tr>
				</c:if>
				<c:if test="${attr.sqltype=='006'}">
					 <td style="width: 150px;text-align: right;">${attr.attrname}</td>
					  <td <c:if test="${(status.last == true || (status.last == false && alist[status.index+1].SQLTYPE=='005')) && attr.seq %2 ==1}" >colspan="3" style="text-align: left;"</c:if>>
					 	<c:choose>
					  	<c:when test="${attr.selfalg==1}">
					  		 <select id="${attr.acode}"  name="${attr.acode}" class="selcombo easyui-combobox" panelHeight="auto"   >
					  	</c:when>
					  	<c:otherwise>
					  		<select id="${attr.acode}"  name="${attr.acode}" class="easyui-combobox" panelHeight="auto"  >
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
	    
	    
		    </table>
</div>	    