<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>

  	$(function(){
			var param = {
					'buttonText'     : '上传附件', //按钮上的文字 
	                'uploader': '<%=basePath %>plugins/uploadify/scripts/uploadify.swf',
	                'script': '<%=basePath%>Main/attachment/save/knowlege--${userid}',
	                'cancelImg': '<%=basePath %>plugins/uploadify/cancel.png',
	                'auto'           : true, //是否自动开始     
		            'multi'          : false, //是否支持多文件上传
		            fileDataName   : 'file',
		            fileQueue     :  'fileQueue',
		 	        onComplete:onComplete,
		 	        onError: function(event, queueID, fileObj) {     
		 	               alert("文件:" + fileObj.name + "上传失败");     
		 	            }
			};
			$("#fj").uploadify(param);
  	  	});

 
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/genekno/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">标题</td>
			    	<td colspan="3">
			    		<input name="t_Bus_Genekno.knotitle"  data-options="validType:'length[0,200]',required:true" class="easyui-textbox" style="width: 540px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主题词</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Bus_Genekno.knokeyword" data-options="validType:'length[0,200]'" class="easyui-textbox" style="width: 540px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">类型</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Genekno.typecode" data-options="panelHeight:135,required:true,method:'get', url:'<%=basePath%>Main/genekno/getTypeTreeByAcode/GENEKNO',editable:false"  class="easyui-combotree" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">数据来源单位</td>
			    	<td >
			    		<select name="t_Bus_Genekno.sourcedeptcode"  code="ZDFHSJLYDW" data-options="panelHeight:135,required:true,icons:iconClear,editable:false" class="easyui-combobox" style="width:200px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急常识来源</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_Genekno.knosource" data-options="validType:'length[0,100]'" class="easyui-textbox" style="width: 540px"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急常识摘要</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_Genekno.knoabstract" data-options="validType:'length[0,500]',multiline:true" class="easyui-textbox" style="width: 540px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_Genekno.notes" data-options="validType:'length[0,500]',multiline:true" class="easyui-textbox" style="width: 540px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="3">
		    			<div>
		    				<input type="file" name="file" id="fj"/>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;"></div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
