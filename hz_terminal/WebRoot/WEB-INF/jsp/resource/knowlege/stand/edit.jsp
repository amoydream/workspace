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
			$("#fjfile").uploadify(param);
  	  	});

  	function onComplete(event, queueId, fileObj, response, data){
		var obj = eval( "(" + response + ")" );
		if($("#fjval").length>0){
			deleteFile($("#fjval").val());
		}
		var html = "<div id='fj_"+obj.id+"' ><input type='hidden' id='fjval' name='fjid' value='" + obj.id +"'fjid' />";
		html += "<a class='btnAttach' title='请点击另存为'></a><a title='请点击另存为' target='_blank' href='<%=basePath%>Main/attachment/downloadFJ/";
		html += obj.id + "' >" + obj.name +　"</a>（" + obj.size + "）<a href='javascript:deleteFile(" + obj.id +");'><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a></div>";
		$("#filebox").html(html);
  	}

  	function deleteFile(fjid){
		//$("#filebox").load("<%=basePath%>Main/attachment/delete/" + fjid);
		$.post("<%=basePath%>Main/attachment/delete/" + fjid, null ,null);
		$("#fj_"+fjid).remove();

  	}
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/stand/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td colspan="3">
			    		<input type="hidden" name="t_Bus_Stand.standid" value="${s.standid}" />
			    		<input name="t_Bus_Stand.standname" value="${s.standname}" data-options="required:true,icons:iconClear,validType:'length[0,200]'" class="easyui-textbox" style="width: 540px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">标准号</td>
			    	<td>
			    		<input type="text"  name="t_Bus_Stand.fileno" value="${s.fileno}" data-options="required:true,icons:iconClear,validType:'length[0,30]'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">类型</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Stand.standtypecode" value="${s.standtypecode}" data-options="method:'get', url:'<%=basePath%>Main/genekno/getTypeTreeByAcode/GENEKNO',editable:false,icons:iconClear"  class="easyui-combotree" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主题词</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_Stand.standkeyword" value="${s.standkeyword}" data-options="icons:iconClear,validType:'length[0,200]'" class="easyui-textbox" style="width: 540px"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">适用等级</td>
		    		<td>
			    		<input type="text"  name="t_Bus_Stand.standlevelcode" code="SYLEVEL" data-options="value:'${s.standlevelcode}',icons:iconClear,panelHeight:120,editable:false" class="easyui-combobox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">法律效力</td>
		    		<td>
			    		<input type="text"  name="t_Bus_Stand.lawforce" code="LAWPOWER" data-options="value:'${s.lawforce}',icons:iconClear,panelHeight:75,editable:false" class="easyui-combobox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">发布时间</td>
		    		<td>
		    			<input type="text"  name="t_Bus_Stand.pubdate" value="${s.pubdate}" data-options="required:true,validType:'date'" class="easyui-datebox" style="width: 200px;"/>
		    		</td>
		    		<td class="sp-td1">生效时间</td>
		    		<td>
		    			<input type="text"  name="t_Bus_Stand.effdate" value="${s.effdate}" data-options="required:true,validType:'date'" class="easyui-datebox" style="width: 200px;"/>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">制定单位</td>
			    	<td>
			    		<input type="text"  name="t_Bus_Stand.createorg" value="${s.createorg}" data-options="icons:iconClear,validType:'length[0,60]'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">数据来源单位</td>
			    	<td >
			    		<select name="t_Bus_Stand.sourcedeptcode"  code="ZDFHSJLYDW" data-options="value:'${s.sourcedeptcode}',panelHeight:135,required:true,icons:iconClear,editable:false" class="easyui-combobox" style="width:200px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">摘要</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_Stand.standabstract" value="${s.standabstract}" data-options="multiline:true,validType:'length[0,50]'" class="easyui-textbox" style="width: 540px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_Stand.notes" value="${s.notes}" data-options="multiline:true,validType:'length[0,50]'" class="easyui-textbox" style="width: 540px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="3">
		    			<div>
		    				<input type="file" name="file" id="fjfile"/>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty s.fjname}">
		    							<div id="fj_${s.fjid}">
		    								<input type="hidden" value="${s.fjid}" name="fjid"/>
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${s.fjid}">${s.fjname}</a>（${s.m_size}）
		    								<a href="javascript:deleteFile(${s.fjid})"><img src="<%=basePath%>plugins/uploadify/cancel.png" height="13" align="middle"/></a>
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
