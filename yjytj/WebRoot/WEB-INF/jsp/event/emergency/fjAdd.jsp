<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
var basePath = '<%=basePath%>';
$(function(){
	$("#evfile").uploadify({
		buttonText: "上传", //按钮上的文字 
        uploader: basePath+"plugins/uploadify/scripts/uploadify.swf",
        script:  basePath+"Main/attachment/save/eventfj-${eventid}-${loginModel.userId}",
        cancelImg: basePath+"plugins/uploadify/cancel.png",
        auto: true, //是否自动开始     
        multi: true, //是否支持多文件上传
        fileDataName:'file',
        fileQueue:'fileQueue',
        onComplete:onComplete_evfj
     });
});
var htmlBody="";
function onComplete_evfj(event, queueId, fileObj, response, data){	
	var obj = eval( "(" + response + ")" );//转换后的JSON对象
	htmlBody+="<div id='file_"+obj.id+"' style='height:25px;line-height:25px;font-size:12px;'>";
	htmlBody+="<span style='display:none'><input type='checkbox' name='fjid' value='"+obj.id+"' checked/></span>";
	htmlBody+="<a title='请点击另存为' target='_blank' href='"+basePath+"Main/attachment/downloadFJ/"+obj.id+"'>"+obj.name+"<a/> （"
				+obj.size+"）<a href='javascript:deleteFile_evfj("+obj.id+");'><img src='"+basePath+"plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
	htmlBody+="</div>";
	$("#EVfileList").html(htmlBody);
}
//删除文件ajax请求
function deleteFile_evfj(id){
	$("#EVfile_"+id).load(basePath+"Main/attachment/delete/"+id);
	$("#EVfile_"+id).remove();
	htmlBody=$("#EVfileList").html();
}
</script>	 
	 <form id="eventfjform" method="post" action="<%=basePath %>Main/event/fjSave" style="width:100%;">
	 	<input type="hidden" name="eventid" value="${eventid}"/>
	 	 <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	 	 <tr>
	 	 	<td class="sp-td1">相关附件：</td>
		    	<td >
		    		<input  id="evfile"  type="file" name="file"/>
		    </td>
		   </tr>
		  </table> 		
		    		<div id="EVfileList" style="width: 450px;"></div>    	
    </form>
