<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	var zTree_sms;
	var setting_sms = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_sms
		}
	};
	
	var zNodes_sms =[
	     		{ id:"0", pId:"0", name:"通讯簿"},
	     		/* { id:"dept", pid:"0", name:"部门"}, */
	     		/* { id:"cluster", pid:"0", name:"群组"} */
	     		{ id:"c_0", pid:"0", name:"群组"} 
	     		//部门
	     		/* <c:forEach items="${orglist2}" var="organ2" >
	     		,{ id:"${organ2.did}", pid:"dept", name:"${organ2.dept}"}
	     		</c:forEach> */
	     		//群组
	     		<c:forEach items="${clulist}" var="clulist" >
	     		,{ id:"c_${clulist.id}", pid:"c_${clulist.pid}", name:"${clulist.name}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_sms(event, treeId, treeNode) {
		$('#selMailbookGrid').datagrid({url:'<%=basePath%>Main/mailbook/getMailList/'+treeNode.id+"-"+treeNode.pid});
	};
	$(document).ready(function(){
		var attrArray={
				fitColumns : true,
				idField:'MAIL',
				fit:true,
				pagination:true,
				pageList: [20,50,100,200],
				onLoadSuccess:function(data){
					var rmail = $("#_selMailaddress").val();
					$.each(data.rows, function(index, item){
						if((','+rmail+',').indexOf(','+item.MAIL+',')>=0){
							$('#selMailbookGrid').datagrid('checkRow', index);
						}else{
							$('#selMailbookGrid').datagrid('uncheckRow', index);
						}
					});
				},
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				if(rowData.MAIL!=null && rowData.MAIL!=''){
					console.info(rowData);
					var sms = $("#_selMailaddress").val();
					var smsname = $("#_selMailname").val();
					if((","+sms+",").indexOf(","+rowData.MAIL+",")<0){
						if(sms!=null && sms!=''){
							sms = sms+","+rowData.MAIL;
						}else{
							sms = sms+rowData.MAIL;
						}
						$("#_selMailaddress").val(sms);
						if(smsname!=null && smsname!=''){
							smsname = smsname+","+rowData.SMSNAME;
						}else{
							smsname = smsname+rowData.SMSNAME;
						}
						$("#_selMailname").val(smsname);
						console.info($('#selected_tagger_mail').tagger('addTag', rowData));
					}
				}
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				if(rowData.MAIL!=null && rowData.MAIL!=''){
					var sms = ","+$("#_selMailaddress").val()+",";
					var smsname = ","+$("#_selMailname").val()+",";
					sms = sms.replace(","+rowData.MAIL+",",",");
					smsname = smsname.replace(","+rowData.SMSNAME+",",",");
					$("#_selMailaddress").val(sms.length==1?"":sms.substring(1,sms.length-1));
					$("#_selMailname").val(smsname.length==1?"":smsname.substring(1,smsname.length-1));
					$('#selected_tagger_mail').tagger('removeTag', rowData.MAIL);
				}
			},
			onCheckAll:function(rows){
				//全选添加
				var sms = $("#_selMailaddress").val();
				var smsname = $("#_selMailname").val();
				for(var i=0;i<rows.length;i++){
					if(rows[i].MAIL!=null && rows[i].MAIL!=''){
						if((","+sms+",").indexOf(","+rows[i].MAIL+",")<0){
							//sms = sms+","+rows[i].MAIL;
							if(sms!=null && sms!=''){
								sms = sms+","+rows[i].MAIL;
							}else{
								sms = sms+rows[i].MAIL;
							}
							if(smsname!=null && smsname!=''){
								smsname = smsname+","+rows[i].SMSNAME;
							}else{
								smsname = smsname+rows[i].SMSNAME;
							}
							$('#selected_tagger_mail').tagger('addTag', rows[i]);
						}
					}
				}
				$("#_selMailaddress").val(sms);
				$("#_selMailname").val(smsname);
				
			},
			onUncheckAll:function(rows){
				//全不选
				var sms = ","+$("#_selMailaddress").val()+",";
				var smsname = ","+$("#_selMailname").val()+",";
				for(var i=0;i<rows.length;i++){
					if(rows[i].MAIL!=null && rows[i].MAIL!=''){
						if(sms.indexOf(","+rows[i].MAIL+",")>=0){
							sms = sms.replace(","+rows[i].MAIL+",",",");
							smsname = smsname.replace(","+rows[i].SMSNAME+",",",");
							$('#selected_tagger_mail').tagger('removeTag', rows[i].MAIL);
						}
					}
				}
				$("#_selMailaddress").val(sms.length==1?"":sms.substring(1,sms.length-1));
				$("#_selMailname").val(smsname.length==1?"":smsname.substring(1,smsname.length-1));
			}
	    };
		$.lauvan.dataGrid("selMailbookGrid",attrArray);
		$.fn.zTree.init($("#selMailbookTree"), setting_sms, zNodes_sms);
		zTree_sms = $.fn.zTree.getZTreeObj('selMailbookTree');
		zTree_sms.selectNode(zTree_sms.getNodeByParam("id", '${apId}', null));
		
		
		var tagger_options = {
		        placeholderText : 'Add...',
		        maxNbTags : false,
		        confirmDelete : true,
		        caseSensitive : false,
		        disableAdd : false,
		        tagId : 'MAIL',
		        tagName : 'SMSNAME',
		        clearBtn : true,
		        validateFn : check_mail,
		        onRemoveTag : onRemoveTag_sms,
		        clearFn : clearAll_sms
		    };
		    $('#selected_tagger_mail').tagger(tagger_options);
		    $('#selected_tagger_mail').tagger('setTags', ${rplist});
		    //if(fax_receivers.length > 0) {
			//    $('#selected_tagger_mail').tagger('setTags', fax_receivers);
		   // }
		
	});
	
	function onRemoveTag_sms(tagId) {
	    var rowIndex = $('#selMailbookGrid').datagrid('getRowIndex', tagId);
	    if(rowIndex != -1) {
		    $('#selMailbookGrid').datagrid('uncheckRow', rowIndex);
	    } else {
	    	var sms = ","+$("#_selMailaddress").val()+",";
			var smsname = ","+$("#_selMailname").val()+",";
			var tags = $('#selected_tagger_mail').tagger('getTags');
			    if(tags != null || tags.length > 0) {
				    for(var i = 0; i < tags.length; i++) {
					    var MAIL = tags[i].MAIL;
					    if(MAIL == tagId) {
					    	sms = sms.replace(","+tagId+",",",");
							smsname = smsname.replace(","+tags[i].SMSNAME+",",",");
							break;
					    }
				    }
			 }
			$("#_selMailaddress").val(sms.length==1?"":sms.substring(1,sms.length-1));
			$("#_selMailname").val(smsname.length==1?"":smsname.substring(1,smsname.length-1));
		    $('#selected_tagger_mail').tagger('removeTag', tagId);
	    }
    }

    function clearAll_sms() {
	    var tags = $('#selected_tagger_mail').tagger('getTags');
	    if(tags != null || tags.length > 0) {
		    for(var i = 0; i < tags.length; i++) {
			    var MAIL = tags[i].MAIL;
			    if(MAIL != null) {
				    $('#selected_tagger_mail').tagger('removeTag', MAIL);
			    }
		    }
	    }
	    $('#selMailbookGrid').datagrid('clearChecked');
    }
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	<ul id="selMailbookTree" class="ztree"></ul>
</div>
<div data-options="region:'center',border:false">
<div class="easyui-layout"  data-options="fit:true">

<div data-options="region:'north',border:false" >
	
	    <table  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		    	<td colspan="4">
		    		<input type="hidden" id="_selMailname" name="_selMailname" value="${rpname}"/>
		    		<input type="hidden" id="_selMailaddress" name="_selMailaddress" value="${rmail}"/>
		    		<select id="selected_tagger_mail" style="width: 520px;" />
		    	</td>
		    	</tr>
	    </table>
	</div>

<div data-options="region:'center',border:false" >
	<table id="selMailbookGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="SMSNAME" width="150">名称</th> 
				            <th field="MAIL" width="100"  >邮箱</th>
				            <th field="DEPT" width="150"  >部门</th>
				            <th field="POSITION" width="100"  >职位</th>
				            <th field="REMARK" width="100" >备注</th>
				        </tr> 
				    </thead> 
	</table>
</div>

	
	</div>
	</div>
</div>	
	
	 
	
