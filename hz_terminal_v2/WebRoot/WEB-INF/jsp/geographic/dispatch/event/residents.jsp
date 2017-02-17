<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				fitColumns : true,
				url:"" 
				
				};
		$.lauvan.dataGrid("residentsGrid",attrArray);
		
	});
	

	</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="residentsGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="CODE" width="100">编号</th> 
			            <th field="NAME" width="150">名称</th>	
			            <th field="ADDRESS"  width="100">地址</th>	
			        </tr> 
			    </thead>
			    <tbody>
			    	<tr>
			    		<td></td>
			    		<td>001</td>
			    		<td>润园二期</td>
			    		<td>红花湖路98号(红花湖水上乐园旁)</td>
			    	</tr>
			    	<tr>
			    		<td></td>
			    		<td>002</td>
			    		<td>惠州市十一小学</td>
			    		<td>金榜路8号</td>
			    	</tr>
			    	
			    </tbody> 
			</table> 
		</div>
	</div>
