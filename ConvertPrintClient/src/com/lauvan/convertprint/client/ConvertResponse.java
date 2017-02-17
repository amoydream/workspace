
package com.lauvan.convertprint.client;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "convertResponse", propOrder = {"_return"
})
public class ConvertResponse {
	@XmlElement(name = "return")
	protected String _return;

	public String getReturn() {
		return _return;
	}

	public void setReturn(String value) {
		_return = value;
	}
}
