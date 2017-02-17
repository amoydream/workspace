/**
 * dwrloader - jQuery EasyUI
 * 
 * Licensed under the GPL:
 *   http://www.gnu.org/licenses/gpl.txt
 *
 * Copyright 2012 stworthy [ stworthy@gmail.com ] 
 * 
 */

(function($){
	
	function getDwrCommboxLoader(pluginName){
		return function(param, success, error){
			var opts = $(this)[pluginName]('options');
			var code = opts.code;
			//有ATTRCODE则默认取ATTRCODE
			if (code){
				$.ajax({
					url:win_getRootPath()+"/Main/common/getStaticAttr",
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	async: false,
	            	data:{'acode':code},
	            	success:function(data){
	            		if(data){
	            			opts.valueField='P_ACODE';
	            			opts.textField='P_NAME';
	            			//$(this).combobox('loadData',data);
	            			success(data);
						}
	            	}
				});
			}else if (opts.url){
							
			}else{
				return false;
			}
			
		}
	}
	
	$.fn.combobox.defaults.loader = getDwrCommboxLoader('combobox');
})(jQuery);
