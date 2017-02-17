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
		$('#smsMobileGrid').datagrid({url:'<%=basePath%>Main/smsMg/getSmsList/'+treeNode.id+"-"+treeNode.pid});
	};
	$(document).ready(function(){
		var attrArray={
				fitColumns : true,
				idField:'PHONENUM',
				fit:true,
				pagination:true,
				pageList: [20,50,100,200],
				onLoadSuccess:function(data){
					var rphone = $("#_smsMobile").val();
					$.each(data.rows, function(index, item){
						if((','+rphone+',').indexOf(','+item.PHONENUM+',')>=0){
							$('#smsMobileGrid').datagrid('checkRow', index);
						}else{
							$('#smsMobileGrid').datagrid('uncheckRow', index);
						}
					});
				},
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				if(rowData.PHONENUM!=null && rowData.PHONENUM!=''){
					var sms = $("#_smsMobile").val();
					var smsname = $("#_smsMobname").val();
					if((","+sms+",").indexOf(","+rowData.PHONENUM+",")<0){
						if(sms!=null && sms!=''){
							sms = sms+","+rowData.PHONENUM;
						}else{
							sms = sms+rowData.PHONENUM;
						}
						$("#_smsMobile").val(sms);
						if(smsname!=null && smsname!=''){
							smsname = smsname+","+rowData.SMSNAME;
						}else{
							smsname = smsname+rowData.SMSNAME;
						}
						$("#_smsMobname").val(smsname);
						$('#select_tagger_sms').tagger('addTag', rowData);
					}
				}
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				if(rowData.PHONENUM!=null && rowData.PHONENUM!=''){
					var sms = ","+$("#_smsMobile").val()+",";
					var smsname = ","+$("#_smsMobname").val()+",";
					sms = sms.replace(","+rowData.PHONENUM+",",",");
					smsname = smsname.replace(","+rowData.SMSNAME+",",",");
					$("#_smsMobile").val(sms.length==1?"":sms.substring(1,sms.length-1));
					$("#_smsMobname").val(smsname.length==1?"":smsname.substring(1,smsname.length-1));
					$('#select_tagger_sms').tagger('removeTag', rowData.PHONENUM);
				}
			},
			onCheckAll:function(rows){
				//全选添加
				var sms = $("#_smsMobile").val();
				var smsname = $("#_smsMobname").val();
				for(var i=0;i<rows.length;i++){
					if(rows[i].PHONENUM!=null && rows[i].PHONENUM!=''){
						if((","+sms+",").indexOf(","+rows[i].PHONENUM+",")<0){
							//sms = sms+","+rows[i].PHONENUM;
							if(sms!=null && sms!=''){
								sms = sms+","+rows[i].PHONENUM;
							}else{
								sms = sms+rows[i].PHONENUM;
							}
							if(smsname!=null && smsname!=''){
								smsname = smsname+","+rows[i].SMSNAME;
							}else{
								smsname = smsname+rows[i].SMSNAME;
							}
							$('#select_tagger_sms').tagger('addTag', rows[i]);
						}
					}
				}
				$("#_smsMobile").val(sms);
				$("#_smsMobname").val(smsname);
				
			},
			onUncheckAll:function(rows){
				//全不选
				var sms = ","+$("#_smsMobile").val()+",";
				var smsname = ","+$("#_smsMobname").val()+",";
				for(var i=0;i<rows.length;i++){
					if(rows[i].PHONENUM!=null && rows[i].PHONENUM!=''){
						if(sms.indexOf(","+rows[i].PHONENUM+",")>=0){
							sms = sms.replace(","+rows[i].PHONENUM+",",",");
							smsname = smsname.replace(","+rows[i].SMSNAME+",",",");
							$('#select_tagger_sms').tagger('removeTag', rows[i].PHONENUM);
						}
					}
				}
				$("#_smsMobile").val(sms.length==1?"":sms.substring(1,sms.length-1));
				$("#_smsMobname").val(smsname.length==1?"":smsname.substring(1,smsname.length-1));
			}
	    };
		$.lauvan.dataGrid("smsMobileGrid",attrArray);
		$.fn.zTree.init($("#smsMobileTree"), setting_sms, zNodes_sms);
		zTree_sms = $.fn.zTree.getZTreeObj('smsMobileTree');
		zTree_sms.selectNode(zTree_sms.getNodeByParam("id", '${apId}', null));
		
		
		var tagger_options = {
		        placeholderText : 'Add...',
		        maxNbTags : false,
		        confirmDelete : true,
		        caseSensitive : false,
		        disableAdd : false,
		        tagId : 'PHONENUM',
		        tagName : 'SMSNAME',
		        clearBtn : true,
		        onRemoveTag : onRemoveTag_sms,
		        validateFn : check_phone,
		        clearFn : clearAll_sms
		    };
		    $('#select_tagger_sms').tagger(tagger_options);
		    $('#select_tagger_sms').tagger('setTags', ${rplist});
		    //if(fax_receivers.length > 0) {
			//    $('#select_tagger_sms').tagger('setTags', fax_receivers);
		   // }
		
	});
	
	function onRemoveTag_sms(tagId) {
	    var rowIndex = $('#smsMobileGrid').datagrid('getRowIndex', tagId);
	    if(rowIndex != -1) {
		    $('#smsMobileGrid').datagrid('uncheckRow', rowIndex);
	    } else {
	    	var sms = ","+$("#_smsMobile").val()+",";
			var smsname = ","+$("#_smsMobname").val()+",";
			var tags = $('#select_tagger_sms').tagger('getTags');
			    if(tags != null || tags.length > 0) {
				    for(var i = 0; i < tags.length; i++) {
					    var PHONENUM = tags[i].PHONENUM;
					    if(PHONENUM == tagId) {
					    	sms = sms.replace(","+tagId+",",",");
							smsname = smsname.replace(","+tags[i].SMSNAME+",",",");
							break;
					    }
				    }
			 }
			$("#_smsMobile").val(sms.length==1?"":sms.substring(1,sms.length-1));
			$("#_smsMobname").val(smsname.length==1?"":smsname.substring(1,smsname.length-1));
		    $('#select_tagger_sms').tagger('removeTag', tagId);
	    }
    }

    function clearAll_sms() {
	    var tags = $('#select_tagger_sms').tagger('getTags');
	    if(tags != null || tags.length > 0) {
		    for(var i = 0; i < tags.length; i++) {
			    var PHONENUM = tags[i].PHONENUM;
			    if(PHONENUM != null) {
				    $('#select_tagger_sms').tagger('removeTag', PHONENUM);
			    }
		    }
	    }
	    $('#smsMobileGrid').datagrid('clearChecked');
    }
    function check_phone(phone) {
    	if(phone == null || typeof phone != 'string' || phone.trim() == '') {
    		return false;
    	}

    	var reg = /^1\d{10}$/;
    	if(!reg.test(phone)) {
    		return false;
    	}
    	reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
		if(!reg.test(phone)) {
			return false;
		}
    	return true;
    }
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	<ul id="smsMobileTree" class="ztree"></ul>
</div>
<div data-options="region:'center',border:false">
<div class="easyui-layout"  data-options="fit:true">

<div data-options="region:'north',border:false" >
	
	    <table  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		    	<td colspan="4">
		    		<input type="hidden" id="_smsMobname" name="_smsMobname" value="${rpname}"/>
		    		<input type="hidden" id="_smsMobile" name="_smsMobile" value="${rphone}"/>
		    		<select id="select_tagger_sms" style="width: 520px;" />
		    	</td>
		    	</tr>
	    </table>
	</div>

<div data-options="region:'center',border:false" >
	<table id="smsMobileGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="SMSNAME" width="150">名称</th> 
				            <th field="PHONENUM" width="100"  >手机</th>
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
	
	 
	
