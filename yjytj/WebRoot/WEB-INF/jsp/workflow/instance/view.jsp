<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
var property = {
		width:800,
		height:100,
		haveHead:false,
		haveTool:false,
		haveGroup:false,
		useOperStack:false,
	};
$(function(){
	if("${t.ftype}"=="00A"){
		$.ajax({
			url:basePath+"Main/wfInstance/getWFimg/${inst.id}",
	    	type:'post',
	    	dataType:'json',
	    	traditional:true,
	    	async: false,
	    	success:function(data){
	    		var demo = $.createGooFlow($("#wfimg-view"),property);
				demo.clearData();
				demo.$max =20;
				demo.loadData(data);
	    	}
		});
	}
});

function ctypeformatter(value,row,index){
	if (value=='00S'){
		return "同意";
	}else if(value=='00X'){
		return "不同意";
	}else if(value=='00R'){
		return "撤回";
	}else {
		return value;
	}
}
</script>

 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'center'" style="border:none;">
		<div class="easyui-tabs" style="width:100%;" data-options="fit:true" >
		<div  title="申请内容"  style="padding:10px">
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
					 	${r[attr.acode]}
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
			<c:if test="${!empty fileList}">
			<tr>
				<td style="width: 100px;text-align: right;">附件</td>
				<td colspan="3" style="text-align: left;line-height: 21px;">
					 	<c:forEach items="${fileList}" var="list">
					<div id="file_${list.id}" style="height:25px;font-size:12px;line-height:25px;">
						<span style="display:none"><input type="checkbox" name="fjid" value="${list.id}" checked/></span>
					    <a title="请点击另存为" target="_blank" href="/hwwx/Main/attachment/downloadFJ/${list.id}">${list.name}<a/> （${list.m_size}）
					</div>
				    </c:forEach>
				</td>
			</tr>	           	            
	      </c:if>
			
	    		<c:if test="${!empty _hlist}">
	    			<c:forEach items="${_hlist}" var="hlist">
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
										<td style="text-align: center;" width="40%">日期：${hlist.marktime}</td>
									</tr>
								</table>
	    					</td>
	    				</tr>
	    			</c:forEach>
	    		</c:if>
	    
		    </table>
			<div>
			</div>
		</div>
		<div  title="历史记录"  >
		<div class="easyui-layout"  data-options="fit:true">
		<c:if test="${t.ftype=='00A'}">
			<div data-options="region:'north'" style="border:none;height: 105px;">
				<div id="wfimg-view"></div>
			</div>
		</c:if>
			<div data-options="region:'center'" style="border:none;">
				<table id="verhistory" cellspacing="0" cellpadding="0" class="easyui-datagrid"
				data-options="url:'<%=basePath%>Main/wfVerify/gethistoryData',fit:true,fitColumns:true,singleSelect:true,pageSize:20,pageList:[20,50,100], pagination:true,queryParams:{instid:'${inst.id}'}">  
				    <thead> 
				        <tr> 
				        	<th field="PORDER" width="50">节点</th>
				            <th field="CHECKNAME" width="100">审批人</th> 
				            <th field="CHECKTYPE" width="100"  formatter="ctypeformatter">审批结果</th>
				            <th field="CONTENT" width="350" >内容</th>
				            <th field="MARKTIME" width="150" >审批时间</th>
				            <th field="RTSET" width="100" code="WFRT">状态</th>  
				        </tr> 
				    </thead> 
				</table>
			</div>
			</div>
		</div>
   </div>
</div>

</div>