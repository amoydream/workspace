package messenger;



import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashSet;
import java.util.Iterator;

import javax.xml.namespace.QName;
import javax.xml.rpc.ServiceException;

import org.apache.axis.AxisFault;
import org.apache.axis.EngineConfiguration;
import org.apache.axis.client.Service;
import org.apache.axis.client.Stub;

@SuppressWarnings("rawtypes")
public class MessengerLocator extends Service implements MessengerService {
	private static final long	serialVersionUID	= 1L;

	private HashSet				ports				= null;

	private String				SMsg_address		= null;

	private String				SMsgWSDDServiceName	= "SMsg";

	public MessengerLocator() {
	}

	public MessengerLocator(EngineConfiguration config) {
		super(config);
	}

	public MessengerLocator(String SMsg_address) {
		this.SMsg_address = SMsg_address;
	}

	public MessengerLocator(String wsdlLoc, QName sName)
		throws ServiceException {
		super(wsdlLoc, sName);
	}

	@Override
	public java.rmi.Remote getPort(Class serviceEndpointInterface) throws ServiceException {
		try {
			if(MessengerRemote.class.isAssignableFrom(serviceEndpointInterface)) {
				MessengerStub _stub = new MessengerStub(new URL(SMsg_address), this);
				_stub.setPortName(getSMsgWSDDServiceName());
				return _stub;
			}
		} catch(Throwable t) {
			throw new ServiceException(t);
		}
		throw new ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
	}

	@Override
	public java.rmi.Remote getPort(QName portName, Class serviceEndpointInterface)
		throws ServiceException {
		if(portName == null) {
			return getPort(serviceEndpointInterface);
		}
		String inputPortName = portName.getLocalPart();
		if("SMsg".equals(inputPortName)) {
			return getSMsg();
		} else {
			java.rmi.Remote _stub = getPort(serviceEndpointInterface);
			((Stub)_stub).setPortName(portName);
			return _stub;
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public Iterator getPorts() {
		if(ports == null) {
			ports = new HashSet();
			ports.add(new QName(SMsg_address, "SMsg"));
		}
		return ports.iterator();
	}

	@Override
	public QName getServiceName() {
		return new QName(SMsg_address, "SMsgService");
	}

	@Override
	public MessengerRemote getSMsg() throws ServiceException {
		URL endpoint;
		try {
			endpoint = new URL(SMsg_address);
		} catch(MalformedURLException e) {
			throw new ServiceException(e);
		}
		return getSMsg(endpoint);
	}

	@Override
	public MessengerRemote getSMsg(URL portAddress) throws ServiceException {
		try {
			MessengerStub _stub = new MessengerStub(portAddress, this);
			_stub.setPortName(getSMsgWSDDServiceName());
			return _stub;
		} catch(AxisFault e) {
			return null;
		}
	}

	@Override
	public String getSMsgAddress() {
		return SMsg_address;
	}

	public String getSMsgWSDDServiceName() {
		return SMsgWSDDServiceName;
	}

	public void setEndpointAddress(QName portName, String address)
		throws ServiceException {
		setEndpointAddress(portName.getLocalPart(), address);
	}

	public void setEndpointAddress(String portName, String address)
		throws ServiceException {
		if("SMsg".equals(portName)) {
			setSMsgEndpointAddress(address);
		} else {
			throw new ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
		}
	}

	public void setSMsgEndpointAddress(String address) {
		SMsg_address = address;
	}

	public void setSMsgWSDDServiceName(String name) {
		SMsgWSDDServiceName = name;
	}
}
