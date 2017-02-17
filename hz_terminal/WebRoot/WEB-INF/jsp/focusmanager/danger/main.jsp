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
                  { text: '新增', iconCls: 'icon-add',handler:adddanger,permitParams:'${pert:hasperti(applicationScope.dangeradd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:upddanger,permitParams:'${pert:hasperti(applicationScope.dangerupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:deldanger,permitParams:'${pert:hasperti(applicationScope.dangerdel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'DANGERID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/danger/getGridData" ,
				onDblClickRow:function(rowIndex, rowData){
					var attrArray={
							title:'重大危险源详情',
							width: 1200,
							height: 500,
							href:"<%=basePath%>Main/danger/dangerview/"+rowData.DANGERID,
							buttons:[]
					};
					
					$.lauvan.openCustomDialog("dangerView",attrArray,null);
				}
				};
		$.lauvan.dataGrid("dangerGrid",attrArray);
		
	});
	function danger_doSearch(){
		$('#dangerGrid').datagrid('load',{
			dangername: $('#dangername1').val()
		});	
	}
	function adddanger(){
		var attrArray={
				title:'新增重大危险源',
				height: 500,
				width:1200,
				href: '<%=basePath%>Main/danger/dangeradd',
		};
		
		$.lauvan.openCustomDialog("dangerDialog",attrArray,danger_dialogSubmit,'danger_form');	
	}
	function upddanger(){
		var node = $("#dangerGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改重点防护对象',
				height: 500,
				width:1200,
				href: '<%=basePath%>Main/danger/dangerupd/'+node.DANGERID
		};
		$.lauvan.openCustomDialog("dangerDialog",attrArray,danger_dialogSubmit,'danger_form');	
	}
	function danger_dialogSubmit(){
  		$('#danger_form').form('submit',{
  			onSubmit:function(param){
  			var dangername=$('#dangername').textbox('getValue');
  			var dangertypecode=$('#dangertypecode').val();
  			var levelcode=$('#levelcode').combobox('getValue');
  			var districtcode=$('#districtcode').combobox('getValue');
  			var address=$('#address').textbox('getValue');
  			//var sourcedeptcode=$('#sourcedeptcode').combobox('getValue');
  			 if(dangername==""||dangertypecode==""||levelcode==""||districtcode==""||address==""){
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
				$("#dangerDialog").dialog('close');
				$('#dangerGrid').datagrid('reload');
				var tablepara=obj.msg.split(",");
				var attrArray={
						title:'扩展数据',
						height: 300,
						width:700,
						href: '<%=basePath%>Main/danger/getexptand?tablecode='+tablepara[0]+'&tableid='+tablepara[1]
				};
				
				$.lauvan.openCustomDialog("danDialog",attrArray,dan_dialogSubmit,'expdanger_form'); 
				}
			}
		});
  	}
	//扩展保存
	function dan_dialogSubmit(){
		var tablename=document.getElementById("dantablename").value;
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
        		$('#expdanger_form').form('submit',{
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
	function deldanger(){
    	/* var node= $("#dangerGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#dangerGrid").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
			 ids=ids+nodes[i].DANGERID+",";
			 }
    	ids=ids.substring(0,ids.length-1);
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	//url:'<%=basePath%>Main/danger/dangerdel/'+node.DANGERID,
	            	url:'<%=basePath%>Main/danger/dangerdel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#dangerGrid").datagrid('clearSelections');
	            			$("#dangerGrid").datagrid('clearChecked');
	            			$("#dangerGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function finddangertype(){
		var attrArray={
				title:'选择类型',
				width:600,
				height:500,
				href: '<%=basePath%>Main/danger/getTypes',
				buttons:[
	{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var node= $("#dtypetable").datagrid('getSelected');
				var name=node.CHECKNAME;
				var code=node.CHECKCODE;
			    if(name!=''){
			    	$("#dangertypename").textbox('setValue',name);
			    	document.getElementById("dangertypecode").value=code;
		   			$("#dtypeDialog").dialog('close');
				}else{
			    	alert("请选择审批人！");
		    	}
	    		
			}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#dtypeDialog").dialog('close');
		}
	}
				         ]
		}; 
		$.lauvan.openCustomDialog("dtypeDialog",attrArray,null,null);
	}
	
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>名称:</span>
		<input id="dangername1" type="text" class="easyui-textbox" >
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="danger_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dangerGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="NUCODE" width="100">统一识别码</th> 
			            <th field="DANGERNAME" width="150">名称</th>	
			            <th field="DANGERTYPECODE" code="WXYFXYHQFL" width="100">类型</th>	
			            <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别</th>  
			             <th field="DISTRICTCODE" code="441303" width="100">行政区划</th>   
			             <th field="ADDRESS"  width="300">地址</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
