
package com.lauvan.convertprint.client;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "print", propOrder = {"arg0"
})
public class Print {
	protected String arg0;

	public String getArg0() {
		return arg0;
	}

	public void setArg0(String value) {
		arg0 = value;
	}
}
