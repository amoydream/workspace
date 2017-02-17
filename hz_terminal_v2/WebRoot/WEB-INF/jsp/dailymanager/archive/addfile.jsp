<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
var basePath = '<%=basePath%>';
function findArchivefile(){
	var type = $("#_archivetypecom").combobox('getValue');
	if(type==null||type==''||type==undefined){
		alert("请选择归档类型！");
		return;
	}
	$(document.body).append("<div id='eArchiveFileDialog'></div>");
	$("#eArchiveFileDialog").dialog({
		title:'文件查询信息列表',
		width: 800,
		height: 500,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: basePath+"Main/archive/getArchiveFileList?atype="+type,
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var afile = $("#arcfilesel").datalist("getData");
				var rows = afile.rows;
				if(rows){
					var fid="";
					var fname="";
					for(var i=0;i<rows.length;i++){
						if(i==0){
							fid=rows[i].ARCID;
							fname=rows[i].NAME;
						}else{
							fid=fid+","+rows[i].ARCID;
							fname=fname+","+rows[i].NAME;
						}
					}
		    		$("#archfids").val(fid);
		    		$("#archfnames").text(fname);
		    		$("#eArchiveFileDialog").dialog('close');
	    		}else{
		    		alert("请选择归档文件！");
	    		}
			}}]
	});
}
</script>	 
	 <form id="archiveform" method="post" action="<%=basePath %>Main/archive/save" style="width:100%;">
	    <input type="hidden" name="flag" value="file"/>
	    <input type="hidden" name="t_Bus_ArchiveFile.archiveid" value="${archive.id}"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">归档目录：</td>
		    	<td >${archive.archivename}</td>
		    	
		    	<td class="sp-td1">归档类型：</td>
		    	<td >
		    	<input type="hidden" name="fids" id="archfids"/>
		    		 <select id="_archivetypecom" class="easyui-combobox" name="t_Bus_ArchiveFile.archivetype"  panelHeight="auto" code="GDFL" 
		    		 style="width: 180px;" data-options="editable:false,required:true,icons:iconClear,value:'${atype}'" ></select>
		    	</td>
		    	
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">归档文件
		  		<a id="btn1" onclick="findArchivefile()" href="javascript:void(0);" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a></td>
		  		<td colspan="3" id="archfnames">
		    	</td>
		  		</tr>
		    	
	    </table>
    </form>
