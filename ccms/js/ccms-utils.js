$.extend(true, {
	ccms : {
	    browser : null,

	    log : function(msg) {
		    if(_.conf.debugMode) {
			    $('#console').val($('#console').val() + '\n' + msg);
		    }
	    },

	    check_DEPT_SEAT : function(tel_number) {
		    return ccms_conf.seatIds.indexOf(tel_number) >= 0;
	    },

	    check_CCMS_TEL : function(tel_number) {
		    return ccms_conf.telNos.indexOf(tel_number) >= 0;
	    },

	    check_CCMS_FAX : function(fax_number) {
		    return ccms_conf.faxNos.indexOf(fax_number) >= 0;
	    },

	    check_TEL : function(tel_number) {
		    if(tel_number === null || typeof tel_number !== 'string' || tel_number.trim() === '') {
			    return false;
		    }

		    var reg = /^0\d{2,3}-?[1-9]{1}\d{6,7}-?\d{1,6}$/;
		    if(!reg.test(tel_number)) {
			    reg = /^0\d{2,3}-?\d{7,8}$/;
			    if(!reg.test(tel_number)) {
				    reg = /^[1-9]{1}\d{6,7}$/;
				    if(!reg.test(tel_number)) {
					    reg = /^1\d{10}$/;
					    if(!reg.test(tel_number)) {
						    reg = /^[1-9]{1}\d{2,14}$/;
						    if(!reg.test(tel_number)) {
							    return false;
						    }
					    }
				    }
			    }
		    }

		    return true;
	    },

	    check_FAX : function(fax_number) {
		    if(fax_number === null || typeof fax_number !== 'string' || fax_number.trim() === '') {
			    return false;
		    }

		    var reg = /^0\d{2,3}-?[1-9]{1}\d{6,7}$/;
		    if(!reg.test(fax_number)) {
			    reg = /^[1-9]{1}\d{6,7}$/;
			    if(!reg.test(fax_number)) {
				    return false;
			    }
		    }

		    return true;
	    },

	    msg : function(msg) {
		    if(!_.conf.silentMode) {
			    if(typeof (msg) == 'object') {
				    alert(msg.msg);
			    } else {
				    alert(msg);
			    }
		    }
	    },

	    alert : function(msg) {
		    if(!_.conf.silentMode) {
			    if(typeof (msg) == 'object') {
				    alert(msg.msg);
			    } else {
				    alert(msg);
			    }
		    }
	    },

	    confirm : function(msg) {
		    if(typeof (msg) == 'object') {
			    return confirm(msg.msg);
		    } else {
			    return confirm(msg);
		    }
	    },

	    userAgent : function() {
		    if(_.browser !== null) {
			    return _.browser;
		    } else {
			    if(typeof (ActiveXObject) != "undefined") {
				    if(navigator.userAgent.indexOf("MSIE 10") != -1) {
					    _.browser = "chrome";
				    } else {
					    _.browser = "ie";
				    }
			    } else {
				    if(navigator.userAgent.indexOf("Trident/7") != -1 && navigator.userAgent.indexOf("rv:11") != -1) {
					    _.browser = "chrome";
				    } else {
					    if(navigator.userAgent.indexOf("Edge") != -1) {
						    _.browser = "chrome";
					    } else {
						    if(Object.prototype.toString.call(window.opera) == "[object Opera]") {
							    _.browser = "opera";
						    } else {
							    if(navigator.vendor.indexOf("Apple") != -1) {
								    _.browser = "safari";
								    if(navigator.userAgent.indexOf("iPad") != -1 || navigator.userAgent.indexOf("iPhone") != -1) {
									    _.browser.ios = true;
								    }
							    } else {
								    if(navigator.vendor.indexOf("Google") != -1) {
									    if((navigator.userAgent.indexOf("Android") != -1) && (navigator.userAgent.indexOf("Chrome") == -1)) {
										    _.browser = "android";
									    } else {
										    _.browser = "chrome";
									    }
								    } else {
									    if(navigator.product == "Gecko" && window.find && !navigator.savePreferences) {
										    _.browser = "firefox";
									    } else {
										    throw new Error("couldn't detect browser");
									    }
								    }
							    }
						    }
					    }
				    }
			    }

			    return _.browser;
		    }
	    },
	}
});
