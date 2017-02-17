package com.lauvan.apps.workcontact.model;

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

/**
 * @author taosongsong 机构通讯录
 */
@TableBind(name = "V_CONTACT", pk = "CONTACT_ID")
public class V_Contact extends Model<V_Contact> {
	private static final long	serialVersionUID	= 1L;
	public static V_Contact		dao					= new V_Contact();

	public V_Contact findByTelNo(String tel_number) {
		return findFirst("SELECT * FROM V_CONTACT WHERE ',' || TEL_NUMBER || ',' LIKE '%," + tel_number + ",%'");
	}
}