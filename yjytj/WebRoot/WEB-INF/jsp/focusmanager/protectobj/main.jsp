<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:addprotectobj,permitParams:'${pert:hasperti(applicationScope.protectadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:updprotectobj,permitParams:'${pert:hasperti(applicationScope.protectupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:delprotectobj,permitParams:'${pert:hasperti(applicationScope.protectdel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'DEFOBJID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/protectobj/getGridData" ,
				onDblClickRow:function(rowIndex, rowData){
					var attrArray={
							title:'防护目标详情',
							width: 1000,
							height: 500,
							href:"<%=basePath%>Main/protectobj/protectview/"+rowData.DEFOBJID,
							buttons:[]
					};
					
					$.lauvan.openCustomDialog("proobjtableView",attrArray,null);
				}
				};
		$.lauvan.dataGrid("protectobjGrid",attrArray);
		
	});
	function protectobj_doSearch(){
		$('#protectobjGrid').datagrid('load',{
			protectobjname: $('#protectobjname').val()
		});	
	}
	function addprotectobj(){
		var attrArray={
				title:'新增重点防护对象',
				height: 500,
				width:1000,
				href: '<%=basePath%>Main/protectobj/protectadd',
		};
		
		$.lauvan.openCustomDialog("protectobjDialog",attrArray,protectobj_dialogSubmit,'protectobj_form');	
	}
	function updprotectobj(){
		var node = $("#protectobjGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改重点防护对象',
				height: 500,
				width:1000,
				href: '<%=basePath%>Main/protectobj/protectupd/'+node.DEFOBJID
		};
		$.lauvan.openCustomDialog("protectobjDialog",attrArray,protectobj_dialogSubmit,'protectobj_form');	
	}
	function protectobj_dialogSubmit(){
  		$('#protectobj_form').form('submit',{
  			onSubmit:function(param){
  			var defobjname=$('#defobjname').textbox('getValue');
  			var defobjtypecode=$('#defobjtypecode').val();
  			var levelcode=$('#levelcode').combobox('getValue');
  			var districtcode=$('#districtcode').combobox('getValue');
  			var address=$('#address').textbox('getValue');
  			//var sourcedeptcode=$('#sourcedeptcode').combobox('getValue');
  			if(defobjname==""||defobjtypecode==""||levelcode==""||districtcode==""||address==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				}  
  			/* var reg = new RegExp("^[0-9]{11}$");
  			if(!reg.test(mbusername)){
  				$.messager.alert('错误','用户名必须为11为数字的号码，请检查！','error');
                return false;
  			}  */ 
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				if(obj.msg=="保存成功！"||obj.msg=="修改成功！"||obj.msg=="保存异常！"){
					$.lauvan.reflash(result);	
				}else{
				$("#protectobjDialog").dialog('close');
				$('#protectobjGrid').datagrid('reload');
				var tablepara=obj.msg.split(",");
				var attrArray={
						title:'扩展数据',
						height: 300,
						width:700,
						href: '<%=basePath%>Main/protectobj/getexptand?tablecode='+tablepara[0]+'&tableid='+tablepara[1]
				};
				
				$.lauvan.openCustomDialog("proobjDialog",attrArray,proobj_dialogSubmit,'exptand_form');
				}
			}
		});
  	}
	//扩展保存
	function proobj_dialogSubmit(){
		var tablename=document.getElementById("tablename").value;
		$.ajax({
        	url:'<%=basePath%>Main/protectobj/getattr?tablename='+tablename,
        	type:'post',
        	traditional:true,
        	success:function(data){
        		var flag=false;
        		for(var i=0;i<data.required.length;i++){
        			if(data.required[i].ISNULL==1){
        			if(data.required[i].SQLTYPE=='004'||data.required[i].SQLTYPE=='002'){
        			if($('#'+data.required[i].ACODE).textbox('getValue')==""){
    				flag=true;		
    				}  
        			}else if(data.required[i].SQLTYPE=='001'||data.required[i].SQLTYPE=='011'){
        			if($('#'+data.required[i].ACODE).datebox('getValue')==""){
            		flag=true;		
            		} 
        			}else if(data.required[i].SQLTYPE=='003'||data.required[i].SQLTYPE=='006'){
        			if($('#'+data.required[i].ACODE).combobox('getValue')==""){
                    flag=true;		
                    }	
        			}
        			else{
        			if(document.getElementById(data.required[i].ACODE).value==""){
                    flag=true;		
                    }	
        			}
        			}
        		}
        		if(flag){
        		$.messager.alert('错误','存在必填项未填，请检查！','error');
                return false;
        		}
        		$('#exptand_form').form('submit',{
    				onSubmit:function(param){
    					
    				},
    			success:function(result){
    				var obj=$.parseJSON(result);
    				$.lauvan.reflash(result);
    			}
    		});
        	}
        });
		}
	function delprotectobj(){
    	/* var node= $("#protectobjGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#protectobjGrid").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
			 ids=ids+nodes[i].DEFOBJID+",";
			 }
    	ids=ids.substring(0,ids.length-1);
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	//url:'<%=basePath%>Main/protectobj/protectdel/'+node.DEFOBJID,
	            	url:'<%=basePath%>Main/protectobj/protectdel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#protectobjGrid").datagrid('clearSelections');
	            			$("#protectobjGrid").datagrid('clearChecked');
	            			$("#protectobjGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function findtype(){
		var attrArray={
				title:'选择类型',
				width:600,
				height:500,
				href: '<%=basePath%>Main/protectobj/getTypes',
				buttons:[
	{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var node= $("#typetable").datagrid('getSelected');
				var name=node.CHECKNAME;
				var code=node.CHECKCODE;
			    if(name!=''){
			    	$("#defobjtypename").textbox('setValue',name);
			    	document.getElementById("defobjtypecode").value=code;
		   			$("#typeDialog").dialog('close');
				}else{
			    	alert("请选择审批人！");
		    	}
	    		
			}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#typeDialog").dialog('close');
		}
	}
				         ]
		}; 
		$.lauvan.openCustomDialog("typeDialog",attrArray,null,null);
	}
	
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>名称:</span>
		<input id="protectobjname" type="text" class="easyui-textbox" >
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="protectobj_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="protectobjGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="NUCODE" width="100">统一识别码</th> 
			            <th field="DEFOBJNAME" width="150">名称</th>	
			            <th field="DEFOBJTYPECODE" code="FHMBFL" width="100">类型</th>	
			            <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别</th>  
			             <th field="DISTRICTCODE" code="441303" width="100">行政区划</th>   
			             <th field="ADDRESS"  width="300">地址</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
