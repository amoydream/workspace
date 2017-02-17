<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
//打开地图
  function DTClick(){
  	$.lauvan.openGisDialog($("#tea_longitude").val(),$("#tea_latitude").val(),function(lng,lat){
  		$("#tea_longitude").textbox('setValue',lng);
  		$("#tea_latitude").textbox('setValue',lat);
  	});
  }

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
  html += obj.id + "' >" + obj.name +"</a>（" + obj.size + "）<a href='javascript:deleteFile(" + obj.id +");'><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a></div>";
  $("#filebox").html(html);
  }

  function deleteFile(fjid){
  $("#filebox").load("<%=basePath%>Main/attachment/delete/" + fjid);
  $("#fj_"+fjid).remove();

  }
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/team/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.name" data-options="required:true" class="easyui-textbox" style="width: 180px;" />
			    	</td>
			    	
			    	<td class="sp-td1">队伍类型：</td> 
				    <td><select class="easyui-combobox" name="t_Bus_Team.type"
			        panelHeight="auto" code="YJDW" style="width: 180px;"
			        data-options="editable:false"></select></td>
			    	
			    </tr>
		    	<tr>	
			    	<td class="sp-td1">人员数</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.membernum" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" class="easyui-numberbox" style="width: 180px;"/>
			    	</td>
			    
			        <td class="sp-td1">所属单位：</td>
		    	    <td >
		    		<input class="easyui-combotree" name="t_Bus_Team.organid" data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get'" style="width:180px;">
		    	    </td>
		    	    
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.master" data-options="" class="easyui-textbox" style="width: 180px;"/>
			    	</td>
		    		<td class="sp-td1">负责人电话</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.mastertel" data-options="validType:'phone'" class="easyui-textbox" style="width: 180px;"/>
			    	</td>
			    	
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">负责人手机</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.masterphone" data-options="validType:'mobile'" class="easyui-textbox" style="width: 180px;"/>
			    	</td>
			    	
		    		<td class="sp-td1">负责人邮箱</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.masteremail" data-options="validType:'email'" class="easyui-textbox" style="width: 180px;"/>
			    	</td>
			    	
			    </tr>
		    	<tr>
		    		<td class="sp-td1">联系人</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.linkman" data-options="" class="easyui-textbox" style="width: 180px;"/>
			    	</td>
		    		<td class="sp-td1">联系人电话</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.linkmantel" data-options="validType:'phone'" class="easyui-textbox" style="width: 180px;"/>
			    	</td>
			    	
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">联系人手机</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.linkmanphone" data-options="validType:'mobile'" class="easyui-textbox" style="width: 180px;"/>
			    	</td>
			    	
			    	<td class="sp-td1">值班电话</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.dutytel" data-options="validType:'phone'" class="easyui-textbox" style="width: 180px;"/>
			    	</td>
			    	
		    	</tr>
		    	<tr>   
		  		    <td  class="sp-td1" >经度：</td>
		    	    <td >
		    	    <input id="tea_longitude" name="t_Bus_Team.tea_longitude"  type="text" class="easyui-textbox"  style="width: 180px;" data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}]"/>
			    	</td>
			    	<td  class="sp-td1" >纬度：</td>
			    	<td >
			    	<input id="tea_latitude" name="t_Bus_Team.tea_latitude"  type="text" class="easyui-textbox lock-on"  style="width: 180px;" data-options="readonly:true"/>
			    	</td>
			    
			    </tr>
		    	<tr> 	
			    	<td class="sp-td1">最近更新时间</td>
			    	<td >
			    		<input type="text"  name="t_Bus_Team.updatetime" data-options="disabled:true,readonly:true" class="easyui-textbox" style="width: 180px;" value="${nowdate}"/>
			    	</td>
			    	
			    </tr>
		    	<tr>
		    	    <td class="sp-td1">所在地址：</td>
		    	    <td colspan="3"><input name="t_Bus_Team.address" type="text" class="easyui-textbox" 
		    	       data-options="prompt:'请输入地址',icons:iconClear"  style="width:564px;"/>  </td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">装备描述</td>
			    	<td colspan="3">
			    		<textarea name="t_Bus_Team.equipdesc" class="textarea" 
			    		data-options="validType:'length[0,500]'"  style="width: 564px;height: 50px;" ></textarea>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">队伍职责</td>
			    	<td colspan="3">
			    		<textarea name="t_Bus_Team.teamjob" class="textarea" 
			    		data-options="validType:'length[0,500]'"  style="width: 564px;height: 50px;" ></textarea>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">备注</td>
			    	<td colspan="3">
			    		<textarea name="t_Bus_Team.remark" class="textarea" 
			    		data-options="validType:'length[0,500]'"  style="width: 564px;height: 50px;" ></textarea>
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
