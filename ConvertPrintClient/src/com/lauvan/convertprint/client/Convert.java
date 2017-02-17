
package com.lauvan.convertprint.client;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "convert", propOrder = {"arg0", "arg1"
})
public class Convert {
	protected String	arg0;
	protected String	arg1;

	public String getArg0() {
		return arg0;
	}

	public void setArg0(String value) {
		arg0 = value;
	}

	public String getArg1() {
		return arg1;
	}

	public void setArg1(String value) {
		arg1 = value;
	}
}
