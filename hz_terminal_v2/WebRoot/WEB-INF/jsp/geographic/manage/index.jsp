<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<style>
.fzindex {
    z-index: 9999;
}
.buybtn {
    position: relative;
    left: 5px;
    top: 2px;
    _top: 2px;
}
.buybtn a {
    width: 10px;
    height: 10px;
    display: inline-block;
}
.buybtn a, .buybtn a:hover, .svg-triangle2, .popclose {
    background: url(<%=basePath%>plugins/gis/css/img/btn.png) -16px 0 no-repeat;
}
a:link, a:visited {
    text-decoration: none;
    color: #3b5998;
}
</style>
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

				$("#zoom").numberbox({
					min:0,
					max:9
				});
				$("#zoom").numberbox("setValue",4);

				if("${apiUrl}"!=""){
					$("#apiurl").textbox("setValue","${apiUrl}");
				}
				if("${gisUrl}"!=""){
					$("#gisurl").textbox("setValue","${gisUrl}");
				}
				
			}else{
				$("#tr_api").hide();
				$("#tr_gis").hide();
				$("#apiurl").textbox({ 
					required:false 
				});
				$("#gisurl").textbox({ 
					required:false 
				});
				
				$("#zoom").numberbox({
					min:1,
					max:19
				});
				$("#zoom").numberbox("setValue",14);
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
		    		<td><input name="c.zoom" id="zoom" class="easyui-numberbox" data-options="icons:iconClear,required:true,min:1,max:19" style="width:500px;" value="${data.zoom }"/>
		    		<span class="buybtn fzindex"><a href="javascript:void(0);" class="easyui-tooltip" data-options=" 
		    		position: 'right',
                	content: '<span style=color:black;font-weight:bold;>离线地图范围：0-9（推荐填4）<br/>百度地图范围：1-19（推荐填14）</span>',
                	onShow:function(){
                		 $(this).tooltip('tip').css({
	                        backgroundColor: '#fff7e0',
	                        borderColor: '#ff7f00'
                    	});	
                	}
                	"></a>  
                    </span>
		    		</td>
		    	</tr>
		    	<tr id="tr_api">
		    		<td class="sp-td1">离线地图api地址</td>
		    		<td><input name="c.apiurl" id="apiurl"  style="width:500px;" <c:if test="${not empty data && data.onlinemap=='0'}">value="${apiUrl }"</c:if>/>
		    		<span class="buybtn fzindex"><a href="javascript:void(0);" class="easyui-tooltip" data-options=" 
		    		position: 'right',
                	content: '<span style=color:black;font-weight:bold;>此项需要提前部署arcgis地图调用的api库</span>',
                	onShow:function(){
                		 $(this).tooltip('tip').css({
	                        backgroundColor: '#fff7e0',
	                        borderColor: '#ff7f00'
                    	});	
                    }
                	"></a>  
                    </span>
		    		</td>
		    	</tr>
		    	<tr id="tr_gis">
		    		<td class="sp-td1">离线地图地址</td>
		    		<td><input name="c.gisurl" id="gisurl" class="easyui-textbox" style="width:500px;" <c:if test="${not empty data && data.onlinemap=='0'}">value="${gisUrl }"</c:if>/>
		    		<span class="buybtn fzindex"><a href="javascript:void(0);" class="easyui-tooltip" data-options=" 
		    		position: 'right',
                	content: '<span style=color:black;font-weight:bold;>此项需要提前部署arcgis离线地图</span>',
                	onShow:function(){
                		 $(this).tooltip('tip').css({
	                        backgroundColor: '#fff7e0',
	                        borderColor: '#ff7f00'
                    	});	
                    }
                	"></a>  
                    </span>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td colspan="2">
		    			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save',onClick:submit"  style="width:80px;height:28px" >保存</a>
		    			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-no',onClick:close" style="width:80px;height:28px">关闭</a>
		    		</td>
		    	</tr>
	    </table>
    </form>
