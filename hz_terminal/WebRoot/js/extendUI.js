
/**
 * 补充下拉框属性
 */
$.extend($.fn.combobox, {
	parseOptions:function(element){
		var t=$(element);
		return $.extend({},$.fn.combo.parseOptions(element),{code:t.attr("code")});
	}
});

/**
 * 扩展datagrid.columns，增加code属性，翻译值
 */
$.extend($.fn.datagrid.defaults.view, {
	onBeforeRender:function(target, rows){
		var opts = $.data(target, 'datagrid').options;
		var columns = opts.columns;
		for ( var i = 0; i < columns.length; i++) {
			for ( var j = 0; j < columns[i].length; j++) {
				if (columns[i][j].code && !columns[i][j].formatter) {
					var column = columns[i][j];
					$.ajax({
						url:win_getRootPath()+"/Main/common/getStaticAttr",
		            	type:'post',
		            	dataType:'json',
		            	traditional:true,
		            	async: false,
		            	data:{'acode':column.code},
		            	success:function(data){
		            		if(data){
								column.codeList = data;
							}
		            	}
					});
					columns[i][j].formatter = function (value,rowData,rowIndex){
						var valueName = '';
						var column = this;
						if (column.codeList) {
							//遍历值
							for ( var k = 0; k < column.codeList.length;k++) {
								if(column.codeList[k].P_ACODE==value){
									valueName = column.codeList[k].P_NAME;
									break;
								}
							}
						}
						return valueName;
					};
				}
			}
		}
	}
});
/**
 * From扩展
 * getData 获取数据接口
 * 
 * @param {Object} jq
 * @param {Object} params 设置为true的话，会把string型"true"和"false"字符串值转化为boolean型。
 */
$.extend($.fn.form.methods, {
    getData: function(jq, params){
        var formArray = jq.serializeArray();
        var oRet = {};
        for (var i in formArray) {
            if (typeof(oRet[formArray[i].name]) == 'undefined') {
                if (params) {
                    oRet[formArray[i].name] = (formArray[i].value == "true" || formArray[i].value == "false") ? formArray[i].value == "true" : formArray[i].value;
                }
                else {
                    oRet[formArray[i].name] = formArray[i].value;
                }
            }
            else {
                if (params) {
                    oRet[formArray[i].name] = (formArray[i].value == "true" || formArray[i].value == "false") ? formArray[i].value == "true" : formArray[i].value;
                }
                else {
                    oRet[formArray[i].name] += "," + formArray[i].value;
                }
            }
        }
        return oRet;
    }
});

var sy = sy || {};
sy.onMove = {
		onMove : function(left, top) {
			var l = left;
			var t = top;
			if (l < 1) {
				l = 1;
			}
			if (t < 1) {
				t = 1;
			}
			var width = parseInt($(this).parent().css('width')) + 14;
			var height = parseInt($(this).parent().css('height')) + 14;
			var right = l + width;
			var buttom = t + height;
			var browserWidth = $(window).width();
			var browserHeight = $(window).height();
			if (right > browserWidth) {
				l = browserWidth - width;
			}
			if (buttom > browserHeight) {
				t = browserHeight - height;
			}
			$(this).parent().css({/* 修正面板位置 */
				left : l,
				top : t
			});
		}
	};
	$.extend($.fn.dialog.defaults, sy.onMove);
	$.extend($.fn.window.defaults, sy.onMove);
	$.extend($.fn.panel.defaults, sy.onMove);
	
	/**
	 * panel关闭时回收内存，主要用于layout使用iframe嵌入网页时的内存泄漏问题
	 * 
	 * 
	 * @requires jQuery,EasyUI
	 * 
	 */
	$.extend($.fn.panel.defaults, {
		onBeforeDestroy : function() {
			var frame = $('iframe', this);
			try {
				if (frame.length > 0) {
					for (var i = 0; i < frame.length; i++) {
						frame[i].src = '';
						frame[i].contentWindow.document.write('');
						frame[i].contentWindow.close();
					}
					frame.remove();
					if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
						try {
							CollectGarbage();
						} catch (e) {
						}
					}
				}
			} catch (e) {
			}
		}
	});
	/**
	 * 
	 * 通用错误提示
	 * 
	 * 用于datagrid/treegrid/tree/combogrid/combobox/form加载数据出错时的操作 
	 * @requires jQuery,EasyUI
	 */
	sy.onLoadError = {
		onLoadError : function(XMLHttpRequest) {
			if (parent.$ && parent.$.messager) {
				parent.$.messager.progress('close');
				parent.$.messager.alert('错误', XMLHttpRequest.responseText);
			} else {
				$.messager.progress('close');
				$.messager.alert('错误', XMLHttpRequest.responseText);
			}
		}
	};
	$.extend($.fn.datagrid.defaults, sy.onLoadError);
	$.extend($.fn.treegrid.defaults, sy.onLoadError);
	$.extend($.fn.tree.defaults, sy.onLoadError);
	$.extend($.fn.combogrid.defaults, sy.onLoadError);
	$.extend($.fn.combobox.defaults, sy.onLoadError);
	$.extend($.fn.form.defaults, sy.onLoadError);
	
	/***
	 * dialog打开错误提示页面
	 * */
	sy.onLoad = {
			onLoad : function(XMLHttpRequest) {
				if(XMLHttpRequest.match("^\{(.+:.+,*){1,}\}$")){
					var obj = $.parseJSON(XMLHttpRequest);
					if(!obj.success){//打开失败时
						if(obj.dialogid){
							$("#"+obj.dialogid).dialog('close');
						}else{
							$(this).dialog('close');
						}
						if(obj.msg){
							var defaults={title:'提示',msg:obj.msg,timeout:1000,showType:'slide',style:{right:'',bottom:''}};
							$.messager.show(defaults);
						}
					}
				}
			}
		};
	$.extend($.fn.dialog.defaults, sy.onLoad);