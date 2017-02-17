<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
function lawClick(){
	//打开法规页面
	$(document.body).append("<div id='_planLawDialog'></div>");
	$("#_planLawDialog").dialog({
		title:'法律法规列表',
		width: 800,
		height: 400,
		href: basePath+"Main/plan/getLaw",
		onClose:function(){
			$(this).dialog('destroy');
		},
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
		    		$("#mlawid").val(lawid);
		    		$("#mlawname").textbox('setValue',lawname);
		    		$("#_planLawDialog").dialog('close');
	    		}else{
		    		alert("请选择法律法规！");
	    		}
			}}]
		});
}
function infosave(){
	//$("#planmodelform").submit();
	$("#planmodelform").form('submit',{
		onSubmit:function(param){	
		},
		success:function(result){
			var obj=$.parseJSON(result);
			$.lauvan.reflash(result);
		}
	});
}
function impmodel(pid){
		var attrArray={
				title:'导入模板',
				height: 500,
				width:1000,
				href: '<%=basePath%>Main/planMg/getmodel',
				buttons:[{
					text:'引用',
					iconCls:'icon-save',
					handler:function(){
						var rows=$("#planModelGrid1").datagrid('getSelected');
						if(rows==null || rows==undefined){
							$.lauvan.MsgShow({msg:'请选择欲导入的数据!'});
							return;
						}
						$.messager.confirm('导入','您确定导入选择的模板吗？',function(r){
						    if (r){
						    	var ids=rows.ID;
						       $.ajax({
					            	url:"<%=basePath%>Main/planMg/impmodel",
					            	type:'post',
					            	dataType:'json',
					            	traditional:true,
					            	data:{'mid':ids,'pid':pid},
					            	success:function(data){
					            		if(data.success){
					            			$.lauvan.MsgShow({msg:'导入成功'});
											$("#yamodelDialog").dialog('close');
											$("#mainTab").tabs("close","应急预案管理详情");
					            		}
					            		else{
					            			$.messager.alert('错误',data.msg,data.errorcode);
					            		}
					            	}
					            });
						    }
						});
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#yamodelDialog").dialog('close');
					}
				}
				]
		};
		
		$.lauvan.openCustomDialog("yamodelDialog",attrArray,null,null);	
}
</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<form id="planmodelform" method="post" action="<%=basePath %>Main/planmodel/save" style="width:100%;" >
		 <input type="hidden" name="t_Bus_Preschinfo.id" value="${p.id }"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">预案名称：</td>
		    	<td >
		    	${p.preschname}
				</td>
		    	
		    	<td class="sp-td1">所属机构：</td>
		    	<td >
		    		${p.preschdeptname}
		    	</td>
		    	<td class="sp-td1">预案分类：</td>
		    	<td >
		    	${str:translate(p.preschtype,'YAFL')}
		  		</td>
		  		<tr>
		  		<td class="sp-td1">级别：</td>
		    	<td >
		    	${str:translate(p.preschclass,'ZDFHJBDM')}
		    	</td>
		  		<td class="sp-td1">编制机构：</td>
		    	<td >
		    		${p.preschworkdept}
		    	</td>
		    	<td class="sp-td1">审批机构：</td>
		    	<td >
		    		${p.preschexamdept}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">发布机构：</td>
		    	<td >
		    	${p.preschpubdept}
		    	</td>
		    	<td class="sp-td1">发布日期：</td>
		    	<td >
		    	${p.preschpubdate}
		    	</td>
		  		<td class="sp-td1">密级：</td>
		    	<td >
		    	${str:translate(p.classcode,'ZDFHMJDM')}
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">版本号：</td>
		    	<td >
		    	${p.preschversion}
		    	</td>
		  		<td class="sp-td1">法律法规：</td>
		    	<td width="200px">
		    	<input type="hidden" name="mlawid" id="mlawid" value="${lawids}"/>
		    	<input id="mlawname" name="mlawname"  type="text" class="easyui-searchbox"  style="width: 180px;" 
		    	data-options="searcher:lawClick,editable:false,icons:iconClear,value:'${lawnames}'"/>
		    	</td>
		    	<td class="sp-td1">电子文档：</td>
		    	<td>
		    	<c:if test="${!empty p.preschdocid}">
		    	<a title="请点击打开" target="_blank" href="<%=basePath%>Main/plan/getDoc/${p.id}">${p.preschdocname}<a/> 
		    	</c:if>
		    	</div>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">适用范围：</td>
		    	<td colspan="5">
		    		<textarea name="t_Bus_Preschinfo.preschscale" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 900px;height: 40px;" >${p.preschscale}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">说明：</td>
		    	<td colspan="5">
		    		<textarea name="t_Bus_Preschinfo.incidenttypenote" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 900px;height: 40px;" >${p.incidenttypenote}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">描述：</td>
		    	<td colspan="5">
		    		<textarea name="t_Bus_Preschinfo.preschdetail" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 900px;height: 40px;" >${p.preschdetail}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		    	<td colspan="5">
		    		<textarea name="t_Bus_Preschinfo.note" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 900px;height: 40px;" >${p.note}</textarea>
		    	</td>
		    	</tr>
	    </table>
	    </form>
		   </div>
	       <div data-options="region:'south',border:false" style="padding: 5px;background:#f7f7f7;height:35px;">
           <div style="float:right;" >
           <c:if test="${!pert:hasperti(applicationScope.model_save, loginModel.xdlimit)}">
           <a href="javascript:infosave();" class="easyui-linkbutton" data-option="iconCls:'icon-ok', plain:true'">保存</a>
           </c:if>
           <c:if test="${type==null&&!pert:hasperti(applicationScope.presch_impmodel, loginModel.xdlimit)}">
           <a href="javascript:impmodel('${p.id }');" class="easyui-linkbutton" data-option="iconCls:'icon-add', plain:true'">引入模板</a>
           </c:if>
           </div>
		</div>
		
   </div>
