<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
var basePath = '<%=basePath%>';
$(function(){		
		$("#usercontactUP").uploadify({
			buttonText: "上传", //按钮上的文字 
            uploader: basePath+"plugins/uploadify/scripts/uploadify.swf",
            script:  basePath+"Main/personcontact/importSave",
            cancelImg: basePath+"plugins/uploadify/cancel.png",
            auto: true, //是否自动开始     
	        multi: true, //是否支持多文件上传
	        fileDataName:'file',
	        fileQueue:'fileQueue',
	        fileExt:'*.xls;',
	        fileDesc:'*.xls;',
	        onComplete:onComplete
	        });
});
var htmlBody="";
function onComplete(event, queueId, fileObj, response, data){	
	var obj = eval( "(" + response + ")" );//转换后的JSON对象
	if(obj.success){
		$("#importDialog").dialog('close');
		//导入成功，提示成功信息
		$('#_personcontactlist_data').datagrid('clearSelections');
		$('#_personcontactlist_data').datagrid('clearChecked');
		$('#_personcontactlist_data').datagrid('reload'); 
		var msg = obj.msg;
		if(obj.errorStr!=''){
			msg = msg+"</br>"+obj.errorStr;
		}
		$.messager.alert('提示',msg,"info");
		
	}else{
		$.messager.alert('错误',obj.msg,"error");
	}
}
</script>

 	 <div class="easyui-layout"  data-options="fit:true">
	  <div data-options="region:'center',border:false">
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
				<td class="sp-td1" style="width: 150px;">日常机构人员通讯录模板：</td>
		    	<td>
		    	<div  style="height:25px;font-size:12px;line-height:25px;">
					<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="Main/template/download/10">日常机构人员通讯录模板<a/>
				</div>
				</td>
		    	</tr>
		    	<tr>
		    	<td colspan="2"><input  id="usercontactUP"  type="file" name="file"/>
		    	<div id="fileList" style="width: 450px;"></div>
				</td>
		    	</tr>
	    </table>
	    </div>	 	
</div>
