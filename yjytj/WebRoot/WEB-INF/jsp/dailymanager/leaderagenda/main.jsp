<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				//toolbar: '#leaderagenda_tb',
				 toolbar: [
                  { text: '新增日程', iconCls: 'icon-add',handler:addleaderagenda,permitParams:'${pert:hasperti(applicationScope.agendaadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改日程',iconCls: 'icon-pageedit',handler:updleaderagenda,permitParams:'${pert:hasperti(applicationScope.agendaupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:delleaderagenda,permitParams:'${pert:hasperti(applicationScope.agendadel, loginModel.xdlimit)}'}
                 ], 
				fitColumns : true,
				view: detailview,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/leaderagenda/getGridData",
				 detailFormatter:function(index,row){
				return '<div style="padding:2px"><table id="la-' + row.ID + '"></table></div>';
			},
			onExpandRow: function(index,row){
				$('#la-'+row.ID).datagrid({
					url:'<%=basePath%>Main/leaderagenda/getGridDataview?id='+row.ID,
					fitColumns:true,
					singleSelect:true,
					rownumbers:true,
					loadMsg:'',
					height:'auto',
					columns:[[
                        {field:'TYPE',title:'时间',width:50,formatter:function type(value,row,index){
                        	var cc="";
                        	if(value=='001'){
                        	cc="上午";	
                        	}else{
                        	cc="下午";	
                        	}
                        	return cc;
                        }},
                        {field:'CONTENTS7',title:'星期日',width:150},
						{field:'CONTENTS1',title:'星期一',width:150},
						{field:'CONTENTS2',title:'星期二',width:150},
						{field:'CONTENTS3',title:'星期三',width:150},
						{field:'CONTENTS4',title:'星期四',width:150},
						{field:'CONTENTS5',title:'星期五',width:150},
						{field:'CONTENTS6',title:'星期六',width:150},
						{field:'operation',title:'操作',width:100,formatter:function operation(value,row,index){
							var id=row.ID;
							var cc="";
							cc="<table width=\"100%;\"><tr><c:if test='${!pert:hasperti(applicationScope.updagenda, loginModel.xdlimit)}'><td width=\"15%\"><a href=\"javascript:void(0);\" onclick=\"updagenda("+id+")\">修改</a></td></c:if><c:if test='${!pert:hasperti(applicationScope.delagenda, loginModel.xdlimit)}'><td  width=\"15%\"><a href=\"javascript:void(0);\" onclick=\"delagenda("+id+")\">删除</a></td></c:if></tr></table>";
							return cc;
						},width:300}
					]],
					onResize:function(){
						$('#leaderagendaGrid').datagrid('fixDetailRowHeight',index);
					},
					onLoadSuccess:function(){
						setTimeout(function(){
							$('#leaderagendaGrid').datagrid('fixDetailRowHeight',index);
						},0);
					}
				});
				$('#leaderagendaGrid').datagrid('fixDetailRowHeight',index);
			}  
        };
		$.lauvan.dataGrid("leaderagendaGrid",attrArray);
		
	});
	function leaderagenda_doSearch(){
		$('#leaderagendaGrid').datagrid('load',{
			sname: $('#sname').val(),
			syear: $('#syear').textbox('getValue'),
			sweek: $('#sweek').textbox('getValue')
			
		});
	}
	function addleaderagenda(){
		var nowtime=$('#nowtime').datebox('getValue');
		var time=$('#syear').textbox('getValue')+"年"+$('#sweek').textbox('getValue')+"周（"+document.getElementById("sjd").innerText+"）";
		var attrArray={
				title:'新增日程',
				width:800,
				height: 620,
				queryParams:{'nowtime':nowtime,'time':time},
				href:'<%=basePath%>Main/leaderagenda/agendaadd'
		};
		
		$.lauvan.openCustomDialog("leaderagendaDialog",attrArray,leaderagenda_dialogSubmit,'leaderagenda_form');
		
	}
	function leaderagenda_dialogSubmit(){
  		$('#leaderagenda_form').form('submit',{
  			onSubmit:function(param){
  			var name=$('#uname').textbox('getValue');	
  			if(name==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				}
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	function updleaderagenda(){
		var node = $("#leaderagendaGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改日程',
				height: 400,
				width:800,
				href: '<%=basePath%>Main/leaderagenda/agendaupd/'+node.ID
		};
		$.lauvan.openCustomDialog("leaderagendaDialog",attrArray,leaderagenda_dialogSubmit,'leaderagenda_form');
	}
	function updagenda(id){
		var attrArray={
				title:'修改详细日程',
				height: 400,
				width:800,
				href: '<%=basePath%>Main/leaderagenda/updagenda/'+id
		};
		$.lauvan.openCustomDialog("leaderagendaDialog",attrArray,agenda_dialogSubmit,'leaderagenda_form');
	}
	function agenda_dialogSubmit(){
  		$('#leaderagenda_form').form('submit',{
  			onSubmit:function(param){
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	$('#nowtime').datebox({
	    onSelect: function(date){	    	
	    	$.ajax({
            	url:'<%=basePath%>Main/leaderagenda/getchangetime?time='+date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate(),
            	type:'post',
            	traditional:true,
            	success:function(data){
            	$('#syear').textbox('setValue',data.year);
            	$('#sweek').textbox('setValue',data.week);
            	document.getElementById("sjd").innerText="日程时间段："+data.sjd;
            	}
            });   
	    }
	});
	function oper(value,row,index){
		var id=row.ID;
		var cc="";
		cc="<table width=\"100%;\"><c:if test='${!pert:hasperti(applicationScope.addagenda, loginModel.xdlimit)}'><tr><a href=\"javascript:void(0);\" onclick=\"addagenda("+id+")\">新增</a></td></tr></c:if></table>";
		return cc;		
	}
	function addagenda(id){
		var attrArray={
				title:'新增详细日程',
				height: 500,
				width:800,
				href: '<%=basePath%>Main/leaderagenda/addagenda/'+id
		};
		$.lauvan.openCustomDialog("leaderagendaDialog",attrArray,agenda_dialogSubmit,'leaderagenda_form');	
	}
	function delleaderagenda(){
    	/* var node= $("#leaderagendaGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#leaderagendaGrid").datagrid('getChecked');
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
	            	//url:'<%=basePath%>Main/leaderagenda/agendadel/'+node.ID,
	            	url:'<%=basePath%>Main/leaderagenda/agendadel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		$("#leaderagendaGrid").datagrid('clearSelections');
            			$("#leaderagendaGrid").datagrid('clearChecked');
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#leaderagendaGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            			$("#leaderagendaGrid").datagrid('reload');
	            		}
	            	}
	            });
		    }
		});
	}
	function delagenda(id){
		       $.ajax({
	            	url:'<%=basePath%>Main/leaderagenda/delagenda/'+id,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#leaderagendaGrid").datagrid('clearSelections');
	            			$("#leaderagendaGrid").datagrid('clearChecked');
	            			$("#leaderagendaGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
	}
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>姓名:</span>
		<input id="sname" type="text" class="easyui-textbox" >			
		<span>日程时间:</span>
		<input name="nowtime" id="nowtime" type="text" class="easyui-datebox" data-options="required:true" editable="false" value="${now}" style="width: 100px;"></input>
		<span>年份:</span>
		<input id="syear" style="width:50px;" type="text" readonly class="easyui-textbox" value="${year}" >
		<span>周:</span>
		<input id="sweek" style="width:50px;" type="text" readonly class="easyui-textbox" value="${week}" >
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="leaderagenda_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
				<label id="sjd">日程时间段：${sjd}</label>
		</div>
		<div data-options="region:'center',border:false">
		
		<!-- <div id="leaderagenda_tb">
		
		<a href="javascript:void(0);" onclick="addleaderagenda()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增日程</a>
		<a  href="javascript:void(0);" onclick="updleaderagenda()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改日程</a>
		<a href="javascript:void(0);" onclick="delleaderagenda()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>

		</div>  -->
		
			<table id="leaderagendaGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="200">姓名</th> 
			            <th field="REMARK" width="800">备注</th> 
			            <th field="oper" width="100" formatter="oper">操作</th>			         
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
