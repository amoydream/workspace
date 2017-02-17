<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	var zTree_evsms;
	var setting_evsms = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_evsms
		}
	};
	
	var zNodes_evsms =[
	     		{ id:"0", pId:"0", name:"通讯簿"},
	     		{ id:"yj_organ", pid:"0", name:"日常机构"},
	     		{ id:"yj_user", pid:"0", name:"日常机构人员"},
	     		{ id:"hy_organ", pid:"0", name:"应急机构"},
	     		{ id:"hy_user", pid:"0", name:"应急办机构人员"}
	     		//日常机构
	     		<c:forEach items="${orglist2}" var="organ2" >
	     		,{ id:"od_${organ2.or_id}", pid:"${empty organ2.or_pid||organ2.or_pid==0 ? 'yj_organ' : organ2.pid}", name:"${organ2.or_name}"}
	     		</c:forEach>
	     		//日常机构人员
	     		<c:forEach items="${orglist2}" var="ulist2" >
	     		,{ id:"ou_${ulist2.or_id}", pid:"${empty ulist2.or_pid||ulist2.or_pid==0 ? 'yj_user' : ulist2.upid}", name:"${ulist2.or_name}"}
	     		</c:forEach>
	     		//应急办组织机构
	     		<c:forEach items="${orglist}" var="organ" >
	     		,{ id:"d_${organ.d_id}", pid:"${organ.d_pid==0?'hy_organ' : organ.pid}", name:"${organ.d_name}"}
	     		</c:forEach>
	     		//应急办人员
	     		<c:forEach items="${orglist}" var="ulist" >
	     		,{ id:"u_${ulist.d_id}", pid:"${ulist.d_pid==0 ? 'hy_user' : ulist.upid}", name:"${ulist.d_name}"}
	     		</c:forEach>
	     		//群组
	     		<c:forEach items="${clulist}" var="clulist" >
	     		,{ id:"c_${clulist.e_id}", pid:"${clulist.e_pid==0?0 : clulist.epid}", name:"${clulist.e_name}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_evsms(event, treeId, treeNode) {
		$('#eventsmsGrid').datagrid({url:'<%=basePath%>Main/eventProcess/getSmsList/'+treeNode.id});
	};
	$(document).ready(function(){
		var attrArray={
				fitColumns : true,
				idField:'ID',
				fit:true,
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				if(rowData.PHONENUM!=null && rowData.PHONENUM!=''){
					var sms = $("#smsnum").val();
					var smsname = $("#smsnumname").val();
					if((sms+",").indexOf(","+rowData.PHONENUM+",")<0){
						$("#smsnum").val(sms+","+rowData.PHONENUM);
						if(smsname!=null && smsname!=''){
							smsname = smsname+","+rowData.PHONENUM;
						}else{
							smsname = smsname+rowData.PHONENUM;
						}
						$("#smsnumname").textbox("setValue",smsname);
					}
				}
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				if(rowData.PHONENUM!=null && rowData.PHONENUM!=''){
					var sms = $("#smsnum").val()+",";
					var smsname = ","+$("#smsnumname").val()+",";
					sms = sms.replace(","+rowData.PHONENUM+",",",");
					smsname = smsname.replace(","+rowData.PHONENUM+",",",");
					$("#smsnum").val(sms.substring(0,sms.length-1));
					$("#smsnumname").textbox("setValue",smsname.length==1?"":smsname.substring(1,smsname.length-1));
				}
			},
			onCheckAll:function(rows){
				//全选添加
				var sms = $("#smsnum").val();
				var smsname = $("#smsnumname").val();
				for(var i=0;i<rows.length;i++){
					if(rows[i].PHONENUM!=null && rows[i].PHONENUM!=''){
						if((sms+",").indexOf(","+rows[i].PHONENUM+",")<0){
							sms = sms+","+rows[i].PHONENUM;
							if(smsname!=null && smsname!=''){
								smsname = smsname+","+rows[i].PHONENUM;
							}else{
								smsname = smsname+rows[i].PHONENUM;
							}
						}
					}
				}
				$("#smsnum").val(sms);
				$("#smsnumname").textbox("setValue",smsname);
			},
			onUncheckAll:function(rows){
				//全不选
				var sms = $("#smsnum").val()+",";
				var smsname = ","+$("#smsnumname").val()+",";
				for(var i=0;i<rows.length;i++){
					if(rows[i].PHONENUM!=null && rows[i].PHONENUM!=''){
						if(sms.indexOf(","+rows[i].PHONENUM+",")>=0){
							sms = sms.replace(","+rows[i].PHONENUM+",",",");
							smsname = smsname.replace(","+rows[i].PHONENUM+",",",");
						}
					}
				}
				$("#smsnum").val(sms.substring(0,sms.length-1));
				$("#smsnumname").textbox("setValue",smsname.length==1?"":smsname.substring(1,smsname.length-1));
			}
	    };
		$.lauvan.dataGrid("eventsmsGrid",attrArray);
		$.fn.zTree.init($("#eventsmsTree"), setting_evsms, zNodes_evsms);
		zTree_evsms = $.fn.zTree.getZTreeObj('eventsmsTree');
		zTree_evsms.selectNode(zTree_evsms.getNodeByParam("id", '${apId}', null));
	});
	function PHactionfn(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
				+"<a  href=\"javascript:void(0);\" onclick=phonecall('"+row.PHONENUM+"','"+row.WORKNUM+"','"+row.HOMENUM+"','${eventid}') ><span class=\"sphone\"></span>拨打</a></li>"
				+"<li class=\"s_b_3\"><a  href=\"javascript:void(0);\" onclick=sendFax('"+row.FAXNUM+"','"+row.SMSNAME+"','${eventid}') ><span  class=\"sfax\" ></span>传真</a></li>"
				+"</ul>";
		return act;
	}
	//拨打号码
	function phonecall(phone,worknum,homenum,id){
		//alert("手机号码："+phone+",办公号码："+worknum+",住宅号码："+homenum);
		$(document.body).append("<div id='eCallphoneDialog'></div>");
		$("#eCallphoneDialog").dialog({
			title:'请选择拨打号码',
			width: 700,
			height: 350,
			modal: true,
			cache: false,
			onClose:function(){
				$(this).dialog('destroy');
			},
			href: "<%=basePath%>Main/eventProcess/callphone?phone="+phone+"&worknum="+worknum+"&eid="+id
		});
	}
	//发送传真
	function sendFax(fax,recename,id){
		if(fax==null || fax=='' || fax==undefined){
			alert("请填写传真号码！");
		}else if('${faxno}'.indexOf(","+fax+",")>=0){
			alert("传真号码与当前号码一致，不能发送，请选择其他传真号码！");
		}else{
			$(document.body).append("<div id='efaxDialog'></div>");
			$("#efaxDialog").dialog({
				title:'传真发送列表',
				width: 800,
				height: 350,
				modal: true,
				cache: false,
				onClose:function(){
					$("#efaxDialog").dialog('destroy');
				},
			    buttons: [{
					text:'发送传真',
					iconCls:'icon-save',
					handler:function(){
			    		//发送传真
			    		var callids = "";
			    		//var ceids = "";
			    		//var status = "";
			    		//var cnum = 0;
			    		var tifs = "";
			    		var faxnumbers = [];
			    		var fnum = $("#userfaxnum").searchbox('getValue');
			    		if(fnum.indexOf(",")>0){
			    			var f = fnum.split(",");
				    		for(var i=0;i<f.length;i++){
					    		faxnumbers.push(f[i]);
				    		}
			    		}else{
			    			faxnumbers.push(fnum);
			    		}
			    		var tfile = $("#_etifFile").val();
			    		var ttitle = $("#_faxtitle").val();
			    		if(tfile==null || tfile=='' || tfile==undefined){
				    		alert("请正确上传传真文件！");
				    		return;
			    		}
			    		if(fnum==null || fnum=='' || fnum==undefined){
				    		alert("请选择传真号码！");
				    		return;
			    		}
			    		if(ttitle==null || ttitle=='' || ttitle==undefined){
				    		alert("请填写任务标题！");
				    		return;
			    		}
			    		var foptions = {
						    tifFile : tfile,
						    eventId : '${eventid}',
						    title : ttitle,
						    onSendComplete : function(result) {
				    			//cnum++;
				    			//ceids=ceids+","+result.FAX_NUMBER;
				    			callids = callids + ","+result.CALLID;
				    			//status = status + ","+result.STATUS;
				    			if(faxQueue.length==0){
				    				//发送完成标志
				    				$("#_callids").val(callids);
					    			//$("#_ceids").val(ceids);
					    			//$("#_status").val(status);
									$.lauvan.dialogSubmit("efaxform","efaxDialog");
				    			}
						    }
						};
						if(faxnumbers.length>0){
			    			ccmsSendFax(faxnumbers, foptions);
						}
		    			
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#efaxDialog").dialog('close');
					}
				}],
				queryParams:{"fax":fax,"eid":id,"recename":recename},
				href: "<%=basePath%>Main/eventProcess/faxOpen"
			});
		}
	}
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	<ul id="eventsmsTree" class="ztree"></ul>
</div>
<div data-options="region:'center',border:false">
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'center',border:false" >
	<table id="eventsmsGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="SMSNAME" width="150">名称</th> 
				            <th field="POSITION" width="100"  >岗位</th>
				            <th field="ADDRESS" width="150"  >地址</th>
				            <th field="WORKNUM" width="100"  >办公电话</th>
				            <th field="PHONENUM" width="100" >手机</th>
				            <th field="HOMENUM" width="100" >住址电话</th>
				            <th field="FAXNUM" width="100" >传真</th>
				            <th field="CALLACTION" width="180" formatter="PHactionfn">操作</th>
				        </tr> 
				    </thead> 
	</table>
</div>

	<div data-options="region:'south',border:false" >
	 <form id="eventProcessform" method="post" action="<%=basePath %>Main/eventProcess/save" style="width:100%;padding: 0px;margin: 0px;">
	    <input type="hidden" name="t_Bus_EventProcess.eventid" value="${eventid}"/>
	    <table  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		  		<td class="sp-td1" style="width:100px;" >已勾选手机号码</td>
		    	<td colspan="3">
		    		<input type="hidden" id="smsnum" name="smsnum" />
		    		<input type="text" id="smsnumname" name="smsnumname" data-options="icons:iconClear" 
		    		class="easyui-textbox" style="width: 460px;"/>
		    	</td>
		    	</tr>
				<tr>
		  		<td class="sp-td1" style="width:100px;" >短信汇报内容</td>
		    	<td colspan="3">
		    		<textarea id="smscontent" name="smscontent" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 460px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1" style="width:100px;" >处置反馈</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventProcess.ep_content" class="textarea" 
		    		data-options="required:true,validType:'length[0,500]'"  style="width: 460px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
	    </table>
    </form>
	</div>
	</div>
	</div>
</div>	
	
	 
	
