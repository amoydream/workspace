$.fn.extend({
	nval : function() {
		if(this.val() === 'undefined' || this.val() === null) {
			return '';
		}
		
		return this.val();
	}
});