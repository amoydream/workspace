<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
var basePath = '<%=basePath%>';
function lawClick(){
	//打开法规页面
	$("#_planLawDialog").dialog({
		title:'法律法规列表',
		width: 800,
		height: 400,
		href: basePath+"Main/plan/getLaw/${p.id}",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
			var law = $("#lawSelect").datalist("getData");
			var rows = law.rows;
			if(rows){
				var lawid="";
				var lawname="";
				for(var i=0;i<rows.length;i++){
					if(i==0){
						lawid=rows[i].LR_ID;
						lawname=rows[i].LR_TITLE;
					}else{
						lawid=lawid+","+rows[i].LR_ID;
						lawname=lawname+","+rows[i].LR_TITLE;
					}
				}
	    		$("#lawid").val(lawid);
	    		$("#lawname").textbox('setValue',lawname);
	    		$("#_planLawDialog").dialog('close');
    		}else{
	    		alert("请选择法律法规！");
    		}
			}}]
		});
}
$(function(){		
	$("#planfile").uploadify({
		buttonText: "上传", //按钮上的文字 
        uploader: basePath+"plugins/uploadify/scripts/uploadify.swf",
        script:  basePath+"Main/attachment/save/planFile-${loginModel.userAccount}-${loginModel.userId}",
        cancelImg: basePath+"plugins/uploadify/cancel.png",
        auto: true, //是否自动开始     
        multi: true, //是否支持多文件上传
        fileDataName:'file',
        fileQueue:'fileQueue',
        fileDesc:'*.doc;*.docx;',
        fileExt:'*.doc;*.docx;',
        onComplete:_planonComplete
        });
});

