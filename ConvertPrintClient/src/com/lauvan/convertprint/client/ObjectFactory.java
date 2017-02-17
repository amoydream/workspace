
package com.lauvan.convertprint.client;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;

@XmlRegistry
public class ObjectFactory {
	private final static QName	_Convert_QNAME			= new QName("http://service.convertprint.lauvan.com/", "convert");
	private final static QName	_ConvertResponse_QNAME	= new QName("http://service.convertprint.lauvan.com/", "convertResponse");
	private final static QName	_Print_QNAME			= new QName("http://service.convertprint.lauvan.com/", "print");
	private final static QName	_PrintResponse_QNAME	= new QName("http://service.convertprint.lauvan.com/", "printResponse");

	public ObjectFactory() {
	}

	public Convert createConvert() {
		return new Convert();
	}

	public ConvertResponse createConvertResponse() {
		return new ConvertResponse();
	}

	public Print createPrint() {
		return new Print();
	}

	public PrintResponse createPrintResponse() {
		return new PrintResponse();
	}

	@XmlElementDecl(namespace = "http://service.convertprint.lauvan.com/", name = "convert")
	public JAXBElement<Convert> createConvert(Convert value) {
		return new JAXBElement<Convert>(_Convert_QNAME, Convert.class, null, value);
	}

	@XmlElementDecl(namespace = "http://service.convertprint.lauvan.com/", name = "convertResponse")
	public JAXBElement<ConvertResponse> createConvertResponse(ConvertResponse value) {
		return new JAXBElement<ConvertResponse>(_ConvertResponse_QNAME, ConvertResponse.class, null, value);
	}

	@XmlElementDecl(namespace = "http://service.convertprint.lauvan.com/", name = "print")
	public JAXBElement<Print> createPrint(Print value) {
		return new JAXBElement<Print>(_Print_QNAME, Print.class, null, value);
	}

	@XmlElementDecl(namespace = "http://service.convertprint.lauvan.com/", name = "printResponse")
	public JAXBElement<PrintResponse> createPrintResponse(PrintResponse value) {
		return new JAXBElement<PrintResponse>(_PrintResponse_QNAME, PrintResponse.class, null, value);
	}
}
