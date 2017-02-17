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
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/transfirm/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.firmname"  data-options="validType:'length[0,60]',required:true,icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">类型</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.firmtypecode" code="YSBZJG" data-options="editable:false,required:true,icons:iconClear,panelHeight:135" class="easyui-combobox" style="width:180px;" />
			    	</td>
			    	<td class="sp-td1">级别</td>
			    	<td>
			    		<select name="t_Bus_TransFirm.levelcode" code="ZDFHJBDM" data-options="editable:false,panelHeight:145,required:true,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">密级</td>
			    	<td>
			    		<select name="t_Bus_TransFirm.classcode" code="ZDFHMJDM" data-options="editable:false,panelHeight:145,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">行政区域</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.districtcode"  data-options="required:true,icons:iconClear,url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get'" class="easyui-combotree" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">邮编</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.postcode"  data-options="icons:iconClear,validType:'zip'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.dutytel"  data-options="icons:iconClear,required:true,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.fax"  data-options="icons:iconClear,validType:'faxno'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.respper"  data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.respotel"  data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.respmtel"  data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.resphtel"  data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.contactper"  data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.contactotel"  data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.contactmtel"  data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.contacthtel"  data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">联系人电子邮箱</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.contactemail"  data-options="icons:iconClear,validType:'email'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">主管单位</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.chargedept"  data-options="validType:'length[0,60]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		
			    	<td class="sp-td1">主管单位地址</td>
			    	<td colspan="5">
			    		<input name="t_Bus_TransFirm.cdeptaddress"  data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width: 490px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">坐标系统</td>
			    	<td>
			    		<select name="t_Bus_TransFirm.coordsyscode" code="ZDFHZBXT"  data-options="editable:false,icons:iconClear,panelHeight:125" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">高程基准</td>
			    	<td>
			    		<select name="t_Bus_TransFirm.elevadatumcode" code="ZDFHGCJZ" data-options="editable:false,icons:iconClear,panelHeight:125" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">高程</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.elevation"  data-options="icons:iconClear,validType:'intOrFloat'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">经度</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.lng" id="lng" data-options="editable:false,icons:[{iconCls:'icon-world', handler:getPoint}]" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">维度</td>
			    	<td>
			    		<input name="t_Bus_TransFirm.lat"  id="lat" data-options="editable:false,icons:[{iconCls:'icon-world', handler:getPoint}]" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		<select name="t_Bus_TransFirm.sourcedeptcode"  code="ZDFHSJLYDW" data-options="editable:false,required:true,panelHeight:135,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">地址</td>
			    	<td colspan="5">
			    		<input name="t_Bus_TransFirm.address"  data-options="required:true,validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width: 615px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">客运能力</td>
			    	<td colspan="5">
			    		<input name="t_Bus_TransFirm.passcap"  data-options="validType:'length[0,500]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 615px;height:40px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">货运能力</td>
			    	<td colspan="5">
			    		<input name="t_Bus_TransFirm.frecap"  data-options="validType:'length[0,500]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 615px;height:40px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急通信方式</td>
			    	<td colspan="5">
			    		<input name="t_Bus_TransFirm.commtype"  data-options="validType:'length[0,500]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 615px;height:40px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">企业基本情况</td>
			    	<td colspan="5">
			    		<input name="t_Bus_TransFirm.firmdesc"  data-options="validType:'length[0,2000]',icons:iconClear" class="easyui-textbox" style="width: 615px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急能力描述</td>
			    	<td colspan="5">
			    		<input name="t_Bus_TransFirm.emcapdesc"  data-options="validType:'length[0,2000]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 615px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Bus_TransFirm.notes" data-options="validType:'length[0,500]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 615px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<input type="file" name="file" id="fjfile"/>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;"></div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
