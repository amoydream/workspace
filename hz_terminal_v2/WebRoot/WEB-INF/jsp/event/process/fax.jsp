<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
var basePath = '<%=basePath%>';
$(function(){		
	$("#_eventFaxfile").uploadify({
		buttonText: "上传", //按钮上的文字 
        uploader: basePath+"plugins/uploadify/scripts/uploadify.swf",
        script:  basePath+"Main/eventProcess/faxUpload/${loginModel.userAccount}-${loginModel.userId}",
        cancelImg: basePath+"plugins/uploadify/cancel.png",
        auto: true, //是否自动开始     
        multi: true, //是否支持多文件上传
        fileDataName:'file',
        fileQueue:'fileQueue',
        fileDesc:'*.doc;*.docx;*.xls;*.xlsx;',
        fileExt:'*.doc;*.docx;*.xls;*.xlsx;',
        onComplete:_eFaxUploadComplete
        });
});

function _eFaxUploadComplete(event, queueId, fileObj, response, data){	
var obj = eval( "(" + response + ")" );//转换后的JSON对象
var _efaxhtmlBody="";
if(obj.success!='false'){
	_efaxhtmlBody+="<div id='_efaxfile_"+obj.id+"' style='height:25px;line-height:25px;font-size:12px;'>";
	_efaxhtmlBody+="<span style='display:none'><input type='checkbox' name='taskid' value='"+obj.id+"' checked/></span>";
	_efaxhtmlBody+="<span style='display:none'><input type='checkbox' id='_etifFile' name='tifFile' value='"+obj.tifFile+"' checked/></span>";
	_efaxhtmlBody+="<a title='请点击另存为' target='_blank' href='"+basePath+"Main/eventProcess/downloadFax/"+obj.id+"'>"+obj.name+"<a/> （"
			+obj.size+"）";
	_efaxhtmlBody+="</div>";
}else{
	alert(obj.msg);
}
$("#_eventFaxfileList").html(_efaxhtmlBody);
}

function faxNumClick(){
	//打开传真号码
	var fnum = $("#userfaxnum").searchbox('getValue');
	var fname = $("#faxusername").val();
	$(document.body).append("<div id='_efaxnumDialog'></div>");
	$("#_efaxnumDialog").dialog({
		title:'传真号码列表',
		width: 800,
		height: 400,
		queryParams:{"faxnos":fnum,"faxnames":fname},
		href: basePath+"Main/eventProcess/getfaxnum",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
			
				var fax = $("#faxSelect").datalist("getData");
				var rows = fax.rows;
				if(rows.length>0){
					var aname="";
					var faxnum="";
					for(var i=0;i<rows.length;i++){
						if(rows[i].FAX!=null && rows[i].FAX!=''){
							if(faxnum.length==0){
								aname = rows[i].ADD_NAME;
								faxnum=rows[i].FAX;
							}else{
								aname = aname+","+ rows[i].ADD_NAME;
								faxnum = faxnum + ","+rows[i].FAX;
							}
						}
					}
		    		$("#faxusername").textbox('setValue',aname);
		    		$("#userfaxnum").textbox('setValue',faxnum);
		    		$("#_efaxnumDialog").dialog('close');
	    		}else{
		    		alert("请选择传真号码！");
	    		}
			}}]
		});
}
</script>
 <form id="efaxform" method="post" action="<%=basePath %>Main/eventProcess/faxOpenSave" style="width:100%;">
<input type="hidden"  name="eventid" value="${eid}"/>
<input type="hidden"  name="_callids"  id="_callids"/>
<input type="hidden"  name="_ceids"  id="_ceids"/>
<input type="hidden"  name="_status"  id="_status"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0"> 
			<tr>
		  		<td class="sp-td1" style="width:100px;" >任务标题：</td>
		    	<td >
		    		
		    		<input type="text" id="_faxtitle" name="_faxtitle" data-options="prompt:'请输入任务标题',required:true,icons:iconClear" 
		    		class="easyui-textbox" style="width: 600px;" />
		    		
		    	</td>
		    	
		    </tr>
		    <tr>
		  		<td class="sp-td1" style="width:100px;" >传真文件：</td>
		    	<td >
		    		<input  id="_eventFaxfile"  type="file" name="file"/>
		    		<div id="_eventFaxfileList" style="width: 600px;"></div>
		    	</td>
		    	
		    </tr>
		     <tr>
		  		<td class="sp-td1" style="width:100px;" >接收对象：</td>
		    	<td >
		    		<input type="text"  id="faxusername" data-options="prompt:'请选择传真号码',readonly:true" 
		    		class="easyui-textbox" style="width: 600px;" value="${recename}"/>
		    	</td>
		    </tr>
		    <tr>
		  		<td class="sp-td1" style="width:100px;" >传真号码：</td>
		    	<td >
			    	<input id="userfaxnum" name="userfaxnum"  type="text" class="easyui-searchbox"  style="width: 600px;" 
			    	data-options="searcher:faxNumClick,editable:false,icons:iconClear,value:'${faxnum}'"/> 
		    	</td>
		    </tr>      
	</table>
</form>
	
	 
	
