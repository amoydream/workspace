
function paginationNav(elemId, pageView, navFuncName) {
	var navHtml = '<nav><ul class="pagination">';
	navHtml += '<li style="cursor:pointer;"><a' + (pageView.currentpage != 1 ? ' onclick="' + navFuncName + '(1);">' : '>');
	navHtml += '<span>首页</a></li>';
	navHtml += '<li style="cursor:pointer;"><a';
	navHtml += pageView.currentpage > 1 ? ' onclick="' + navFuncName + '(\'' + (pageView.currentpage - 1) + '\');">' : '><span>';
	navHtml += '上一页</a></li>';
	for(var i = pageView.pageindex.startindex; i <= pageView.pageindex.endindex; i++) {
		navHtml += i == pageView.currentpage ? '<li style="cursor:pointer;" class="active">' : '<li style="cursor:pointer;">';
		navHtml += '<a onclick="' + navFuncName + '(\'' + i + '\');"><span>' + i + '</a></li>'
	}
	navHtml += '<li style="cursor:pointer;"><a';
	navHtml += pageView.currentpage < pageView.totalpage ? ' onclick="' + navFuncName + '(\''
	                                                       + (pageView.currentpage + 1) + '\');">' : '>';
	navHtml += '<span>下一页</a></li>';
	navHtml += '<li style="cursor:pointer;"><a';
	navHtml += pageView.currentpage < pageView.totalpage ? ' onclick="' + navFuncName + '(\'' + pageView.totalpage
	                                                       + '\');">' : '>';
	navHtml += '末页</i></a></li>';
	navHtml += '</ul></nav>';
	document.getElementById(elemId).innerHTML = navHtml;
}

/*function telNoBtn(bo_number, ev_id) {
	if(bo_number != undefined && bo_number != null && typeof bo_number == 'string' && bo_number.trim() != '') {
		bo_number = bo_number.trim();
		var str = '<a class="btn btn-link btn-xs" onclick="parent.parent.callOut(\'' + bo_number + '\',\'' + ev_id
		          + '\');"><i class="icon-phone"/>&nbsp;' + bo_number + '</a>';
		return str;
	}
	return '';
}*/

function telNoBtn(tel_numbers) {
	var str = '';
	if(typeof(tel_numbers) === 'string' && tel_numbers.trim() != '') {
		tel_numbers = tel_numbers.trim().split(',');
		if(tel_numbers.length > 0) {
			str = '<a class="btn btn-link btn-xs" onclick="parent.parent.callOut(' + tel_numbers[0]
	          + ');"><span class="glyphicon glyphicon-earphone"> ' + tel_numbers[0] + '</a>';
			for(var i = 1; i < tel_numbers.length; i++) {
				str += '<a class="btn btn-link btn-xs" onclick="parent.parent.callOut(' + tel_numbers[i]
		          + ');"><span class="glyphicon glyphicon-earphone"> ' + tel_numbers[i] + '</a>';
			}
		}
	}
	
	return str;
}

Array.prototype.indexOf = function(val) {
	for(var i = 0; i < this.length; i++) {
		if(this[i] == val)
			return i;
	}
	return -1;
};
Array.prototype.remove = function(val) {
	var index = this.indexOf(val);
	if(index > -1) {
		this.splice(index, 1);
	}
};
Array.prototype.S = String.fromCharCode(2);
Array.prototype.in_array = function(e) {
	var r = new RegExp(this.S + e + this.S);
	return (r.test(this.S + this.join(this.S) + this.S));
};
/*该方法使日期列的显示符合阅读习惯*/
//datagrid中用法：{ field:'StartDate',title:'开始日期', formatter: formatDatebox, width:80}
function formatDatebox(value) {
	if(value == null || value == '') {
		return '';
	}
	var dt = parseToDate(value);
	return dt.format("yyyy-MM-dd");
}

/*转换日期字符串为带时间的格式*/
function formatDateBoxFull(value) {
	if(value == null || value == '') {
		return '';
	}
	var dt = parseToDate(value);
	return dt.format("yyyy-MM-dd hh:mm:ss");
}

//辅助方法(转换日期)
function parseToDate(value) {
	if(value == null || value == '') {
		return undefined;
	}
	
	var dt;
	if(value instanceof Date) {
		dt = value;
	} else {
		if(!isNaN(value)) {
			dt = new Date(value);
		} else if(value.indexOf('/Date') > -1) {
			value = value.replace(/\/Date\((-?\d+)\)\//, '$1');
			dt = new Date();
			dt.setTime(value);
		} else if(value.indexOf('/') > -1) {
			dt = new Date(Date.parse(value.replace(/-/g, '/')));
		} else {
			dt = new Date(value);
		}
	}
	return dt;
}

//为Date类型拓展一个format方法，用于格式化日期
Date.prototype.format = function(format) //author: meizz 
{
	var o = {
	    "M+" : this.getMonth() + 1, //month 
	    "d+" : this.getDate(), //day 
	    "h+" : this.getHours(), //hour 
	    "m+" : this.getMinutes(), //minute 
	    "s+" : this.getSeconds(), //second 
	    "q+" : Math.floor((this.getMonth() + 3) / 3), //quarter 
	    "S" : this.getMilliseconds()
	//millisecond 
	};
	if(/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for( var k in o)
		if(new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	return format;
};
/**
 * 数组去重
 */
Array.prototype.unique = function()
{
	this.sort();
	var re=[this[0]];
	for(var i = 1; i < this.length; i++)
	{
		if( this[i] !== re[re.length-1])
		{
			re.push(this[i]);
		}
	}
	return re;
}

$userAgent = 'ie';

$(function() {
    if(typeof (ActiveXObject) != "undefined") {
	    if(navigator.userAgent.indexOf("MSIE 10") != -1) {
		    $userAgent = "chrome";
	    } else {
		    $userAgent = "ie";
	    }
    } else {
	    if(navigator.userAgent.indexOf("Trident/7") != -1 && navigator.userAgent.indexOf("rv:11") != -1) {
		    $userAgent = "chrome";
	    } else {
		    if(navigator.userAgent.indexOf("Edge") != -1) {
			    $userAgent = "chrome";
		    } else {
			    if(Object.prototype.toString.call(window.opera) == "[object Opera]") {
				    $userAgent = "opera";
			    } else {
				    if(navigator.vendor.indexOf("Apple") != -1) {
					    $userAgent = "safari";
					    if(navigator.userAgent.indexOf("iPad") != -1 || navigator.userAgent.indexOf("iPhone") != -1) {
						    $userAgent.ios = true;
					    }
				    } else {
					    if(navigator.vendor.indexOf("Google") != -1) {
						    if((navigator.userAgent.indexOf("Android") != -1) && (navigator.userAgent.indexOf("Chrome") == -1)) {
							    $userAgent = "android";
						    } else {
							    $userAgent = "chrome";
						    }
					    } else {
						    if(navigator.product == "Gecko" && window.find && !navigator.savePreferences) {
							    $userAgent = "firefox";
						    } else {
							    throw new Error("couldn't detect browser");
						    }
					    }
				    }
			    }
		    }
	    }
    }
});