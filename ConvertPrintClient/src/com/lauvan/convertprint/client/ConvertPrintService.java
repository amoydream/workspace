package com.lauvan.convertprint.client;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.Action;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;

@WebService(targetNamespace = "http://service.convertprint.lauvan.com/", name = "ConvertPrintService")
@XmlSeeAlso({ObjectFactory.class})
public interface ConvertPrintService {
	@WebMethod
	@Action(input = "http://service.convertprint.lauvan.com/ConvertPrintService/convertRequest",
		output = "http://service.convertprint.lauvan.com/ConvertPrintService/convertResponse")
	@RequestWrapper(localName = "convert", targetNamespace = "http://service.convertprint.lauvan.com/",
		className = "com.lauvan.convertprint.client.Convert")
	@ResponseWrapper(localName = "convertResponse", targetNamespace = "http://service.convertprint.lauvan.com/",
		className = "com.lauvan.convertprint.client.ConvertResponse")
	@WebResult(name = "return", targetNamespace = "")
	public java.lang.String convert(@WebParam(name = "arg0", targetNamespace = "") java.lang.String arg0, @WebParam(name = "arg1",
		targetNamespace = "") java.lang.String arg1);
	
	@WebMethod
	@Action(input = "http://service.convertprint.lauvan.com/ConvertPrintService/printRequest",
		output = "http://service.convertprint.lauvan.com/ConvertPrintService/printResponse")
	@RequestWrapper(localName = "print", targetNamespace = "http://service.convertprint.lauvan.com/",
		className = "com.lauvan.convertprint.client.Print")
	@ResponseWrapper(localName = "printResponse", targetNamespace = "http://service.convertprint.lauvan.com/",
		className = "com.lauvan.convertprint.client.PrintResponse")
	public void print(@WebParam(name = "arg0", targetNamespace = "") java.lang.String arg0);
}
