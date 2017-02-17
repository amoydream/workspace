<%@ page language="java" pageEncoding="utf-8"%>
<script type="text/javascript">
	var contact_tree;
    var selected_contact;

    var tree_setting = {
        data : {
	        simpleData : {
	            enable : true,
	            idKey : 'ID',
	            pIdKey : 'PID'
	        }
        },
        callback : {
	        onClick : nodeOnClick
        }
    };

    function nodeOnClick(event, treeId, node) {
	    if(node.ID == '0' || node.ID == 'organ_0' || node.ID == 'dept_0') {
		    return;
	    }
	    selected_contact = node;
	    var CONTACT_TYPE = node.CONTACT_TYPE;
	    if('O' == CONTACT_TYPE || 'D' == CONTACT_TYPE) {
		    $('#contact_info').html(node.OR_NAME);
	    } else {
		    $('#contact_info').html(node.OR_NAME + (node.POSITION_NAME == null ? '' : ' | ' + node.POSITION_NAME) + ' | ' + node.CONTACT_NAME);
	    }
	    $('#tel_mobile').textbox('setValue', node.TEL_MOBILE);
	    $('#tel_office').textbox('setValue', node.TEL_OFFICE);
	    $('#tel_home').textbox('setValue', node.TEL_HOME);
    };

    function create_contact_tree(contacts) {
	    if(contact_tree != null) {
		    contact_tree.destroy();
		    contact_tree = null;
	    }
	    contact_tree = $.fn.zTree.init($('#contact_tree'), tree_setting, contacts);
    }

    function clear_filter() {
	    $('#contact_filter').textbox('setValue', '');
    }

    function refresh_contact() {
	    $.post('Main/communication/ccms/refreshContact', {}, function(contacts) {
		    $ccms_contacts = contacts;
		    create_contact_tree($ccms_contacts);
	    });
    }

    function getParent(data, PID) {
	    for(var i = 0; i < data.length; i++) {
		    if(data[i].ID == PID) {
			    return data[i];
		    }
	    }

	    return null;
    }

    function filter_contact() {
	    var contact_filter = $('#contact_filter').val();
	    if(contact_filter == null || contact_filter.trim() == '') {
		    create_contact_tree($ccms_contacts);
	    } else {
		    var filteredContacts = [{
		        ID : 0,
		        PID : 0,
		        name : '组织机构'
		    }];
		    for(var i = 3; i < $ccms_contacts.length; i++) {
			    var contact = $ccms_contacts[i];
			    var CONTACT_NAME = contact.name;
			    var TEL_NUMBER = contact.TEL_NUMBER;
			    if(CONTACT_NAME == null) {
				    continue;
			    }
			    if(TEL_NUMBER == null) {
				    continue;
			    }
			    if(CONTACT_NAME.indexOf(contact_filter) == -1 && TEL_NUMBER.indexOf(contact_filter) == -1) {
				    continue;
			    }
			    filteredContacts.push(contact);
			    var parent = getParent(filteredContacts, contact.PID);
			    while(parent == null) {
				    contact = getParent($ccms_contacts, contact.PID);
				    filteredContacts.push(contact);
				    parent = getParent(filteredContacts, contact.PID);
			    }
		    }

		    create_contact_tree(filteredContacts);
		    contact_tree.expandAll(true);
	    }
    }

    function call_mobile() {
	    call('#tel_mobile');
    }

    function call_office() {
	    call('#tel_office');
    }

    function call_home() {
	    call('#tel_home');
    }

    function call(tel_input) {
	    var tel_number = $(tel_input).val();
	    callout(tel_number);
    }

    function meeting_call() {
	    var tags = $('#member_tagger').tagger('getTags');
	    if(tags != null && tags.length > 0) {
		    var member_tels = '';
		    for(var i = 0; i < tags.length; i++) {
			    member_tels += ',' + tags[i].TEL_NUMBER;
		    }

		    member_tels = member_tels.substr(1);
		    if(confirm('点击【确定】开始电话会议')) {
			    CtiMeetingCALL(member_tels, '', '');
		    }
	    }
    }

    function add_member(elem) {
	    var TEL_NUMBER = $('#' + elem).val();
	    if(TEL_NUMBER == null || TEL_NUMBER.trim() == '') {
		    return;
	    }

	    var tags = $('#member_tagger').tagger('getTags');
	    if(tags != null && tags.length > 0) {
		    for(var i = 0; i < tags.length; i++) {
			    var tag = tags[i];
			    if(TEL_NUMBER == tag.TEL_NUMBER) {
				    return;
			    }
		    }
	    }

	    var contact = {
	        TEL_NUMBER : TEL_NUMBER,
	        CONTACT_NAME : TEL_NUMBER,
	        CONTACT_ID : null
	    };

	    if(selected_contact != null) {
		    var CONTACT_ID = selected_contact.ID;
		    if(tags != null && tags.length > 0) {
			    for(var i = 0; i < tags.length; i++) {
				    var tag = tags[i];
				    if(CONTACT_ID == tag.CONTACT_ID) {
					    return;
				    }
			    }
		    }

		    var TEL_MOBILE = selected_contact.TEL_MOBILE;
		    var TEL_OFFICE = selected_contact.TEL_OFFICE;
		    var TEL_HOME = selected_contact.TEL_HOME;
		    if(TEL_NUMBER == TEL_MOBILE || TEL_NUMBER == TEL_OFFICE || TEL_NUMBER == TEL_HOME) {
			    contact.CONTACT_NAME = selected_contact.CONTACT_NAME;
			    contact.CONTACT_ID = CONTACT_ID
		    }
	    }

	    if(contact.CONTACT_ID == null) {
		    contact = get_contact(TEL_NUMBER);
		    if(contact != null) {
			    contact.CONTACT_ID = contact.ID;
			    contact.TEL_NUMBER = TEL_NUMBER;
		    }
	    }

	    if(contact == null) {
		    contact = {
		        TEL_NUMBER : TEL_NUMBER,
		        CONTACT_NAME : TEL_NUMBER,
		        CONTACT_ID : null
		    };
	    }

	    $('#member_tagger').tagger('addTag', contact);
    }

    $(function() {
	    create_contact_tree($ccms_contacts);
	    $('#contact_filter').textbox({
		    onChange : function() {
			    filter_contact();
		    }
	    });

	    var tagger_options = {
	        placeholderText : 'Add...',
	        maxNbTags : false,
	        confirmDelete : true,
	        caseSensitive : false,
	        disableAdd : false,
	        tagId : 'TEL_NUMBER',
	        tagName : 'CONTACT_NAME',
	        clearBtn : true,
	        clearFn : function() {
		        $('#member_tagger').tagger('removeTags');
	        },
	        validateFn : check_TEL
	    };

	    $('#member_tagger').tagger(tagger_options);

	    $.extend($.fn.validatebox.defaults.rules, {
		    checkTel : {
		        validator : function(value, param) {
			        return check_TEL(value);
		        },
		        message : '号码格式错误'
		    }
	    });
    });
</script>
