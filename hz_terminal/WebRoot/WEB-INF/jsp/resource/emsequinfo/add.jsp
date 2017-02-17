<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  	var basePath = '<%=basePath%>';
  	$(function(){
		var param = {
			uploader: 'plugins/uploadify/scripts/uploadify.swf',
			cancelImg: 'plugins/uploadify/cancel.png',
			buttonText: '上传',
			script:'Main/attachment/save/civilphoto--${loginModel.userId}',
			fileQueue: 'fileQueue',
			onComplete: onComplete,
			fileDataName: 'file',
			auto:true,
			fileExt:'*.jpg;*.png;',
			fileDesc:'*.jpg;*.png;'
		};
		$("#emsequinfophoto").uploadify(param);

		function onComplete(event, queueId, fileObj, response, data){
			var obj = eval( "(" + response + ")" );
			var html = "<input type='hidden' name='t_Emsequinfo.equphoto' value='"+obj.id+"'/><img src='"+basePath+obj.url+"' style='width:135px;height:85px;float:left;' />";
			html += "<a href='javascript:delFile("+obj.id+");'><img src='"+basePath+"plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
			$("#equphoto").append(html);
		}
  	});

  	function delFile(id){
  		$("#equphoto").load(basePath+"Main/attachment/delete/"+id);
		$("#equphoto").empty();
  	}

  	function getPoint(){
		$.lauvan.openGisDialog($("#pox").val(), $("#poy").val(), function(lng, lat){
			$("#pox").textbox('setValue', lat);
			$("#poy").textbox('setValue', lng);
			
		});
  	}

  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/emsequinfo/save/${cid}" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">装备名称</td>
			    	<td >
			    		<input type="hidden" name="t_Emsequinfo.equtypeid" id="equtypeid"/>
			    		<input type="text"  name="t_Emsequinfo.equname" id="equname" data-options="required:true,readonly:true" class="easyui-textbox" style="width: 170px;" />
			    		<a id="btn" onclick="findequip()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			    	</td>
			    	<td class="sp-td1" >型号</td>
			   		<td >
			   			<input type="text"  name="t_Emsequinfo.equmodel" data-options="validType:'length[0,40]'" class="easyui-textbox" style="width: 200px;" />
			   		</td>
			    
		    	</tr>
		    	<tr style="height:90px;">
		    		<td class="sp-td1" >照片</td>
		    		<td >
		    			<div id="equphoto" style="padding-left:25px;"></div>
		    		</td>
		    		<td colspan="2">
		    			<input type="file" name="file" id="emsequinfophoto" />
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">规格</td>
			    	<td >
			    		<input name="t_Emsequinfo.equspec" class="easyui-textbox" style="width:200px;" data-options="" />
			    	</td>
			    	<td class="sp-td1">生产日期</td>
			    	<td>
			    		<input type="text"  name="t_Emsequinfo.equproddate" data-options="validType:'date'" class="easyui-datebox" style="width: 200px;"/>
			    	</td>
		    		
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">购买日期</td>
			    	<td >
			    		<input type="text"  name="t_Emsequinfo.equstoredate" data-options="validType:'date'" class="easyui-datebox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">停放地名称</td>
			    	<td >
			    		<input name="t_Emsequinfo.stopaddrname" class="easyui-textbox" style="width:200px;" data-options="" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">有效期</td>
			    	<td >
						<input type="text"  name="t_Emsequinfo.validates" data-options="validType:'date'" class="easyui-datebox" style="width: 200px;"/>			    	
					</td>
			    	<td class="sp-td1">装备价格</td>
			    	<td >
			    		<input name="t_Emsequinfo.priunit" class="easyui-textbox" style="width:200px;" data-options="validType:'intOrFloat'" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">拥有数量</td>
			    	<td >
			    		<input name="t_Emsequinfo.equnum" class="easyui-textbox" style="width:200px;" data-options="validType:'integer'" />
			    	</td>
		    		<td class="sp-td1">联系人</td>
			    	<td >
			    		<input name="t_Emsequinfo.equlinker" class="easyui-textbox" style="width:200px;" data-options="" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">填报时间</td>
			    	<td >
			    	<input type="text"  name="t_Emsequinfo.equrecdate" data-options="validType:'date'" class="easyui-datebox" style="width: 200px;"/>		
			    	</td>
		    		<td class="sp-td1">所属单位名称</td>
			    	<td >
			    		<input type="hidden" name="t_Emsequinfo.equdeptid" id="equdeptid" />
			    		<input name="t_Emsequinfo.equdeptname" id="equdeptname" class="easyui-textbox" data-options="" style="width: 170px;"/>
			    		<a id="btn" onclick="findbusorg()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">经度</td>
			    	<td >
			    		<input name="t_Emsequinfo.posx" id="pox" class="easyui-textbox" style="width:200px;" data-options="icons:[{iconCls:'icon-world',handler:getPoint}]" />
			    	</td>
			    	<td class="sp-td1">纬度</td>
			    	<td>
			    		<input name="t_Emsequinfo.posy" id="poy" class="easyui-textbox" style="width:200px;" data-options="icons:[{iconCls:'icon-world',handler:getPoint}]" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">应急装备状态</td>
			    	<td >
			    		<input name="t_Emsequinfo.equstyle" class="easyui-textbox" style="width:200px;" data-options="" />
			    	</td>
			    	<td>
			    	</td>
			    	<td></td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">停放地址</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Emsequinfo.stopaddr" data-options="multiline:true" class="easyui-textbox" style="width: 540px;height:80px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">装备说明</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Emsequinfo.equnote" data-options="multiline:true" class="easyui-textbox" style="width: 540px;height:80px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">装备描述</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Emsequinfo.equdetail" data-options="multiline:true" class="easyui-textbox" style="width: 540px;height:80px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Emsequinfo.note" data-options="multiline:true" class="easyui-textbox" style="width: 540px;height:80px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
