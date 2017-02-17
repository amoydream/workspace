$.extend({
	messenger : {
	    msg : function(id) {
		    var msgs = Messenger().findById(id);
		    if(msgs.length == 0) {
			    return null;
		    }
		    return msgs[0].msg;
	    },
	    post : function(options) {
		    if(typeof (options.id) == 'undefined') {
			    alert('id未指定');
		    }
		    if($.messenger.msg(options.id) != null) {
			    return $.messenger.msg(options.id);
		    }

		    var defaults = {
		        type : 'info',
		        hideAfter : 0,
		        hideDestroy : false,
		        showCloseButton : true,
		        onClickClose : function() {
			        $.messenger.destroy(options.id);
		        }
		    };

		    options = $.extend(defaults, options);
		    Messenger().post(options);
	    },
	    update : function(options) {
		    if(typeof (options.id) == 'undefined') {
			    alert('id未指定');
		    }
		    var msg = $.messenger.msg(options.id);
		    if(msg != null) {
			    msg.update(options);
		    }
	    },
	    destroy : function(id) {
		    if($.messenger.msg(id) != null) {
		    	Messenger().destroy(id);
		    }
	    }
	}
});