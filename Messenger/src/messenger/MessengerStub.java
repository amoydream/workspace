package messenger;



import java.rmi.RemoteException;
import java.util.Enumeration;
import java.util.Vector;

import javax.xml.namespace.QName;

import org.apache.axis.AxisFault;
import org.apache.axis.Constants;
import org.apache.axis.NoEndPointException;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.client.Stub;
import org.apache.axis.constants.Style;
import org.apache.axis.constants.Use;
import org.apache.axis.description.OperationDesc;
import org.apache.axis.description.ParameterDesc;
import org.apache.axis.encoding.DeserializerFactory;
import org.apache.axis.encoding.SerializerFactory;
import org.apache.axis.encoding.XMLType;
import org.apache.axis.encoding.ser.ArrayDeserializerFactory;
import org.apache.axis.encoding.ser.ArraySerializerFactory;
import org.apache.axis.soap.SOAPConstants;
import org.apache.axis.utils.JavaUtils;

@SuppressWarnings({"unchecked", "rawtypes"})
public class MessengerStub extends Stub implements MessengerRemote {
	static OperationDesc[]	_operations;
	private static String	SMsg_address			= Messenger.get("smsg.address");
	private Vector			cachedDeserFactories	= new Vector();
	private Vector			cachedSerClasses		= new Vector();
	private Vector			cachedSerFactories		= new Vector();
	private Vector			cachedSerQNames			= new Vector();
	static {
		_operations = new OperationDesc[16];
		_initOperationDesc1();
		_initOperationDesc2();
	}

