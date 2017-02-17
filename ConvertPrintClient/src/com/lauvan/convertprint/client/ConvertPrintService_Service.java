package com.lauvan.convertprint.client;

import java.net.MalformedURLException;
import java.net.URL;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceFeature;

@WebServiceClient(name = "ConvertPrintService",
	targetNamespace = "http://service.convertprint.lauvan.com/")
public class ConvertPrintService_Service extends Service {
	public final static QName	SERVICE						= new QName("http://service.convertprint.lauvan.com/", "ConvertPrintService");
	public final static QName	ConvertPrintServiceImplPort	= new QName("http://service.convertprint.lauvan.com/", "ConvertPrintServiceImplPort");

	public ConvertPrintService_Service(String wsdlLocation) throws MalformedURLException {
		super(new URL(wsdlLocation), SERVICE);
	}

	public ConvertPrintService_Service(URL wsdlLocation, QName serviceName) {
		super(wsdlLocation, serviceName);
	}

	@WebEndpoint(name = "ConvertPrintServiceImplPort")
	public ConvertPrintService getConvertPrintServiceImplPort() {
		return super.getPort(ConvertPrintServiceImplPort, ConvertPrintService.class);
	}

	@WebEndpoint(name = "ConvertPrintServiceImplPort")
	public ConvertPrintService getConvertPrintServiceImplPort(WebServiceFeature features) {
		return super.getPort(ConvertPrintServiceImplPort, ConvertPrintService.class, features);
	}
}
