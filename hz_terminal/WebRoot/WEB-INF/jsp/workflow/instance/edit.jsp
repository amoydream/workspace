<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
var basePath = '<%=basePath%>';
function flowClick(value,name){
	//打开检索页面
	$("#wfDialog").dialog({
		title:'流程检索',
		width: 500,
		height: 400,
		href: basePath+"Main/wfInstance/getWorkFlow",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
	    		var dba = $("#_wfFormSource").datagrid("getSelected");
	    		$("#wf_formBox").searchbox("setValue",dba.FNAME);
	    		$("#wf_id").val(dba.ID);
	    		$("#wf_pointid").val(dba.POINTID);
	    		$("#wf_ftype").val(dba.FTYPE);
	    		$("#wf_formid").val(dba.FORMID);
	    		//展示表单内容
	    		$("#formid").load(basePath+"Main/wfInstance/getContent",{"formid":dba.FORMID});
	    		$("#wfDialog").dialog('close');
			}}]
		});	
}
function checkUserClick(value,name){
	var wfid = $("#wf_id").val();
	var ctype = $("#wf_ftype").val();
	var point = $("#wf_pointid").val();
	if(wfid==null || wfid==undefined || wfid==''){
		alert("请选择流程！");
	}else{
	//打开检索页面
	$("#checkUserDialog_inst").dialog({
		title:'审批人检索',
		width: 500,
		height: 400,
		href: basePath+"Main/wfInstance/getCheckUser",
		queryParams:{ftype:ctype,instid:'${instid}',flag:'${flag}',pointid:point},
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
		    	var rows = $("#wfCheckUser").treegrid("getChecked");
		    	var cname = '';
		    	var cid = '';
		    	if(rows && "00A"==ctype){
			    	for(var i=0;i<rows.length;i++){
				    	cname = cname+","+rows[i].USER_NAME;
				    	cid = cid+","+rows[i].USER_ID;
			    	}
		    	}else{
		    		$("input:checkbox[name='userBox']:checked").each(function(){
		    			cname = cname+","+this.value;
				    	cid = cid+","+this.id;
		    		});
		    	}
			    if(cname!=''){
			    	$("#spr_id").val(cid.substring(1));
			    	$("#spr_name").searchbox("setValue",cname.substring(1));
		   			$("#checkUserDialog_inst").dialog('close');
				}else{
			    	alert("请选择审批人！");
		    	}
	    		
			}}]
		});
	}
}
$(function(){		
		$("#wffile").uploadify({
			buttonText: "上传", //按钮上的文字 
            uploader: basePath+"plugins/uploadify/scripts/uploadify.swf",
            script:  basePath+"Main/attachment/save/wflow-${loginModel.userAccount}-${loginModel.userId}",
            cancelImg: basePath+"plugins/uploadify/cancel.png",
            auto: true, //是否自动开始     
	        multi: true, //是否支持多文件上传
	        fileDataName:'file',
	        fileQueue:'fileQueue',
	        onComplete:onComplete
	        });
        //获取流程内容
		$("#formid").load(basePath+"Main/wfInstance/getContent",{"formid":"${wf.formid}","contentid":"${inst.content}"});
});
var htmlBody="";
function onComplete(event, queueId, fileObj, response, data){	
	var obj = eval( "(" + response + ")" );//转换后的JSON对象
	htmlBody+="<div id='file_"+obj.id+"' style='height:25px;line-height:25px;font-size:12px;'>";
	htmlBody+="<span style='display:none'><input type='checkbox' name='fjid' value='"+obj.id+"' checked/></span>";
	htmlBody+="<a title='请点击另存为' target='_blank' href='"+basePath+"Main/attachment/downloadFJ/"+obj.id+"'>"+obj.name+"<a/> （"
				+obj.size+"）<a href='javascript:deleteFile("+obj.id+");'><img src='"+basePath+"plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
	htmlBody+="</div>";
	$("#fileList").html(htmlBody);
}
//删除文件ajax请求
function deleteFile(id){
	$("#file_"+id).load(basePath+"Main/attachment/delete/"+id);
	$("#file_"+id).remove();
	htmlBody=$("#fileList").html();
}
</script>
 	 <div class="easyui-layout"  data-options="fit:true">
	  <form id="instanceform" method="post" action="<%=basePath%>Main/wfInstance/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:120px;">
	  <input type="hidden" id="_aid" name="_aid" value="${inst.content}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">流程名称：</td>
		    	<td>
		    	<input type="hidden" id="wf_id" name="t_WF_Instance.id" value="${inst.id}"/>
		    	<input type="hidden" id="wf_id" name="t_WF_Instance.wfid" value="${inst.wfid}"/>
		    	<input type="hidden" id="wf_pointid" name="t_WF_Instance.pointid" value="${inst.pointid}"/>
		    	<input type="hidden" id="wf_ftype" name="wf_ftype" value="${wf.ftype}"/>
		    	<input type="hidden" id="wf_formid" name="wf_formid" value="${wf.formid}"/>
		    	<input id="wf_formBox" name="wf_name" type="text" class="easyui-searchbox" value="${wf.tname}" style="width: 200px;" 
		    	data-options="searcher:flowClick"/>  </td>
		    	<td class="sp-td1">审批人：</td>
				<td >
		    	<input type="hidden" id="spr_id" name="spr.id" value="${checkuser}"/>
		    	<input id="spr_name" name="spr.name" type="text" class="easyui-searchbox" value="${checkname}" style="width: 200px;" 
		    	data-options="searcher:checkUserClick"/>    
				</td>
		  		
		    	</tr>
		    	<tr>
				<td class="sp-td1">申请简述：</td>
		    	<td><input type="text" name="t_WF_Instance.name" class="easyui-textbox" value="${inst.name}" data-options="required:true"  style="width: 200px;"/>
				</td>
				<td class="sp-td1">附件：</td>
		    	<td><input  id="wffile"  type="file" name="file"/>
	            <c:if test="${!empty fileList}">	           
				    <c:forEach items="${fileList}" var="list">
					<div id="file_${list.id}" style="height:25px;font-size:12px;line-height:25px;">
						<span style="display:none"><input type="checkbox" name="fjid" value="${list.id}" checked/></span>
						<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="/hwwx/Main/attachment/downloadFJ/${list.id}">${list.name}<a/> （${list.m_size}）<a href="javascript:deleteFile(${list.id},${list.sizelong});"><img src="<%=basePath%>plugins/uploadify/cancel.png" height="13" align="middle"/></a>
					</div>
				    </c:forEach>	            
	            </c:if>
                 <div id="fileList" style="width: 450px;"></div>
				</td>
		    	</tr>
	    </table>
	    </div>
	    <div  data-options="region:'center',border:false" >
	    	<div id="formid"></div>
		</div>
		
		 	
    </form>
</div>

<div id="wfDialog"></div>
<div id="checkUserDialog_inst"></div>