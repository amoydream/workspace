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
		var html = "<div id='fj_"+obj.id+"' ><input type='hidden' name='fjid' id='fjval' value='" + obj.id +"'fjid' />";
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
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/comfirm/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td>
			    		<input type="hidden" name="t_Bus_Comfirm.firmid" value="${firm.firmid}" />
			    		<input name="t_Bus_Comfirm.firmname" value="${firm.firmname}" data-options="validType:'length[0,60]',required:true,icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">类型</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.firmtypecode" code="TXBZJG" data-options="editable:false,value:'${firm.firmtypecode}',required:true,icons:iconClear,panelHeight:145" class="easyui-combobox" style="width:180px;" />
			    	</td>
			    	<td class="sp-td1">级别</td>
			    	<td>
			    		<select name="t_Bus_Comfirm.levelcode" code="ZDFHJBDM" data-options="editable:false,value:'${firm.levelcode}',panelHeight:145,required:true,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">密级</td>
			    	<td>
			    		<select name="t_Bus_Comfirm.classcode" code="ZDFHMJDM" data-options="editable:false,value:'${firm.classcode}',panelHeight:145,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">行政区域</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.districtcode"  data-options="editable:false,value:'${firm.districtcode}',required:true,icons:iconClear,url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get'" class="easyui-combotree" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">邮编</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.postcode" value="${firm.postcode}" data-options="icons:iconClear,validType:'zip'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.dutytel" value="${firm.dutytel}" data-options="icons:iconClear,required:true,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.fax" value="${firm.fax}" data-options="icons:iconClear,validType:'faxno'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.respper" value="${firm.respper}" data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.respotel" value="${firm.respotel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.respmtel" value="${firm.respmtel}" data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.resphtel" value="${firm.resphtel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.contactper" value="${firm.contactper}" data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.contactotel" value="${firm.contactotel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.contactmtel" value="${firm.contactmtel}" data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.contacthtel" value="${firm.contacthtel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">联系人电子邮箱</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.contactemail" value="${firm.contactemail}" data-options="icons:iconClear,validType:'email'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">应急通信车数</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.commvehnum" value="${firm.commvehnum}" data-options="icons:iconClear,prompt:'请输入整数'" class="easyui-numberbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急发电车数</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.powervehnum" value="${firm.powervehnum}" data-options="icons:iconClear,prompt:'请输入整数'" class="easyui-numberbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">卫星电话数</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.sattelnum" value="${firm.sattelnum}" data-options="icons:iconClear,prompt:'请输入整数'" class="easyui-numberbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">基站总数</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.basestationnum" value="${firm.basestationnum}" data-options="icons:iconClear,prompt:'请输入整数'" class="easyui-numberbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主管单位</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.chargedept" value="${firm.chargedept}" data-options="validType:'length[0,60]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">主管单位地址</td>
			    	<td colspan="3">
			    		<input name="t_Bus_Comfirm.cdeptaddress" value="${firm.cdeptaddress}" data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width: 500px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">坐标系统</td>
			    	<td>
			    		<select name="t_Bus_Comfirm.coordsyscode" code="ZDFHZBXT"  data-options="editable:false,value:'${firm.coordsyscode}',icons:iconClear,panelHeight:125" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">高程基准</td>
			    	<td>
			    		<select name="t_Bus_Comfirm.elevadatumcode" code="ZDFHGCJZ" data-options="editable:false,value:'${firm.elevadatumcode}',icons:iconClear,panelHeight:125" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">高程</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.elevation" value="${firm.elevation}" data-options="icons:iconClear,validType:'intOrFloat'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">经度</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.lng" id="lng" value="${firm.lng}" data-options="editable:false,icons:[{iconCls:'icon-world', handler:getPoint}]" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">维度</td>
			    	<td>
			    		<input name="t_Bus_Comfirm.lat"  id="lat" value="${firm.lat}" data-options="editable:false,icons:[{iconCls:'icon-world', handler:getPoint}]" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		<select name="t_Bus_Comfirm.sourcedeptcode"  code="ZDFHSJLYDW" data-options="editable:false,value:'${firm.sourcedeptcode}',required:true,panelHeight:135,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">地址</td>
			    	<td colspan="5">
			    		<input name="t_Bus_Comfirm.address" value="${firm.address}" data-options="required:true,validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width: 620px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">机构基本情况</td>
			    	<td colspan="5">
			    		<input name="t_Bus_Comfirm.firmdesc" value="${firm.firmdesc}" data-options="validType:'length[0,2000]',icons:iconClear" class="easyui-textbox" style="width: 620px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急能力描述</td>
			    	<td colspan="5">
			    		<input name="t_Bus_Comfirm.emcapdesc" value="${firm.emcapdesc}" data-options="validType:'length[0,4000]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 620px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急通信方式</td>
			    	<td colspan="5">
			    		<input name="t_Bus_Comfirm.commtype" value="${firm.commtype}" data-options="validType:'length[0,500]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 620px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Bus_Comfirm.notes" value="${firm.notes}" data-options="validType:'length[0,500]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 620px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<input type="file" name="file" id="fjfile"/>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty firm.fjname}">
		    							<div id="fj_${firm.fjid}">
		    								<input type="hidden" value="${firm.fjid}" name="fjid" />
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${firm.fjid}">${firm.fjname}</a>（${firm.m_size}）
			    							<a href="javascript:deleteFile(${firm.fjid})"><img src="<%=basePath%>plugins/uploadify/cancel.png" height="13" align="middle"/></a>
		    							</div>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
