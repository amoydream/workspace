<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  	function compinfoSave(){
		$.post('<%=basePath%>Main/chemcommon/save/${info.chemid}',$("#compinfoForm").serialize(),function (result){
				if(result.success){
					$.lauvan.MsgShow({msg: '保存成功'});

				}else{
					$.lauvan.MsgShow({msg: '保异异常！'});
	
				}
			});
	}

  </script>
  <div class="easyui-layout" style="width:100%" data-options="fit:true">
 	<%--<div data-options="region:'center'">
	    <div class="easyui-panel" style="height:280px;" data-options="iconCls:'icon-eye',collapsible:true" title="危化品基本信息">
	    --%><table id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">CASNO</td>
			    	<td >
			    		${info.casno}
			    	</td>
			    	<td class="sp-td1">化学品名称</td>
			    	<td >
			    		${info.chemname}
			    	</td>
			    	<td class="sp-td1">化学品俗名</td>
			    	<td >
			    		${info.column1}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">化学品英文名称</td>
			    	<td>
			    		${info.chemnameen}
			    	</td>
			    	<td class="sp-td1">化学品英文简称</td>
		    		<td >
			    		${info.achemliasen}
			    	</td>
			    	<td class="sp-td1">un编号</td>
		    		<td >
			    		${info.unno}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">危险货物号</td>
		    		<td >
			    		${info.dangno}
			    	</td>
			    	<td class="sp-td1">rtecsh号</td>
		    		<td >
			    		${info.rtecsno}
			    	</td>
			    	<td class="sp-td1">分子式</td>
		    		<td >
			    		${info.moleform}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">分子量</td>
		    		<td >
			    		${info.moleweight}
			    	</td>
			    	<td class="sp-td1">生效日期</td>
		    		<td >
			    		${info.effectdate}
			    	</td>
			    	<td class="sp-td1">企业名称</td>
		    		<td >
			    		${info.corpname}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">企业编号</td>
		    		<td >
			    		${info.corpno}
			    	</td>
			    	<td class="sp-td1">企业地址</td>
		    		<td >
			    		${info.corpaddr}
			    	</td>
			    	<td class="sp-td1">企业邮编</td>
		    		<td >
			    		${info.corpzip}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">企业应急电话</td>
		    		<td >
			    		${info.corpemstel}
			    	</td>
			    	<td class="sp-td1">企业传真</td>
		    		<td >
			    		${info.corpfax}
			    	</td>
			    	<td class="sp-td1">企业邮箱</td>
		    		<td >
			    		${info.corpemail}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">技术说明书编码</td>
		    		<td >
			    		${info.explanno}
			    	</td>
			    	<td class="sp-td1">记录人</td>
		    		<td >
			    		${info.username}
			    	</td>
			    	<td class="sp-td1">记录时间</td>
		    		<td >
			    		${info.recordtime}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		${info.note}
			    	</td>
		    	</tr>
	   </table>
	 <%-- </div>
	  <div id="cheminfotabs" class="easyui-tabs" style="width:100px;" data-options="fit:true">
	  	<div title="组成成分" id="chemcompinfo">
	  		 <form id="compinfoForm" method="post" action="<%=basePath%>Main/chemcommon/save/${info.chemid}" style="width:100%;">
	   			 <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">主要成分</td>
			    	<td >
			    		<input type="hidden" name="tbname" value="t_chemcompinfo"/>
			    		<input type="hidden" name="t_Chemcompinfo.chemid" value="${compinfo.chemid}"/>
			    		<input type="hidden" name="t_Chemcompinfo.id" value="${compinfo.id}"/>
			    		<input type="text" name="t_Chemcompinfo.maincomponent" value="${compinfo.maincomponent}" data-options="" class="easyui-textbox" style="width: 400px;" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">有害物成分</td>
			    	<td >
			    		<input type="text"  name="t_Chemcompinfo.injurantcomp" value="${compinfo.injurantcomp}" data-options="" class="easyui-textbox" style="width: 400px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">浓度</td>
			    	<td >
			    		<input type="text"  name="t_Chemcompinfo.consistence" value="${compinfo.consistence}" data-options="" class="easyui-textbox" style="width: 400px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td></td>
		    		<td>
		    			<a href="javascript:compinfoSave();" class="easyui-linkbutton" data-option="iconCls:'icon-save', plain:true'">保存</a>
		    		</td>
		    	</tr>
	    		</table>
    		</form>
	  	</div>
	  	<div title="危险性">
	  		<c:import url="../chemdanginfo/main.jsp"></c:import>
	  	</div>
	  	<div title="急救">
	  	
	  	</div>
	  	<div title="消防">
	  	
	  	</div>
	  	<div title="泄露应急">
	  	
	  	</div>
	  	<div title="操作存储">
	  	
	  	</div>
	  	<div title="控制防护">
	  	
	  	</div>
	  	<div title="理化特性">
	  	
	  	</div>
	  	<div title="稳定反应">
	  	
	  	</div>
	  	<div title="毒理学">
	  	
	  	</div>
	  	<div title="生态学">
	  	
	  	</div>
	  	<div title="废弃处置">
	  	
	  	</div>
	  	<div title="运输">
	  	
	  	</div>
	  	<div title="法规">
	  	
	  	</div>
	  	<div title="其他">
	  	
	  	</div>
	  </div>
 </div>--%>
</div>