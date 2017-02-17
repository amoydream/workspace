<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script type="text/javascript">
	var zTree_preschPro2;
	var setting_preschPro2 = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_preschPro2
		}
	};
	
	var zNodes_preschPro2 =[
	     		{ id:"0", pId:"0", name:"应急处置",open:true}
	     		<c:forEach items="${plist}" var="phase" >
	     		,{ id:"p_${phase.phaseid}", pid:"${empty phase.pid||phase.fatherid==0?0:phase.pid}", name:"${phase.phasename}"}
	     		</c:forEach>
	     		<c:forEach items="${alist}" var="alist" >
	     		,{ id:"${alist.evactid}", pid:"${alist.pid}", name:"${alist.actname}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_preschPro2(event, treeId, treeNode) {
		if(treeNode.id!=0 && treeNode.id.indexOf("p_")<0){
			$('#preschProGrid2').datagrid("showColumn",'ACTLINKERMAN');
			$('#preschProGrid2').datagrid("showColumn",'ACTLINKERTEL');
			$('#preschProGrid2').datagrid("hideColumn",'SEQ');
		}else{
			$('#preschProGrid2').datagrid("hideColumn",'ACTLINKERMAN');
			$('#preschProGrid2').datagrid("hideColumn",'ACTLINKERTEL');
			$('#preschProGrid2').datagrid("showColumn",'SEQ');
		}
		$('#_preschProcessid2').val(treeNode.id);
		$('#_preschProcesspid2').val(treeNode.pid);
		$('#preschProGrid2').datagrid({url:'<%=basePath%>Main/geographic/dispatch/getEventProcessData/${instid}-'+treeNode.id+'-'+treeNode.level});
	};
	$(document).ready(function(){
		var attrArray={
				fitColumns : true,
				idField:'ID',
				fit:true,
				onLoadSuccess:function(data){
				$("#preschProGrid2").datagrid('clearSelections');
				$("#preschProGrid2").datagrid('clearChecked');
			}
	    };
		$.lauvan.dataGrid("preschProGrid2",attrArray);
		$.fn.zTree.init($("#preschProTree2"), setting_preschPro2, zNodes_preschPro2);
		zTree_preschPro2 = $.fn.zTree.getZTreeObj('preschProTree2');
	});
	function phaseTypeFN(value,row,index){
		if(value=='0'){
			return '行动阶段';
		}else if(value=='1'){
			return '行动流程';
		}else if(value=='2'){
			return '行动';
		}else if(value=='3'){
			return '执行部门';
		}else{
			return value;
		}
	}
</script>
<div class="easyui-layout"  data-options="fit:true">
	<div data-options="region:'west',border:false" style="width: 180px;">
		<ul id="preschProTree2" class="ztree"></ul>
	</div>
	<input type="hidden" id="_preschProcessid2"/>
	<input type="hidden" id="_preschProcesspid2"/>
	<div data-options="region:'center',border:false">
		<table id="preschProGrid2" cellspacing="0" cellpadding="0"> 
					    <thead> 
					        <tr> 
					        	<th field="PROCESSTYPE" width="100" formatter="phaseTypeFN">类型</th>
					            <th field="PROCESSNAME" width="100">名称</th>
					            <th field="ACTLINKERMAN" width="100"  hidden="true">联系人</th>
					            <th field="ACTLINKERTEL" width="100"  hidden="true">联系电话</th> 
					            <th field="PCONTENT" width="150"  >说明</th>
					            <th field="SEQ" width="80"  >执行顺序</th>
					        </tr> 
					    </thead> 
		</table>
	</div>
</div>	
	
	 
	
