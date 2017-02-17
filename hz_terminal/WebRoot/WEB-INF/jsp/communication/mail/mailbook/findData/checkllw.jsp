<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
    var checkid=",";
    var checkname=",";
	var zTree_llw;
	var setting_llw = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_llw
		}
	};
	
	var zNodes_llw =[
	     		{ id:"gzllw", pId:"0", name:"工作联络网"}
	     		
	     		,{ id:"yj_organ", pid:"gzllw", name:"日常机构"}
	     		,{ id:"yj_user", pid:"gzllw", name:"日常机构人员"}
	     		,{ id:"hy_organ", pid:"gzllw", name:"应急机构"}
	     		,{ id:"hy_user", pid:"gzllw", name:"应急办机构人员"}
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
	     		
	     	];
	
	function zTreeOnClick_llw(event, treeId, treeNode) {
		/* if(treeNode.id=='gzllw'||treeNode.pid=='gzllw'
				||treeNode.id.indexOf("od_")==0 ||treeNode.id.indexOf("ou_")==0 ||treeNode.id.indexOf("d_")==0 ||treeNode.id.indexOf("u_")==0){ */
			if(treeNode.id!='gzllw'){
				$('#llwGrid').datagrid({url:'<%=basePath%>Main/linkman/getllwList/'+treeNode.id});	
			}
			
<%-- 		}else{
			$('#llwGrid').datagrid({url:'<%=basePath%>Main/smsMg/getSmsList/'+treeNode.id+"-"+treeNode.pid});
		} --%>
	};
	$(document).ready(function(){
		var attrArray={
				fitColumns : true,
				idField:'ID',
				fit:true,
				onCheck:function(rowIndex,rowData){
					checkname+=rowData.SMSNAME+",";
					checkid+=rowData.ID+",";
				//在已勾选框添加
				/* if(rowData.PHONENUM!=null && rowData.PHONENUM!=''){
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
				} */
			},
			onUncheck:function(rowIndex,rowData){
				checkname=checkname.replace(","+rowData.SMSNAME+",",",");
				checkid=checkid.replace(","+rowData.ID+",",",");
				//取消勾选
				/* if(rowData.PHONENUM!=null && rowData.PHONENUM!=''){
					var sms = $("#smsnum").val()+",";
					var smsname = ","+$("#smsnumname").val()+",";
					sms = sms.replace(","+rowData.PHONENUM+",",",");
					smsname = smsname.replace(","+rowData.PHONENUM+",",",");
					$("#smsnum").val(sms.substring(0,sms.length-1));
					$("#smsnumname").textbox("setValue",smsname.length==1?"":smsname.substring(1,smsname.length-1));
				} */
			},
			onCheckAll:function(rows){
				for(var i=0;i<rows.length;i++){
					if(checkid.indexOf(","+rows[i].ID+",")==-1){
						checkid+=rows[i].ID+",";	
					}
					if(checkname.indexOf(","+rows[i].SMSNAME+",")==-1){
						checkname+=rows[i].SMSNAME+",";	
					}
				}
				//全选添加
				/* var sms = $("#smsnum").val();
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
				$("#smsnumname").textbox("setValue",smsname); */
			},
			onUncheckAll:function(rows){
				for(var i=0;i<rows.length;i++){
					if(checkid.indexOf(","+rows[i].ID+",")!=-1){
					checkid=checkid.replace(","+rows[i].ID+",",",");
					}
					if(checkname.indexOf(","+rows[i].SMSNAME+",")!=-1){
						checkame=checkname.replace(","+rows[i].SMSNAME+",",",");
						}
				}
				//全不选
				/* var sms = $("#smsnum").val()+",";
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
				$("#smsnumname").textbox("setValue",smsname.length==1?"":smsname.substring(1,smsname.length-1)); */
			}
	    };
		$.lauvan.dataGrid("llwGrid",attrArray);
		$.fn.zTree.init($("#llwTree"), setting_llw, zNodes_llw);
		zTree_llw = $.fn.zTree.getZTreeObj('llwTree');
		zTree_llw.selectNode(zTree_llw.getNodeByParam("id", '${apId}', null));
	});
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	<ul id="llwTree" class="ztree"></ul>
</div>
<div data-options="region:'center',border:false">
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'center',border:false" >
	<table id="llwGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="SMSNAME" width="150">名称</th> 
				            <th field="POSITION" width="100"  >岗位</th>
				            <th field="EMAIL" width="150"  >邮箱</th>
				            <th field="ADDRESS" width="150"  >地址</th>
				            <th field="WORKNUM" width="100"  >办公电话</th>
				            <th field="PHONENUM" width="100" >手机</th>
				            <th field="HOMENUM" width="100" >住址电话</th>
				        </tr> 
				    </thead> 
	</table>
</div>

	</div>
	</div>
</div>	
	
	 
	