	private static void _initOperationDesc1() {
		OperationDesc oper;
		ParameterDesc param;
		oper = new OperationDesc();
		oper.setName("flushHost");
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "boolean"));
		oper.setReturnClass(boolean.class);
		oper.setReturnQName(new QName("", "flushHostReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[0] = oper;

		oper = new OperationDesc();
		oper.setName("sendSM");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "mobiles"), ParameterDesc.IN, new QName(SMsg_address, "ArrayOf_soapenc_string"), String[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "content"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "smID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "sendSMReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[1] = oper;

		oper = new OperationDesc();
		oper.setName("sendSM");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "mobiles"), ParameterDesc.IN, new QName(SMsg_address, "ArrayOf_soapenc_string"), String[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "content"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "smID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "srcID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "sendSMReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[2] = oper;

		oper = new OperationDesc();
		oper.setName("sendSM");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "mobiles"), ParameterDesc.IN, new QName(SMsg_address, "ArrayOf_soapenc_string"), String[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "content"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "smID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "url"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "sendSMReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[3] = oper;

		oper = new OperationDesc();
		oper.setName("sendSM");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "mobiles"), ParameterDesc.IN, new QName(SMsg_address, "ArrayOf_soapenc_string"), String[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "content"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "smID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "srcID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "url"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "sendSMReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[4] = oper;

		oper = new OperationDesc();
		oper.setName("sendSM");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "mobiles"), ParameterDesc.IN, new QName(SMsg_address, "ArrayOf_soapenc_string"), String[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "content"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "sendTime"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "smID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "srcID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "sendSMReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[5] = oper;

		oper = new OperationDesc();
		oper.setName("sendSM");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "mobiles"), ParameterDesc.IN, new QName(SMsg_address, "ArrayOf_soapenc_string"), String[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "content"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "smID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "srcID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "url"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "sendTime"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "sendSMReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[6] = oper;

		oper = new OperationDesc();
		oper.setName("recvRPT");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"));
		oper.setReturnClass(String.class);
		oper.setReturnQName(new QName("", "recvRPTReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[7] = oper;

		oper = new OperationDesc();
		oper.setName("sendPDU");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "mobiles"), ParameterDesc.IN, new QName(SMsg_address, "ArrayOf_soapenc_string"), String[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "content"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "base64Binary"), byte[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "smID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "msgFmt"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "tpPID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "tpUdhi"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "feeTerminalID"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "feeType"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "feeCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "feeUserType"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "sendPDUReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[8] = oper;

		oper = new OperationDesc();
		oper.setName("sendPDU");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "mobiles"), ParameterDesc.IN, new QName(SMsg_address, "ArrayOf_soapenc_string"), String[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "content"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "base64Binary"), byte[].class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "smID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "srcID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "msgFmt"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "tpPID"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "tpUdhi"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "feeTerminalID"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "feeType"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "feeCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "feeUserType"), ParameterDesc.IN, new QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "sendPDUReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[9] = oper;

	}

	private static void _initOperationDesc2() {
		OperationDesc oper;
		ParameterDesc param;
		oper = new OperationDesc();
		oper.setName("recvMo");
		param = new ParameterDesc(new QName("", "apiCode"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "loginPwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"));
		oper.setReturnClass(String.class);
		oper.setReturnQName(new QName("", "recvMoReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[10] = oper;

		oper = new OperationDesc();
		oper.setName("checkTime");
		param = new ParameterDesc(new QName("", "sendTime"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "boolean"));
		oper.setReturnClass(boolean.class);
		oper.setReturnQName(new QName("", "checkTimeReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[11] = oper;

		oper = new OperationDesc();
		oper.setName("main");
		param = new ParameterDesc(new QName("", "args"), ParameterDesc.IN, new QName(SMsg_address, "ArrayOf_soapenc_string"), String[].class, false, false);
		oper.addParameter(param);
		oper.setReturnType(XMLType.AXIS_VOID);
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[12] = oper;

		oper = new OperationDesc();
		oper.setName("invoke");
		param = new ParameterDesc(new QName("", "shell"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "anyType"));
		oper.setReturnClass(Object.class);
		oper.setReturnQName(new QName("", "invokeReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[13] = oper;

		oper = new OperationDesc();
		oper.setName("init");
		param = new ParameterDesc(new QName("", "dbIp"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "dbName"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "dbPort"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "user"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		param = new ParameterDesc(new QName("", "pwd"), ParameterDesc.IN, new QName("http://schemas.xmlsoap.org/soap/encoding/", "string"), String.class, false, false);
		oper.addParameter(param);
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "initReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[14] = oper;

		oper = new OperationDesc();
		oper.setName("release");
		oper.setReturnType(new QName("http://www.w3.org/2001/XMLSchema", "int"));
		oper.setReturnClass(int.class);
		oper.setReturnQName(new QName("", "releaseReturn"));
		oper.setStyle(Style.RPC);
		oper.setUse(Use.ENCODED);
		_operations[15] = oper;

	}

	public MessengerStub() throws AxisFault {
		this(null);
	}

	public MessengerStub(java.net.URL endpointURL, Service service)
		throws AxisFault {
		this(service);
		super.cachedEndpoint = endpointURL;
	}

	public MessengerStub(Service service) throws AxisFault {
		if(service == null) {
			super.service = new Service();
		} else {
			super.service = service;
		}
		((Service)super.service).setTypeMappingVersion("1.2");
		Class cls;
		QName qName;
		QName qName2;
		qName = new QName(SMsg_address, "ArrayOf_soapenc_string");
		cachedSerQNames.add(qName);
		cls = String[].class;
		cachedSerClasses.add(cls);
		qName = new QName("http://schemas.xmlsoap.org/soap/encoding/", "string");
		qName2 = null;
		cachedSerFactories.add(new ArraySerializerFactory(qName, qName2));
		cachedDeserFactories.add(new ArrayDeserializerFactory());
	}

	@Override
	public boolean checkTime(String sendTime) throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[11]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "checkTime"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{sendTime});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Boolean)_resp).booleanValue();
				} catch(Exception _exception) {
					return ((Boolean)JavaUtils.convert(_resp, boolean.class)).booleanValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	protected Call createCall() throws RemoteException {
		try {
			Call _call = super._createCall();
			if(super.maintainSessionSet) {
				_call.setMaintainSession(super.maintainSession);
			}
			if(super.cachedUsername != null) {
				_call.setUsername(super.cachedUsername);
			}
			if(super.cachedPassword != null) {
				_call.setPassword(super.cachedPassword);
			}
			if(super.cachedEndpoint != null) {
				_call.setTargetEndpointAddress(super.cachedEndpoint);
			}
			if(super.cachedTimeout != null) {
				_call.setTimeout(super.cachedTimeout);
			}
			if(super.cachedPortName != null) {
				_call.setPortName(super.cachedPortName);
			}
			Enumeration keys = super.cachedProperties.keys();
			while(keys.hasMoreElements()) {
				String key = (String)keys.nextElement();
				_call.setProperty(key, super.cachedProperties.get(key));
			}
			synchronized(this) {
				if(firstCall()) {
					_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
					_call.setEncodingStyle(Constants.URI_SOAP11_ENC);
					for(int i = 0; i < cachedSerFactories.size(); ++i) {
						Class cls = (Class)cachedSerClasses.get(i);
						QName qName = (QName)cachedSerQNames.get(i);
						Object x = cachedSerFactories.get(i);
						if(x instanceof Class) {
							Class sf = (Class)cachedSerFactories.get(i);
							Class df = (Class)cachedDeserFactories.get(i);
							_call.registerTypeMapping(cls, qName, sf, df, false);
						} else if(x instanceof SerializerFactory) {
							SerializerFactory sf = (SerializerFactory)cachedSerFactories.get(i);
							DeserializerFactory df = (DeserializerFactory)cachedDeserFactories.get(i);
							_call.registerTypeMapping(cls, qName, sf, df, false);
						}
					}
				}
			}
			return _call;
		} catch(Throwable _t) {
			throw new AxisFault("Failure trying to get the Call object", _t);
		}
	}

	@Override
	public boolean flushHost() throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[0]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "flushHost"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Boolean)_resp).booleanValue();
				} catch(Exception _exception) {
					return ((Boolean)JavaUtils.convert(_resp, boolean.class)).booleanValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int init(String dbIp, String dbName, String dbPort, String user, String pwd)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[14]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "init"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{dbIp, dbName, dbPort, user, pwd});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public Object invoke(String shell) throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[13]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "invoke"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{shell});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return _resp;
				} catch(Exception _exception) {
					return JavaUtils.convert(_resp, Object.class);
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public void main(String[] args) throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[12]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "main"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{args});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			}
			extractAttachments(_call);
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public String recvMo(String apiCode, String loginName, String loginPwd)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[10]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "recvMo"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (String)_resp;
				} catch(Exception _exception) {
					return (String)JavaUtils.convert(_resp, String.class);
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public String recvRPT(String apiCode, String loginName, String loginPwd)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[7]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "recvRPT"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (String)_resp;
				} catch(Exception _exception) {
					return (String)JavaUtils.convert(_resp, String.class);
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int release() throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[15]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "release"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int sendPDU(String apiCode, String loginName, String loginPwd, String[] mobiles, byte[] content, long smID, int msgFmt, int tpPID, int tpUdhi, String feeTerminalID, String feeType, String feeCode, int feeUserType)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[8]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "sendPDU"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd, mobiles, content, new Long(smID), new Integer(msgFmt), new Integer(tpPID), new Integer(tpUdhi), feeTerminalID, feeType, feeCode, new Integer(feeUserType)});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int sendPDU(String apiCode, String loginName, String loginPwd, String[] mobiles, byte[] content, long smID, long srcID, int msgFmt, int tpPID, int tpUdhi, String feeTerminalID, String feeType, String feeCode, int feeUserType)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[9]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "sendPDU"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd, mobiles, content, new Long(smID), new Long(srcID), new Integer(msgFmt), new Integer(tpPID), new Integer(tpUdhi), feeTerminalID, feeType, feeCode, new Integer(feeUserType)});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[1]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "sendSM"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd, mobiles, content, new Long(smID)});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, long srcID)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[2]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "sendSM"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd, mobiles, content, new Long(smID), new Long(srcID)});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, long srcID, String url)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[4]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "sendSM"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd, mobiles, content, new Long(smID), new Long(srcID), url});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, long srcID, String url, String sendTime)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[6]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "sendSM"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd, mobiles, content, new Long(smID), new Long(srcID), url, sendTime});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, long smID, String url)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[3]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "sendSM"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd, mobiles, content, new Long(smID), url});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public int sendSM(String apiCode, String loginName, String loginPwd, String[] mobiles, String content, String sendTime, long smID, long srcID)
		throws RemoteException {
		if(super.cachedEndpoint == null) {
			throw new NoEndPointException();
		}
		Call _call = createCall();
		_call.setOperation(_operations[5]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setSOAPVersion(SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new QName("http://webservice.api.im.jasson.com", "sendSM"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			Object _resp = _call.invoke(new Object[]{apiCode, loginName, loginPwd, mobiles, content, sendTime, new Long(smID), new Long(srcID)});

			if(_resp instanceof RemoteException) {
				throw (RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return ((Integer)_resp).intValue();
				} catch(Exception _exception) {
					return ((Integer)JavaUtils.convert(_resp, int.class)).intValue();
				}
			}
		} catch(AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}
}
