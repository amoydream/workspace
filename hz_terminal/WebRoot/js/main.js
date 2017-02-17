var iconClear=[{iconCls:'icon-clear',handler:function(e){$(e.data.target).textbox('clear');}}];

if ($.messager){
	$.messager.defaults.loadMsg = '数据提交中';
}
//通用方法
$.extend({lauvan:{
	/**
	 * 打开easyui dialog
	 * 
	 * @param    dialogId    	对话框容器id
	 * @param	 attrArray	    easyui属性数组 
	 * @param	 formid	        表单ID
	 * @param	 submitFn	    默认第一个按钮自定义事件 
	 */
	openCustomDialog:function(dialogId,attrArray,submitFn,formid){
		//parent.$("<div id='"+dialogId+"'></div>").appendTo('body');
		$(document.body).append("<div id='"+dialogId+"'></div>");
		var $dialog=$("#"+dialogId);
		var defaults={
			    title: '标题',
			    width: 500,
			    height: 350,
			    cache: false,
			    resizable:true,
			    maximizable:true,
			    modal: true,
			    onClose:function(){
					$(this).dialog('destroy');
					$dialog.remove();
				},
				onRestore:function(){
					$(this).dialog('resize');
					$(this).dialog('resize');
				},
			    buttons: [{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
			    		if(submitFn && $.isFunction(submitFn)){
			    			submitFn();
			    		}else{
			    			if(formid){
			    				$.lauvan.dialogSubmit(formid,dialogId);
			    			}
			    		}
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$dialog.dialog('close');
					}
				}]
			};
		var target=$.extend(false,defaults,attrArray);
		var button=target.buttons;
		var abutton=[];
		if(button){
			for(var i=0;i<button.length;i++){
				abutton.push(button[i]);
				for(var name in button[i]){
					if(name==='permitParams'){//按钮权限
						var permitParam = button[i].permitParams;
						if(permitParam=='true'){
							button[i].disabled=permitParam;
							//button[i] = "";
							//button.splice(i,1);
							abutton.pop();
						}
					}
				}
			}
		}
		target.buttons = abutton;
		$dialog.dialog(target);
	},
	/**
	 * 窗口提示
	 * 
	 * @param	 attrArray	    属性数组 		
	 */
	MsgShow:function(attrArray){
		var defaults={title:'提示',msg:'提示',timeout:1000,showType:'fade',style:{right:'',bottom:''}};
		var target=$.extend(defaults,attrArray);
		$.messager.show(target);
	},
	
	msg : function(options) {
		var opt = {timeout : 500};
		if(typeof(options == 'string')) {
			options = {msg:options};
		}
		opt = $.extend(opt, options);
		
		$.lauvan.MsgShow(opt);
	},
	
	/**
	 * 初始化easyui datagrid
	 * 
	 * @param    tableId		datagrid容器id
	 * @param	 attrArray	    属性数组 
	 * 
	 * attrArray.toolbar额外参数说明
	 * dialogParams:{					//打开dialog需传入的属性值包括以下自定义属性
	 *					dialogId:'',	//dialog的id值(必填)
	 *					href:'',		//dialog加载内容地址(必填)
	 *					outerParam:'',	//外部参数值，与href拼合成地址(可选)
	 *					firstFn			//dialog里第一个按钮默认事件(可选)
	 *				}
	 * 				outerParam为空时，href与datagrid选中行的id值拼合最终href,
	 * 				outerParam不为空时，href与outerParam值拼合成最终href
	 * 
	 * delParams:{						//datagrid删除操作需传入的参数集				
	 * 					url:,			//删除操作地址(必选)
	 * 					successFn:,		//删除成功后执行函数(可选)
	 * 				}
	 * 
	 */
	dataGrid:function(tableId,attrArray){
		var $grid=$("#"+tableId);
		
		//datagrid工具栏(toolbar)通用打开dialog方法
		var openDialog=function(){
			var options=$(this).linkbutton("options");
			var paramsList=options.dialogParams;
			var href=paramsList.href;
			if(paramsList.outerParam){
				href+="/"+paramsList.outerParam;
			}else if(!paramsList.isNoParam){
				var row=$grid.datagrid("getSelected");
				if(!row){
					$.lauvan.MsgShow({msg:'请选择相应的记录！'});
					return;
				}
				href+="/"+row[$grid.datagrid("options").idField];
			}
			var dialogDef={
					title:options.title,
					iconCls:options.iconCls,
			};
			var dialogTgt=$.extend(dialogDef,paramsList);
			dialogTgt.href=href;
			//$.lauvan.openCustomDialog(paramsList.dialogId,dialogTgt,paramsList.firstFn);
			if(paramsList.firstFn!=null && paramsList.firstFn!=undefined){
				$.lauvan.openCustomDialog(paramsList.dialogId,dialogTgt,paramsList.firstFn);
			}else{
				$.lauvan.openCustomDialog(paramsList.dialogId,dialogTgt,null,paramsList.formId);
			}
		}
		//删除操作函数
		var delFn=function (){
			var rows=$grid.datagrid('getChecked');
			var options=$(this).linkbutton("options");
			var paramsList=options.delParams;
			var btext = options.text;
			if(rows.length==0){
				$.lauvan.MsgShow({msg:'请选择要'+btext+'的数据!'});
				return;
			}
			var warnMsg = '您确定'+btext+'选择的数据吗？';
			if(options.warnMsg){
				warnMsg = options.warnMsg;
			}
			$.messager.confirm('删除',warnMsg,function(r){
				var idField=$grid.datagrid("options").idField;
			    if (r){
			    	var ids=[];
			        for(var i=0;i<rows.length;i++){
						ids[i]=rows[i][idField];
					}
			        $.ajax({
		            	url:paramsList.url,
		            	type:'post',
		            	dataType:'json',
		            	traditional:true,
		            	data:{'ids':ids},
		            	success:function(data){
		            		if(data.success){
		            			var msg = data.msg == null ? '数据'+btext+'成功' : data.msg;
		            			if(data.msg != '') {
		            				$.lauvan.MsgShow({msg:msg});
		            			}
		            			if(paramsList.successFn){
		            				paramsList.successFn();
		            			}else{
		            				$grid.datagrid('clearSelections');
		            				$grid.datagrid('clearChecked');
		            				if(data.reflashtab){ //如果传入刷新tab页面的标志
		            					$("#mainTab").tabs('getSelected').panel('refresh');
		            				}else{
		            					$grid.datagrid('reload');
		            				}
		            				if(data.treeObj){
		            					//刷新树
		            					var treeObj =  $.fn.zTree.getZTreeObj(data.treeObj);
		            					if(data.reloadid!=null && ""!=data.reloadid && data.reloadid>0){
		            						var node = treeObj.getNodeByParam(data.idkey, data.reloadid, null);
		            						treeObj.reAsyncChildNodes(node, "refresh");
		            					}else{
		            						treeObj.reAsyncChildNodes(null, "refresh");
		            					}
		            				}
		            			}
		            		}
		            		else{
		            			$.messager.alert('错误',data.msg,data.errorcode);
		            		}
		            	}
		            });
			    }
			});
		}
		
		var defaults={ 
		        width: 700, 
		        height: 'auto', 
		        nowrap: false, 
		        striped: true, 
		        border: true, 
		        collapsible:false,//是否可折叠的 
		        fit: true,//自动大小 
		        singleSelect: true,
		        selectOnCheck: false,
		        checkOnSelect: false,
		        pageSize:20,
		        pageList:[20,50,100],
		        //sortName: 'code', 
		        //sortOrder: 'desc', 
		        remoteSort:false,  
		        pagination:true,//分页控件 
		        rownumbers:true,//行号 
		        frozenColumns:[[ 
		            {field:'ck',checkbox:true} 
		        ]]
		    };
		var target=$.extend(defaults,attrArray);
		var toolbar=target.toolbar;
		if(typeof(toolbar)!='string'){
		var atool=[];
		if(toolbar){
			for(var i=0;i<toolbar.length;i++){
				atool.push(toolbar[i]);
				for(var name in toolbar[i]){
					if(name==='permitParams'){//按钮权限
						var permitParam = toolbar[i].permitParams;
						if(permitParam=='true'||permitParam==true){
							toolbar[i].disabled=permitParam;
							//toolbar[i] = "";
							if(i+1<toolbar.length && toolbar[i+1]=="-"){
								//toolbar[i+1] = "";
								i++;
							}
							atool.pop();
						}
					}
					if(name==='dialogParams'){
						toolbar[i].handler=openDialog;
					}
					if(name==='delParams'){
						toolbar[i].handler=delFn;
					}
				}
			}
		}
		target.toolbar = atool;
		}
		$grid.datagrid(target); 
	},
	/**
	 * ztree树初始化
	 * 
	 * @param	 treeId	    			tree树存放容器 
	 * @param	 url					地址
	 * @param	 selectedTreeNodeId		选中节点id值(可选)
	 * @param	 TreeClickFn			节点单击事件
	 * @param	 loadedFn				ztree加载后执行的函数(可选)
	 * 		
	 */
	initTree:function(treeId,url,selectedTreeNodeId,TreeClickFn,loadedFn){
		var zTree;
		var zNodes;
		var selectedNode;
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
			TreeClickFn(event, treeId, treeNode);
		};
		
		
		$.ajax({  
	        cache:false,  
	        type: 'POST',  
	        dataType : "json",
	        data:{idKey:'id',pidKey:'pId'},
	        url: url,
	        error: function () {
	            alert('请求失败');  
	        },  
	        success:function(data){ 
	            zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
	            var selectedNode=null;
	            if(zTree!=null)
	            	zTree.destroy();
	            zTree =$.fn.zTree.init($("#"+treeId), setting, zNodes);
	            if(!selectedTreeNodeId){
					selectedTreeNodeId=0;
				}
	            selectedNode=zTree.getNodeByParam("id", selectedTreeNodeId, null);
	            zTree.selectNode(selectedNode);
	            zTree.expandNode(selectedNode, true, false, false);
	            if(loadedFn)
	            	loadedFn();
	            zTree.setting.callback.onClick(null, zTree.setting.treeId, selectedNode);
	            
	        }  
	    });
	},
	/**
	 * 表单提交
	 * 
	 * @param	 $dialog	    			dialog对象 
	 * @param	 formId						表单id
	 * @param	 flag						表单提交前额外判断标识(可选)
	 * @param	 successFn					表单提交成功后执行函数(可选)
	 * 		
	 */
	submit:function($dialog,formId,flag,successFn){
		$('#'+formId).form('submit',{
  			onSubmit:function(){
				$.messager.progress();
  				var isValid=$(this).form('enableValidation').form('validate') && flag;
				if(isValid){
					$.messager.progress({title:$.messager.defaults.loadMsg});
				}
				return isValid;
			},
			success:function(result){
				$.messager.progress('close'); 
				var obj=$.parseJSON(result);
				if(obj.success){
					$dialog.dialog('close');
					if(successFn)
						successFn();
					$.messager.progress("close");
				}
			}
		});
	},
	/**
	 * 判断字段数值是否存在
	 * 
	 * @param	 url	    				判断地址
	 * @param	 params						参数集
	 * @param	 fieldId					字段id
	 * @param	 existContent				存在时提示文字
	 * @param	 callbackFn					回调函数(可选)
	 * 		
	 */
	judgeField:function(url,params,fieldId,existContent,callbackFn){
		var $field=$("#"+fieldId);
		$.post(url, params,
				function (data, textStatus){
					var flag=false;
					if(!data.success){
						$field.next("span").tooltip('destroy');
						$field.next("span").children("input").eq(0).removeClass("custombox-invalid");
						flag=true;
					}
					else{
						$field.next("span").tooltip({
							position:'right',
							content:existContent,
							onShow: function(){
							$(this).tooltip('tip').css({
								backgroundColor: 'rgb(255, 255, 204)',
								borderColor: ' rgb(204, 153, 51)'
							});
					    }
						});
						$field.next("span").addClass("textbox-invalid");
						$field.next("span").children("input").eq(0).addClass("custombox-invalid");
						flag=false;
					}
					if(callbackFn)
						callbackFn(flag);
				}, "json");
	},
	/**树列表
	 * @param tableId       树列表id
	 * @param attrArray	    属性数组 
	 * */
	treeGrid:function(tableId,attrArray){
		var $treegrid=$("#"+tableId);
		//datagrid工具栏(toolbar)通用打开dialog方法
		var openDialog=function(){
			var options=$(this).linkbutton("options");
			var paramsList=options.dialogParams;
			var limitLevel = paramsList.limitLevel;
			var pflag = false;
			var href=paramsList.href+"/";
			if(paramsList.outerParam){
				href+=paramsList.outerParam;
			}else{
				var row=$treegrid.datagrid("getSelected");
				var r_id = ""; 
				if(!row){
					if(paramsList.defVal!=null && paramsList.defVal!=undefined){
						href+=paramsList.defVal;
						r_id = paramsList.defVal;
					}else{
						$.lauvan.MsgShow({msg:'请选择相应的记录！'});
						return;
					}
				}else{
					r_id = row[$treegrid.datagrid("options").idField]
					href+=row[$treegrid.datagrid("options").idField];
				}
				if(limitLevel!=null && limitLevel!=undefined){
					var tlevel = $treegrid.treegrid("getLevel",r_id);
					if(tlevel>limitLevel){
						pflag = true;
					}
				}
			}
			if(!pflag){
				var dialogDef={
						title:options.title,
						iconCls:options.iconCls,
				};
				var dialogTgt=$.extend(dialogDef,paramsList);
				dialogTgt.href=href;
				if(paramsList.firstFn!=null && paramsList.firstFn!=undefined){
					$.lauvan.openCustomDialog(paramsList.dialogId,dialogTgt,paramsList.firstFn);
				}else{
					$.lauvan.openCustomDialog(paramsList.dialogId,dialogTgt,null,paramsList.formId);
				}
			}else{
				alert(paramsList.limitLevelMsg);
			}
		}
		//删除操作函数
		var delFn=function (){
			var ckfiled = $treegrid.treegrid("getColumnOption","ck");
			var rows=$treegrid.datagrid('getChecked');
			var options=$(this).linkbutton("options");
			var paramsList=options.delParams;
			if(rows.length==0){
				if(ckfiled!=null){
					$.lauvan.MsgShow({msg:'请选择要删除的数据!'});
					return;
				}else{
					var row_0 = $treegrid.datagrid('getSelected');
					if(row_0==null || row_0==undefined){
						$.lauvan.MsgShow({msg:'请选择要删除的数据!'});
						return;
					}else{
						rows[0]=row_0;
					}
				}
			}
			$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
				var idField=$treegrid.datagrid("options").idField;
			    if (r){
			    	var ids=[];
			        for(var i=0;i<rows.length;i++){
						ids[i]=rows[i][idField];
					}
			        $.ajax({
		            	url:paramsList.url,
		            	type:'post',
		            	dataType:'json',
		            	traditional:true,
		            	data:{'ids':ids},
		            	success:function(data){
		            		if(data.success){
	            				$.lauvan.MsgShow({msg:'数据删除成功'});
		            			if(paramsList.successFn){
		            				paramsList.successFn();
		            			}else{
		            				$treegrid.treegrid('clearSelections');
		            				$treegrid.treegrid('clearChecked');
		            				var param = $treegrid.treegrid("options").queryParams;
		            				if(data.treeid!=null && data.treeid!=""){
		            					$treegrid.treegrid('reload',data.treeid); 
		            				}else if(param!=null && param.pid !=null){
		            					$treegrid.treegrid('reload',param.pid); 
		            				}else{
		            					$treegrid.treegrid('reload'); 
		            				}
		            			}
		            		}
		            		else{
		            			$treegrid.treegrid('clearSelections');
	            				$treegrid.treegrid('clearChecked');
		            			$.messager.alert('错误',data.msg,data.errorcode);
		            		}
		            	}
		            });
			    }
			});
			
		}
		
		var defaults={ 
		        width: 700, 
		        height: 'auto', 
		        nowrap: false, 
		        striped: true, 
		        border: true,
		        method: 'post',
		        collapsible:false,//是否可折叠的 
		        fit: true,//自动大小 
		        singleSelect: true,
		        selectOnCheck: false,
		        checkOnSelect: false,
		        pageSize:20,
		        pageList:[20,50,100],
		        fitColumns : true, 
		        remoteSort:false,  
		        pagination:true,//分页控件 
		        rownumbers:true//行号
		    };
		var target=$.extend(defaults,attrArray);
		
		var toolbar=target.toolbar;
		if(typeof(toolbar)!='string'){
			var atool=[];
		if(toolbar){
			for(var i=0;i<toolbar.length;i++){
				atool.push(toolbar[i]);
				for(var name in toolbar[i]){
					if(name==='permitParams'){//按钮权限
						var permitParam = toolbar[i].permitParams;
						if(permitParam=='true'||permitParam==true){
							toolbar[i].disabled=permitParam;
							//toolbar[i] = "";
							//if(i+1<toolbar.length && toolbar[i+1]=="-"){
							//	toolbar[i+1] = "";
							//}
							if(i+1<toolbar.length && toolbar[i+1]=="-"){
								i++;
							}
							atool.pop();
						}
					}
					if(name==='dialogParams'){
						toolbar[i].handler=openDialog;
					}
					if(name==='delParams'){
						toolbar[i].handler=delFn;
					}
				}
			}
		}
		target.toolbar = atool;
		}
		
		$treegrid.treegrid(target); 
	    //设置分页控件 
	    var p = $treegrid.treegrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 20,//每页显示的记录条数，默认为20 
	        pageList: [20,50,100],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	    }); 
	},
	/***
	 * 提交方法ajax
	 * @param formid	    表单ID
	 * @param dialogid	    dialogID
	 * */
	dialogSubmit:function(formid,dialogid){
  		$('#'+formid).form('submit',{
  			onSubmit:function(){
  				var fboolean = $(this).form('enableValidation').form('validate');
  				if(!fboolean){
  					$.messager.alert('警告','请按要求填写信息！');
  				}
				return fboolean;
			},
			success:function(result){
				var obj=$.parseJSON(result);
				if(obj.tabid && obj.furl){
					$.lauvan.reflashTab(result);
				}else{
					$.lauvan.reflash(result);
				}
			}
		});
  	},
	/**
	 * 返回刷新方法
	 * @param result 后台返回组装的json值
	 * **/
	reflash:function(result){
		var obj=$.parseJSON(result);
		if(obj.success){
			if(obj.dialogid){
				$("#"+obj.dialogid).dialog('close');
			}
			if(obj.treegid){
				$('#'+obj.treegid).treegrid('clearSelections');
				$('#'+obj.treegid).treegrid('clearChecked');
				var param = $('#'+obj.treegid).treegrid("options").queryParams;
				if(obj.reloadid!=null && ""!=obj.reloadid && obj.reloadid>0){
					var childs = $('#'+obj.treegid).treegrid('getChildren',obj.reloadid);
					if(childs!=null && childs.length>0){
						$('#'+obj.treegid).treegrid('reload',obj.reloadid);
					}else{
						var pid = $('#'+obj.treegid).treegrid('getParent',obj.reloadid);
						if(pid!=null){
							$('#'+obj.treegid).treegrid('reload',pid[$('#'+obj.treegid).treegrid("options").idField]);
						}else{
							$('#'+obj.treegid).treegrid('reload'); 
						}
					}
				}else if(obj.reloadid==0){
					$('#'+obj.treegid).treegrid('reload'); 
				}else if(param!=null && param.pid !=null){
					$('#'+obj.treegid).treegrid('reload',param.pid); 
				}else{
					$('#'+obj.treegid).treegrid('reload'); 
				}
				
			}
			if(obj.gridid){
				$('#'+obj.gridid).datagrid('clearSelections');
				$('#'+obj.gridid).datagrid('clearChecked');
				$('#'+obj.gridid).datagrid('reload'); 
			}
			if(obj.msg){
				var defaults={title:'提示',msg:obj.msg,timeout:1000,showType:'slide',style:{right:'',bottom:''}};
				$.messager.show(defaults);
			}
			if(obj.treeObj){
				//刷新树
				var treeObj =  $.fn.zTree.getZTreeObj(obj.treeObj);
				//勾选节点
				if(obj.reloadid!=null && ""!=obj.reloadid && "null"!=obj.reloadid){
					var node = treeObj.getNodeByParam(obj.idkey, obj.reloadid, null);
					node.isParent = true;
					treeObj.reAsyncChildNodes(node, "refresh");
					treeObj.selectNode(node);
				}else{
					treeObj.reAsyncChildNodes(null, "refresh");
				}
			}
		}else{
			$.messager.alert("错误",obj.msg,"error");
		}
	},
	reflashTab:function(result){
		var obj=$.parseJSON(result);
		if(obj.success){
			if(obj.dialogid){
				$("#"+obj.dialogid).dialog('close');
			}
			if(obj.msg){
				var defaults={title:'提示',msg:obj.msg,timeout:1000,showType:'slide',style:{right:'',bottom:''}};
				$.messager.show(defaults);
			}
			//window.parent.reflshTab(obj.tabid,obj.furl);
			if ($("#mainTab").tabs('exists', obj.tabid)){
				$("#mainTab").tabs('select', obj.tabid);
		    	// 调用 'refresh' 方法更新选项卡面板的内容
		    	var _tab = $("#mainTab").tabs('getSelected');  // 获取选择的面板
		    	_tab.panel('refresh', $.basePath+obj.furl);
		    }
		}else{
			$.messager.alert("错误",obj.msg,"error");
		}
	},
	/**
	 * 获取地图点位置方法
	 * @param lng     		经度
	 * @param lat    		纬度
	 * @param callback      回调函数(参数：lng,lat)
	 * **/
	openGisDialog:function(lng,lat,callback){
		var dialogId="gisDialog";
		var attrArray={
				title:'获取地理位置',
				width:1000,
				height:600,
				iconCls:"icon-world",
				href: $.basePath+'Main/geographic/common/getGeoPosition?lat='+lat+'&lng='+lng,
				buttons:[
				{
					text:'确定',
					iconCls:'icon-save',
					handler:function(){
						callback(point.lng,point.lat);
						$("#"+dialogId).dialog('close');
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#"+dialogId).dialog('close');
					}
				}
			 ]
			}; 
			$.lauvan.openCustomDialog("gisDialog",attrArray,callback,null);
	}
}});
