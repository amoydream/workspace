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

  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/colldept/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td>
			    		<input type="hidden" name="t_Bus_CollDept.deptid" value="${dept.deptid}"/>
			    		<input name="t_Bus_CollDept.deptname" value="${dept.deptname}" data-options="validType:'length[0,60]',required:true,icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">类型代码</td>
			    	<td>
			    		<input name="t_Bus_CollDept.depttypecode" data-options="value:'${dept.depttypecode}',required:true,icons:iconClear,panelHeight:145,method:'get',url:'<%=basePath%>Main/genekno/getTypeTreeByAcode/YJJG'" class="easyui-combotree" style="width:180px;" />
			    	</td>
			    	<td class="sp-td1">行政区域代码</td>
			    	<td>
			    		<input name="t_Bus_CollDept.districtcode"  data-options="value:'${dept.districtcode}',required:true,icons:iconClear,url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get'" class="easyui-combotree" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">邮编</td>
			    	<td>
			    		<input name="t_Bus_CollDept.postcode" value="${dept.postcode}" data-options="icons:iconClear,validType:'zip'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		<input name="t_Bus_CollDept.dutytel" value="${dept.dutytel}" data-options="icons:iconClear,required:true,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		<input name="t_Bus_CollDept.fax" value="${dept.fax}" data-options="icons:iconClear,validType:'faxno'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		<input name="t_Bus_CollDept.respper" value="${dept.respper}" data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		<input name="t_Bus_CollDept.respotel" value="${dept.respotel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		<input name="t_Bus_CollDept.respmtel" value="${dept.respmtel}" data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_CollDept.resphtel" value="${dept.resphtel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">联系人</td>
			    	<td>
			    		<input name="t_Bus_CollDept.contactper" value="${dept.contactper}" data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		<input name="t_Bus_CollDept.contactotel" value="${dept.contactotel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		<input name="t_Bus_CollDept.contactmtel" value="${dept.contactmtel}" data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_CollDept.contacthtel" value="${dept.contacthtel}" data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">联系人电子邮箱</td>
			    	<td>
			    		<input name="t_Bus_CollDept.contactemail" value="${dept.contactemail}" data-options="icons:iconClear,validType:'email'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">主管单位</td>
			    	<td>
			    		<input name="t_Bus_CollDept.chargedept" value="${dept.chargedept}" data-options="validType:'length[0,60]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">主管单位地址</td>
			    	<td colspan="3">
			    		<input name="t_Bus_CollDept.cdeptaddress" value="${dept.cdeptaddress}" data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width: 500px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">捐赠热线电话</td>
			    	<td>
			    		<input name="t_Bus_CollDept.contacttel" value="${dept.contacttel}" data-options="required:true,icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">开户行</td>
			    	<td>
			    		<input name="t_Bus_CollDept.openaccbank" value="${dept.openaccbank}" data-options="required:true,icons:iconClear,validType:'length[0,60]'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">账户名称</td>
			    	<td>
			    		<input name="t_Bus_CollDept.accountname" value="${dept.accountname}" data-options="required:true,icons:iconClear,validType:'length[0,60]'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">账户</td>
			    	<td>
			    		<input name="t_Bus_CollDept.accounts" value="${dept.accounts}" data-options="required:true,icons:iconClear,validType:'length[0,50]',prompt:'请输入账号 '" class="easyui-numberbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		<select name="t_Bus_CollDept.sourcedeptcode" code="ZDFHSJLYDW" data-options="value:'${dept.sourcedeptcode}',editable:false,panelHeight:135,icons:iconClear,required:true" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td></td>
			    	<td></td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">地址</td>
			    	<td colspan="5">
			    		<input name="t_Bus_CollDept.address" value="${dept.address}" data-options="required:true,validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width: 620px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">机构基本情况</td>
			    	<td colspan="5">
			    		<input name="t_Bus_CollDept.deptdesc" value="${dept.deptdesc}" data-options="validType:'length[0,2000]',icons:iconClear" class="easyui-textbox" style="width: 620px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Bus_CollDept.notes" value="${dept.notes}" data-options="validType:'length[0,500]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 620px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<input type="file" name="file" id="fjfile"/>
		    				<div id="fileQueue">
		    					<div id="filebox" style="width:450px;">
		    						<c:if test="${! empty dept.fjname}">
		    							<input type="hidden" value="${dept.fjid}" name="fjid" />
		    								<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${dept.fjid}">${dept.fjname}</a>（${dept.m_size}）
			    							<a href="javascript:deleteFile(${dept.fjid})"><img src="<%=basePath%>plugins/uploadify/cancel.png" height="13" align="middle"/></a>
		    						</c:if>
		    					</div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
