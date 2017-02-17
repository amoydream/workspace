(function($) {
	var defaultOptions = {
	    addKeys : [9, 13],
	    placeholder : "Add...",
	    maxNbTags : false,
	    confirmDelete : false,
	    caseSensitive : false,
	    disableAdd : false,
	    tagId : null,
	    tagName : null,
	    onRemoveTag : null,
	    addBtn : false,
	    clearBtn : true,
	    addFn : function() {
	    },
	    clearFn : function() {
	    },
	    createFn : function(value) {
		    return value;
	    },
	    validateFn : function() {
	    },
	    onchange : function() {
	    }
	};

	function Tagger(elem, options) {
		this.options = options;
		this.$select = elem;
		this.$select.hide();
		var width = this.$select.css("width");

		this.$select.wrapAll($('<div class="tagger-container" style="width: ' + width + ';"/>'));
		this.$container = elem.parents(".tagger-container");

		this.$inputContainer = $('<div class="input-container"/>');
		this.$input = $('<input type="text"/>');
		this.$placeholder = $('<span class="placeholder">' + (this.options.placeholder ? this.options.placeholder : "") + '</span>')
		this.$inputContainer.append(this.$input).append(this.$placeholder);
		if(this.options.addBtn == true || this.options.clearBtn == true) {
			this.$container.append('<div id="bottomright" class="bottomright">');
			if(this.options.addBtn == true) {
				this.$container.append('<a id="addBtn" class="tagger-addBtn" onclick="$(\'#' + elem[0].id + '\').tagger(\'addFn\');"' + '/>');
			}
			if(this.options.clearBtn == true) {
				this.$container.append('<a id="clearBtn" class="tagger-clearBtn" onclick="$(\'#' + elem[0].id + '\').tagger(\'clearFn\');"' + '/>');
			}
			this.$container.append('</div>');
		}
		this.$select.after(this.$inputContainer);

		this.$select.find("option").each(function() {
			var value = $(this).val();
			$(this).val(value).text(value);
			this.addTag(value);
		});

		this.$select.is(":disabled") ? this.disable() : this.enable();
		this.adjustInputWidth();
	};

	Tagger.prototype = {
	    constructor : Tagger,

	    addFn : function() {
		    this.options.addFn();
	    },

	    clearFn : function() {
		    this.options.clearFn();
	    },
	    
	    validate : function(value) {
	    	return this.options.validateFn(value);
	    },

	    getTags : function() {
		    var tags = [];
		    this.$container.find(".tagger-tag").each(function() {
			    tags.push($(this).data("value"));
		    });
		    return tags;
	    },

	    getTagId : function(tag) {
		    value = tag.data("value");
		    if(this.options.tagId) {
			    return value[this.options.tagId];
		    } else if(this.options.tagName) {
			    return value[this.options.tagName];
		    } else {
			    return value;
		    }
	    },

	    findTag : function(tag) {
		    var self = this;
		    return this.$container.find(".tagger-tag").filter(function() {
			    var a = self.getTagId($(this));
			    var b = tag;

			    if(self.options.caseSensitive) {
				    a = a.toLowerCase();
				    b = b.toLowerCase();
			    }
			    return a === b;
		    });
	    },

	    addTag : function(data) {
		    var added = false;
		    var isObj = false;

		    var value = data;
		    if($.isPlainObject(data)) {
			    isObj = true;
		    } else {
			    var obj = {};
			    obj[this.options.tagId] = data;
			    obj[this.options.tagName] = data;
			    isObj = true;
			    data = obj;
		    }

		    value = data[this.options.tagName];
		    if("" === $.trim(value)) {
			    value = data[this.options.tagId];
		    }

		    value = $.trim(value);
		    if(!this.validate(data[this.options.tagId])) {
		    	return false;
		    }
		    if(value !== "") {
			    var existingTag = this.findTag(data[this.options.tagId]);
			    if(existingTag.length > 0) {
				    existingTag.css("opacity", 0).animate({
					    opacity : 1
				    }, 300);
			    } else {
				    added = true;
				    var tag = this.getCalculatedTag(value);

				    tag.data("value", isObj ? data : this.options.createFn(value));
				    this.$inputContainer.before(tag);
				    this.inputReset();

				    if(this.$select.find('option[value="' + value + '"]').length === 0) {
					    this.$select.append('<option value="' + value + '"/>');
				    }
			    }
		    }
		    
		    this.options.onchange();

		    return added;
	    },

	    removeTag : function(value) {
		    var self = this;
		    this.$container.find(".tagger-tag").filter(function() {
			    return self.getTagId($(this)) === value;
		    }).remove();
		    this.$select.find('option[value="' + value + '"]').remove();
	    },

	    removeTags : function() {
		    this.$container.find(".tagger-tag").remove();
		    this.$select.find("option").remove();
	    },

	    setTags : function(tags) {
		    this.removeTags();
		    for(var i = 0; i < tags.length; i++) {
			    this.addTag(tags[i]);
		    }
	    },

	    reachedNbMaxTags : function() {
		    return this.options.maxNbTags && this.options.maxNbTags >= 0 && this.getTags().length >= this.options.maxNbTags;
	    },

	    addTagFromKeyboard : function(value) {
		    if(!this.options.disableAdd) {
			    this.addTag(value);
		    }
	    },

	    enable : function() {
		    this.setEvents();
		    this.$input.prop("disabled", false);
		    this.$container.removeClass("tagger-disabled");
	    },

	    disable : function() {
		    this.unsetEvents();
		    this.$input.prop("disabled", true);
		    this.$container.addClass("tagger-disabled");
	    },

	    destroy : function() {
		    this.$container.parent().html(this.$select.show());
	    },

	    setEvents : function() {
		    var self = this;

		    if(!this.options.disableAdd) {
			    this.$input.on("blur", function(e) {
				    self.addTagFromKeyboard(self.$input.val());
				    self.$input.val("");
				    self.$placeholder.show();
				    var tags = self.$container.find(".tagger-tag");
				    tags.removeClass("confirm");
				    tags.last().after(self.$inputContainer);
			    });
		    }

		    this.$input.on("paste", function(e) {
			    self.$placeholder.hide();
			    if(self.reachedNbMaxTags()) {
				    e.preventDefault();
				    e.stopPropagation();
			    } else {
				    var elem = this;
				    setTimeout(function(e) {
					    self.adjustInputWidth($(elem).val());
				    }, 0);
			    }
		    });

		    this.$input.on("keyup", function(e) {
			    if(self.$input.val().length === 0) {
				    self.$placeholder.show();
			    } else {
				    self.$placeholder.hide();
			    }
			    self.adjustInputWidth();
		    });

		    this.$input.on("keydown", function(e) {
			    var inputText = self.$input.val();
			    switch(e.which) {
				    case 8:
				    case 46:
					    if(inputText.length === 0) {
						    var elem;
						    if(e.which === 8) {
							    elem = self.$inputContainer.prev(".tagger-tag");
						    } else {
							    elem = self.$inputContainer.next(".tagger-tag");
						    }

						    if(self.options.confirmDelete) {
							    elem.siblings().removeClass("confirm");
							    if(elem.hasClass("confirm")) {
								    self.removeTag(self.getTagId(elem));
							    } else {
								    elem.addClass("confirm");
							    }
						    } else {
							    self.removeTag(self.getTagId(elem));
						    }
					    }

					    break;
				    case 37:
					    if(inputText.length === 0) {
						    self.goToPreviousTag();
					    }
					    break;
				    case 39:
					    if(inputText.length === 0) {
						    self.goToNextTag();
					    }
					    break;
			    }

			    if(e.keyCode !== 8 && e.keyCode !== 46) {
				    self.$container.find(".tagger-tag").removeClass("confirm");
			    }
		    });

		    this.$input.on("keypress", function(e) {
			    var inputText = self.$input.val();
			    if(e.keyCode !== 8 && e.keyCode !== 46) {
				    self.$container.find(".tagger-tag").removeClass("confirm");
			    }

			    switch(e.keyCode) {
				    case 8:
				    case 46:
					    break;
				    default:
					    if($.inArray(e.keyCode, self.options.addKeys) !== -1) {
						    var value = $.trim(self.$input.val());
						    if(value !== "") {
							    if(self.addTagFromKeyboard(value)) {
								    self.$placeholder.show();
							    }
							    e.preventDefault();
							    e.stopPropagation();
						    }
						    self.adjustInputWidth();
					    } else if(!e.ctrlKey && self.reachedNbMaxTags()) {
						    e.preventDefault();
						    e.stopPropagation();
					    } else {
						    self.$container.find(".tagger-tag").removeClass("confirm");
						    self.$placeholder.hide();
						    self.adjustInputWidth(self.$input.val() + String.fromCharCode(e.which));
					    }
					    break;
			    }
		    });

		    this.$container.on("click", function(e) {
			    self.$input.focus();
		    });

		    this.$container.on("click", ".tagger-tag .remove-tag", function(e) {
			    var tagId = self.getTagId($(e.target).parents(".tagger-tag"));
			    if(self.options.onRemoveTag != null) {
				    eval(self.options.onRemoveTag(tagId));
			    } else {
				    self.removeTag(tagId);
			    }
		    });
	    },

	    unsetEvents : function() {
		    this.$input.off("blur");
		    this.$input.off("paste");
		    this.$input.off("keyup");
		    this.$input.off("keydown");
		    this.$input.off("keypress");
		    this.$container.off("click", ".tagger-tag .remove-tag");
		    this.$container.off("click");
	    },

	    goToPreviousTag : function() {
		    this.$inputContainer.prevAll(".tagger-tag").first().before(this.$inputContainer);
		    this.inputReset();
	    },

	    goToNextTag : function() {
		    this.$inputContainer.nextAll(".tagger-tag").first().after(this.$inputContainer);
		    this.inputReset();
	    },

	    inputReset : function(noFocus) {
		    this.$input.val("");

		    var self = this;
		    setTimeout(function() {
			    self.$input.focus();
		    }, 10);

		    this.adjustInputWidth();
	    },

	    getCalculatedTag : function(value) {
		    var testSubject = $("#tagger-widthCalculator");
		    if(testSubject.length === 0) {
			    testSubject = $('<div id="tagger-widthCalculator" class="tagger-tag"/>').css({
			        position : "absolute",
			        top : -9999,
			        left : -9999,
			        whiteSpace : "nowrap"
			    });
			    $("body").append(testSubject);
		    }

		    var changeContent = function(text) {
			    testSubject.html(escapeHtml(text));
		    }

		    changeContent(value);
		    var width = testSubject.outerWidth();
		    var containerWidth = this.$container.width();
		    var fullWidth = width > containerWidth;

		    var self = this;
		    var getCalculatedHtml = function(text) {
			    changeContent(text);
			    var width = testSubject.outerWidth();
			    if(width <= containerWidth) {
				    testSubject.html(escapeHtml(text) + '<span class="remove-tag">&times;</span>');
				    width = testSubject.outerWidth();
				    if(width <= containerWidth) {
					    return escapeHtml(text) + '<span class="remove-tag">&times;</span>';
				    } else {
					    return escapeHtml(text) + '<br/><span class="remove-tag">&times;</span>';
				    }
			    } else {
				    var ratio = containerWidth / width;
				    var pos = parseInt(text.length * ratio, 10);
				    changeContent(text.substr(0, pos));
				    width = testSubject.outerWidth();

				    var adjusted = false;
				    if(width > containerWidth) {
					    while(width > containerWidth) {
						    adjusted = true;
						    pos--;
						    changeContent(text.substr(0, pos));
						    width = testSubject.outerWidth();
					    }
				    } else {
					    while(width < containerWidth) {
						    pos++;
						    changeContent(text.substr(0, pos));
						    width = testSubject.outerWidth();
					    }
					    pos--;
				    }
			    }

			    var line = text.substr(0, pos);
			    var lastSpacePos = line.lastIndexOf(" ");
			    if(lastSpacePos !== -1) {
				    pos = lastSpacePos;
			    }

			    return escapeHtml(text.substr(0, pos)) + "<br/>" + getCalculatedHtml($.trim(text.substr(pos)));
		    }

		    return $('<div class="tagger-tag' + (fullWidth ? ' full-width' : '') + '">' + getCalculatedHtml(value) + '</div>');
	    },

	    adjustInputWidth : function(value) {
		    value = value || this.$input.val();
		    $("taggerWidth").remove();
		    var testSubject = $("<taggerWidth/>").css({
		        position : "absolute",
		        top : -9999,
		        left : -9999,
		        fontSize : this.$input.css("fontSize"),
		        fontFamily : this.$input.css("fontFamily"),
		        fontWeight : this.$input.css("fontWeight"),
		        letterSpacing : this.$input.css("letterSpacing"),
		        whiteSpace : "nowrap"
		    });
		    testSubject.html(escapeHtml(value));
		    $("body").append(testSubject);

		    var valueWidth = testSubject.width();

		    var placeholderWidth = 0;
		    if(this.options.placeholder) {
			    testSubject.html(escapeHtml(this.options.placeholder));
			    placeholderWidth = testSubject.width();
		    }

		    var width = Math.max(valueWidth, placeholderWidth);
		    var diff = this.$input.outerWidth() - this.$input.width();
		    this.$input.width(Math.min(this.$container.width() - diff, width + 1));
	    }
	};

	var escapeHtml = function(text) {
		return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#039;")
		    .replace(/ /g, "&nbsp;");
	};

	$.fn.tagger = function(arg1, arg2) {
		var self = this;
		var tagger = $(this).data("tagger");
		if(!tagger) {
			var options = $.extend({}, defaultOptions, arg1);
			return this.each(function() {
				var tagger = new Tagger($(this), options);
				$(this).data("tagger", tagger);
			});
		} else {
			if(tagger[arg1]) {
				return tagger[arg1](arg2);
			}
		}
	};
}(window.jQuery));