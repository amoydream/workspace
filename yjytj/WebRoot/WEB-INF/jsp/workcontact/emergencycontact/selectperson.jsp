<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var zTree_sperson;
	var zNodes_sperson;
	var selectedNode_sperson;
	var pidss = '${personids}';
	var pidsStr = pidss.split(","); 
	var setting = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick
		}
	};
   
	function zTreeOnClick(event, treeId, treeNode) {
		if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		}
		$('#s_personcontactlist_data').datagrid({url:'<%=basePath%>Main/personcontact/getGridData',queryParams:{p_orid:treeNode.id}});
		selectedNode_sperson=zTree_sperson.getSelectedNodes()[0];
		//$("#_personcontactlist_data").datagrid("clearSelections");
		//$("#_personcontactlist_data").datagrid("clearChecked");
	};

	function initTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/organcontact/getTreeData',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		        	zNodes_sperson = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_sperson!=null)
		            	zTree_sperson.destroy();
		            zTree_sperson =$.fn.zTree.init($("#spersoncontactTree"), setting, zNodes_sperson);
					if(!selectedNode_sperson){
						selectedNode_sperson=zTree_sperson.getNodeByParam("id", '0', null);
						if(selectedNode_sperson.children && selectedNode_sperson.children.length>0)
							selectedNode_sperson=selectedNode_sperson.children[0];
					}
					zTree_sperson.selectNode(selectedNode_sperson);
					zTree_sperson.expandNode(selectedNode_sperson, true, false, false);
					zTree_sperson.setting.callback.onClick(null, zTree_sperson.setting.treeId, selectedNode_sperson);
		            
		        }  
		    });
		 
	}

	function refreshGrid(){
		zTree_sperson.setting.callback.onClick(null, zTree_sperson.setting.treeId, selectedNode_sperson);
	}
	 
	$(function(){
		initTree();
		//删除数组元素方法
		Array.prototype.indexOf = function(val) {  
	         for (var i = 0; i < this.length; i++) {  
	             if (this[i] == val) return i;  
	         }  
	         return -1;  
	     };  
	     Array.prototype.remove = function(val) {  
	         var index = this.indexOf(val);  
	         if (index > -1) {  
	             this.splice(index, 1);  
	         }  
	     }; 
	    //删除数组第一个空元素 
		if(pidsStr[0]==""){
			pidsStr.remove(pidsStr[0]);  
		}
		var attrArray={
				idField:'P_ID',
				fitColumns : true,
				onCheck:function(rowIndex,rowData){
					var isContain = false;
					for(var i=0;i<pidsStr.length;i++){
						if(pidsStr[i]==rowData['P_ID']){
							isContain = true;
					        break;	
						}
					}
					if(isContain==false){						
						pidsStr.push(rowData['P_ID']);
					}
				},
				onUncheck:function(rowIndex,rowData){
					var isContain = false;
					for(var i=0;i<pidsStr.length;i++){
						if(pidsStr[i]==rowData['P_ID']){
							isContain = true;
					        break;	
						}
					}
					if(isContain==true){	
						pidsStr.remove(rowData['P_ID']);
						//pidsStr.pop(rowData['P_ID']);
					}
				
				},
				onCheckAll:function(rows){				
	                 var isContain = false;
					 for (var i = 0; i <rows.length; i++) {
	                    	for(var j = 0; j < pidsStr.length; j++){ 
	                    		//alert(rows[j]['P_ID']);
	                          if (rows[i]['P_ID']==pidsStr[j]) {
	                        	//alert("已经存在："+rows[i]['P_ID']);
	                        	isContain = true;
	                            break;                                 
	                          }else{
	                        	  isContain = false;
	                          }
	                    	} 
	                    	if(isContain == false){
	                    		//alert(rows[i]['P_ID']);
	                            pidsStr.push(rows[i]['P_ID']);  
	                    	}
	                    }		
				},
				onUncheckAll:function(rows){				
					 for (var i = 0; i <rows.length; i++) {
	                    	for(var j = 0; j < pidsStr.length; j++){ 	            

       		
	                          if (rows[i]['P_ID']==pidsStr[j]) {
	                        	//alert("已经存在："+rows[i]['P_ID']);
	                        	pidsStr.remove(rows[i]['P_ID']);
	                            break;                                 
	                          }
	                    	} 	                    	
	                    }							
				},
				onLoadSuccess:function(){
					var pids = '${personids}';
					var arrids = pids.split(",");    
					var rows=$('#s_personcontactlist_data').datagrid('getRows');
                    var rowindex;
                    for (var i = 0; i < rows.length; i++) {
                    	for(var j = 0; j < arrids.length; j++){            
                        if (rows[i]['P_ID'] == arrids[j]) {
                            rowindex = i;                      
                            $('#s_personcontactlist_data').datagrid('checkRow', rowindex);                      
                          }
                    	} 
                    }
				}			
			};
		$.lauvan.dataGrid("s_personcontactlist_data",attrArray);
	});
	
  
	function onSubmit($dialog){
		var e_id = ${e_id};
		if(pidsStr.length==0||pidsStr.length==1){
		  var idStr = pidsStr.join("");
		}else{	
		  var idStr = pidsStr.join(',');
		}
		var url = "<%=basePath%>Main/emergencycontact/personcontactSave";
		$.post(url,{ids:idStr,e_id:e_id}, function(result) {
			if (result.success) {
				refreshEmergencyGrid();
				$.messager.show({title:'提示',msg:'保存成功！',timeout:1000,showType:'fade',style:{right:'',bottom:''}});
				$dialog.dialog('close');
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}
		}, 'json');
		
	}
	
	function CallNumber(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=phonecall('"+row.P_WORKNUMBER+"') ><span></span>拨打</a></li>"
			+"</ul>";
	    return act;
	}
	
	function phonecall(num){
		alert("拨打电话...");
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,Prder:false" style="width:230px">
			<ul id="spersoncontactTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',Prder:false">
			<table id="s_personcontactlist_data" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="P_ID" data-options="hidden:true">ID</th> 
			            <th field="P_NAME" width="80">姓名</th>	
			            <th field="RPOSITION" width="100">岗位</th>
			            <th field="P_WORKNUMBER" width="100">办公电话</th> 	    			          			        		    			          
			            <th field="P_MOBILE" width="100">手机</th> 
			            <th field="P_HOMENUMBER" width="100">住宅电话</th> 
			            <th field="CALLACTION" width="80" formatter="CallNumber">拨打电话</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

