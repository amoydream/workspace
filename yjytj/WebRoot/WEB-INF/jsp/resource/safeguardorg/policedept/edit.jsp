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
	                'script': '<%=basePath%>Main/attachment/save/safeguardorg--${userid}',
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
		var html = "<div id='fj_"+obj.id+"' ><input type='hidden' name='fjid' id='fjval' value='" + obj.id +"' />";
		html += "<a class='btnAttach' title='请点击另存为'></a><a title='请点击另存为' target='_blank' href='<%=basePath%>Main/attachment/downloadFJ/";
		html += obj.id + "' >" + obj.name +　"</a>（" + obj.size + "）<a href='javascript:deleteFile(" + obj.id +");'><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a></div>";
		$("#filebox").html(html);
  	}

  	function deleteFile(fjid){
		//$("#filebox").load("<%=basePath%>Main/attachment/delete/" + fjid);
			$.post("<%=basePath%>Main/attachment/delete/" + fjid, null ,null);
		$("#fj_"+fjid).remove();

  	}

  	function getPoint(){
		$.lauvan.openGisDialog($("#lng").val(), $("#lat").val(), function(lng, lat){
			$("#lng").textbox('setValue', lng);
			$("#lat").textbox('setValue', lat);
		
			});
  	}
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/policedept/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">单位名称</td>
			    	<td>
			    		<input type="hidden" name="t_Bus_Policedept.deptid" value="${poldept.deptid}" />
			    		<input name="t_Bus_Policedept.deptname" value="${poldept.deptname}" data-options="validType:'length[0,60]',required:true,icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">行政区域</td>
			    	<td>
			    		<input name="t_Bus_Policedept.districtcode" value="${poldept.districtcode}" data-options="required:true,icons:iconClear,url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get'" class="easyui-combotree" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">级别</td>
			    	<td>
			    		<select name="t_Bus_Policedept.levelcode"  code="ZDFHJBDM" data-options="value:'${poldept.levelcode}',editable:false,panelHeight:145,required:true,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">邮编</td>
			    	<td>
			    		<input name="t_Bus_Policedept.postcode" value="${poldept.postcode}" data-options="icons:iconClear,validType:'zip'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		<input name="t_Bus_Policedept.dutytel" value="${poldept.dutytel}" data-options="icons:iconClear,required:true,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		<input name="t_Bus_Policedept.fax" value="${poldept.fax}" data-options="icons:iconClear,validType:'faxno'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">警员人数</td>
			    	<td>
			    		<input name="t_Bus_Policedept.policenum" value="${poldept.policenum}" data-options="required:true,icons:iconClear,validType:'integer'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		<input name="t_Bus_Policedept.respper" value="${poldept.respper}" data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		<input name="t_Bus_Policedept.respotel" value="${poldept.respotel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		<input name="t_Bus_Policedept.respmtel" value="${poldept.respmtel}" data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_Policedept.resphtel" value="${poldept.resphtel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">联系人</td>
			    	<td>
			    		<input name="t_Bus_Policedept.contactper" value="${poldept.contactper}" data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		<input name="t_Bus_Policedept.contactotel" value="${poldept.contactotel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		<input name="t_Bus_Policedept.contactmtel" value="${poldept.contactmtel}" data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_Policedept.contacthtel" value="${poldept.contacthtel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人电子邮件</td>
			    	<td>
			    		<input name="t_Bus_Policedept.contactemail" value="${poldept.contactemail}" data-options="icons:iconClear,validType:'email'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">管辖范围</td>
			    	<td colspan="3">
			    		<input name="t_Bus_Policedept.dominscope" value="${poldept.dominscope}" data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width: 505px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">坐标系统</td>
			    	<td>
			    		<select name="t_Bus_Policedept.coordsyscode" code="ZDFHZBXT"  data-options="value:'${poldept.coordsyscode}',icons:iconClear,editable:false,panelHeight:125" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">高程基准</td>
			    	<td>
			    		<select name="t_Bus_Policedept.elevadatumcode" code="ZDFHGCJZ" data-options="value:'${poldept.elevadatumcode}',icons:iconClear,editable:false,panelHeight:125" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">高程</td>
			    	<td>
			    		<input name="t_Bus_Policedept.elevation" value="${poldept.elevation}" data-options="icons:iconClear,validType:'intOrFloat'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">经度</td>
			    	<td>
			    		<input name="t_Bus_Policedept.lng" id="lng" value="${poldept.lng}" data-options="editable:false,icons:[{iconCls:'icon-world', handler:getPoint}]" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">维度</td>
			    	<td>
			    		<input name="t_Bus_Policedept.lat"  id="lat" value="${poldept.lat}" data-options="editable:false,icons:[{iconCls:'icon-world', handler:getPoint}]" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		<select name="t_Bus_Policedept.sourcedeptcode"  code="ZDFHSJLYDW" data-options="editable:false,required:true,panelHeight:135,value:'${poldept.sourcedeptcode}',icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">地址</td>
			    	<td colspan="5">
			    		<input name="t_Bus_Policedept.address" value="${poldept.address}" data-options="required:true,validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width: 620px;"/>
			    	</td>
			    	
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Bus_Policedept.notes" value="${poldept.notes}" data-options="validType:'length[0,500]',multiline:true" class="easyui-textbox" style="width: 620px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<input type="file" name="file" id="fjfile"/>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty poldept.fjid}">
		    							<div id="fj_${poldept.fjid}">
		    								<input type="hidden" value="${poldept.fjid}" name="fjid"/>
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${poldept.fjid}">${poldept.fjname}</a>
			    							<a href="javascript:deleteFile(${poldept.fjid})"><img src="<%=basePath%>plugins/uploadify/cancel.png" height="13" align="middle"/></a>
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
