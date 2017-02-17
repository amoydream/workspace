$.extend(true, {
	ccms : {
		connTimer : {
		    delay : 3000,
		    timer : null,

		    start : function() {
			    var _t = _.connTimer;
			    if(_t.timer !== null) {
				    clearTimeout(_t.timer);
			    }
			    _t.timer = setTimeout(_t.start, _t.delay);
			    if(!_.connected && _.reOpen) {
				    _.CtiOpen();
				    return;
			    }
		    },

		    stop : function() {
			    var _t = _.connTimer;
			    clearTimeout(_t.timer);
			    _t.timer = null;
		    }
		}
	}
});