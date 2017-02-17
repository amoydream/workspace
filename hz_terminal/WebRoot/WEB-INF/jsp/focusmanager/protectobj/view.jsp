<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$(function(){
	$(function(){
		var attrArray={
				<c:if test="${xgflag}">
				toolbar: [
		                  { text: '新增', iconCls: 'icon-add',handler:expadd,permitParams:'${pert:hasperti(applicationScope.expadd, loginModel.xdlimit)}'}, '-', 
		                  { text: '删除',iconCls: 'icon-delete',handler:expdel,permitParams:'${pert:hasperti(applicationScope.expdel, loginModel.xdlimit)}'}
		                 ],
		                 </c:if>
				fitColumns : true,
				idField:'ID',
				rownumbers:true,
				pagination:false,/* 
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/protectobj/getGridcontent?tablecode=${tablecode}&defobjid=${defenceobj.defobjid}"
        };
		$.lauvan.dataGrid("expcontentgrid",attrArray);	
	});
});
//扩展增
function expadd(){
	var attrArray={
			title:'新增扩展内容',
			height: 300,
			width:700,
			href: '<%=basePath%>Main/protectobj/getexptand?tablecode=${defenceobj.defobjtypecode}&tableid=${defenceobj.defobjid}'
	};
	
	$.lauvan.openCustomDialog("proobjDialog",attrArray,proobj_dialogSubmit,'exptand_form');	
}

function expdel(){
	/* var node= $("#expcontentgrid").datagrid('getSelected');
	if(node==null || node.length==0){
		$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
		return;
	} */
	var nodes= $("#expcontentgrid").datagrid('getChecked');
	var ids="";
	if(nodes.length==0){
		$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
		return;	
	}
	for (var i = 0; i < nodes.length; i++) {
		 ids=ids+nodes[i].ID+",";
		 }
	ids=ids.substring(0,ids.length-1);
	$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
	    if (r){
	       $.ajax({
            	url:'<%=basePath%>Main/protectobj/expdel?ids='+ids+'&tablecode='+nodes[0].TABLECODE,
            	type:'post',
            	traditional:true,
            	success:function(data){
            		if(data.success){
            			$.lauvan.MsgShow({msg:'数据删除成功'});
            			$("#expcontentgrid").datagrid('clearSelections');
            			$("#expcontentgrid").datagrid('clearChecked');
            			$("#expcontentgrid").datagrid('reload');
            		}
            		else{
            			$.messager.alert('错误',data.msg,data.errorcode);
            		}
            	}
            });
	    }
	});	
}
function selectvalue(value,row,index){
	var selcontent=row.SELCONTENT.split(",");
	var selvalue=row.SELVALUE.split(",");
	var cc=value;
	for(var i=0;i<selvalue.length;i++){
		if(cc==selvalue[i]){
			cc=selcontent[i];
		}
	}
	return cc;		
}
</script>
<c:if test="${isviewexp}">
<div class="easyui-panel" title="重点保护目标"     
        style="width:98%;height:325px;padding:5px;background:#fafafa;"   
        data-options="closable:false,    
                collapsible:true,minimizable:false,maximizable:false">
                </c:if>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">统一标识码：</td>
		    <td style="width:20%">
		    ${defenceobj.nucode}
		    </td>
		    <td class="sp-td1">名称：</td>
		    <td style="width:20%">
		    ${defenceobj.defobjname}
		    </td>
		    <td class="sp-td1">类型代码：</td>
		    <td style="width:20%">
		    ${str:translate(defenceobj.defobjtypecode,'FHMBFL')}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">级别代码：</td>
		    <td>
            ${str:translate(defenceobj.levelcode,'ZDFHJBDM')}
		    </td>
		    <td class="sp-td1">密级代码：</td>
		    <td>
		    ${str:translate(defenceobj.classcode,'ZDFHMJDM')}
		    </td>
		    <td class="sp-td1">值班电话：</td>
		    <td>
		    ${defenceobj.dutytel}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">地址：</td>
		    	<td colspan="5">
		    	${str:translate(defenceobj.districtcode,'EVQY')}
		    	${defenceobj.address}
		   <%-- <td class="sp-td1">数据来源单位：</td>
		    <td>
		    ${str:translate(defenceobj.sourcedeptcode,'ZDFHSJLYDW')}
		    </td> --%>
		    </tr>
		    <tr>
		    <td class="sp-td1">传真：</td>
		    <td>
		    ${defenceobj.fax}
		    </td>
		    <td class="sp-td1">负责人：</td>
		    <td>
		    ${defenceobj.respper}
		    </td>
		    <td class="sp-td1">负责人办公电话：</td>
		    <td>
		    ${defenceobj.respotel}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">负责人移动电话：</td>
		    <td>
		    ${defenceobj.respmtel}
		    </td>
		    <td class="sp-td1">负责人住宅电话：</td>
		    <td>
		    ${defenceobj.resphtel}
		    </td>
		    <td class="sp-td1">联系人：</td>
		    <td>
		    ${defenceobj.contactper}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人办公电话：</td>
		    <td>
		    ${defenceobj.contactotel}
		    </td>
		    <td class="sp-td1">联系人移动电话：</td>
		    <td>
		    ${defenceobj.contactmtel}
		    </td>
		    <td class="sp-td1">联系人住宅电话：</td>
		    <td>
		    ${defenceobj.contacthtel}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人电子邮箱：</td>
		    <td>
		    ${defenceobj.contactemail}
		    </td>
		    <td class="sp-td1">高层基准代码：</td>
		    <td>
		    ${str:translate(defenceobj.elevadatumcode,'ZDFHGCJZ')}
		    </td>
		    <td class="sp-td1">高程：</td>
		    <td>
		    ${defenceobj.elevadation}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">主管单位：</td>
		    <td>
		    ${defenceobj.chargedept}
		    </td>
		    <td class="sp-td1">主管单位地址：</td>
		    	<td colspan="3" style="word-wrap:break-word;word-break:break-all;">
		    	${defenceobj.cdeptaddress}
		    	</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">坐标系统代码：</td>
		    <td>
		    ${str:translate(defenceobj.coordsyscode,'ZDFHZBXT')}
		    </td>
		    <td class="sp-td1">经度：</td>
		    <td>
		    ${defenceobj.longitude}
		    </td>
		    <td class="sp-td1">纬度：</td>
		    <td>
		    ${defenceobj.latitude}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">面积：</td>
		    <td>
		    ${defenceobj.area}
		    </td>
		    <td class="sp-td1">人数：</td>
		    <td>
		    ${defenceobj.personnum}
		    </td>
		    <td class="sp-td1">周边交通情况：</td>
		    <td>
		    ${defenceobj.traffic}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">投入使用时间：</td>
		    <td>
		    ${defenceobj.inusedate}   
		    </td>
		     <td class="sp-td1">设计使用年限：</td>
		    <td>
		    ${defenceobj.useyearnum}
		    </td>
		    <td class="sp-td1">应急通信方式：</td>
		    <td>
		    ${defenceobj.commtype}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">受灾形式：</td>
		    <td>
		    ${defenceobj.disasterform}
		    </td>
		    <td class="sp-td1">防护等级代码：</td>
		    <td>
		     ${str:translate(defenceobj.deflevelcode,'ZDFHFHDJ')}
		    </td>
		    <td class="sp-td1">防护区域：</td>
		    <td>
		    ${defenceobj.defencearea}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">可接纳人数：</td>
		    <td>
		    ${defenceobj.maxpersonnum}
		    </td>
		    <td class="sp-td1">监测方式：</td>
		    <td>
		    ${defenceobj.monitmode}
		    </td>
		    <td class="sp-td1">防护措施：</td>
		    <td>
		    ${defenceobj.defencestep}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">基本情况：</td>
			<td colspan="3" style="word-wrap:break-word;word-break:break-all;">
			${defenceobj.description}</td>
			<td class="sp-td1">备注：</td>
			<td style="word-wrap:break-word;word-break:break-all;">
			${defenceobj.notes}</td>
		    </tr>
    </table>
    <c:if test="${isviewexp}">
</div>
</c:if>
<c:if test="${isviewexp}">
<div class="easyui-panel" title="扩展内容"     
        style="width:98%;height:325px;padding:5px;background:#fafafa;"   
        data-options="closable:false,    
                collapsible:true,minimizable:false,maximizable:false">
      <div class="easyui-layout"  data-options="fit:true">
      <table id="expcontentgrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			        <c:forEach items="${tableattr}" var="attr">
			        <c:choose>
			        <c:when test="${attr.sqltype=='006'}">
			        <c:if test="${attr.selfalg=='1'}">
			         <th field="${attr.upperacode}" code="${attr.selcontent}" width="200">${attr.remark}</th> 
			         </c:if>
			         <c:if test="${attr.selfalg=='0'}">
			         <th field="${attr.upperacode}" formatter="selectvalue" width="200">${attr.remark}</th> 
			         </c:if>
			         </c:when>
			         <c:otherwise>
			         <th field="${attr.upperacode}" width="200">${attr.remark}</th> 
			         </c:otherwise>
			         </c:choose>
			            </c:forEach>
			        </tr> 
			    </thead> 
			</table>
      </div>           
</div>
</c:if>