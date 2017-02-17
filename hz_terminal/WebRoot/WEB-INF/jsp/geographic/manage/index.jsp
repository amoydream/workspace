<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  	$(function(){
		$("input[name='c.onlinemap']").on("click",function(e){
			if($(this).val()=='0'){
				$("#tr_api").show();
				$("#tr_gis").show();
				$("#apiurl").textbox({ 
					required:true 
				});
				$("#gisurl").textbox({ 
					required:true 
				});
				
			}else{
				$("#tr_api").hide();
				$("#tr_gis").hide();
				$("#apiurl").textbox({ 
					required:false 
				});
				$("#gisurl").textbox({ 
					required:false 
				});
			}
		});

		if("${data.onlinemap}"=="")
			$("input[name='c.onlinemap'][value='0']").click();
		else
			$("input[name='c.onlinemap'][value='${data.onlinemap}']").click();
   });

    function submit(){
    	$('#form1').form('submit',{
  			onSubmit:function(){
  				var fboolean = $(this).form('enableValidation').form('validate');
  				if(!fboolean){
  					$.messager.alert('警告','请按要求填写信息！');
  				}
				return fboolean;
			},
			success:function(result){
				result=$.parseJSON(result);
				if(result.success){
					$.lauvan.MsgShow({msg:'设置成功,3秒后重新刷新页面！'});
					window.setTimeout(function(){
						location.reload();
					},3000);
				}else{
					$.messager.alert('警告',result.msg);
				}
			}
		});
    }

    function close(){
    	var title=$("#mainTab").tabs("getSelected").panel('options').title;
    	$("#mainTab").tabs("close",title);
    }
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/geographic/manage/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	
		    	<tr>
		    		<td class="sp-td1">地图类型</td>
		    		<td>
		    			<input type="radio" name="c.onlinemap" value="0" style="width:20px;"/>离线地图(arcgis)&nbsp;&nbsp;&nbsp;
		    			<input type="radio" name="c.onlinemap" value="1"  style="width:20px;"/>百度地图
		    			
		    			<input type="hidden" name="c.id" value="${data.id }"/>
			    	</td>
		    	</tr>
		    	
		    	<tr>
		    		<td class="sp-td1">经度</td>
		    		<td><input name="c.lng" class="easyui-numberbox" data-options="icons:iconClear,required:true,precision:6" style="width:500px;" value="${data.lng }"/></td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">纬度</td>
		    		<td><input name="c.lat" class="easyui-numberbox" data-options="icons:iconClear,required:true,precision:6" style="width:500px;"  value="${data.lat}"/></td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">默认放大级数</td>
		    		<td><input name="c.zoom" class="easyui-numberbox" data-options="icons:iconClear,required:true" style="width:500px;" value="${data.zoom }"/></td>
		    	</tr>
		    	<tr id="tr_api">
		    		<td class="sp-td1">离线地图api地址</td>
		    		<td><input name="c.apiurl" id="apiurl"  style="width:500px;" <c:if test="${not empty data && data.onlinemap=='0'}">value="${data.apiurl }"</c:if>/></td>
		    	</tr>
		    	<tr id="tr_gis">
		    		<td class="sp-td1">离线地图地址</td>
		    		<td><input name="c.gisurl" id="gisurl" class="easyui-textbox" style="width:500px;" <c:if test="${not empty data && data.onlinemap=='0'}">value="${data.gisurl }"</c:if>/></td>
		    	</tr>
		    	<tr>
		    		<td colspan="2">
		    			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save',onClick:submit"  style="width:80px;height:28px" >保存</a>
		    			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-no',onClick:close" style="width:80px;height:28px">关闭</a>
		    		</td>
		    	</tr>
	    </table>
    </form>
