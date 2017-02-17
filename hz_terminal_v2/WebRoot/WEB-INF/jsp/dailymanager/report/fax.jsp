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
	     		{ id:"hy_organ", pid:"0", name:"应急办"},
	     		{ id:"hy_user", pid:"0", name:"应急办人员"},
	     		{ id:"yj_organ", pid:"0", name:"日常机构"},
	     		{ id:"yj_user", pid:"0", name:"日常机构人员"}
	     		<c:forEach items="${clulist}" var="clulist" >
	     		,{ id:"c_${clulist.e_id}", pid:"0", name:"${clulist.e_name}"}
	     		</c:forEach>
	     		//应急办组织机构
	     		<c:forEach items="${orglist}" var="organ" >
	     		,{ id:"d_${organ.d_id}", pid:"${organ.d_pid==0?'hy_organ' : organ.pid}", name:"${organ.d_name}"}
	     		</c:forEach>
	     		//应急办人员
	     		<c:forEach items="${orglist}" var="ulist" >
	     		,{ id:"u_${ulist.d_id}", pid:"${ulist.d_pid==0 ? 'hy_user' : ulist.upid}", name:"${ulist.d_name}"}
	     		</c:forEach>
	     		//日常机构
	     		<c:forEach items="${orglist2}" var="organ2" >
	     		,{ id:"od_${organ2.or_id}", pid:"${empty organ2.or_pid||organ2.or_pid==0 ? 'yj_organ' : organ2.pid}", name:"${organ2.or_name}"}
	     		</c:forEach>
	     		//日常机构人员
	     		<c:forEach items="${orglist2}" var="ulist2" >
	     		,{ id:"ou_${ulist2.or_id}", pid:"${empty ulist2.or_pid||ulist2.or_pid==0 ? 'yj_user' : ulist2.upid}", name:"${ulist2.or_name}"}
	     		</c:forEach>
	     		//群组
	     		<c:forEach items="${clulist}" var="clulist" >
	     		,{ id:"c_${clulist.e_id}", pid:"${clulist.epid}", name:"${clulist.e_name}"}
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
				if(rowData.FAXNUM!=null && rowData.FAXNUM!=''){
					var sms = $("#smsnum").val();
					var smsname = $("#smsnumname").val();
					$("#smsnum").val(sms+","+rowData.FAXNUM);
					if(smsname!=null && smsname!=''){
						smsname = smsname+","+rowData.FAXNUM;
					}else{
						smsname = smsname+rowData.FAXNUM;
					}
					$("#smsnumname").textbox("setValue",smsname);
				}
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				if(rowData.FAXNUM!=null && rowData.FAXNUM!=''){
					var sms = $("#smsnum").val()+",";
					var smsname = ","+$("#smsnumname").val()+",";
					sms = sms.replace(","+rowData.FAXNUM+",",",");
					smsname = smsname.replace(","+rowData.FAXNUM+",",",");
					$("#smsnum").val(sms.substring(0,sms.length-1));
					$("#smsnumname").textbox("setValue",smsname.length==1?"":smsname.substring(1,smsname.length-1));
				}
			},
			onCheckAll:function(rows){
				//全选添加
				var sms = $("#smsnum").val();
				var smsname = $("#smsnumname").val();
				for(var i=0;i<rows.length;i++){
					if(rows[i].FAXNUM!=null && rows[i].FAXNUM!=''){
						if((sms+",").indexOf(","+rows[i].FAXNUM+",")<0){
							sms = sms+","+rows[i].FAXNUM;
							if(smsname!=null && smsname!=''){
								smsname = smsname+","+rows[i].FAXNUM;
							}else{
								smsname = smsname+rows[i].FAXNUM;
							}
						}
					}
				}
				$("#smsnum").val(sms);
				$("#smsnumname").textbox("setValue",smsname);
			},
			onUncheckAll:function(rows){
				alert("全不选");
				//全不选
				var sms = $("#smsnum").val()+",";
				var smsname = ","+$("#smsnumname").val()+",";
				for(var i=0;i<rows.length;i++){
					if(rows[i].FAXNUM!=null && rows[i].FAXNUM!=''){
						if(sms.indexOf(","+rows[i].FAXNUM+",")>=0){
							sms = sms.replace(","+rows[i].FAXNUM+",",",");
							smsname = smsname.replace(","+rows[i].FAXNUM+",",",");
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
				+"<a  href=\"javascript:void(0);\" onclick=phonecall('"+row.PHONENUM+"','"+row.WORKNUM+"','"+row.HOMENUM+"') ><span></span>拨打</a></li>"
				+"</ul>";
		return act;
	}
	//拨打号码
	function phonecall(phone,worknum,homenum){
		alert("手机号码："+phone+",办公号码："+worknum+",住宅号码："+homenum);
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
				            <th field="POSITION" width="100">岗位</th>
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
	 <form id="reportfaxform" method="post" action="<%=basePath %>Main/dayreport/sendfax" style="width:100%;padding: 0px;margin: 0px;">
	    <table  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		  		<td class="sp-td1" style="width:100px;" >已勾选传真号码</td>
		    	<td colspan="3">
		    		<input type="hidden" id="smsnum" name="smsnum" />
		    		<input type="hidden"  name="t_Bus_Report.r_username" value="${dayreport.r_username }"/>		    		
		    		<input type="text" id="smsnumname" name="smsnumname" data-options="icons:iconClear" 
		    		class="easyui-textbox" style="width: 460px;"/>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1" style="width:100px;" >要情快报标题</td>
		    	<td colspan="3">		    
		    	    <input type="text" name="t_Bus_Report.r_title" value="${title }" data-options="icons:iconClear" 
		    		class="easyui-textbox" style="width: 460px;"/>
		    	</td>
		    	</tr>
				<tr>
		  		<td class="sp-td1" style="width:100px;" >要情快报内容</td>
		    	<td colspan="3">
		    		<textarea id="smscontent" name="t_Bus_Report.r_content" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 460px;height: 50px;" >${content }</textarea>
		    	</td>
		    	</tr>
		    	
	    </table>
    </form>
	</div>
	</div>
	</div>
</div>	