function _planonComplete(event, queueId, fileObj, response, data){	
var obj = eval( "(" + response + ")" );//转换后的JSON对象
var htmlBody="";
htmlBody+="<div id='planfile_"+obj.id+"' style='height:25px;line-height:25px;font-size:12px;'>";
htmlBody+="<span style='display:none'><input type='hidden' name='docid' value='"+obj.id+"' /></span>";
htmlBody+="<a title='请点击另存为' target='_blank' href='"+basePath+"Main/attachment/downloadFJ/"+obj.id+"'>"+obj.name+"<a/> （"
			+obj.size+"）<a href='javascript:deleteFile("+obj.id+");'><img src='"+basePath+"plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
htmlBody+="</div>";
$("#planfileList").html(htmlBody);
}
//删除文件ajax请求
function deleteFile(id){
$("#planfile_"+id).load(basePath+"Main/attachment/delete/"+id);
$("#planfile_"+id).remove();
}
</script>	 
	 <form id="planform" method="post" action="<%=basePath %>Main/plan/save" style="width:100%;">
	    <input type="hidden" name="act" value="upd"/>
	    <input type="hidden" name="t_Bus_Preschinfo.id" value="${p.id}"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">预案名称：</td>
		    	<td >
		    	<input type="text" name="t_Bus_Preschinfo.preschname" data-options="prompt:'请输入预案名称',required:true,icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;" value="${p.preschname}"/></td>
		    	
		    	<td class="sp-td1">所属机构：</td>
		    	<td >
		    	<!-- 	<input class="easyui-combotree" name="t_Bus_Preschinfo.organid" 
		    		data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get',value:'${p.organid}'" style="width:180px;"> -->
		    		<input type="text" name="t_Bus_Preschinfo.preschdeptname" data-options="prompt:'请输入所属机构名称',icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;" value="${p.preschdeptname}"/>
		    	</td>
		    	
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">预案分类：</td>
		    	<td >
		    	<input class="easyui-combotree" name="t_Bus_Preschinfo.preschtype" style="width:180px;"
		    	data-options="url:'<%=basePath%>Main/busParam/getTypeTree/YAFL-1-1',method:'get',editable:false,required:true,value:'${p.preschtype}'" >
		  		</td>
		  		<td class="sp-td1">级别：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_Preschinfo.preschclass"  panelHeight="auto" code="ZDFHJBDM" 
		    	style="width: 180px;" data-options="editable:false,required:true,value:'${p.preschclass}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">编制机构：</td>
		    	<td >
		    		<!-- <input class="easyui-combotree" name="t_Bus_Preschinfo.organid_bz" 
		    		data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get',value:'${p.organid_bz}'" style="width:180px;"> -->
		    		<input type="text" name="t_Bus_Preschinfo.preschworkdept" data-options="prompt:'请输入编制机构名称',icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;" value="${p.preschworkdept}"/>
		    	</td>
		    	<td class="sp-td1">审批机构：</td>
		    	<td >
		    		<!--  <input class="easyui-combotree" name="t_Bus_Preschinfo.organid_sp" 
		    		data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get',value:'${p.organid_sp}'" style="width:180px;">-->
		    		<input type="text" name="t_Bus_Preschinfo.preschexamdept" data-options="prompt:'请输入审批机构名称',icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;" value="${p.preschexamdept}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">发布机构：</td>
		    	<td >
		    	<!-- <input class="easyui-combotree" name="t_Bus_Preschinfo.organid_fb" 
		    		data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get',value:'${p.organid_fb}'" style="width:180px;"> -->
		    		<input type="text" name="t_Bus_Preschinfo.preschpubdept" data-options="prompt:'请输入发布机构名称',icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;" value="${p.preschpubdept}"/>
		    	</td>
		    	<td class="sp-td1">发布日期：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_Preschinfo.preschpubdate"  class="easyui-datetimebox"   
		    	style="width: 180px;"  data-options="editable:false,icons:iconClear,value:'${p.preschpubdate}'"/>
		    	</td>
		    	</tr>
		    	
		    	
		    	<tr>
		  		<td class="sp-td1">密级：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_Preschinfo.classcode" 
		    	panelHeight="auto" code="ZDFHMJDM" style="width: 180px;" data-options="editable:false,icons:iconClear,value:'${p.classcode}'">
		    	</select>
		    	<td class="sp-td1">版本号：</td>
		    	<td >
		    	<input type="text" name="t_Bus_Preschinfo.preschversion" data-options="prompt:'请输入版本号',icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;" value="${p.preschversion}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">是否模板：</td>
		    	<td >
		    		<select class="easyui-combobox" name="t_Bus_Preschinfo.type"  panelHeight="auto" 
		    	style="width: 180px;" data-options="editable:false,required:true" >
		    		<option value="0" <c:if test="${p.type==0}">selected</c:if> >否</option>
		    		<option value="1" <c:if test="${p.type==1}">selected</c:if> >是</option>
		    	</select>
		    	</td>
		    	<td class="sp-td1">是否审批：</td>
		    	<td >
		    		<select class="easyui-combobox" name="t_Bus_Preschinfo.isverify"  panelHeight="auto" 
		    	style="width: 180px;" data-options="editable:false,required:true" >
		    		<option value="00A" <c:if test="${p.isverify=='00A'}">selected</c:if> >未审批</option>
		    		<option value="00S" <c:if test="${p.isverify=='00S'}">selected</c:if> >已审批</option>
		    	</select>
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">审批日期：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_Preschinfo.verifytime"  class="easyui-datebox"  
		    	 style="width: 180px;"  data-options="editable:false,icons:iconClear,value:'${p.verifytime}'"/>
		    	</td>
		    	
		    	<td class="sp-td1">电子文档：</td>
		    	<td >
		    	<input  id="planfile"  type="file" name="file"/>
		    	<div id="planfileList" style="width: 200px;">
		    	<c:if test="${!empty p.preschdocid}">
		    	<input type='hidden' name="docedit" value="upd" />
		    	<div id='planfile_${p.preschdocid}' style='height:25px;line-height:25px;font-size:12px;'>
		    	<a title="请点击打开" target="_blank" href="<%=basePath%>Main/plan/getDoc/${p.id}">${p.preschdocname}<a/> 
		    	</c:if>
		    	</div>
		    	</td>
		    	</tr>
		    	
		    	<!-- 
		    	<tr>
		  		<td class="sp-td1">法律法规：</td>
		    	<td >
		    	<input type="hidden" name="lawid" id="lawid" value="${lawids}"/>
		    	<input id="lawname" name="lawname"  type="text" class="easyui-searchbox"  style="width: 180px;" 
		    	data-options="searcher:lawClick,editable:false,icons:iconClear,value:'${lawnames}'"/> 
		    	</td>
		    	<td class="sp-td1">操作手册：</td>
		    	<td >
		    	<input  id="planfile"  type="file" name="file"/>
		    	<div id="planfileList" style="width: 200px;">
		    	<c:if test="${!empty p.preschdocid}">
		    	<div id='planfile_${p.preschdocid}' style='height:25px;line-height:25px;font-size:12px;'>
		    	<a title="请点击打开" target="_blank" href="<%=basePath%>Main/plan/getDoc/${p.id}">${p.preschdocname}<a/> 
		    	</c:if>
		    	</div>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">适用范围：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Preschinfo.preschscale" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 573px;height: 40px;" >${p.preschscale}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">说明：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Preschinfo.incidenttypenote" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 573px;height: 40px;" >${p.incidenttypenote}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">描述：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Preschinfo.preschdetail" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 573px;height: 40px;" >${p.preschdetail}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Preschinfo.note" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 573px;height: 40px;" >${p.note}</textarea>
		    	</td>
		    	</tr>
		    	 -->
	    </table>
    </form>
<div id="_planLawDialog"></div>